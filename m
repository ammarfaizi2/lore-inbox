Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317859AbSHZDTg>; Sun, 25 Aug 2002 23:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317861AbSHZDTg>; Sun, 25 Aug 2002 23:19:36 -0400
Received: from c-24-126-73-164.we.client2.attbi.com ([24.126.73.164]:36851
	"EHLO kegel.com") by vger.kernel.org with ESMTP id <S317859AbSHZDTa>;
	Sun, 25 Aug 2002 23:19:30 -0400
Date: Sun, 25 Aug 2002 20:29:08 -0700
From: dank@kegel.com
Message-Id: <200208260329.g7Q3T8h16233@kegel.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] khttpd crash fix, take 3
Cc: dank@alumni.caltech.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox accepted my recent patch to fix a checker warning in khttpd,
but not my earlier patch to fix an oops in khttpd.
That earlier patch must have hit some bogon filter... hmm.  Yes.
It contained extraneous whitespace and style changes, was complex, and 
had a poor description.  So, here's a cleaner one with a better description.

This patch fixes four problems in khttpd:
1. An oops in DecodeHeader where Buffer[CPUNR] is NULL, happened 
   whenever a worker thread was restarted after being stopped.
   (The worker thread frees its buffer on exit, but the manager thread
    neglected to allocate a buffer for the worker thread when restarting it.)
2. A bug that caused worker threads to be spuriously restarted once
   on startup (this made the previous bug much worse).
3. The end-user had to do a "sleep 1" after stopping the daemon
   before restarting it.  This was not documented, and was rather confusing.
4. There was no entry in /usr/src/linux/Documentation for khttpd,
   and beginning users sometimes could not find the documentation.

