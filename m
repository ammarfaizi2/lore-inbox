Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135306AbREEUDd>; Sat, 5 May 2001 16:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135313AbREEUDY>; Sat, 5 May 2001 16:03:24 -0400
Received: from hose.mail.pipex.net ([158.43.128.58]:30383 "HELO
	hose.mail.pipex.net") by vger.kernel.org with SMTP
	id <S135306AbREEUDR>; Sat, 5 May 2001 16:03:17 -0400
From: Michael Miller <michaelm@mjmm.org>
Message-Id: <200105051955.f45JtAD02315@mjmm.org>
Subject: curedump configuration additions
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Date: Sat, 5 May 2001 20:55:09 +0100 (BST)
Cc: michaelm@mjmm.org (Michael Miller)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="%--multipart-mixed-boundary-1.806.989092509--%"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--%--multipart-mixed-boundary-1.806.989092509--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I have added some configuration options to the coredump abilities of the 
kernel. Please can this patch be considered for addition to the kernel.

I have added three sysctl variables which control the 'features' I 
have added.  These are:

kernel.coredump_enabled
kernel.coredump_log
kernel.coredump_file_name

The first two are 'boolean' options which control if the creation of
core files is globally enabled and if corefile generation if logged
respectively.

The third option controls the filename of the coredump.  It allows the use
of a few tokens within the filename.

Please find the patch below and attached for convenience.  This is a diff
against a 2.4.4 kernel.

Many thanks
mike

--

diff -ru -x *.o -x *.s -x *.flags -x *.a -x *.map -x *.depend linux-2.4.4-orig/Documentation/sysctl/kernel.txt linux/Documentation/sysctl/kernel.txt
--- linux-2.4.4-orig/Documentation/sysctl/kernel.txt	Tue Jan 11 02:15:58 2000
+++ linux/Documentation/sysctl/kernel.txt	Sat May  5 19:48:37 2001
@@ -41,6 +41,9 @@
 - shmmax                      [ sysv ipc ]
 - version
 - zero-paged                  [ PPC only ]
+- coredump_enabled
+- coredump_file_name          
+- coredump_log
 
 ==============================================================
 
@@ -226,3 +229,60 @@
 the idle loop, possibly speeding up get_free_pages. Since
 this only affects what the idle loop is doing, you should
 enable this and see if anything changes.
+
+==============================================================
+
+coredump_enabled:
+
+When enabled (which is the default), Linux will produce
+coredumps.  This mimics the previous behavior.  Coredumps 
+will not be produced if processes have had their coredump
+limit set.
+
+If disabled, no coredumps will be produced at all.  This is
+useful for systems where increased security is needed so
+that coredumps are not produced, or for systems where coredumps
+are unwanted due to disk space shortages.  I'm sure there are
+other reasons why you would want to disable coredumps too...
+
+==============================================================
+
+coredump_file_name:
+
+Coredump filenames are now configurable using this sysctl.
+
+For starters, to set the variable to emulate previous behavior (which
+is still the default) you need to do:
+  sysctl -w kernel.coredump_filename=core
+
+The filename can either be a relative or absolute filename. The filename
+can contain meta characters which will be expanded when the corefile is
+written.  The meta characters are:
+
+ %c  which is expanded to the process's command name
+ %p  which is expanded to the process's PID
+ %u  which is expanded to the process's UID
+ %U  which is expanded to the process's EUID
+ %g  which is expanded to the process's GID
+ %G  which is expanded to the process's EGID
+
+Note that this is a global setting, so all coredumps are affected by
+this.  A future modification would be to enable per process coredump
+parameters.
+
+==============================================================
+
+coredump_log:
+
+This controls if coredumps get logged by the kernel.  Note that even
+if coredump_enabled=0, you can still log attempts to generate a coredump.
+
+This sysctl variable is useful on machines which may be targets of hacking.
+Hackers may cause a process to crash and generate a coredump.  This option
+allows such events to be logged, and hopefully alert sysadmins to hack
+attempts.
+
+The default is to log coredumps.
+
+==============================================================
+
diff -ru -x *.o -x *.s -x *.flags -x *.a -x *.map -x *.depend linux-2.4.4-orig/fs/exec.c linux/fs/exec.c
--- linux-2.4.4-orig/fs/exec.c	Sat May  5 14:01:45 2001
+++ linux/fs/exec.c	Sat May  5 19:07:07 2001
@@ -20,6 +20,10 @@
  * table to check for several different types  of binary formats.  We keep
  * trying until we recognize the file or we run out of supported binary
  * formats. 
+ *
+ * Configurable coredump_file_name, coredump_log and coredump_enabled 
+ * support added by Michael Miller, May 2001, michael@mjmm.org
+ *
  */
 
 #include <linux/config.h>
@@ -48,6 +52,10 @@
 static struct linux_binfmt *formats;
 static rwlock_t binfmt_lock = RW_LOCK_UNLOCKED;
 
+int coredump_enabled = 1;
+char coredump_file_name[256] = "core";
+int coredump_log = 1;
+
 int register_binfmt(struct linux_binfmt * fmt)
 {
 	struct linux_binfmt ** tmp = &formats;
@@ -924,11 +932,23 @@
 int do_coredump(long signr, struct pt_regs * regs)
 {
 	struct linux_binfmt * binfmt;
-	char corename[6+sizeof(current->comm)];
+	char corename[256]="";
 	struct file * file;
 	struct inode * inode;
+        int i,j,k;
+
+	/* Calculate the min buffer free to handle an expanded token from
+	   coredump_file_name. 22 comes from the max number of digits 
+	   for a 64bit integer.
+	*/
+	k=sizeof(current->comm);
+	if (k<22) 
+		k=22;
+	k=sizeof(corename) - k;
 
 	lock_kernel();
+	if (!coredump_enabled)
+		goto fail;
 	binfmt = current->binfmt;
 	if (!binfmt || !binfmt->core_dump)
 		goto fail;
@@ -938,12 +958,48 @@
 	if (current->rlim[RLIMIT_CORE].rlim_cur < binfmt->min_coredump)
 		goto fail;
 
-	memcpy(corename,"core.", 5);
-#if 0
-	memcpy(corename+5,current->comm,sizeof(current->comm));
-#else
-	corename[4] = '\0';
-#endif
+	j=0;
+	for (i=0; (coredump_file_name[i] != '\0') && 
+			(j<k); i++) {
+        	if ( coredump_file_name[i] != '%' ) {
+			corename[j]=coredump_file_name[i];
+			j++;
+		} else {
+			switch(coredump_file_name[++i]) {
+			case 'c':
+				j += sprintf(&corename[j],"%s", current->comm);
+				break;
+			case 'g':
+				j += sprintf(&corename[j],"%u", current->gid);
+				break;
+			case 'G': 
+				j += sprintf(&corename[j],"%u", current->egid);
+				break;
+			case 'p':
+				j += sprintf(&corename[j],"%u", current->pid);
+				break;
+			case 'u':
+				j += sprintf(&corename[j],"%u", current->uid);
+				break;
+			case 'U': 
+				j += sprintf(&corename[j],"%u", current->euid);
+				break;
+			case '%': 
+				corename[j++]=coredump_file_name[i];;
+				break;
+			default: 
+				corename[j++]=coredump_file_name[--i];
+			}
+		}
+	
+        }
+
+	if (j==0) { 
+		memcpy(corename,"core",4);
+		j=4;
+	}
+	corename[j] = '\0';
+
 	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW, 0600);
 	if (IS_ERR(file))
 		goto fail;
@@ -963,13 +1019,22 @@
 		goto close_fail;
 	if (!binfmt->core_dump(signr, regs, file))
 		goto close_fail;
+	if (coredump_log) 
+		printk("Coredump to file %s for process %s, pid %d, uid %d\n",
+			corename, current->comm, current->pid, current->uid);
 	unlock_kernel();
 	filp_close(file, NULL);
 	return 1;
 
 close_fail:
 	filp_close(file, NULL);
+	if (coredump_log && (corename[0]!='\0'))
+		printk("Coredump failed to dump to file %s.\n",corename); 
+	
 fail:
+	if (coredump_log) 
+		printk("Coredump not dumped for process %s, pid %d, uid %d\n",
+			current->comm,current->pid,current->uid);
 	unlock_kernel();
 	return 0;
 }
diff -ru -x *.o -x *.s -x *.flags -x *.a -x *.map -x *.depend linux-2.4.4-orig/include/linux/sysctl.h linux/include/linux/sysctl.h
--- linux-2.4.4-orig/include/linux/sysctl.h	Sat May  5 14:01:49 2001
+++ linux/include/linux/sysctl.h	Sat May  5 17:51:53 2001
@@ -118,7 +118,10 @@
 	KERN_SHMPATH=48,	/* string: path to shm fs */
 	KERN_HOTPLUG=49,	/* string: path to hotplug policy agent */
 	KERN_IEEE_EMULATION_WARNINGS=50, /* int: unimplemented ieee instructions */
-	KERN_S390_USER_DEBUG_LOGGING=51  /* int: dumps of user faults */
+	KERN_S390_USER_DEBUG_LOGGING=51,  /* int: dumps of user faults */
+	KERN_COREDUMP_ENABLED=52, /* are coredumps enabled on this system */
+	KERN_COREDUMP_FILE_NAME=53, /*file name format of coredump files */
+	KERN_COREDUMP_LOG=54    /*should coredumps get logged */
 };
 
 
