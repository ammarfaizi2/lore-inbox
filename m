Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVBGT00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVBGT00 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVBGT00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:26:26 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:31699 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261249AbVBGTV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:21:28 -0500
Date: Mon, 7 Feb 2005 13:21:08 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>
Subject: [PATCH] BSD Secure Levels: printk overhaul, 2.6.11-rc2-mm1 (1/8)
Message-ID: <20050207192108.GA776@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is the first in a series of eight patches to the BSD Secure
Levels LSM.  It overhauls the printk mechanism in order to reduce the
unnecessary usage of the .text area.  Thanks to Brad Spengler for the
suggestion.

Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="seclvl_printk.patch"

Index: linux-2.6.11-rc2-mm1-modules/security/seclvl.c
===================================================================
--- linux-2.6.11-rc2-mm1-modules.orig/security/seclvl.c	2005-02-03 14:55:44.799527472 -0600
+++ linux-2.6.11-rc2-mm1-modules/security/seclvl.c	2005-02-03 14:56:18.527400056 -0600
@@ -101,22 +101,20 @@
 
 #define MY_NAME "seclvl"
 
-/**
- * This time-limits log writes to one per second.
- */
-#define seclvl_printk(verb, type, fmt, arg...)			\
-	do {							\
-		if (verbosity >= verb) {			\
-			static unsigned long _prior;		\
-			unsigned long _now = jiffies;		\
-			if ((_now - _prior) > HZ) {		\
-				printk(type "%s: %s: " fmt,	\
-					MY_NAME, __FUNCTION__ ,	\
-					## arg);		\
-				_prior = _now;			\
-			}					\
-		}						\
-	} while (0)
+static void seclvl_printk( int verb, const char * fmt, ... )
+{
+	va_list args;
+	va_start( args, fmt );
+	if (verbosity >= verb) {
+		static unsigned long _prior;
+		unsigned long _now = jiffies;
+		if ((_now - _prior) > HZ) {
+			vprintk( fmt, args );
+		}
+		_prior = _now;
+	}
+	va_end( args );
+}
 
 /**
  * kobject stuff
@@ -198,15 +196,15 @@
 static int seclvl_sanity(int reqlvl)
 {
 	if ((reqlvl < -1) || (reqlvl > 2)) {
-		seclvl_printk(1, KERN_WARNING, "Attempt to set seclvl out of "
-			      "range: [%d]\n", reqlvl);
+		seclvl_printk(1, KERN_WARNING "%s: Attempt to set seclvl out "
+			      "of range: [%d]\n", __FUNCTION__, reqlvl);
 		return -EINVAL;
 	}
 	if ((seclvl == 0) && (reqlvl == -1))
 		return 0;
 	if (reqlvl < seclvl) {
-		seclvl_printk(1, KERN_WARNING, "Attempt to lower seclvl to "
-			      "[%d]\n", reqlvl);
+		seclvl_printk(1, KERN_WARNING "%s: Attempt to lower seclvl to "
+			      "[%d]\n", __FUNCTION__, reqlvl);
 		return -EPERM;
 	}
 	return 0;
@@ -230,18 +228,18 @@
 static int do_seclvl_advance(int newlvl)
 {
 	if (newlvl <= seclvl) {
-		seclvl_printk(1, KERN_WARNING, "Cannot advance to seclvl "
-			      "[%d]\n", newlvl);
+		seclvl_printk(1, KERN_WARNING "%s: Cannot advance to seclvl "
+			      "[%d]\n", __FUNCTION__, newlvl);
 		return -EINVAL;
 	}
 	if (newlvl > 2) {
-		seclvl_printk(1, KERN_WARNING, "Cannot advance to seclvl "
-			      "[%d]\n", newlvl);
+		seclvl_printk(1, KERN_WARNING "%s: Cannot advance to seclvl "
+			      "[%d]\n", __FUNCTION__, newlvl);
 		return -EINVAL;
 	}
 	if (seclvl == -1) {
-		seclvl_printk(1, KERN_WARNING, "Not allowed to advance to "
-			      "seclvl [%d]\n", seclvl);
+		seclvl_printk(1, KERN_WARNING "%s: Not allowed to advance to "
+			      "seclvl [%d]\n", __FUNCTION__, seclvl);
 		return -EPERM;
 	}
 	seclvl = newlvl;
@@ -257,19 +255,19 @@
 {
 	unsigned long val;
 	if (count > 2 || (count == 2 && buff[1] != '\n')) {
-		seclvl_printk(1, KERN_WARNING, "Invalid value passed to "
-			      "seclvl: [%s]\n", buff);
+		seclvl_printk(1, KERN_WARNING "%s: Invalid value passed to "
+			      "seclvl: [%s]\n", __FUNCTION__, buff);
 		return -EINVAL;
 	}
 	val = buff[0] - 48;
 	if (seclvl_sanity(val)) {
-		seclvl_printk(1, KERN_WARNING, "Illegal secure level "
-			      "requested: [%d]\n", (int)val);
+		seclvl_printk(1, KERN_WARNING "%s: Illegal secure level "
+			      "requested: [%d]\n", __FUNCTION__, (int)val);
 		return -EPERM;
 	}
 	if (do_seclvl_advance(val)) {
-		seclvl_printk(0, KERN_ERR, "Failure advancing security level "
-			      "to %lu\n", val);
+		seclvl_printk(0, KERN_ERR "%s: Failure advancing security "
+			      "level to [%lu]\n", __FUNCTION__, val);
 	}
 	return count;
 }
@@ -316,15 +314,15 @@
 	struct crypto_tfm *tfm;
 	struct scatterlist sg[1];
 	if (len > PAGE_SIZE) {
-		seclvl_printk(0, KERN_ERR, "Plaintext password too large (%d "
-			      "characters).  Largest possible is %lu "
-			      "bytes.\n", len, PAGE_SIZE);
+		seclvl_printk(0, KERN_ERR "%s: Plaintext password too large "
+			      "(%d characters).  Largest possible is %lu "
+			      "bytes.\n", __FUNCTION__, len, PAGE_SIZE);
 		return -ENOMEM;
 	}
 	tfm = crypto_alloc_tfm("sha1", 0);
 	if (tfm == NULL) {
-		seclvl_printk(0, KERN_ERR,
-			      "Failed to load transform for SHA1\n");
+		seclvl_printk(0, KERN_ERR "%s: Failed to load transform for "
+			      "SHA1\n", __FUNCTION__);
 		return -ENOSYS;
 	}
 	// Just get a new page; don't play around with page boundaries
@@ -354,13 +352,13 @@
 	int rc;
 	int len;
 	if (!*passwd && !*sha1_passwd) {
-		seclvl_printk(0, KERN_ERR, "Attempt to password-unlock the "
+		seclvl_printk(0, KERN_ERR "%s: Attempt to password-unlock the "
 			      "seclvl module, but neither a plain text "
 			      "password nor a SHA1 hashed password was "
 			      "passed in as a module parameter!  This is a "
 			      "bug, since it should not be possible to be in "
 			      "this part of the module; please tell a "
-			      "maintainer about this event.\n");
+			      "maintainer about this event.\n", __FUNCTION__);
 		return -EINVAL;
 	}
 	len = strlen(buff);
@@ -370,8 +368,8 @@
 	}
 	/* Hash the password, then compare the hashed values */
 	if ((rc = plaintext_to_sha1(tmp, buff, len))) {
-		seclvl_printk(0, KERN_ERR, "Error hashing password: rc = "
-			      "[%d]\n", rc);
+		seclvl_printk(0, KERN_ERR "%s: Error hashing password: rc = "
+			      "[%d]\n", __FUNCTION__, rc);
 		return rc;
 	}
 	for (i = 0; i < SHA1_DIGEST_SIZE; i++) {
@@ -379,8 +377,8 @@
 			return -EPERM;
 		}
 	}
