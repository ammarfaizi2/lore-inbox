Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbVLTUmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbVLTUmc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbVLTUmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:42:32 -0500
Received: from smtp20.libero.it ([193.70.192.147]:30862 "EHLO smtp20.libero.it")
	by vger.kernel.org with ESMTP id S932085AbVLTUmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:42:31 -0500
From: borsa77@libero.it
To: kaos@ocs.com.au
Date: Tue, 20 Dec 2005 21:43:50 +0100
Subject: [PATCH] Correction to kmod.c control loop
CC: linux-kernel@vger.kernel.org
Message-ID: <43A87B16.12387.487781@localhost>
X-mailer: Pegasus Mail for Windows (v4.11)
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried this patch on my system Slackware 10.1 with the version kernel  
2.4.29 with any problem, below it is in broken form to allow comment  
to the source. 

--- ./kmod.bak	2005-12-19 12:48:56.000000000 +0100 
+++ ../kernel/kmod.c	2005-12-19 13:29:44.000000000 +0100 
@@ -175,13 +175,11 @@ 
  */ 
 int request_module(const char * module_name) 
 { 
-	pid_t pid; 
-	int waitpid_result; 
+	pid_t pid, waitpid_result; 
 	sigset_t tmpsig; 
 	int i; 
 	static atomic_t kmod_concurrent = ATOMIC_INIT(0); 
-#define MAX_KMOD_CONCURRENT 50	/* Completely arbitrary 
value - KAO */ 
-	static int kmod_loop_msg; 
+	static int MAX_KMOD_CONCURRENT, kmod_loop_msg; 

The man page for waitpid function tells the return type is pid_t. 

 	/* Don't allow request_module() before the root fs is mounted!  */ 
 	if ( ! current->fs->root ) { 
@@ -192,7 +190,7 @@ 
  

 	/* If modprobe needs a service that is in a module, we get a 
recursive 
 	 * loop.  Limit the number of running kmod threads to 
max_threads/2 or 
-	 * MAX_KMOD_CONCURRENT, whichever is the smaller.  A 
cleaner method 
+	 * MAX_KMOD_CONCURRENT, whichever is the larger.  A 
cleaner method 
 	 * would be to run the parents of this process, counting how 
many times 
 	 * kmod was invoked.  That would mean accessing the internals 
of the 
 	 * process tables to get the command line, proc_pid_cmdline is 
static 
@@ -200,7 +198,7 @@ 
 	 * KAO. 
 	 */ 
 	i = max_threads/2; 
-	if (i > MAX_KMOD_CONCURRENT) 
+	if (i < MAX_KMOD_CONCURRENT) 
 		i = MAX_KMOD_CONCURRENT; 
 	atomic_inc(&kmod_concurrent); 
 	if (atomic_read(&kmod_concurrent) > i) { 
@@ -208,6 +206,7 @@ 
 			printk(KERN_ERR 
 			       "kmod: runaway modprobe loop assumed 
and stopped\n"); 
 		atomic_dec(&kmod_concurrent); 
+		MAX_KMOD_CONCURRENT = 
2*MAX_KMOD_CONCURRENT+1; 
 		return -ENOMEM; 
 	} 

Two advantages: (i) you do not worry about the choice of an arbitrary  
value, (ii) you can reiterate modprobe command until the module is  
loaded because MAX_KMOD_CONCURRENT grows with arithmetic  
progression. 

@@ -237,6 +236,7 @@ 
 	if (waitpid_result != pid) { 
 		printk(KERN_ERR "request_module[%s]: waitpid(%d,...) 
failed, errno %d\n", 
 		       module_name, pid, -waitpid_result); 
+		return waitpid_result; 
 	} 
 	return 0; 
 } 

I think here the exit point was omitted because originally the check was  
before the unblock of the signals, now it is safe because it is at the end  
so the errorcode should be handled. 

If you believe these corrections are valid, please you will send me 
feedback. Otherwise I am sorry for this lack of time. 
Regards, Marco Borsari.