diff -ru -x *.o -x *.s -x *.flags -x *.a -x *.map -x *.depend linux-2.4.4-orig/kernel/sysctl.c linux/kernel/sysctl.c
--- linux-2.4.4-orig/kernel/sysctl.c	Sat May  5 14:01:50 2001
+++ linux/kernel/sysctl.c	Sat May  5 19:57:04 2001
@@ -16,6 +16,8 @@
  *  Wendling.
  * The list_for_each() macro wasn't appropriate for the sysctl loop.
  *  Removed it and replaced it with older style, 03/23/00, Bill Wendling
+ * Added coredump_enable, coredump_log, coredump_file_name 2001/05/05,
+ *  Michael Miller
  */
 
 #include <linux/config.h>
@@ -47,6 +49,9 @@
 extern int max_threads;
 extern int nr_queued_signals, max_queued_signals;
 extern int sysrq_enabled;
+extern int coredump_enabled;
+extern int coredump_log;
+extern char coredump_file_name[];
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -249,6 +254,12 @@
 	{KERN_S390_USER_DEBUG_LOGGING,"userprocess_debug",
 	 &sysctl_userprocess_debug,sizeof(int),0644,NULL,&proc_dointvec},
 #endif
+	{KERN_COREDUMP_ENABLED,"coredump_enabled",&coredump_enabled,
+	sizeof(int), 0644, NULL, &proc_dointvec},
+	{KERN_COREDUMP_FILE_NAME,"coredump_file_name",&coredump_file_name,256,
+	0644,NULL,&proc_dostring, &sysctl_string},
+	{KERN_COREDUMP_LOG,"coredump_log",&coredump_log,
+	sizeof(int), 0644, NULL, &proc_dointvec},
 	{0}
 };
 