-	seclvl_printk(0, KERN_INFO,
-		      "Password accepted; seclvl reduced to 0.\n");
+	seclvl_printk(0, KERN_INFO "%s: Password accepted; seclvl reduced to "
+		      "0.\n", __FUNCTION__);
 	seclvl = 0;
 	return count;
 }
@@ -397,9 +395,10 @@
 {
 	if (seclvl >= 0) {
 		if (child->pid == 1) {
-			seclvl_printk(1, KERN_WARNING, "Attempt to ptrace "
+			seclvl_printk(1, KERN_WARNING "%s: Attempt to ptrace "
 				      "the init process dissallowed in "
-				      "secure level %d\n", seclvl);
+				      "secure level %d\n", __FUNCTION__,
+				      seclvl);
 			return -EPERM;
 		}
 	}
@@ -421,35 +420,38 @@
 		/* fall through */
 	case 1:
 		if (cap == CAP_LINUX_IMMUTABLE) {
-			seclvl_printk(1, KERN_WARNING, "Attempt to modify "
+			seclvl_printk(1, KERN_WARNING "%s: Attempt to modify "
 				      "the IMMUTABLE and/or APPEND extended "
 				      "attribute on a file with the IMMUTABLE "
 				      "and/or APPEND extended attribute set "
-				      "denied in seclvl [%d]\n", seclvl);
+				      "denied in seclvl [%d]\n", __FUNCTION__,
+				      seclvl);
 			return -EPERM;
 		} else if (cap == CAP_SYS_RAWIO) {	// Somewhat broad...
-			seclvl_printk(1, KERN_WARNING, "Attempt to perform "
+			seclvl_printk(1, KERN_WARNING "%s: Attempt to perform "
 				      "raw I/O while in secure level [%d] "
-				      "denied\n", seclvl);
+				      "denied\n", __FUNCTION__, seclvl);
 			return -EPERM;
 		} else if (cap == CAP_NET_ADMIN) {
-			seclvl_printk(1, KERN_WARNING, "Attempt to perform "
+			seclvl_printk(1, KERN_WARNING "%s: Attempt to perform "
 				      "network administrative task while "
-				      "in secure level [%d] denied\n", seclvl);
+				      "in secure level [%d] denied\n",
+				      __FUNCTION__, seclvl);
 			return -EPERM;
 		} else if (cap == CAP_SETUID) {
-			seclvl_printk(1, KERN_WARNING, "Attempt to setuid "
+			seclvl_printk(1, KERN_WARNING "%s: Attempt to setuid "
 				      "while in secure level [%d] denied\n",
-				      seclvl);
+				      __FUNCTION__, seclvl);
 			return -EPERM;
 		} else if (cap == CAP_SETGID) {
-			seclvl_printk(1, KERN_WARNING, "Attempt to setgid "
+			seclvl_printk(1, KERN_WARNING "%s: Attempt to setgid "
 				      "while in secure level [%d] denied\n",
-				      seclvl);
+				      __FUNCTION__, seclvl);
 		} else if (cap == CAP_SYS_MODULE) {
-			seclvl_printk(1, KERN_WARNING, "Attempt to perform "
+			seclvl_printk(1, KERN_WARNING "%s: Attempt to perform "
 				      "a module operation while in secure "
-				      "level [%d] denied\n", seclvl);
+				      "level [%d] denied\n",
+				      __FUNCTION__, seclvl);
 			return -EPERM;
 		}
 		break;
@@ -459,7 +461,7 @@
 	/* from dummy.c */
 	if (cap_is_fs_cap(cap) ? tsk->fsuid == 0 : tsk->euid == 0)
 		return 0;	/* capability granted */
-	seclvl_printk(1, KERN_WARNING, "Capability denied\n");
+	seclvl_printk(1, KERN_WARNING "%s: Capability denied\n", __FUNCTION__);
 	return -EPERM;		/* capability denied */
 }
 
