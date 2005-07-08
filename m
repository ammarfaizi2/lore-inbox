Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262860AbVGHUtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbVGHUtF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbVGHUrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 16:47:10 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:33666 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261421AbVGHUpF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 16:45:05 -0400
Date: Fri, 8 Jul 2005 15:44:19 -0500
From: serue@us.ibm.com
To: Greg KH <greg@kroah.com>
Cc: James Morris <jmorris@redhat.com>, Tony Jones <tonyj@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] securityfs
Message-ID: <20050708204419.GA30515@serge.austin.ibm.com>
References: <20050703182505.GA29491@immunix.com> <Xine.LNX.4.44.0507031450540.30297-100000@thoron.boston.redhat.com> <20050703204423.GA17418@kroah.com> <20050706220835.GA32005@serge.austin.ibm.com> <20050706222237.GB6696@kroah.com> <20050707173035.GA10503@vino.hallyn.com> <20050707174852.GA19609@kroah.com> <20050707182720.GA26431@serge.austin.ibm.com> <20050707224604.GA13117@vino.hallyn.com> <20050707230609.GA851@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707230609.GA851@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Greg KH (greg@kroah.com):
> On Thu, Jul 07, 2005 at 05:46:04PM -0500, serge@hallyn.com wrote:
> > 
> > With the obvious fix, that does in fact work (patch appended).
> 
> Good.
> 
> > The __simple_attr_check_format problem remains however.  I assume we
> > don't really want to just take it out, though, like this patch does?
> 
> No we do not.
> 
> > The error I get without the fs.h patch is:
> > 
> > security/seclvl.c: In function `seclvl_file_ops_open':
> > security/seclvl.c:186: warning: int format, different type arg (arg 2)
> 
> Care to work to try to fix it up?

Once again, the simple_attr in libfs was actually sufficient - I'd
thought the __attribute__(format(printk(1,2))) was more mysterious than
it really is.

At last, here is the full patch to make seclvl use securityfs.

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
--
 seclvl.c |  228 +++++++++++++++++++--------------------------------------------
 1 files changed, 70 insertions(+), 158 deletions(-)

Index: linux-2.6.13-rc1/security/seclvl.c
===================================================================
--- linux-2.6.13-rc1.orig/security/seclvl.c	2005-07-08 19:38:22.000000000 -0500
+++ linux-2.6.13-rc1/security/seclvl.c	2005-07-08 19:39:49.000000000 -0500
@@ -119,69 +119,6 @@ MODULE_PARM_DESC(hideHash, "When set to 
 	} while (0)
 
 /**
- * kobject stuff
- */
-
-struct subsystem seclvl_subsys;
-
-struct seclvl_obj {
-	char *name;
-	struct list_head slot_list;
-	struct kobject kobj;
-};
-
-/**
- * There is a seclvl_attribute struct for each file in sysfs.
- *
- * In our case, we have one of these structs for "passwd" and another
- * for "seclvl".
- */
-struct seclvl_attribute {
-	struct attribute attr;
-	ssize_t(*show) (struct seclvl_obj *, char *);
-	ssize_t(*store) (struct seclvl_obj *, const char *, size_t);
-};
-
-/**
- * When this function is called, one of the files in sysfs is being
- * written to.  attribute->store is a function pointer to whatever the
- * struct seclvl_attribute store function pointer points to.  It is
- * unique for "passwd" and "seclvl".
- */
-static ssize_t
-seclvl_attr_store(struct kobject *kobj,
-		  struct attribute *attr, const char *buf, size_t len)
-{
-	struct seclvl_obj *obj = container_of(kobj, struct seclvl_obj, kobj);
-	struct seclvl_attribute *attribute =
-	    container_of(attr, struct seclvl_attribute, attr);
-	return attribute->store ? attribute->store(obj, buf, len) : -EIO;
-}
-
-static ssize_t
-seclvl_attr_show(struct kobject *kobj, struct attribute *attr, char *buf)
-{
-	struct seclvl_obj *obj = container_of(kobj, struct seclvl_obj, kobj);
-	struct seclvl_attribute *attribute =
-	    container_of(attr, struct seclvl_attribute, attr);
-	return attribute->show ? attribute->show(obj, buf) : -EIO;
-}
-
-/**
- * Callback function pointers for show and store
- */
-static struct sysfs_ops seclvlfs_sysfs_ops = {
-	.show = seclvl_attr_show,
-	.store = seclvl_attr_store,
-};
-
-static struct kobj_type seclvl_ktype = {
-	.sysfs_ops = &seclvlfs_sysfs_ops
-};
-
-decl_subsys(seclvl, &seclvl_ktype, NULL);
-
-/**
  * The actual security level.  Ranges between -1 and 2 inclusive.
  */
 static int seclvl;
@@ -213,97 +150,44 @@ static int seclvl_sanity(int reqlvl)
 }
 
 /**
- * Called whenever the user reads the sysfs handle to this kernel
- * object
- */
-static ssize_t seclvl_read_file(struct seclvl_obj *obj, char *buff)
-{
-	return snprintf(buff, PAGE_SIZE, "%d\n", seclvl);
-}
-
-/**
  * security level advancement rules:
  *   Valid levels are -1 through 2, inclusive.
  *   From -1, stuck.  [ in case compiled into kernel ]
  *   From 0 or above, can only increment.
  */
-static int do_seclvl_advance(int newlvl)
+static void do_seclvl_advance(void *data, u64 val)
 {
-	if (newlvl <= seclvl) {
-		seclvl_printk(1, KERN_WARNING, "Cannot advance to seclvl "
-			      "[%d]\n", newlvl);
-		return -EINVAL;
-	}
+	int ret;
+	int newlvl = (int)val;
+
+	ret = seclvl_sanity(newlvl);
+	if (ret)
+		return;
+
 	if (newlvl > 2) {
 		seclvl_printk(1, KERN_WARNING, "Cannot advance to seclvl "
 			      "[%d]\n", newlvl);
-		return -EINVAL;
+		return;
 	}
 	if (seclvl == -1) {
 		seclvl_printk(1, KERN_WARNING, "Not allowed to advance to "
 			      "seclvl [%d]\n", seclvl);
-		return -EPERM;
+		return;
 	}
-	seclvl = newlvl;
-	return 0;
+	seclvl = newlvl;  /* would it be more "correct" to set *data? */
+	return;
 }
 
-/**
- * Called whenever the user writes to the sysfs handle to this kernel
- * object (seclvl/seclvl).  It expects a single-digit number.
- */
-static ssize_t
-seclvl_write_file(struct seclvl_obj *obj, const char *buff, size_t count)
+static u64 seclvl_int_get(void *data)
 {
-	unsigned long val;
-	if (count > 2 || (count == 2 && buff[1] != '\n')) {
-		seclvl_printk(1, KERN_WARNING, "Invalid value passed to "
-			      "seclvl: [%s]\n", buff);
-		return -EINVAL;
-	}
-	val = buff[0] - 48;
-	if (seclvl_sanity(val)) {
-		seclvl_printk(1, KERN_WARNING, "Illegal secure level "
-			      "requested: [%d]\n", (int)val);
-		return -EPERM;
-	}
-	if (do_seclvl_advance(val)) {
-		seclvl_printk(0, KERN_ERR, "Failure advancing security level "
-			      "to %lu\n", val);
-	}
-	return count;
+	return *(int *)data;
 }
 
-/* Generate sysfs_attr_seclvl */
-static struct seclvl_attribute sysfs_attr_seclvl =
-__ATTR(seclvl, (S_IFREG | S_IRUGO | S_IWUSR), seclvl_read_file,
-       seclvl_write_file);
+DEFINE_SIMPLE_ATTRIBUTE(seclvl_file_ops, seclvl_int_get, do_seclvl_advance, "%lld\n");
 
 static unsigned char hashedPassword[SHA1_DIGEST_SIZE];
 
 /**
- * Called whenever the user reads the sysfs passwd handle.
- */
-static ssize_t seclvl_read_passwd(struct seclvl_obj *obj, char *buff)
-{
-	/* So just how good *is* your password? :-) */
-	char tmp[3];
-	int i = 0;
-	buff[0] = '\0';
-	if (hideHash) {
-		/* Security through obscurity */
-		return 0;
-	}
-	while (i < SHA1_DIGEST_SIZE) {
-		snprintf(tmp, 3, "%02x", hashedPassword[i]);
-		strncat(buff, tmp, 2);
-		i++;
-	}
-	strcat(buff, "\n");
-	return ((SHA1_DIGEST_SIZE * 2) + 1);
-}
-
-/**
  * Converts a block of plaintext of into its SHA1 hashed value.
  *
  * It would be nice if crypto had a wrapper to do this for us linear
@@ -347,12 +231,15 @@ plaintext_to_sha1(unsigned char *hash, c
  * object.  It hashes the password and compares the hashed results.
  */
 static ssize_t
-seclvl_write_passwd(struct seclvl_obj *obj, const char *buff, size_t count)
+passwd_write_file(struct file * file, const char __user * buf,
+				size_t count, loff_t *ppos)
 {
 	int i;
 	unsigned char tmp[SHA1_DIGEST_SIZE];
+	char *page;
 	int rc;
 	int len;
+
 	if (!*passwd && !*sha1_passwd) {
 		seclvl_printk(0, KERN_ERR, "Attempt to password-unlock the "
 			      "seclvl module, but neither a plain text "
@@ -363,13 +250,26 @@ seclvl_write_passwd(struct seclvl_obj *o
 			      "maintainer about this event.\n");
 		return -EINVAL;
 	}
-	len = strlen(buff);
+
+	if (count < 0 || count >= PAGE_SIZE)
+		return -ENOMEM;
+	if (*ppos != 0) {
+		return -EINVAL;
+	}
+	page = (char *)get_zeroed_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+	len = -EFAULT;
+	if (copy_from_user(page, buf, count))
+		goto out;
+	
+	len = strlen(page);
 	/* ``echo "secret" > seclvl/passwd'' includes a newline */
-	if (buff[len - 1] == '\n') {
+	if (page[len - 1] == '\n') {
 		len--;
 	}
 	/* Hash the password, then compare the hashed values */
-	if ((rc = plaintext_to_sha1(tmp, buff, len))) {
+	if ((rc = plaintext_to_sha1(tmp, page, len))) {
 		seclvl_printk(0, KERN_ERR, "Error hashing password: rc = "
 			      "[%d]\n", rc);
 		return rc;
@@ -382,13 +282,16 @@ seclvl_write_passwd(struct seclvl_obj *o
 	seclvl_printk(0, KERN_INFO,
 		      "Password accepted; seclvl reduced to 0.\n");
 	seclvl = 0;
-	return count;
+	len = count;
+
+out:
+	free_page((unsigned long)page);
+	return len;
 }
 
-/* Generate sysfs_attr_passwd */
-static struct seclvl_attribute sysfs_attr_passwd =
-__ATTR(passwd, (S_IFREG | S_IRUGO | S_IWUSR), seclvl_read_passwd,
-       seclvl_write_passwd);
+static struct file_operations passwd_file_ops = {
+	.write = passwd_write_file,
+};
 
 /**
  * Explicitely disallow ptrace'ing the init process.
@@ -647,22 +550,34 @@ static int processPassword(void)
 }
 
 /**
- * Sysfs registrations
+ * securityfs registrations
  */
-static int doSysfsRegistrations(void)
+struct dentry *dir_ino, *seclvl_ino, *passwd_ino;
+
+static int seclvlfs_register(void)
 {
-	int rc = 0;
-	if ((rc = subsystem_register(&seclvl_subsys))) {
-		seclvl_printk(0, KERN_WARNING,
-			      "Error [%d] registering seclvl subsystem\n", rc);
-		return rc;
-	}
-	sysfs_create_file(&seclvl_subsys.kset.kobj, &sysfs_attr_seclvl.attr);
+	dir_ino = securityfs_create_dir("seclvl", NULL);
+	if (!dir_ino)
+		return -EFAULT;
+
+	seclvl_ino = securityfs_create_file("seclvl", S_IRUGO | S_IWUSR,
+				dir_ino, &seclvl, &seclvl_file_ops);
+	if (!seclvl_ino)
+		goto out_deldir;
 	if (*passwd || *sha1_passwd) {
-		sysfs_create_file(&seclvl_subsys.kset.kobj,
-				  &sysfs_attr_passwd.attr);
+		passwd_ino = securityfs_create_file("passwd", S_IRUGO | S_IWUSR,
+				dir_ino, NULL, &passwd_file_ops);
+		if (!passwd_ino)
+			goto out_delf;
 	}
 	return 0;
+
+out_deldir:
+	securityfs_remove(dir_ino);
+out_delf:
+	securityfs_remove(seclvl_ino);
+
+	return -EFAULT;
 }
 
 /**
@@ -677,8 +592,6 @@ static int __init seclvl_init(void)
 		rc = -EINVAL;
 		goto exit;
 	}
-	sysfs_attr_seclvl.attr.owner = THIS_MODULE;
-	sysfs_attr_passwd.attr.owner = THIS_MODULE;
 	if (initlvl < -1 || initlvl > 2) {
 		seclvl_printk(0, KERN_ERR, "Error: bad initial securelevel "
 			      "[%d].\n", initlvl);
@@ -706,7 +619,7 @@ static int __init seclvl_init(void)
 		}		/* if primary module registered */
 		secondary = 1;
 	}			/* if we registered ourselves with the security framework */
-	if ((rc = doSysfsRegistrations())) {
+	if ((rc = seclvlfs_register())) {
 		seclvl_printk(0, KERN_ERR, "Error registering with sysfs\n");
 		goto exit;
 	}
@@ -724,12 +637,11 @@ static int __init seclvl_init(void)
  */
 static void __exit seclvl_exit(void)
 {
-	sysfs_remove_file(&seclvl_subsys.kset.kobj, &sysfs_attr_seclvl.attr);
+	securityfs_remove(seclvl_ino);
 	if (*passwd || *sha1_passwd) {
-		sysfs_remove_file(&seclvl_subsys.kset.kobj,
-				  &sysfs_attr_passwd.attr);
+		securityfs_remove(passwd_ino);
 	}
-	subsystem_unregister(&seclvl_subsys);
+	securityfs_remove(dir_ino);
 	if (secondary == 1) {
 		mod_unreg_security(MY_NAME, &seclvl_ops);
 	} else if (unregister_security(&seclvl_ops)) {