--%--multipart-mixed-boundary-1.806.989092509--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Description: 'diff' output text
Content-Disposition: attachment; filename="coredump.diff"

diff -ru -x *.o -x *.s -x *.flags -x *.a -x *.map -x *.depend linux-2.4.4-orig/Documentation/sysctl/kernel.txt linux/Documentation/sysctl/kernel.txt
--- linux-2.4.4-orig/Documentation/sysctl/kernel.txt	Tue Jan 11 02:15:58 2000
+++ linux/Documentation/sysctl/kernel.txt	Sat May  5 19:48:37 2001
@@ -41,6 +41,9 @@
 - shmmax                      [ sysv ipc ]
 - version
 - zero-paged                  [ PPC only ]
+- coredump_enabled
+- coredump_file_name          
+- coredump_log
 
 ==============================================================
 
@@ -226,3 +229,60 @@
 the idle loop, possibly speeding up get_free_pages. Since
 this only affects what the idle loop is doing, you should
 enable this and see if anything changes.
+
+==============================================================
+
+coredump_enabled:
+
+When enabled (which is the default), Linux will produce
+coredumps.  This mimics the previous behavior.  Coredumps 
+will not be produced if processes have had their coredump
+limit set.
+
+If disabled, no coredumps will be produced at all.  This is
+useful for systems where increased security is needed so
+that coredumps are not produced, or for systems where coredumps
+are unwanted due to disk space shortages.  I'm sure there are
+other reasons why you would want to disable coredumps too...
+
+==============================================================
+
+coredump_file_name:
+
+Coredump filenames are now configurable using this sysctl.
+
+For starters, to set the variable to emulate previous behavior (which
+is still the default) you need to do:
+  sysctl -w kernel.coredump_filename=core
+
+The filename can either be a relative or absolute filename. The filename
+can contain meta characters which will be expanded when the corefile is
+written.  The meta characters are:
+
+ %c  which is expanded to the process's command name
+ %p  which is expanded to the process's PID
+ %u  which is expanded to the process's UID
+ %U  which is expanded to the process's EUID
+ %g  which is expanded to the process's GID
+ %G  which is expanded to the process's EGID
+
+Note that this is a global setting, so all coredumps are affected by
+this.  A future modification would be to enable per process coredump
+parameters.
+
+==============================================================
+
+coredump_log:
+
+This controls if coredumps get logged by the kernel.  Note that even
+if coredump_enabled=0, you can still log attempts to generate a coredump.
+
+This sysctl variable is useful on machines which may be targets of hacking.
+Hackers may cause a process to crash and generate a coredump.  This option
+allows such events to be logged, and hopefully alert sysadmins to hack
+attempts.
+
+The default is to log coredumps.
+
+==============================================================
+
diff -ru -x *.o -x *.s -x *.flags -x *.a -x *.map -x *.depend linux-2.4.4-orig/fs/exec.c linux/fs/exec.c
--- linux-2.4.4-orig/fs/exec.c	Sat May  5 14:01:45 2001
+++ linux/fs/exec.c	Sat May  5 19:07:07 2001
@@ -20,6 +20,10 @@
  * table to check for several different types  of binary formats.  We keep
  * trying until we recognize the file or we run out of supported binary
  * formats. 