@@ -473,11 +475,11 @@
 		now = current_kernel_time();
 		if (tv->tv_sec < now.tv_sec ||
 		    (tv->tv_sec == now.tv_sec && tv->tv_nsec < now.tv_nsec)) {
-			seclvl_printk(1, KERN_WARNING, "Attempt to decrement "
-				      "time in secure level %d denied: "
-				      "current->pid = [%d], "
+			seclvl_printk(1, KERN_WARNING "%s: Attempt to "
+				      "decrement time in secure level %d "
+				      "denied: current->pid = [%d], "
 				      "current->group_leader->pid = [%d]\n",
-				      seclvl, current->pid,
+				      __FUNCTION__, seclvl, current->pid,
 				      current->group_leader->pid);
 			return -EPERM;
 		}		/* if attempt to decrement time */
@@ -527,15 +529,16 @@
 	if (current->pid != 1 && S_ISBLK(inode->i_mode) && (mask & MAY_WRITE)) {
 		switch (seclvl) {
 		case 2:
-			seclvl_printk(1, KERN_WARNING, "Write to block device "
-				      "denied in secure level [%d]\n", seclvl);
+			seclvl_printk(1, KERN_WARNING "%s: Write to block "
+				      "device denied in secure level [%d]\n",
+				      __FUNCTION__, seclvl);
 			return -EPERM;
 		case 1:
 			if (seclvl_bd_claim(inode)) {
-				seclvl_printk(1, KERN_WARNING,
-					      "Write to mounted block device "
-					      "denied in secure level [%d]\n",
-					      seclvl);
+				seclvl_printk(1, KERN_WARNING "%s: Write to "
+					      "mounted block device denied in "
+					      "secure level [%d]\n",
+					      __FUNCTION__, seclvl);
 				return -EPERM;
 			}
 		}
@@ -552,10 +555,10 @@
 		if (iattr->ia_valid & ATTR_MODE)
 			if (iattr->ia_mode & S_ISUID ||
 			    iattr->ia_mode & S_ISGID) {
-				seclvl_printk(1, KERN_WARNING, "Attempt to "
+				seclvl_printk(1, KERN_WARNING "%s: Attempt to "
 					      "modify SUID or SGID bit "
 					      "denied in seclvl [%d]\n",
-					      seclvl);
+					      __FUNCTION__, seclvl);
 				return -EPERM;
 			}
 	}
@@ -583,8 +586,8 @@
 		return 0;
 	}
 	if (seclvl == 2) {
-		seclvl_printk(1, KERN_WARNING, "Attempt to unmount in secure "
-			      "level %d\n", seclvl);
+		seclvl_printk(1, KERN_WARNING "%s: Attempt to unmount in "
+			      "secure level [%d]\n", __FUNCTION__, seclvl);
 		return -EPERM;
 	}
 	return 0;