(An earlier version that fixes only the first two is at
http://marc.theaimsgroup.com/?l=linux-kernel&m=102068445316516&w=2 )
I can separate this patch into three or four pieces if need be.

Please let me know if this patch gets blocked by any bogon filters...

Thanks,
Dan

diff -Naur linux-2.4.19.orig/net/khttpd/main.c linux-2.4.19/net/khttpd/main.c
--- linux-2.4.19.orig/net/khttpd/main.c	Fri Aug  2 17:39:46 2002
+++ linux-2.4.19/net/khttpd/main.c	Sun Aug 25 17:52:04 2002
@@ -95,11 +95,17 @@
 {
 	int CPUNR;
 	sigset_t tmpsig;
+	int old_stop_count;
 	
 	DECLARE_WAITQUEUE(main_wait,current);
 	
 	MOD_INC_USE_COUNT;
 
+	/* Remember value of stop count.  If it changes, user must have 
+	 * asked us to stop.  Sensing this is much less racy than 
+	 * directly sensing sysctl_khttpd_stop. - dank
+	 */
+	old_stop_count = atomic_read(&khttpd_stopCount);
 	
 	CPUNR=0;
 	if (cpu_pointer!=NULL)
@@ -125,7 +131,7 @@
 	atomic_inc(&DaemonCount);
 	atomic_set(&Running[CPUNR],1);
 	
-	while (sysctl_khttpd_stop==0)
+	while (old_stop_count == atomic_read(&khttpd_stopCount)) 
 	{
 		int changes = 0;
 				
@@ -211,12 +217,10 @@
 	while (sysctl_khttpd_unload==0)
 	{
 		int I;
+		int old_stop_count;
 		
 		
 		/* First : wait for activation */
-		
-		sysctl_khttpd_start = 0;
-		
 		while ( (sysctl_khttpd_start==0) && (!signal_pending(current)) && (sysctl_khttpd_unload==0) )
 		{
 			current->state = TASK_INTERRUPTIBLE;
@@ -225,11 +229,13 @@
 		
 		if ( (signal_pending(current)) || (sysctl_khttpd_unload!=0) )
 		 	break;
+		sysctl_khttpd_stop = 0;
 		 	
 		/* Then start listening and spawn the daemons */
 		 	
 		if (StartListening(sysctl_khttpd_serverport)==0)
 		{
+			sysctl_khttpd_start = 0;
 			continue;
 		}
 		
@@ -249,6 +255,7 @@
 		if (InitDataSending(ActualThreads)!=0)
 		{
 			StopListening();
+			sysctl_khttpd_start = 0;
 			continue;
 		}
 		if (InitWaitHeaders(ActualThreads)!=0)
@@ -260,6 +267,7 @@
 				I++;
 			}
 			StopListening();
+			sysctl_khttpd_start = 0;
 			continue;
 		}
 	
@@ -276,59 +284,52 @@
 			I++;
 		}
 		
-		/* Then wait for deactivation */
-		sysctl_khttpd_stop = 0;
-
-		while ( (sysctl_khttpd_stop==0) && (!signal_pending(current)) && (sysctl_khttpd_unload==0) )
+		/* Then loop, sleeping for a second at a time, until user does
+		 * "echo 1 > /proc/sys/net/khttpd/stop" or
+		 * "echo 1 > /proc/sys/net/khttpd/unload"
+		 * or we receive SIGKILL or SIGSTOP.
+		 */
+		old_stop_count = atomic_read(&khttpd_stopCount);
+		while ( ( old_stop_count == atomic_read(&khttpd_stopCount)) 
+			 && (!signal_pending(current)) 
+			 && (sysctl_khttpd_unload==0) )
 		{
-			if (atomic_read(&DaemonCount)<ActualThreads)
-			{
-				I=0;
-				while (I<ActualThreads)
-				{
-					if (atomic_read(&Running[I])==0)
-					{
-						atomic_set(&Running[I],1);
-						(void)kernel_thread(MainDaemon,&(CountBuf[I]), CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
-						(void)printk(KERN_CRIT "kHTTPd: Restarting daemon %i \n",I);
-					}
-					I++;
-				}
-			}
+			/* Used to restart dead threads here, but it didn't 
+			 * reallocate the worker threads' buffers, and since the worker
+			 * threads free their buffer on exit, this caused oopses.
+			 * Rather than fix this code, I removed it.
+			 * (If it turns out worker threads die spontaneously, I guess
+			 * it should be fixed and added back in.)  - dank
+			 */
 			interruptible_sleep_on_timeout(&WQ,HZ);
-			
-			/* reap the daemons */
-			waitpid_result = waitpid(-1,NULL,__WCLONE|WNOHANG);
-			
 		}
 		
-		
-		/* The user wants us to stop. So stop listening on the socket. */
-		if (sysctl_khttpd_stop!=0)	
-		{
-			/* Wait for the daemons to stop, one second per iteration */
-			while (atomic_read(&DaemonCount)>0)
-		 		interruptible_sleep_on_timeout(&WQ,HZ);
-			StopListening();
-		}
-
-		
-	
+		/* Wait for the daemons to stop, one second per iteration */
+		while (atomic_read(&DaemonCount)>0)
+			interruptible_sleep_on_timeout(&WQ,HZ);
+		StopListening();
+		sysctl_khttpd_start = 0;
+		/* reap the zombie-daemons */
+		do
+			waitpid_result = waitpid(-1,NULL,__WCLONE|WNOHANG);
+		while (waitpid_result>0);
 	}
 	
+	sysctl_khttpd_start = 0;
 	sysctl_khttpd_stop = 1;
+	atomic_inc(&khttpd_stopCount);
 
 	/* Wait for the daemons to stop, one second per iteration */
 	while (atomic_read(&DaemonCount)>0)
  		interruptible_sleep_on_timeout(&WQ,HZ);
 		
 		
-	waitpid_result = 1;
+	StopListening();
 	/* reap the zombie-daemons */
-	while (waitpid_result>0)
+	do
 		waitpid_result = waitpid(-1,NULL,__WCLONE|WNOHANG);
 		
-	StopListening();
+	while (waitpid_result>0);
 	
 	
 	(void)printk(KERN_NOTICE "kHTTPd: Management daemon stopped. \n        You can unload the module now.\n");
@@ -354,6 +355,7 @@
 	
 	atomic_set(&ConnectCount,0);
 	atomic_set(&DaemonCount,0);
+	atomic_set(&khttpd_stopCount,0);
 	
 
 	/* Maybe the mime-types will be set-able through sysctl in the future */	   
diff -Naur linux-2.4.19.orig/net/khttpd/sysctl.c linux-2.4.19/net/khttpd/sysctl.c
--- linux-2.4.19.orig/net/khttpd/sysctl.c	Fri Feb  9 11:34:13 2001
+++ linux-2.4.19/net/khttpd/sysctl.c	Sun Aug 25 13:53:05 2002
@@ -64,6 +64,7 @@
 int	sysctl_khttpd_threads	= 2;
 int	sysctl_khttpd_maxconnect = 1000;
 
+atomic_t        khttpd_stopCount;
 
 static struct ctl_table_header *khttpd_table_header;
 
@@ -72,6 +73,8 @@
 		  void *newval, size_t newlen, void **context);
 static int proc_dosecurestring(ctl_table *table, int write, struct file *filp,
 		  void *buffer, size_t *lenp);
+static int khttpd_stop_wrap_proc_dointvec(ctl_table *table, int write, struct file *filp,
+		  void *buffer, size_t *lenp);
 
 
 static ctl_table khttpd_table[] = {
@@ -93,7 +96,7 @@
 		sizeof(int),
 		0644,
 		NULL,
-		proc_dointvec,
+		khttpd_stop_wrap_proc_dointvec,
 		&sysctl_intvec,
 		NULL,
 		NULL,
@@ -307,6 +310,24 @@
 	return 0;
 }
 
+/* A wrapper around proc_dointvec that computes
+ * khttpd_stopCount = # of times sysctl_khttpd_stop has gone true
+ * Sensing sysctl_khttpd_stop in other threads is racy;
+ * sensing khttpd_stopCount in other threads is not.
+ */
+static int khttpd_stop_wrap_proc_dointvec(ctl_table *table, int write, struct file *filp,
+		  void *buffer, size_t *lenp)
+{
+	int rv;
+	int oldstop = sysctl_khttpd_stop;
+	rv = proc_dointvec(table, write, filp, buffer, lenp);
+	if (sysctl_khttpd_stop && !oldstop)
+		atomic_inc(&khttpd_stopCount);
+
+	return rv;
+}
+		
+
 static int sysctl_SecureString (/*@unused@*/ctl_table *table, 
 				/*@unused@*/int *name, 
 				/*@unused@*/int nlen,
diff -Naur linux-2.4.19.orig/net/khttpd/sysctl.h linux-2.4.19/net/khttpd/sysctl.h
--- linux-2.4.19.orig/net/khttpd/sysctl.h	Wed Aug 18 09:45:10 1999
+++ linux-2.4.19/net/khttpd/sysctl.h	Sun Aug 25 13:53:05 2002
@@ -14,4 +14,7 @@
 extern int 	sysctl_khttpd_threads;
 extern int	sysctl_khttpd_maxconnect;
 
+/* incremented each time sysctl_khttpd_stop goes nonzero */
+extern atomic_t	khttpd_stopCount;
+
 #endif
diff -Naur linux-2.4.19.orig/net/khttpd/waitheaders.c linux-2.4.19/net/khttpd/waitheaders.c
--- linux-2.4.19.orig/net/khttpd/waitheaders.c	Mon Sep 10 07:57:00 2001
+++ linux-2.4.19/net/khttpd/waitheaders.c	Sun Aug 25 13:53:05 2002
@@ -134,7 +134,7 @@
 		CurrentRequest = CurrentRequest->Next;
 	}
 
-	LeaveFunction("WaitHeaders");
+	LeaveFunction("WaitForHeaders");
 	return count;
 }
 