+ *
+ * Configurable coredump_file_name, coredump_log and coredump_enabled 
+ * support added by Michael Miller, May 2001, michael@mjmm.org
+ *
  */
 
 #include <linux/config.h>
@@ -48,6 +52,10 @@
 static struct linux_binfmt *formats;
 static rwlock_t binfmt_lock = RW_LOCK_UNLOCKED;
 
+int coredump_enabled = 1;
+char coredump_file_name[256] = "core";
+int coredump_log = 1;
+
 int register_binfmt(struct linux_binfmt * fmt)
 {
 	struct linux_binfmt ** tmp = &formats;
@@ -924,11 +932,23 @@
 int do_coredump(long signr, struct pt_regs * regs)
 {
 	struct linux_binfmt * binfmt;
-	char corename[6+sizeof(current->comm)];
+	char corename[256]="";
 	struct file * file;
 	struct inode * inode;
+        int i,j,k;
+
+	/* Calculate the min buffer free to handle an expanded token from
+	   coredump_file_name. 22 comes from the max number of digits 
+	   for a 64bit integer.
+	*/
+	k=sizeof(current->comm);
+	if (k<22) 
+		k=22;
+	k=sizeof(corename) - k;
 
 	lock_kernel();
+	if (!coredump_enabled)
+		goto fail;
 	binfmt = current->binfmt;
 	if (!binfmt || !binfmt->core_dump)
 		goto fail;
@@ -938,12 +958,48 @@
 	if (current->rlim[RLIMIT_CORE].rlim_cur < binfmt->min_coredump)
 		goto fail;
 
-	memcpy(corename,"core.", 5);
-#if 0
-	memcpy(corename+5,current->comm,sizeof(current->comm));
-#else
-	corename[4] = '\0';
-#endif
+	j=0;
+	for (i=0; (coredump_file_name[i] != '\0') && 
+			(j<k); i++) {
+        	if ( coredump_file_name[i] != '%' ) {
+			corename[j]=coredump_file_name[i];
+			j++;
+		} else {
+			switch(coredump_file_name[++i]) {
+			case 'c':
+				j += sprintf(&corename[j],"%s", current->comm);
+				break;
+			case 'g':
+				j += sprintf(&corename[j],"%u", current->gid);
+				break;
+			case 'G': 
+				j += sprintf(&corename[j],"%u", current->egid);
+				break;
+			case 'p':
+				j += sprintf(&corename[j],"%u", current->pid);
+				break;
+			case 'u':
+				j += sprintf(&corename[j],"%u", current->uid);
+				break;
+			case 'U': 
+				j += sprintf(&corename[j],"%u", current->euid);
+				break;
+			case '%': 
+				corename[j++]=coredump_file_name[i];;
+				break;
+			default: 
+				corename[j++]=coredump_file_name[--i];
+			}
+		}
+	
+        }
+
+	if (j==0) { 
+		memcpy(corename,"core",4);
+		j=4;
+	}
+	corename[j] = '\0';
+
 	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW, 0600);
 	if (IS_ERR(file))
 		goto fail;
@@ -963,13 +1019,22 @@
 		goto close_fail;
 	if (!binfmt->core_dump(signr, regs, file))
 		goto close_fail;
+	if (coredump_log) 
+		printk("Coredump to file %s for process %s, pid %d, uid %d\n",
+			corename, current->comm, current->pid, current->uid);
 	unlock_kernel();
 	filp_close(file, NULL);
 	return 1;
 
 close_fail:
 	filp_close(file, NULL);
+	if (coredump_log && (corename[0]!='\0'))
+		printk("Coredump failed to dump to file %s.\n",corename); 
+	
 fail:
+	if (coredump_log) 
+		printk("Coredump not dumped for process %s, pid %d, uid %d\n",
+			current->comm,current->pid,current->uid);
 	unlock_kernel();
 	return 0;
 }
