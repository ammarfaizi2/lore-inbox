Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751617AbVIZJef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbVIZJef (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 05:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbVIZJef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 05:34:35 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:18391 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751617AbVIZJee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 05:34:34 -0400
Date: Mon, 26 Sep 2005 18:34:04 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: Paul Jackson <pj@sgi.com>
Cc: taka@valinux.co.jp, magnus.damm@gmail.com, dino@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] CPUMETER: add cpumeter framework to the CPUSETS
In-Reply-To: <20050910015209.4f581b8a.pj@sgi.com>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
X-Mailer: Sylpheed version 2.1.2+svn (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20050926093432.9975870043@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds CPUMETER framework code to the CPUSETS.
CPUMETER is meant for subdividing cpuset resources.
A few files are added in order to control the guarantee and the limit
of the resource amount to the cpuset filesystem.  Also, interfaces
for the specific resource controller like CPU and memory.

Signed-off-by: KUROSAWA Takahiro <kurosawa@valinux.co.jp>

--- from-0001/include/linux/cpuset.h
+++ to-work/include/linux/cpuset.h	2005-09-26 17:24:09.480931862 +0900
@@ -14,6 +14,46 @@
 
 #ifdef CONFIG_CPUSETS
 
+#ifdef CONFIG_CPUMETER
+struct cpumeter_ctlr {
+	char *name;		/* controller name */
+	int idx;		/* used by cpumeter core */
+	void *(*create_rcdomain)(struct cpuset *cs, cpumask_t cpus,
+				 nodemask_t mems);
+	void (*destroy_rcdomain)(void *rcd);
+	void *(*create)(void *rcd, struct cpuset *cs);
+	void (*destroy)(void *ctldata);
+	int (*set_lim)(void *ctldata, unsigned long val);
+	int (*set_guar)(void *ctldata, unsigned long val);
+	int (*get_cur)(void *ctldata, unsigned long *valp);
+};
+
+extern int cpumeter_register_controller(struct cpumeter_ctlr *ctlr);
+extern void *cpumeter_get_controller_data(struct cpuset *cs,
+					  struct cpumeter_ctlr *ctlr);
+extern void *cpumeter_get_rcdomain(struct cpuset *cs,
+				   struct cpumeter_ctlr *ctlr);
+#else /* CONFIG_CPUMETER */
+struct cpumeter_ctlr;
+
+static inline int cpumeter_register_controller(struct cpumeter_ctlr *ctlr)
+{
+	return -EINVAL;
+}
+
+static inline void *cpumeter_get_controller_data(struct cpuset *cs,
+						 struct cpumeter_ctlr *ctlr)
+{
+	return NULL;
+}
+
+static inline void *cpumeter_get_rcdomain(struct cpuset *cs,
+					  struct cpumeter_ctlr *ctlr)
+{
+	return NULL;
+}
+#endif /* CONFIG_CPUMETER */
+
 extern int cpuset_init(void);
 extern void cpuset_init_smp(void);
 extern void cpuset_fork(struct task_struct *p);
--- from-0001/init/Kconfig
+++ to-work/init/Kconfig	2005-09-26 17:24:09.481931723 +0900
@@ -238,6 +238,15 @@ config CPUSETS
 
 	  Say N if unsure.
 
+config CPUMETER
+	bool "Cpumeter support"
+	depends on CPUSETS
+	help
+	  This option enables the resource control of CPUs and memory
+	  via the CPUSETS interface.
+
+	  Say N if unsure.
+
 menuconfig EMBEDDED
 	bool "Configure standard kernel features (for small systems)"
 	help
--- from-0001/kernel/cpuset.c
+++ to-work/kernel/cpuset.c	2005-09-26 17:24:09.479932000 +0900
@@ -55,6 +55,19 @@
 
 #define CPUSET_SUPER_MAGIC 		0x27e0eb
 
+#ifdef CONFIG_CPUMETER
+#define CPUMETER_CTLRS_MAX		16
+
+struct cpumeter {
+	void *ctlr_data;		/* resource controller data */
+	unsigned long guar;		/* resource guarantee */
+	unsigned long lim;		/* resource limit */
+};
+
+static struct cpumeter_ctlr *cpumeter_ctlrs[CPUMETER_CTLRS_MAX];
+static int cpumeter_numctlrs = 0;
+#endif /* CONFIG_CPUMETER */
+
 struct cpuset {
 	unsigned long flags;		/* "unsigned long" so bitops work */
 	cpumask_t cpus_allowed;		/* CPUs allowed to tasks in cpuset */
@@ -77,6 +90,16 @@ struct cpuset {
 	 * recent time this cpuset changed its mems_allowed.
 	 */
 	 int mems_generation;
+#ifdef CONFIG_CPUMETER
+	/*
+	 * rcdomains: used for the recource control domains
+	 *            to keep track of total ammount of resources.
+	 * meters:    used for metering resources assigned for
+	 *            the cpuset.
+	 */
+	void *rcdomains[CPUMETER_CTLRS_MAX];
+	struct cpumeter meters[CPUMETER_CTLRS_MAX];
+#endif /* CONFIG_CPUMETER */
 };
 
 /* bits in struct cpuset flags field */
@@ -84,7 +107,8 @@ typedef enum {
 	CS_CPU_EXCLUSIVE,
 	CS_MEM_EXCLUSIVE,
 	CS_REMOVED,
-	CS_NOTIFY_ON_RELEASE
+	CS_NOTIFY_ON_RELEASE,
+	CS_METER_OFFSET		/* must be the last. */
 } cpuset_flagbits_t;
 
 /* convenient tests for these bits */
@@ -108,6 +132,47 @@ static inline int notify_on_release(cons
 	return !!test_bit(CS_NOTIFY_ON_RELEASE, &cs->flags);
 }
 
+static inline int is_metered(const struct cpuset *cs, int idx)
+{
+	return !!test_bit(CS_METER_OFFSET + idx, &cs->flags);
+}
+
+static inline void set_meter(struct cpuset *cs, int idx)
+{
+	set_bit(CS_METER_OFFSET + idx, &cs->flags);
+}
+
+static inline void clear_meter(struct cpuset *cs, int idx)
+{
+	clear_bit(CS_METER_OFFSET + idx, &cs->flags);
+}
+
+#ifdef CONFIG_CPUMETER
+static int cpumeter_add_meter_flags(struct dentry *d);
+static int validate_meters(const struct cpuset *cur,
+			   const struct cpuset *trial);
+static int inherit_meters(struct cpuset *cs, struct cpuset *parent);
+static void cpumeter_destroy_meters(struct cpuset *cs);
+
+#else /* CONFIG_CPUMETER */
+
+static inline int cpumeter_add_meter_flags(struct dentry *d) { return 0; }
+
+static inline int validate_meters(const struct cpuset *cur,
+				  const struct cpuset *trial)
+{
+	return 0;
+}
+
+static inline int inherit_meters(struct cpuset *cs, struct cpuset *parent)
+{
+	return 0;
+}
+
+static inline void cpumeter_destroy_meters(struct cpuset *cs) {}
+
+#endif /* CONFIG_CPUMETER */
+
 /*
  * Increment this atomic integer everytime any cpuset changes its
  * mems_allowed value.  Users of cpusets can track this generation
@@ -217,6 +282,7 @@ static void cpuset_diput(struct dentry *
 	if (S_ISDIR(inode->i_mode)) {
 		struct cpuset *cs = dentry->d_fsdata;
 		BUG_ON(!(is_removed(cs)));
+		cpumeter_destroy_meters(cs);
 		kfree(cs);
 	}
 	iput(inode);
@@ -613,6 +679,9 @@ static int validate_change(const struct 
 			return -EINVAL;
 	}
 
+	if (validate_meters(cur, trial))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -1052,7 +1121,10 @@ static struct inode_operations cpuset_di
 	.rmdir = cpuset_rmdir,
 };
 
-static int cpuset_create_file(struct dentry *dentry, int mode)
+static int cpuset_create_file(struct dentry *dentry,
+			      int mode,
+			      struct inode_operations *iop,
+			      struct file_operations *fop)
 {
 	struct inode *inode;
 
@@ -1065,15 +1137,16 @@ static int cpuset_create_file(struct den
 	if (!inode)
 		return -ENOMEM;
 
-	if (S_ISDIR(mode)) {
-		inode->i_op = &cpuset_dir_inode_operations;
-		inode->i_fop = &simple_dir_operations;
+	if (iop)
+		inode->i_op = iop;
+	if (fop)
+		inode->i_fop = fop;
 
+	if (S_ISDIR(mode)) {
 		/* start off with i_nlink == 2 (for "." entry) */
 		inode->i_nlink++;
 	} else if (S_ISREG(mode)) {
 		inode->i_size = 0;
-		inode->i_fop = &cpuset_file_operations;
 	}
 
 	d_instantiate(dentry, inode);
@@ -1100,7 +1173,9 @@ static int cpuset_create_dir(struct cpus
 	dentry = cpuset_get_dentry(parent, name);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
-	error = cpuset_create_file(dentry, S_IFDIR | mode);
+	error = cpuset_create_file(dentry, S_IFDIR | mode,
+				   &cpuset_dir_inode_operations,
+				   &simple_dir_operations);
 	if (!error) {
 		dentry->d_fsdata = cs;
 		parent->d_inode->i_nlink++;
@@ -1119,7 +1194,8 @@ static int cpuset_add_file(struct dentry
 	down(&dir->d_inode->i_sem);
 	dentry = cpuset_get_dentry(dir, cft->name);
 	if (!IS_ERR(dentry)) {
-		error = cpuset_create_file(dentry, 0644 | S_IFREG);
+		error = cpuset_create_file(dentry, 0644 | S_IFREG,
+					   NULL, &cpuset_file_operations);
 		if (!error)
 			dentry->d_fsdata = (void *)cft;
 		dput(dentry);
@@ -1321,6 +1397,8 @@ static int cpuset_populate_dir(struct de
 		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_tasks)) < 0)
 		return err;
+	if ((err = cpumeter_add_meter_flags(cs_dentry)) < 0)
+		return err;
 	return 0;
 }
 
@@ -1359,6 +1437,10 @@ static long cpuset_create(struct cpuset 
 
 	list_add(&cs->sibling, &cs->parent->children);
 
+	err = inherit_meters(cs, parent);
+	if (err < 0)
+		goto err;
+
 	err = cpuset_create_dir(cs, name, mode);
 	if (err < 0)
 		goto err;
@@ -1686,3 +1768,739 @@ char *cpuset_task_status_allowed(struct 
 	buffer += sprintf(buffer, "\n");
 	return buffer;
 }
+
+#ifdef CONFIG_CPUMETER
+/*
+ * cpumeter support routine
+ */
+
+static ssize_t cpumeter_file_read_common(struct file *file, char __user *buf, 
+					 size_t nbytes, loff_t *ppos,
+					 unsigned long val);
+static ssize_t cpumeter_file_get_written_data(const char __user *userbuf,
+					      size_t nbytes,
+					      unsigned long *valp);
+static ssize_t cpumeter_meter_file_read(struct file *file, char __user *buf, 
+					size_t nbytes, loff_t *ppos);
+static ssize_t cpumeter_meter_file_write(struct file *file,
+					 const char __user *userbuf,
+					 size_t nbytes,
+					 loff_t *unused_ppos);
+static ssize_t cpumeter_guar_file_read(struct file *file, char __user *buf, 
+				       size_t nbytes, loff_t *ppos);
+static ssize_t cpumeter_guar_file_write(struct file *file,
+					const char __user *userbuf,
+					size_t nbytes,
+					loff_t *unused_ppos);
+static int cpumeter_add_meter_flag(struct dentry *d, struct cpumeter_ctlr *c);
+static int cpumeter_add_meter_file(struct dentry *dir,
+				   char *name,
+				   int mode,
+				   struct file_operations *fop,
+				   struct cpumeter_ctlr *c);
+static int cpumeter_add_meter_files(struct dentry *d, struct cpumeter_ctlr *c);
+static void cpumeter_remove_meter_files(struct dentry *d,
+					struct cpumeter_ctlr *c);
+
+static char cpumeter_guar_suffix[] = "_guar";
+static char cpumeter_lim_suffix[] = "_lim";
+static char cpumeter_cur_suffix[] = "_cur";
+static char cpumeter_meter_prefix[] = "meter_";
+#define CPUMETER_FNAME_MAX		255
+#define CPUMETER_AFFIX_MAX		\
+	(sizeof(cpumeter_meter_prefix) + sizeof(cpumeter_guar_suffix) - 2)
+
+int cpumeter_register_controller(struct cpumeter_ctlr *ctlr)
+{
+	int namelen;
+
+	namelen = strlen(ctlr->name);
+	if (namelen + CPUMETER_AFFIX_MAX > CPUMETER_FNAME_MAX)
+		return -ENAMETOOLONG;
+
+	down(&cpuset_sem);
+	if (cpumeter_numctlrs >= CPUMETER_CTLRS_MAX) {
+		up(&cpuset_sem);
+		return -ENOSPC;
+	}
+
+	cpumeter_ctlrs[cpumeter_numctlrs] = ctlr;
+	ctlr->idx = cpumeter_numctlrs;
+	cpumeter_numctlrs++;
+	up(&cpuset_sem);
+
+	if (top_cpuset.dentry) {
+		down(&top_cpuset.dentry->d_inode->i_sem);
+		cpumeter_add_meter_flag(top_cpuset.dentry, ctlr);
+		up(&top_cpuset.dentry->d_inode->i_sem);
+	}
+
+	return 0;
+}
+
+void *cpumeter_get_controller_data(struct cpuset *cs,
+				   struct cpumeter_ctlr *c)
+{
+	if (!cs || !is_metered(cs, c->idx))
+		return NULL;
+
+	return cs->meters[c->idx].ctlr_data;
+}
+
+void *cpumeter_get_rcdomain(struct cpuset *cs,
+			    struct cpumeter_ctlr *c)
+{
+	if (!cs || !is_metered(cs, c->idx))
+		return NULL;
+
+	return cs->rcdomains[c->idx];
+}
+
+static ssize_t cpumeter_file_read_common(struct file *file, char __user *buf, 
+					 size_t nbytes, loff_t *ppos,
+					 unsigned long val)
+{
+	char *page, *s, *start;
+	ssize_t retval;
+	size_t n;
+
+	if (!(page = (char *)__get_free_page(GFP_KERNEL)))
+		return -ENOMEM;
+
+	s = page;
+	s += snprintf(s, PAGE_SIZE, "%lu", val);
+	*s++ = '\n';
+	*s = '\0';
+
+	/* Do nothing if *ppos is at the eof or beyond the eof. */
+	if (s - page <= *ppos)
+		return 0;
+
+	start = page + *ppos;
+	n = s - start;
+	retval = n - copy_to_user(buf, start, min(n, nbytes));
+	*ppos += retval;
+
+	free_page((unsigned long)page);
+	return retval;
+}
+
+static ssize_t cpumeter_file_get_written_data(const char __user *userbuf,
+					      size_t nbytes,
+					      unsigned long *valp)
+{
+	char *buffer;
+	int retval = 0;
+
+	/* Crude upper limit on largest legitimate cpulist user might write. */
+	if (nbytes > 100 + 6 * NR_CPUS)
+		return -E2BIG;
+
+	/* +1 for nul-terminator */
+	if ((buffer = kmalloc(nbytes + 1, GFP_KERNEL)) == 0)
+		return -ENOMEM;
+
+	if (copy_from_user(buffer, userbuf, nbytes)) {
+		retval = -EFAULT;
+		goto out;
+	}
+
+	buffer[nbytes] = 0;	/* nul-terminate */
+	*valp = simple_strtoul(buffer, NULL, 0);
+out:
+	kfree(buffer);
+	return retval;
+}
+
+static ssize_t cpumeter_meter_file_read(struct file *file, char __user *buf, 
+					size_t nbytes, loff_t *ppos)
+{
+	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
+	struct cpumeter_ctlr *c = file->f_dentry->d_fsdata;
+	unsigned long val;
+
+	down(&cpuset_sem);
+	val = is_metered(cs, c->idx);
+	up(&cpuset_sem);
+
+	return cpumeter_file_read_common(file, buf, nbytes, ppos, val);
+}
+
+static ssize_t cpumeter_meter_file_write(struct file *file,
+					 const char __user *userbuf,
+					 size_t nbytes,
+					 loff_t *unused_ppos)
+{
+	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
+	struct cpuset *parent;
+	struct cpuset trialcs;
+	struct cpumeter_ctlr *c = file->f_dentry->d_fsdata;
+	struct cpumeter *m;
+	unsigned long val;
+	void *ctlr_data;
+	int turning_on;
+	int retval;
+
+	retval = cpumeter_file_get_written_data(userbuf, nbytes, &val);
+	if (retval)
+		return retval;
+
+	turning_on = (val != 0);
+
+	/*
+	 * keeping the lock order (i_sem > cpuset_sem).
+	 * i_sem should be held because we are going to create/remove files.
+	 */
+	down(&cs->dentry->d_inode->i_sem);
+	down(&cpuset_sem);
+	if (is_removed(cs)) {
+		retval = -ENODEV;
+		goto out;
+	}
+
+	parent = cs->parent;
+	m = &cs->meters[c->idx];
+	ctlr_data = m->ctlr_data;
+	trialcs = *cs;
+	if (turning_on)
+		set_meter(&trialcs, c->idx);
+	else
+		clear_meter(&trialcs, c->idx);
+
+	retval = validate_change(cs, &trialcs);
+	if (retval < 0)
+		goto out;
+
+	if (is_metered(cs, c->idx) == is_metered(&trialcs, c->idx)) {
+		retval = nbytes;
+		goto out;
+	}
+
+	if (!turning_on) {
+		if (c->set_guar) {
+			c->set_guar(cs->meters[c->idx].ctlr_data, 0);
+			/* Do not set cs->meters[c->idx].guar=0 here. */
+		}
+		c->destroy(cs->meters[c->idx].ctlr_data);
+		cs->meters[c->idx].ctlr_data = NULL;
+
+		if (parent && is_metered(parent, c->idx)) {
+			parent->meters[c->idx].guar += cs->meters[c->idx].guar;
+			cs->rcdomains[c->idx] = NULL;
+		} else {
+			c->destroy_rcdomain(cs->rcdomains[c->idx]);
+			cs->rcdomains[c->idx] = NULL;
+		}
+
+		cs->meters[c->idx].guar = 0;
+		clear_meter(cs, c->idx);
+	} else {
+		if (parent && is_metered(parent, c->idx)) {
+			cs->rcdomains[c->idx] = parent->rcdomains[c->idx];
+
+			/* Initial guarantee for children should be 0% */
+			cs->meters[c->idx].guar = 0;
+		} else {
+			cs->rcdomains[c->idx] =
+				c->create_rcdomain(cs,
+						   cs->cpus_allowed,
+						   cs->mems_allowed);
+			if (!cs->rcdomains[c->idx]) {
+				retval = -ENOMEM;
+				goto out;
+			}
+
+			cs->meters[c->idx].guar = 100;
+		}
+
+		cs->meters[c->idx].ctlr_data =
+			c->create(cs->rcdomains[c->idx], cs);
+		if (!cs->meters[c->idx].ctlr_data) {
+			if (parent && is_metered(parent, c->idx)) {
+				c->destroy_rcdomain(cs->rcdomains[c->idx]);
+				cs->rcdomains[c->idx] = NULL;
+			}
+			retval = -ENOMEM;
+			goto out;
+		}
+
+		set_meter(cs, c->idx);
+		if (c->set_guar) {
+			c->set_guar(cs->meters[c->idx].ctlr_data,
+				    cs->meters[c->idx].guar);
+		}
+	}
+
+	up(&cpuset_sem);
+
+	if (turning_on)
+		cpumeter_add_meter_files(cs->dentry, c);
+	else
+		cpumeter_remove_meter_files(cs->dentry, c);
+
+	up(&cs->dentry->d_inode->i_sem);
+	return retval;
+
+out:
+	up(&cpuset_sem);
+	up(&cs->dentry->d_inode->i_sem);
+
+	return retval;
+}
+
+static struct file_operations cpumeter_meter_file_operations = {
+	.read = cpumeter_meter_file_read,
+	.write = cpumeter_meter_file_write,
+	.llseek = generic_file_llseek,
+	.open = generic_file_open,
+};
+
+static ssize_t cpumeter_guar_file_read(struct file *file, char __user *buf, 
+				       size_t nbytes, loff_t *ppos)
+{
+	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
+	struct cpumeter_ctlr *c = file->f_dentry->d_fsdata;
+	unsigned long val;
+
+	down(&cpuset_sem);
+	val = cs->meters[c->idx].guar;
+	up(&cpuset_sem);
+
+	return cpumeter_file_read_common(file, buf, nbytes, ppos, val);
+}
+
+static ssize_t cpumeter_guar_file_write(struct file *file,
+					const char __user *userbuf,
+					size_t nbytes,
+					loff_t *unused_ppos)
+{
+	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
+	struct cpuset *parent;
+	struct cpumeter_ctlr *c = file->f_dentry->d_fsdata;
+	struct cpumeter *m, *pm;
+	unsigned long val;
+	long diff;
+	int retval;
+
+	retval = cpumeter_file_get_written_data(userbuf, nbytes, &val);
+	if (retval)
+		return retval;
+
+	m = &cs->meters[c->idx];
+	down(&cpuset_sem);
+	if (is_removed(cs)) {
+		retval = -ENODEV;
+		goto out;
+	}
+
+	if (c->set_lim && m->lim && val > m->lim) {
+		retval = -EINVAL;
+		goto out;
+	}
+
+	/* If the meter is toplevel, the guarantee can not be changed. */
+	parent = cs->parent;
+	if (!parent || !is_metered(parent, c->idx)) {
+		retval = -EINVAL;
+		goto out;
+	}
+
+	pm = &parent->meters[c->idx];
+	diff = (long)val - (long)m->guar;
+	if (diff == 0) {
+		retval = nbytes;
+		goto out;
+	} else if (diff > (long)pm->guar) {
+		retval = -ENOSPC;
+		goto out;
+	}
+
+	retval = c->set_guar(m->ctlr_data, val);
+	if (retval == 0) {
+		retval = c->set_guar(pm->ctlr_data, pm->guar - diff);
+		if (retval < 0) {
+			c->set_guar(m->ctlr_data, m->guar);
+			goto out;
+		} else {
+			pm->guar -= diff;
+			m->guar  += diff;
+			retval = nbytes;
+		}
+	}
+out:
+	up(&cpuset_sem);
+	return retval;
+}
+
+static struct file_operations cpumeter_guar_file_operations = {
+	.read = cpumeter_guar_file_read,
+	.write = cpumeter_guar_file_write,
+	.llseek = generic_file_llseek,
+	.open = generic_file_open,
+};
+
+static ssize_t cpumeter_lim_file_read(struct file *file, char __user *buf, 
+				      size_t nbytes, loff_t *ppos)
+{
+	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
+	struct cpumeter_ctlr *c = file->f_dentry->d_fsdata;
+	unsigned long val;
+
+	down(&cpuset_sem);
+	val = cs->meters[c->idx].lim;
+	up(&cpuset_sem);
+
+	return cpumeter_file_read_common(file, buf, nbytes, ppos, val);
+}
+
+static ssize_t cpumeter_lim_file_write(struct file *file,
+				       const char __user *userbuf,
+				       size_t nbytes,
+				       loff_t *unused_ppos)
+{
+	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
+	struct cpumeter_ctlr *c = file->f_dentry->d_fsdata;
+	struct cpumeter *m;
+	unsigned long val;
+	int retval;
+
+	retval = cpumeter_file_get_written_data(userbuf, nbytes, &val);
+	if (retval)
+		return retval;
+
+	m = &cs->meters[c->idx];
+	down(&cpuset_sem);
+	if (is_removed(cs)) {
+		retval = -ENODEV;
+		goto out;
+	}
+
+	if (val && c->set_guar && val < m->guar) {
+		retval = -EINVAL;
+		goto out;
+	}
+
+	retval = c->set_lim(m->ctlr_data, val);
+	if (retval == 0) {
+		m->lim = val;
+		retval = nbytes;
+	}
+out:
+	up(&cpuset_sem);
+	return retval;
+}
+
+static struct file_operations cpumeter_lim_file_operations = {
+	.read = cpumeter_lim_file_read,
+	.write = cpumeter_lim_file_write,
+	.llseek = generic_file_llseek,
+	.open = generic_file_open,
+};
+
+static ssize_t cpumeter_cur_file_read(struct file *file, char __user *buf, 
+				      size_t nbytes, loff_t *ppos)
+{
+	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
+	struct cpumeter_ctlr *c = file->f_dentry->d_fsdata;
+	struct cpumeter *m;
+	unsigned long val;
+	int err;
+
+	m = &cs->meters[c->idx];
+
+	down(&cpuset_sem);
+	err = c->get_cur(m->ctlr_data, &val);
+	if (err) {
+		up(&cpuset_sem);
+		return err;
+	}
+	up(&cpuset_sem);
+
+	return cpumeter_file_read_common(file, buf, nbytes, ppos, val);
+}
+
+static struct file_operations cpumeter_cur_file_operations = {
+	.read = cpumeter_cur_file_read,
+	.llseek = generic_file_llseek,
+	.open = generic_file_open,
+};
+
+
+static int cpumeter_add_meter_flag(struct dentry *d, struct cpumeter_ctlr *c)
+{
+	char name[CPUMETER_FNAME_MAX + 1];
+	struct dentry *dentry;
+	int err;
+
+	sprintf(name, "%s%s", cpumeter_meter_prefix, c->name);
+	dentry = cpuset_get_dentry(d, name);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
+	err = cpuset_create_file(dentry, 0644 | S_IFREG, NULL,
+				 &cpumeter_meter_file_operations);
+	if (err) {
+		dput(dentry);
+		return err;
+	}
+
+	dentry->d_fsdata = c;
+	dput(dentry);
+
+	if (is_metered(__d_cs(d), c->idx)) {
+		err = cpumeter_add_meter_files(d, c);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int cpumeter_add_meter_flags(struct dentry *d)
+{
+	int err = 0;
+	int i;
+
+	/* cpuset_sem needed because this function references cs->flags. */
+	down(&cpuset_sem);
+	for (i = 0; i < cpumeter_numctlrs; i++) {
+		err = cpumeter_add_meter_flag(d, cpumeter_ctlrs[i]);
+		if (err)
+			break;
+	}
+
+	up(&cpuset_sem);
+
+	return err;
+}
+
+static int cpumeter_add_meter_file(struct dentry *dir,
+				   char *name,
+				   int mode,
+				   struct file_operations *fop,
+				   struct cpumeter_ctlr *c)
+{
+	struct dentry *dentry;
+	int error;
+
+	dentry = cpuset_get_dentry(dir, name);
+	if (!IS_ERR(dentry)) {
+		error = cpuset_create_file(dentry, mode, NULL, fop);
+		if (!error)
+			dentry->d_fsdata = c;
+		dput(dentry);
+	} else
+		error = PTR_ERR(dentry);
+
+	return error;
+}
+
+static int cpumeter_add_meter_files(struct dentry *d, struct cpumeter_ctlr *c)
+{
+	char name[CPUMETER_FNAME_MAX + 1];
+	int err;
+
+	if (c->set_guar) {
+		sprintf(name, "%s%s%s", cpumeter_meter_prefix, c->name,
+			cpumeter_guar_suffix);
+		err = cpumeter_add_meter_file(d, name, 0644 | S_IFREG,
+					      &cpumeter_guar_file_operations,
+					      c);
+		if (err < 0)
+			return err;
+	}
+
+	if (c->set_lim) {
+		sprintf(name, "%s%s%s", cpumeter_meter_prefix, c->name,
+			cpumeter_lim_suffix);
+		err = cpumeter_add_meter_file(d, name, 0644 | S_IFREG,
+					      &cpumeter_lim_file_operations,
+					      c);
+		if (err < 0)
+			return err;
+	}
+
+	if (c->get_cur) {
+		sprintf(name, "%s%s%s", cpumeter_meter_prefix, c->name,
+			cpumeter_cur_suffix);
+		err = cpumeter_add_meter_file(d, name, 0444 | S_IFREG,
+					      &cpumeter_cur_file_operations,
+					      c);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static void cpumeter_remove_meter_files(struct dentry *dentry,
+					struct cpumeter_ctlr *c)
+{
+	struct list_head *node, *n;
+	struct inode *inode;
+
+	dget(dentry);
+	spin_lock(&dcache_lock);
+	node = dentry->d_subdirs.next;
+	while (node != &dentry->d_subdirs) {
+		struct dentry *d = list_entry(node, struct dentry, d_child);
+		n = node->next;
+
+		inode = d->d_inode;
+		if (!inode)
+			goto next;
+
+		if (d->d_fsdata != c)
+			goto next;
+
+		if (inode->i_fop != &cpumeter_guar_file_operations &&
+		    inode->i_fop != &cpumeter_lim_file_operations &&
+		    inode->i_fop != &cpumeter_cur_file_operations)
+			goto next;
+
+		list_del_init(node);
+		d = dget_locked(d);
+		spin_unlock(&dcache_lock);
+		d_delete(d);
+		simple_unlink(dentry->d_inode, d);
+		dput(d);
+		spin_lock(&dcache_lock);
+
+		/*
+		 * this might be paranoid, but we have released 
+		 * the dcache_lock...
+		 */
+		n = dentry->d_subdirs.next;
+	next:
+		node = n;
+	}
+
+	spin_unlock(&dcache_lock);
+	dput(dentry);
+}
+
+static int validate_meters(const struct cpuset *cur,
+			   const struct cpuset *trial)
+{
+	struct cpuset *parent;
+	int is_anything_metered = 0;
+	int is_changed;
+	int i;
+
+	parent = cur->parent;
+
+	/* checks for flag bits */
+	for (i = 0; i < cpumeter_numctlrs; i++) {
+		is_changed = (is_metered(trial, i) != is_metered(cur, i));
+
+		/* meter flags can not be changed if the cs has any child. */
+		if (!list_empty(&cur->children) && is_changed)
+			return -EINVAL;
+
+		/* meter flags can not be changed if the parent is metered */
+		if (parent && is_metered(parent, i) && is_changed)
+			return -EINVAL;
+
+		if (is_metered(cur, i))
+			is_anything_metered++;
+	}
+
+	/* checks for cpus & mems changes */
+	if (is_anything_metered) {
+		if (!cpus_equal(cur->cpus_allowed, trial->cpus_allowed))
+			return -EINVAL;
+
+		if (!nodes_equal(cur->mems_allowed, trial->mems_allowed))
+			return -EINVAL;
+	}
+
+	/* checks for guarantee values */
+	/* XXX  not yet */
+
+	return 0;
+}
+
+static int inherit_meters(struct cpuset *cs, struct cpuset *parent)
+{
+	struct cpumeter_ctlr *c;
+	int is_anything_metered = 0;
+	int i;
+
+	/* initialize meters */
+	memset(cs->meters, 0, sizeof(cs->meters));
+
+	/* parent == NULL means the root cpuset.  no need to inherit. */
+	if (!parent)
+		return 0;
+
+	/* inerit meter flags and rcdomains */
+	for (i = 0; i < cpumeter_numctlrs; i++) {
+		cs->rcdomains[i] = parent->rcdomains[i];
+		if (!is_metered(parent, i))
+			continue;
+
+		set_meter(cs, i);
+		c = cpumeter_ctlrs[i];
+		cs->meters[i].ctlr_data =
+			c->create(cs->rcdomains[i], cs);
+		if (!cs->meters[i].ctlr_data)
+			goto failed;
+
+		is_anything_metered++;
+	}
+
+	if (is_anything_metered) {
+		/* inherit cpus and mems. */
+		cs->cpus_allowed = parent->cpus_allowed;
+		cs->mems_allowed = parent->mems_allowed;
+	}
+
+	return 0;
+
+failed:
+	for (i = 0; i < cpumeter_numctlrs; i++) {
+		if (!is_metered(cs, i))
+			continue;
+
+		c = cpumeter_ctlrs[i];
+		if (cs->meters[i].ctlr_data)
+			c->destroy(cs->meters[i].ctlr_data);
+		cs->meters[i].ctlr_data = NULL;
+		clear_meter(cs, i);
+	}
+
+	return -ENOMEM;
+}
+
+static void cpumeter_destroy_meters(struct cpuset *cs)
+{
+	struct cpuset *parent = cs->parent;
+	struct cpumeter_ctlr *c;
+	int i;
+
+	for (i = 0; i < cpumeter_numctlrs; i++) {
+		c = cpumeter_ctlrs[i];
+		if (cs->meters[i].ctlr_data) {
+			if (c->set_guar)
+				c->set_guar(cs->meters[i].ctlr_data, 0);
+			c->destroy(cs->meters[i].ctlr_data);
+			cs->meters[i].ctlr_data = NULL;
+		}
+
+		if (parent && is_metered(parent, i)) {
+			/* the rcdomain is inherited from the parent. */
+			parent->meters[i].guar += cs->meters[i].guar;
+			if (c->set_guar)
+				c->set_guar(parent->meters[i].ctlr_data,
+					    parent->meters[i].guar);
+			cs->rcdomains[i] = NULL;
+			continue;
+		}
+
+		if (cs->rcdomains[i]) {
+			c->destroy_rcdomain(cs->rcdomains[i]);
+			cs->rcdomains[i] = NULL;
+		}
+	}
+}
+#endif /* CONFIG_CPUMETER */