@@ -178,6 +178,12 @@
 	
 	EnterFunction("DecodeHeader");
 	
+	if (Buffer[CPUNR] == NULL) {
+		/* see comments in main.c regarding buffer managemnet - dank */
+		printk(KERN_CRIT "khttpd: lost my buffer");
+		BUG();
+	}
+
 	/* First, read the data */
 
 	msg.msg_name     = 0;
diff -Naur linux-2.4.19.orig/Documentation/networking/khttpd.txt linux-2.4.19/Documentation/networking/khttpd.txt
--- linux-2.4.19.orig/Documentation/networking/khttpd.txt	Wed Dec 31 16:00:00 1969
+++ linux-2.4.19/Documentation/networking/khttpd.txt	Sun Aug 25 13:53:05 2002
@@ -0,0 +1 @@
+See net/khttpd/README for documentation on khttpd, the kernel http server.
diff -Naur linux-2.4.19.orig/net/khttpd/README linux-2.4.19/net/khttpd/README
--- linux-2.4.19.orig/net/khttpd/README	Thu Nov 16 14:07:53 2000
+++ linux-2.4.19/net/khttpd/README	Sun Aug 25 17:53:54 2002
@@ -14,9 +14,9 @@
    other webservers in that it runs from within the Linux-kernel as a module 
    (device-driver).
 