diff -ru -x *.o -x *.s -x *.flags -x *.a -x *.map -x *.depend linux-2.4.4-orig/include/linux/sysctl.h linux/include/linux/sysctl.h
--- linux-2.4.4-orig/include/linux/sysctl.h	Sat May  5 14:01:49 2001
+++ linux/include/linux/sysctl.h	Sat May  5 17:51:53 2001
@@ -118,7 +118,10 @@
 	KERN_SHMPATH=48,	/* string: path to shm fs */
 	KERN_HOTPLUG=49,	/* string: path to hotplug policy agent */
 	KERN_IEEE_EMULATION_WARNINGS=50, /* int: unimplemented ieee instructions */
-	KERN_S390_USER_DEBUG_LOGGING=51  /* int: dumps of user faults */
+	KERN_S390_USER_DEBUG_LOGGING=51,  /* int: dumps of user faults */
+	KERN_COREDUMP_ENABLED=52, /* are coredumps enabled on this system */
+	KERN_COREDUMP_FILE_NAME=53, /*file name format of coredump files */
+	KERN_COREDUMP_LOG=54    /*should coredumps get logged */
 };
 
 
diff -ru -x *.o -x *.s -x *.flags -x *.a -x *.map -x *.depend linux-2.4.4-orig/kernel/sysctl.c linux/kernel/sysctl.c
--- linux-2.4.4-orig/kernel/sysctl.c	Sat May  5 14:01:50 2001
+++ linux/kernel/sysctl.c	Sat May  5 19:57:04 2001
@@ -16,6 +16,8 @@
  *  Wendling.
  * The list_for_each() macro wasn't appropriate for the sysctl loop.
  *  Removed it and replaced it with older style, 03/23/00, Bill Wendling
+ * Added coredump_enable, coredump_log, coredump_file_name 2001/05/05,
+ *  Michael Miller
  */
 
 #include <linux/config.h>
@@ -47,6 +49,9 @@
 extern int max_threads;
 extern int nr_queued_signals, max_queued_signals;
 extern int sysrq_enabled;
+extern int coredump_enabled;
+extern int coredump_log;
+extern char coredump_file_name[];
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -249,6 +254,12 @@
 	{KERN_S390_USER_DEBUG_LOGGING,"userprocess_debug",
 	 &sysctl_userprocess_debug,sizeof(int),0644,NULL,&proc_dointvec},
 #endif
+	{KERN_COREDUMP_ENABLED,"coredump_enabled",&coredump_enabled,
+	sizeof(int), 0644, NULL, &proc_dointvec},
+	{KERN_COREDUMP_FILE_NAME,"coredump_file_name",&coredump_file_name,256,
+	0644,NULL,&proc_dostring, &sysctl_string},
+	{KERN_COREDUMP_LOG,"coredump_log",&coredump_log,
+	sizeof(int), 0644, NULL, &proc_dointvec},
 	{0}
 };
 

--%--multipart-mixed-boundary-1.806.989092509--%--
