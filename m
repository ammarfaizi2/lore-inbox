Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbVIHFlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbVIHFlu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 01:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbVIHFlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 01:41:50 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:29122 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932575AbVIHFlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 01:41:49 -0400
Date: Thu, 8 Sep 2005 14:41:47 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] SUBCPUSETS: add subcpusets framework to the CPUSETS
X-Mailer: Sylpheed version 2.1.0+svn (GTK+ 2.6.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20050908054147.CF99B70037@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds subcpusets framework code to the CPUSETS.
Subcpusets are meant for subdividing cpuset resources.
A few files are added in order to control the guarantee and the limit
of the resource amount to the cpuset filesystem.  Also, interfaces
for the specific resource controller like CPU and memory.

Signed-off-by: KUROSAWA Takahiro <kurosawa@valinux.co.jp>


--- from-0001/include/linux/cpuset.h
+++ to-work/include/linux/cpuset.h	2005-09-07 20:04:26.000000000 +0900
@@ -14,6 +14,46 @@
 
 #ifdef CONFIG_CPUSETS
 
+#ifdef CONFIG_SUBCPUSETS
+struct subcpuset_ctlr {
+	char *name;		/* controller name */
+	int idx;		/* used by subcpuset core */
+	void *(*create_toplevel)(struct cpuset *cs, cpumask_t cpus,
+				 nodemask_t mems);
+	void (*destroy_toplevel)(void *top);
+	void *(*create)(void *top, struct cpuset *cs);
+	void (*destroy)(void *ctldata);
+	int (*set_lim)(void *ctldata, unsigned long val);
+	int (*set_guar)(void *ctldata, unsigned long val);
+	int (*get_cur)(void *ctldata, unsigned long *valp);
+};
+
+extern int subcpuset_register_controller(struct subcpuset_ctlr *ctlr);
+extern void *subcpuset_get_controller_data(struct cpuset *cs,
+					   struct subcpuset_ctlr *ctlr);
+extern void *subcpuset_get_toplevel_data(struct cpuset *cs,
+					 struct subcpuset_ctlr *ctlr);
+#else /* CONFIG_SUBCPUSETS */
+struct subcpuset_ctlr;
+
+static inline int subcpuset_register_controller(struct subcpuset_ctlr *ctlr)
+{
+	return -EINVAL;
+}
+
+static inline void *subcpuset_get_controller_data(struct cpuset *cs,
+						  struct subcpuset_ctlr *ctlr)
+{
+	return NULL;
+}
+
+static inline void *subcpuset_get_toplevel_data(struct cpuset *cs,
+						struct subcpuset_ctlr *ctlr)
+{
+	return NULL;
+}
+#endif /* CONFIG_SUBCPUSETS */
+
 extern int cpuset_init(void);
 extern void cpuset_init_smp(void);
 extern void cpuset_fork(struct task_struct *p);
--- from-0001/init/Kconfig
+++ to-work/init/Kconfig	2005-09-07 20:04:26.000000000 +0900
@@ -238,6 +238,15 @@ config CPUSETS
 
 	  Say N if unsure.
 
+config SUBCPUSETS
+	bool "Subcpuset support"
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
--- from-0002/kernel/cpuset.c
+++ to-work/kernel/cpuset.c	2005-09-08 11:42:49.404111648 +0900
@@ -55,6 +55,18 @@
 
 #define CPUSET_SUPER_MAGIC 		0x27e0eb
 
+#ifdef CONFIG_SUBCPUSETS
+#define SUBCPUSET_CTLRS_MAX		16
+
+struct subcpuset_resource {
+	void *ctlr_data;		/* resource controller data */
+	unsigned long guar;		/* resource guarantee */
+	unsigned long lim;		/* resource limit */
+};
+
+static struct subcpuset_ctlr *subcpuset_ctlrs[SUBCPUSET_CTLRS_MAX];
+#endif
+
 struct cpuset {
 	unsigned long flags;		/* "unsigned long" so bitops work */
 	cpumask_t cpus_allowed;		/* CPUs allowed to tasks in cpuset */
@@ -77,6 +89,18 @@ struct cpuset {
 	 * recent time this cpuset changed its mems_allowed.
 	 */
 	 int mems_generation;
+#ifdef CONFIG_SUBCPUSETS
+	union {
+		/*
+		 * topdata:   used for the toplevel cpuset of subcpusets
+		 *            to keep track of total ammount of resources.
+		 * resources: used for the subcpuset to keep track of 
+		 *            resources assigned to it.
+		 */
+		void *topdata[SUBCPUSET_CTLRS_MAX];
+		struct subcpuset_resource resources[SUBCPUSET_CTLRS_MAX];
+	} scs_u;
+#endif /* CONFIG_SUBCPUSETS */
 };
 
 /* bits in struct cpuset flags field */
@@ -84,7 +108,8 @@ typedef enum {
 	CS_CPU_EXCLUSIVE,
 	CS_MEM_EXCLUSIVE,
 	CS_REMOVED,
-	CS_NOTIFY_ON_RELEASE
+	CS_NOTIFY_ON_RELEASE,
+	CS_SUBCPUSET_TOP
 } cpuset_flagbits_t;
 
 /* convenient tests for these bits */
@@ -108,6 +133,64 @@ static inline int notify_on_release(cons
 	return !!test_bit(CS_NOTIFY_ON_RELEASE, &cs->flags);
 }
 
+#ifdef CONFIG_SUBCPUSETS
+static inline int is_subcpuset_top(const struct cpuset *cs)
+{
+	return !!test_bit(CS_SUBCPUSET_TOP, &cs->flags);
+}
+
+static inline int is_subcpuset(const struct cpuset *cs)
+{
+	if (!cs->parent)
+		return 0;
+
+	return is_subcpuset_top(cs->parent);
+}
+
+static int subcpuset_create_ctlr_data(struct cpuset *cs, struct cpuset *parent);
+static void subcpuset_destroy_ctlr_data(struct cpuset *cs);
+static int subcpuset_create_top_data(struct cpuset *cs);
+static void subcpuset_destroy_top_data(struct cpuset *cs);
+static int subcpuset_update_top_data(struct cpuset *cs);
+
+static ssize_t subcpuset_file_read_common(struct file *file, char __user *buf, 
+					  size_t nbytes, loff_t *ppos,
+					  unsigned long val);
+static ssize_t subcpuset_guar_file_read(struct file *file, char __user *buf, 
+					size_t nbytes, loff_t *ppos);
+static ssize_t subcpuset_lim_file_read(struct file *file, char __user *buf, 
+				       size_t nbytes, loff_t *ppos);
+static ssize_t subcpuset_cur_file_read(struct file *file, char __user *buf, 
+				       size_t nbytes, loff_t *ppos);
+static ssize_t subcpuset_file_get_written_data(const char __user *userbuf,
+					       size_t nbytes,
+					       unsigned long *valp);
+static ssize_t subcpuset_lim_file_write(struct file *file,
+					const char __user *userbuf,
+					size_t nbytes,
+					loff_t *unused_ppos);
+static int subcpuset_add_file(struct dentry *dir,
+			      char *name,
+			      int mode,
+			      const struct subcpuset_ctlr *c,
+			      struct file_operations *fop);
+static int cpuset_add_subcpuset_top(struct dentry *d);
+static int subcpuset_populate_dir(struct dentry *cs_dentry);
+
+#else /* CONFIG_SUBCPUSETS */
+
+static inline int is_subcpuset_top(const struct cpuset *cs) { return 0; }
+static inline int is_subcpuset(const struct cpuset *cs) { return 0; }
+static inline int subcpuset_create_ctlr_data(struct cpuset *cs, struct cpuset *parent) { return 0; }
+static inline void subcpuset_destroy_ctlr_data(struct cpuset *cs) {}
+static inline int subcpuset_create_top_data(struct cpuset *cs) { return 0; }
+static inline void subcpuset_destroy_top_data(struct cpuset *cs) {}
+static inline int subcpuset_update_top_data(struct cpuset *cs) { return 0; }
+static inline int cpuset_add_subcpuset_top(struct dentry *d) { return 0; }
+static inline int subcpuset_populate_dir(struct dentry *cs_dentry) { return 0; }
+
+#endif /* CONFIG_SUBCPUSETS */
+
 /*
  * Increment this atomic integer everytime any cpuset changes its
  * mems_allowed value.  Users of cpusets can track this generation
@@ -217,6 +300,10 @@ static void cpuset_diput(struct dentry *
 	if (S_ISDIR(inode->i_mode)) {
 		struct cpuset *cs = dentry->d_fsdata;
 		BUG_ON(!(is_removed(cs)));
+		if (is_subcpuset_top(cs))
+			subcpuset_destroy_top_data(cs);
+		if (is_subcpuset(cs))
+			subcpuset_destroy_ctlr_data(cs);
 		kfree(cs);
 	}
 	iput(inode);
@@ -593,6 +680,36 @@ static int validate_change(const struct 
 			return -EBUSY;
 	}
 
+	/* subcpuset_top can not be changed when cur has any children. */
+	if (!list_empty(&cur->children) &&
+	    (is_subcpuset_top(trial) != is_subcpuset_top(cur)))
+		return -EINVAL;
+
+	/* prevent from changing values if is_subcpuset_top() */
+	if (is_subcpuset_top(cur) && is_subcpuset_top(trial)) {
+		if (is_cpu_exclusive(trial) != is_cpu_exclusive(cur))
+			return -EBUSY;
+		if (is_mem_exclusive(trial) != is_mem_exclusive(cur))
+			return -EBUSY;
+		if (notify_on_release(trial) != notify_on_release(cur))
+			return -EBUSY;
+		if (!cpus_equal(trial->cpus_allowed, cur->cpus_allowed))
+			return -EBUSY;
+		if (!nodes_equal(trial->mems_allowed, cur->mems_allowed))
+			return -EBUSY;
+	}
+
+	/*
+	 * Do not allow to set subcpuset_top to 1 if neither cpus nor 
+	 * mems is empty.
+	 */
+	if (is_subcpuset_top(trial)) {
+		if (cpus_empty(cur->cpus_allowed))
+			return -EBUSY;
+		if (nodes_empty(cur->mems_allowed))
+			return -EBUSY;
+	}
+
 	/* Remaining checks don't apply to root cpuset */
 	if ((par = cur->parent) == NULL)
 		return 0;
@@ -736,7 +853,7 @@ static int update_flag(cpuset_flagbits_t
 {
 	int turning_on;
 	struct cpuset trialcs;
-	int err, cpu_exclusive_changed;
+	int err, cpu_exclusive_changed, subcpuset_top_changed;
 
 	turning_on = (simple_strtoul(buf, NULL, 10) != 0);
 
@@ -751,6 +868,8 @@ static int update_flag(cpuset_flagbits_t
 		return err;
 	cpu_exclusive_changed =
 		(is_cpu_exclusive(cs) != is_cpu_exclusive(&trialcs));
+	subcpuset_top_changed =
+		(is_subcpuset_top(cs) != is_subcpuset_top(&trialcs));
 	if (turning_on)
 		set_bit(bit, &cs->flags);
 	else
@@ -758,6 +877,13 @@ static int update_flag(cpuset_flagbits_t
 
 	if (cpu_exclusive_changed)
                 update_cpu_domains(cs);
+	if (subcpuset_top_changed) {
+		err = subcpuset_update_top_data(cs);
+		if (err) {
+			change_bit(bit, &cs->flags);
+			return err;
+		}
+	}
 	return 0;
 }
 
@@ -767,10 +893,20 @@ static int attach_task(struct cpuset *cs
 	struct task_struct *tsk;
 	struct cpuset *oldcs;
 	cpumask_t cpus;
+	nodemask_t mems;
 
 	if (sscanf(pidbuf, "%d", &pid) != 1)
 		return -EIO;
-	if (cpus_empty(cs->cpus_allowed) || nodes_empty(cs->mems_allowed))
+
+	if (is_subcpuset(cs)) {
+		cpus = cs->parent->cpus_allowed;
+		mems = cs->parent->mems_allowed;
+	} else {
+		cpus = cs->cpus_allowed;
+		mems = cs->mems_allowed;
+	}
+
+	if (cpus_empty(cpus) || nodes_empty(mems))
 		return -ENOSPC;
 
 	if (pid) {
@@ -826,6 +962,7 @@ typedef enum {
 	FILE_MEM_EXCLUSIVE,
 	FILE_NOTIFY_ON_RELEASE,
 	FILE_TASKLIST,
+	FILE_SUBCPUSET_TOP,
 } cpuset_filetype_t;
 
 static ssize_t cpuset_common_file_write(struct file *file, const char __user *userbuf,
@@ -878,6 +1015,9 @@ static ssize_t cpuset_common_file_write(
 	case FILE_TASKLIST:
 		retval = attach_task(cs, buffer, &pathbuf);
 		break;
+	case FILE_SUBCPUSET_TOP:
+		retval = update_flag(CS_SUBCPUSET_TOP, cs, buffer);
+		break;
 	default:
 		retval = -EINVAL;
 		goto out2;
@@ -977,6 +1117,9 @@ static ssize_t cpuset_common_file_read(s
 	case FILE_NOTIFY_ON_RELEASE:
 		*s++ = notify_on_release(cs) ? '1' : '0';
 		break;
+	case FILE_SUBCPUSET_TOP:
+		*s++ = is_subcpuset_top(cs) ? '1' : '0';
+		break;
 	default:
 		retval = -EINVAL;
 		goto out;
@@ -1056,7 +1199,10 @@ static struct inode_operations cpuset_di
 	.rmdir = cpuset_rmdir,
 };
 
-static int cpuset_create_file(struct dentry *dentry, int mode)
+static int cpuset_create_file(struct dentry *dentry,
+			      int mode,
+			      struct inode_operations *iop,
+			      struct file_operations *fop)
 {
 	struct inode *inode;
 
@@ -1069,15 +1215,16 @@ static int cpuset_create_file(struct den
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
@@ -1104,7 +1251,9 @@ static int cpuset_create_dir(struct cpus
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
@@ -1123,7 +1272,8 @@ static int cpuset_add_file(struct dentry
 	down(&dir->d_inode->i_sem);
 	dentry = cpuset_get_dentry(dir, cft->name);
 	if (!IS_ERR(dentry)) {
-		error = cpuset_create_file(dentry, 0644 | S_IFREG);
+		error = cpuset_create_file(dentry, 0644 | S_IFREG,
+					   NULL, &cpuset_file_operations);
 		if (!error)
 			dentry->d_fsdata = (void *)cft;
 		dput(dentry);
@@ -1325,6 +1475,8 @@ static int cpuset_populate_dir(struct de
 		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_tasks)) < 0)
 		return err;
+	if ((err = cpuset_add_subcpuset_top(cs_dentry)) < 0)
+		return err;
 	return 0;
 }
 
@@ -1342,10 +1494,22 @@ static long cpuset_create(struct cpuset 
 	struct cpuset *cs;
 	int err;
 
+	/* subcpusets can not have any children. */
+	if (is_subcpuset(parent))
+		return -EINVAL;
+
 	cs = kmalloc(sizeof(*cs), GFP_KERNEL);
 	if (!cs)
 		return -ENOMEM;
 
+	if (is_subcpuset_top(parent)) {
+		err = subcpuset_create_ctlr_data(cs, parent);
+		if (err) {
+			kfree(cs);
+			return err;
+		}
+	}
+
 	down(&cpuset_sem);
 	refresh_mems();
 	cs->flags = 0;
@@ -1374,10 +1538,17 @@ static long cpuset_create(struct cpuset 
 	 */
 	up(&cpuset_sem);
 
-	err = cpuset_populate_dir(cs->dentry);
+	if (is_subcpuset_top(parent))
+		err = subcpuset_populate_dir(cs->dentry);
+	else
+		err = cpuset_populate_dir(cs->dentry);
+
 	/* If err < 0, we have a half-filled directory - oh well ;) */
 	return 0;
 err:
+	if (is_subcpuset_top(parent))
+		subcpuset_destroy_ctlr_data(cs);
+
 	list_del(&cs->sibling);
 	up(&cpuset_sem);
 	kfree(cs);
@@ -1690,3 +1861,462 @@ char *cpuset_task_status_allowed(struct 
 	buffer += sprintf(buffer, "\n");
 	return buffer;
 }
+
+#ifdef CONFIG_SUBCPUSETS
+/*
+ * subcpuset support routine
+ */
+
+static char subcpuset_guar_suffix[] = "_guar";
+static char subcpuset_lim_suffix[] = "_lim";
+static char subcpuset_cur_suffix[] = "_cur";
+#define SUBCPUSET_FNAME_MAX		255
+#define SUBCPUSET_FSUFFIX_MAX		(sizeof(subcpuset_guar_suffix) - 1)
+
+int subcpuset_register_controller(struct subcpuset_ctlr *ctlr)
+{
+	int idx;
+
+	if (strlen(ctlr->name) + SUBCPUSET_FSUFFIX_MAX > SUBCPUSET_FNAME_MAX)
+		return -ENAMETOOLONG;
+		    
+	for (idx = 0; idx < SUBCPUSET_CTLRS_MAX; idx++) {
+		if (subcpuset_ctlrs[idx] == NULL)
+			break;
+	}
+
+	if (idx >= SUBCPUSET_CTLRS_MAX)
+		return -ENOSPC;
+
+	subcpuset_ctlrs[idx] = ctlr;
+	ctlr->idx = idx;
+
+	return 0;
+}
+
+void *subcpuset_get_controller_data(struct cpuset *cs,
+				    struct subcpuset_ctlr *ctlr)
+{
+	if (!cs || !is_subcpuset(cs))
+		return NULL;
+
+	return cs->scs_u.resources[ctlr->idx].ctlr_data;
+}
+
+void *subcpuset_get_toplevel_data(struct cpuset *cs,
+				  struct subcpuset_ctlr *ctlr)
+{
+	if (!cs || !is_subcpuset(cs))
+		return NULL;
+
+	return cs->parent->scs_u.topdata[ctlr->idx];
+}
+
+static int subcpuset_create_top_data(struct cpuset *cs)
+{
+	struct subcpuset_ctlr **cp;
+	void **p;
+	int i;
+
+	memset(cs->scs_u.topdata, 0, sizeof(cs->scs_u.topdata));
+
+	p = cs->scs_u.topdata;
+	cp = subcpuset_ctlrs;
+	for (i = 0; i < SUBCPUSET_CTLRS_MAX; i++, p++, cp++) {
+		if (*cp && (*cp)->create_toplevel) {
+			*p = (*cp)->create_toplevel(cs, cs->cpus_allowed,
+						    cs->mems_allowed);
+			if (! *p)
+				goto failed;
+		}
+	}
+
+	return 0;
+
+failed:
+	p = cs->scs_u.topdata;
+	cp = subcpuset_ctlrs;
+	for (i = 0; i < SUBCPUSET_CTLRS_MAX; i++, p++, cp++) {
+		if (*p)
+			(*cp)->destroy_toplevel(*p);
+		*p = NULL;
+	}			
+
+	return -ENOMEM;
+}
+
+static void subcpuset_destroy_top_data(struct cpuset *cs)
+{
+	struct subcpuset_ctlr **cp;
+	void **p;
+	int i;
+
+	p = cs->scs_u.topdata;
+	cp = subcpuset_ctlrs;
+	for (i = 0; i < SUBCPUSET_CTLRS_MAX; i++, p++, cp++) {
+		if (*p)
+			(*cp)->destroy_toplevel(*p);
+		*p = NULL;
+	}
+}
+
+static int subcpuset_update_top_data(struct cpuset *cs)
+{
+	int err = 0;
+
+	if (is_subcpuset_top(cs))
+		err = subcpuset_create_top_data(cs);
+	else
+		subcpuset_destroy_top_data(cs);
+
+	return err;
+}
+
+static int subcpuset_create_ctlr_data(struct cpuset *cs, struct cpuset *parent)
+{
+	void **topdata = parent->scs_u.topdata;
+	struct subcpuset_resource *r;
+	struct subcpuset_ctlr **cp;
+	int i;
+
+	/*
+	 * The cpuset "cs" is not exported to the cpuset tree yet.
+	 * We can modify its members without locking.
+	 */
+
+	memset(cs->scs_u.resources, 0, sizeof(cs->scs_u.resources));
+
+	r = cs->scs_u.resources;
+	cp = subcpuset_ctlrs;
+	for (i = 0; i < SUBCPUSET_CTLRS_MAX; i++, r++, cp++) {
+		if (!*cp)
+			continue;
+
+		r->ctlr_data = (*cp)->create(topdata[i], cs);
+		if (!r->ctlr_data)
+			goto failed;
+
+		r->guar = r->lim = 0;
+	}
+
+	return 0;
+
+failed:
+	r = cs->scs_u.resources;
+	cp = subcpuset_ctlrs;
+	for (i = 0; i < SUBCPUSET_CTLRS_MAX; i++, r++, cp++) {
+		if (!*cp)
+			continue;
+
+		if (r->ctlr_data)
+			(*cp)->destroy(r->ctlr_data);
+		r->ctlr_data = NULL;
+	}
+
+	return -ENOMEM;
+}
+
+static void subcpuset_destroy_ctlr_data(struct cpuset *cs)
+{
+	struct subcpuset_resource *r;
+	struct subcpuset_ctlr **cp;
+	int i;
+
+	r = cs->scs_u.resources;
+	cp = subcpuset_ctlrs;
+	for (i = 0; i < SUBCPUSET_CTLRS_MAX; i++, r++, cp++) {
+		if (!*cp)
+			continue;
+
+		/* Putting back guarantee and limit to zero. */
+		if ((*cp)->set_guar)
+			(*cp)->set_guar(r->ctlr_data, 0);
+		if ((*cp)->set_lim)
+			(*cp)->set_lim(r->ctlr_data, 0);
+
+		(*cp)->destroy(r->ctlr_data);
+		r->ctlr_data = NULL;
+	}
+}
+
+static ssize_t subcpuset_file_read_common(struct file *file, char __user *buf, 
+					  size_t nbytes, loff_t *ppos,
+					  unsigned long val)
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
+static ssize_t subcpuset_guar_file_read(struct file *file, char __user *buf, 
+					size_t nbytes, loff_t *ppos)
+{
+	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
+	struct subcpuset_ctlr *c = file->f_dentry->d_fsdata;
+	struct subcpuset_resource *r;
+	unsigned long val;
+
+	r = &cs->scs_u.resources[c->idx];
+	down(&cpuset_sem);
+	val = r->guar;
+	up(&cpuset_sem);
+
+	return subcpuset_file_read_common(file, buf, nbytes, ppos, val);
+}
+
+static ssize_t subcpuset_lim_file_read(struct file *file, char __user *buf, 
+				       size_t nbytes, loff_t *ppos)
+{
+	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
+	struct subcpuset_ctlr *c = file->f_dentry->d_fsdata;
+	struct subcpuset_resource *r;
+	unsigned long val;
+
+	r = &cs->scs_u.resources[c->idx];
+	down(&cpuset_sem);
+	val = r->lim;
+	up(&cpuset_sem);
+
+	return subcpuset_file_read_common(file, buf, nbytes, ppos, val);
+}
+
+static ssize_t subcpuset_cur_file_read(struct file *file, char __user *buf, 
+				       size_t nbytes, loff_t *ppos)
+{
+	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
+	struct subcpuset_ctlr *c = file->f_dentry->d_fsdata;
+	struct subcpuset_resource *r;
+	unsigned long val;
+	int err;
+
+	r = &cs->scs_u.resources[c->idx];
+	err = c->get_cur(r->ctlr_data, &val);
+	if (err)
+		return err;
+
+	return subcpuset_file_read_common(file, buf, nbytes, ppos, val);
+}
+
+static ssize_t subcpuset_file_get_written_data(const char __user *userbuf,
+					       size_t nbytes,
+					       unsigned long *valp)
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
+static ssize_t subcpuset_guar_file_write(struct file *file,
+					 const char __user *userbuf,
+					 size_t nbytes,
+					 loff_t *unused_ppos)
+{
+	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
+	struct subcpuset_ctlr *c = file->f_dentry->d_fsdata;
+	struct subcpuset_resource *r;
+	unsigned long val;
+	int retval;
+
+	retval = subcpuset_file_get_written_data(userbuf, nbytes, &val);
+	if (retval)
+		return retval;
+
+	r = &cs->scs_u.resources[c->idx];
+	down(&cpuset_sem);
+	if (is_removed(cs)) {
+		retval = -ENODEV;
+		goto out;
+	}
+
+	if (c->set_lim && r->lim && val > r->lim) {
+		retval = -EINVAL;
+		goto out;
+	}
+
+	retval = c->set_guar(r->ctlr_data, val);
+	if (retval == 0) {
+		r->guar = val;
+		retval = nbytes;
+	}
+out:
+	up(&cpuset_sem);
+	return retval;
+}
+
+static ssize_t subcpuset_lim_file_write(struct file *file,
+					const char __user *userbuf,
+					size_t nbytes,
+					loff_t *unused_ppos)
+{
+	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
+	struct subcpuset_ctlr *c = file->f_dentry->d_fsdata;
+	struct subcpuset_resource *r;
+	unsigned long val;
+	int retval;
+
+	retval = subcpuset_file_get_written_data(userbuf, nbytes, &val);
+	if (retval)
+		return retval;
+
+	r = &cs->scs_u.resources[c->idx];
+	down(&cpuset_sem);
+	if (is_removed(cs)) {
+		retval = -ENODEV;
+		goto out;
+	}
+
+	if (val && c->set_guar && val < r->guar) {
+		retval = -EINVAL;
+		goto out;
+	}
+
+	retval = c->set_lim(r->ctlr_data, val);
+	if (retval == 0) {
+		r->lim = val;
+		retval = nbytes;
+	}
+out:
+	up(&cpuset_sem);
+	return retval;
+}
+
+static struct file_operations subcpuset_guar_file_operations = {
+	.read = subcpuset_guar_file_read,
+	.write = subcpuset_guar_file_write,
+	.llseek = generic_file_llseek,
+	.open = generic_file_open,
+};
+
+static struct file_operations subcpuset_lim_file_operations = {
+	.read = subcpuset_lim_file_read,
+	.write = subcpuset_lim_file_write,
+	.llseek = generic_file_llseek,
+	.open = generic_file_open,
+};
+
+static struct file_operations subcpuset_cur_file_operations = {
+	.read = subcpuset_cur_file_read,
+	.llseek = generic_file_llseek,
+	.open = generic_file_open,
+};
+
+static int subcpuset_populate_dir(struct dentry *cs_dentry)
+{
+	struct subcpuset_ctlr **cp;
+	char buf[SUBCPUSET_FNAME_MAX + 1];
+	int err;
+	int i;
+
+	if ((err = cpuset_add_file(cs_dentry, &cft_notify_on_release)) < 0)
+		return err;
+
+	if ((err = cpuset_add_file(cs_dentry, &cft_tasks)) < 0)
+		return err;
+
+	cp = subcpuset_ctlrs;
+	for (i = 0; i < SUBCPUSET_CTLRS_MAX; i++, cp++) {
+		if (!*cp)
+			continue;
+
+		if ((*cp)->set_guar) {
+			snprintf(buf, sizeof(buf), "%s%s",
+				 (*cp)->name, subcpuset_guar_suffix);
+			err = subcpuset_add_file(cs_dentry, buf, 0644, *cp,
+						 &subcpuset_guar_file_operations);
+			if (err < 0)
+				return err;
+		}
+
+		if ((*cp)->set_lim) {
+			snprintf(buf, sizeof(buf), "%s%s",
+				 (*cp)->name, subcpuset_lim_suffix);
+			err = subcpuset_add_file(cs_dentry, buf, 0644, *cp,
+						 &subcpuset_lim_file_operations);
+			if (err < 0)
+				return err;
+		}
+
+		if ((*cp)->get_cur) {
+			snprintf(buf, sizeof(buf), "%s%s",
+				 (*cp)->name, subcpuset_cur_suffix);
+			err = subcpuset_add_file(cs_dentry, buf, 0444, *cp,
+						 &subcpuset_cur_file_operations);
+			if (err < 0)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+static int subcpuset_add_file(struct dentry *dir,
+			      char *name,
+			      int mode,
+			      const struct subcpuset_ctlr *c,
+			      struct file_operations *fop)
+{
+	struct dentry *dentry;
+	int error;
+
+	down(&dir->d_inode->i_sem);
+	dentry = cpuset_get_dentry(dir, name);
+	if (!IS_ERR(dentry)) {
+		error = cpuset_create_file(dentry, mode | S_IFREG, NULL, fop);
+		if (!error)
+			dentry->d_fsdata = (void *)c;
+		dput(dentry);
+	} else
+		error = PTR_ERR(dentry);
+	up(&dir->d_inode->i_sem);
+	return error;
+}
+
+static struct cftype cft_subcpuset_top = {
+	.name = "subcpuset_top",
+	.private = FILE_SUBCPUSET_TOP,
+};
+
+static int cpuset_add_subcpuset_top(struct dentry *d)
+{
+	return cpuset_add_file(d, &cft_subcpuset_top);
+}
+
+#endif /* CONFIG_SUBCPUSETS */