@@ -609,16 +612,16 @@
 	hashedPassword[0] = '\0';
 	if (*passwd) {
 		if (*sha1_passwd) {
-			seclvl_printk(0, KERN_ERR, "Error: Both "
+			seclvl_printk(0, KERN_ERR "%s: Error: Both "
 				      "passwd and sha1_passwd "
 				      "were set, but they are mutually "
-				      "exclusive.\n");
+				      "exclusive.\n", __FUNCTION__);
 			return -EINVAL;
 		}
 		if ((rc = plaintext_to_sha1(hashedPassword, passwd,
 					    strlen(passwd)))) {
-			seclvl_printk(0, KERN_ERR, "Error: SHA1 support not "
-				      "in kernel\n");
+			seclvl_printk(0, KERN_ERR "%s: Error: SHA1 support "
+				      "not in kernel\n", __FUNCTION__);
 			return rc;
 		}
 		/* All static data goes to the BSS, which zero's the
@@ -627,10 +630,10 @@
 		int i;
 		i = strlen(sha1_passwd);
 		if (i != (SHA1_DIGEST_SIZE * 2)) {
-			seclvl_printk(0, KERN_ERR, "Received [%d] bytes; "
+			seclvl_printk(0, KERN_ERR "%s: Received [%d] bytes; "
 				      "expected [%d] for the hexadecimal "
 				      "representation of the SHA1 hash of "
-				      "the password.\n",
+				      "the password.\n", __FUNCTION__,
 				      i, (SHA1_DIGEST_SIZE * 2));
 			return -EINVAL;
 		}
@@ -653,8 +656,8 @@
 {
 	int rc = 0;
 	if ((rc = subsystem_register(&seclvl_subsys))) {
-		seclvl_printk(0, KERN_WARNING,
-			      "Error [%d] registering seclvl subsystem\n", rc);
+		seclvl_printk(0, KERN_WARNING "Error [%d] registering seclvl "
+			      "subsystem\n", __FUNCTION__, rc);
 		return rc;
 	}
 	sysfs_create_file(&seclvl_subsys.kset.kobj, &sysfs_attr_seclvl.attr);
@@ -680,37 +683,39 @@
 	sysfs_attr_seclvl.attr.owner = THIS_MODULE;
 	sysfs_attr_passwd.attr.owner = THIS_MODULE;
 	if (initlvl < -1 || initlvl > 2) {
-		seclvl_printk(0, KERN_ERR, "Error: bad initial securelevel "
-			      "[%d].\n", initlvl);
+		seclvl_printk(0, KERN_ERR "%s: Error: bad initial securelevel "
+			      "[%d].\n", __FUNCTION__, initlvl);
 		rc = -EINVAL;
 		goto exit;
 	}
 	seclvl = initlvl;
 	if ((rc = processPassword())) {
-		seclvl_printk(0, KERN_ERR, "Error processing the password "
-			      "module parameter(s): rc = [%d]\n", rc);
+		seclvl_printk(0, KERN_ERR "%s: Error processing the password "
+			      "module parameter(s): rc = [%d]\n", __FUNCTION__,
+			      rc);
 		goto exit;
 	}
 	/* register ourselves with the security framework */
 	if (register_security(&seclvl_ops)) {
-		seclvl_printk(0, KERN_ERR,
-			      "seclvl: Failure registering with the "
-			      "kernel.\n");
+		seclvl_printk(0, KERN_ERR "%s: seclvl: Failure registering "
+			      "with the kernel.\n", __FUNCTION__);
 		/* try registering with primary module */
 		rc = mod_reg_security(MY_NAME, &seclvl_ops);
 		if (rc) {
-			seclvl_printk(0, KERN_ERR, "seclvl: Failure "
+			seclvl_printk(0, KERN_ERR "%s: seclvl: Failure "
 				      "registering with primary security "
-				      "module.\n");
+				      "module.\n", __FUNCTION__);
 			goto exit;
 		}		/* if primary module registered */
 		secondary = 1;
 	}			/* if we registered ourselves with the security framework */
 	if ((rc = doSysfsRegistrations())) {
-		seclvl_printk(0, KERN_ERR, "Error registering with sysfs\n");
+		seclvl_printk(0, KERN_ERR "%s: Error registering with sysfs\n",
+			      __FUNCTION__);
 		goto exit;
 	}
-	seclvl_printk(0, KERN_INFO, "seclvl: Successfully initialized.\n");
+	seclvl_printk(0, KERN_INFO "%s: seclvl: Successfully initialized.\n",
+		      __FUNCTION__);
  exit:
 	if (rc) {
 		printk(KERN_ERR "seclvl: Error during initialization: rc = "
@@ -733,9 +738,8 @@
 	if (secondary == 1) {
 		mod_unreg_security(MY_NAME, &seclvl_ops);
 	} else if (unregister_security(&seclvl_ops)) {
-		seclvl_printk(0, KERN_INFO,
-			      "seclvl: Failure unregistering with the "
-			      "kernel\n");
+		seclvl_printk(0, KERN_INFO "%s: seclvl: Failure unregistering "
+			      "with the kernel\n", __FUNCTION__);
 	}
 }
 

--jI8keyz6grp/JLjh--