-   kHTTPd handles only static (file based) web-pages, and passes all requests
-   for non-static information to a regular userspace-webserver such as Apache or 
-   Zeus. The userspace-daemon doesn't have to be altered in any way.
+   kHTTPd handles only static (file based) web-pages, and passes all requests 
+   for non-static information to a regular userspace-webserver such as Apache 
+   or Zeus. The userspace-daemon doesn't have to be altered in any way.
 
    Static web-pages are not a very complex thing to serve, but these are very
    important nevertheless, since virtually all images are static, and a large
@@ -44,6 +44,7 @@
  
    echo 1 > /proc/sys/net/khttpd/stop
    echo 1 > /proc/sys/net/khttpd/unload 
+   sleep 2
    rmmod khttpd
    
 
@@ -71,7 +72,7 @@
 
    Before you can start using kHTTPd, you have to configure it. This
    is done through the /proc filesystem, and can thus be done from inside
-   a script. Most parameters can only be set when kHTTPd is not active.
+   a script. Most parameters can only be set when kHTTPd is stopped.
 
    The following things need configuration:
 
@@ -117,26 +118,31 @@
 
    Port 8080
 
+   Starting kHTTPd
+   ===============
+   Once you have set up the configuration, start kHTTPD by running
+   echo 1 > /proc/sys/net/khttpd/start
+   It may take a jiffie or two to start.
 
-   
    Stopping kHTTPd
    ===============
-   In order to change the configuration, you should stop kHTTPd by typing
+   To stop kHTTPd, do
    echo 1 > /proc/sys/net/khttpd/stop
-   on a command-prompt.
+   It should stop in a jiffy or two.
 
-   If you want to unload the module, you should type
+   Unloading kHTTPd
+   ===============
+   To unload the module, do
+   echo 1 > /proc/sys/net/khttpd/stop
    echo 1 > /proc/sys/net/khttpd/unload
-   after stopping kHTTPd first.
+   #killall -HUP khttpd
+   sleep 2
+   rmmod khttpd
 
-   If this doesn't work fast enough for you (the commands above can wait for 
+   If this doesn't work fast enough for you (unloading can wait for 
    a remote connection to close down), you can send the daemons a "HUP"
    signal after you told them to stop. This will cause the daemon-threads to
    stop immediately. 
-
-   Note that the daemons will restart immediately if they are not told to
-   stop.
-
    
 
 4. Permissions
@@ -212,7 +218,21 @@
 	maxconnect	1000		Maximum number of concurrent
 					connections
 
-6. More information
+6. Known Issues
+   kHTTPd is *not* currently compatible with tmpfs.  Trying to serve
+   files stored on a tmpfs partition is known to cause kernel oopses
+   as of 2.4.18.  This is due to the same problem that prevents sendfile()
+   from being usable with tmpfs.  A tmpfs patch is floating around that seems
+   to fix this, but has not been released as of 27 May 2002.
+   kHTTPD does work fine with ramfs, though.
+
+   There is debate about whether to remove kHTTPd from the main
+   kernel sources.  This will probably happen in the 2.5 kernel series,
+   after which khttpd will still be available as a patch.
+
+   The kHTTPd source code could use a good spring cleaning.
+
+7. More information
 -------------------
    More information about the architecture of kHTTPd, the mailinglist and
    configuration-examples can be found at the kHTTPd homepage:
@@ -221,4 +241,6 @@
 
    Bugreports, patches, etc can be send to the mailinglist
    (khttpd-users@zgp.org) or to khttpd@fenrus.demon.nl
+   Mailing list archives are at 
+      http://lists.alt.org/mailman/listinfo/khttpd-users
 
