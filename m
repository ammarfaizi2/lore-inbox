Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318190AbSHMP4E>; Tue, 13 Aug 2002 11:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318193AbSHMP4E>; Tue, 13 Aug 2002 11:56:04 -0400
Received: from c-24-126-73-164.we.client2.attbi.com ([24.126.73.164]:10490
	"EHLO kegel.com") by vger.kernel.org with ESMTP id <S318190AbSHMPzy>;
	Tue, 13 Aug 2002 11:55:54 -0400
Date: Tue, 13 Aug 2002 09:04:25 -0700
From: dank@kegel.com
Message-Id: <200208131604.g7DG4PO03553@kegel.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix crash bugs in khttpd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has been working for me for some time.
It's been posted both on l-k and on the khttpd mailing list.
It not only fixes oopses, it also adds crucial usage notes to the readme.
Although this is against 2.4.17, it seems to apply cleanly to 2.4.19.
Marcello, please apply.
- Dan

diff -x '*times*' -x '.*' -x '*.o' -Naur linux-2.4.17-orig/net/khttpd/README linux/net/khttpd/README
--- linux-2.4.17-orig/net/khttpd/README	Thu Nov 16 14:07:53 2000
+++ linux/net/khttpd/README	Mon May 27 22:43:43 2002
@@ -44,6 +45,7 @@
  
    echo 1 > /proc/sys/net/khttpd/stop
    echo 1 > /proc/sys/net/khttpd/unload 
+   sleep 2
    rmmod khttpd
    
 
@@ -71,7 +73,7 @@
 
    Before you can start using kHTTPd, you have to configure it. This
    is done through the /proc filesystem, and can thus be done from inside
-   a script. Most parameters can only be set when kHTTPd is not active.
+   a script. Most parameters can only be set when kHTTPd is stopped.
 
    The following things need configuration:
 
@@ -117,26 +119,31 @@
 
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
@@ -212,7 +219,21 @@
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
@@ -221,4 +242,6 @@
 
    Bugreports, patches, etc can be send to the mailinglist
    (khttpd-users@zgp.org) or to khttpd@fenrus.demon.nl
+   Mailing list archives are at 
+      http://lists.alt.org/mailman/listinfo/khttpd-users
 
diff -x '*times*' -x '.*' -x '*.o' -Naur linux-2.4.17-orig/net/khttpd/main.c linux/net/khttpd/main.c
--- linux-2.4.17-orig/net/khttpd/main.c	Sun Mar 25 18:14:25 2001
+++ linux/net/khttpd/main.c	Mon May 27 23:17:08 2002
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
@@ -125,11 +131,9 @@
 	atomic_inc(&DaemonCount);
 	atomic_set(&Running[CPUNR],1);
 	
-	while (sysctl_khttpd_stop==0)
+	while (old_stop_count == atomic_read(&khttpd_stopCount)) 
 	{
 		int changes = 0;
-				
-
 		
 		changes +=AcceptConnections(CPUNR,MainSocket);
 		if (ConnectionsPending(CPUNR))
@@ -194,11 +198,9 @@
 	
 	DECLARE_WAIT_QUEUE_HEAD(WQ);
 	
-	
 	sprintf(current->comm,"khttpd manager");
 	daemonize();
 	
-
 	/* Block all signals except SIGKILL and SIGSTOP */
 	spin_lock_irq(&current->sigmask_lock);
 	tmpsig = current->blocked;
@@ -206,42 +208,35 @@
 	recalc_sigpending(current);
 	spin_unlock_irq(&current->sigmask_lock);
 
-
 	/* main loop */
 	while (sysctl_khttpd_unload==0)
 	{
 		int I;
-		
+		int old_stop_count;
 		
 		/* First : wait for activation */
-		
-		sysctl_khttpd_start = 0;
-		
 		while ( (sysctl_khttpd_start==0) && (!signal_pending(current)) && (sysctl_khttpd_unload==0) )
 		{
 			current->state = TASK_INTERRUPTIBLE;
 			interruptible_sleep_on_timeout(&WQ,HZ); 
 		}
-		
 		if ( (signal_pending(current)) || (sysctl_khttpd_unload!=0) )
 		 	break;
+		sysctl_khttpd_stop = 0;
 		 	
 		/* Then start listening and spawn the daemons */
-		 	
 		if (StartListening(sysctl_khttpd_serverport)==0)
 		{
+			sysctl_khttpd_start = 0;
 			continue;
 		}
-		
+
 		ActualThreads = sysctl_khttpd_threads;
 		if (ActualThreads<1) 
 			ActualThreads = 1;
-			
 		if (ActualThreads>CONFIG_KHTTPD_NUMCPU) 
 			ActualThreads = CONFIG_KHTTPD_NUMCPU;
-		
 		/* Write back the actual value */
-		
 		sysctl_khttpd_threads = ActualThreads;
 		
 		InitUserspace(ActualThreads);
@@ -249,87 +244,63 @@
 		if (InitDataSending(ActualThreads)!=0)
 		{
 			StopListening();
+			sysctl_khttpd_start = 0;
 			continue;
 		}
 		if (InitWaitHeaders(ActualThreads)!=0)
 		{
-			I=0;
-			while (I<ActualThreads)
-			{
+			for (I=0; I<ActualThreads; I++) {
 				StopDataSending(I);
-				I++;
 			}
 			StopListening();
+			sysctl_khttpd_start = 0;
 			continue;
 		}
 	
 		/* Clean all queues */
 		memset(threadinfo, 0, sizeof(struct khttpd_threadinfo));
 
-
-		 	
-		I=0;
-		while (I<ActualThreads)
-		{
+		for (I=0; I<ActualThreads; I++) {
 			atomic_set(&Running[I],1);
 			(void)kernel_thread(MainDaemon,&(CountBuf[I]), CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
-			I++;
 		}
 		
 		/* Then wait for deactivation */
-		sysctl_khttpd_stop = 0;
-
-		while ( (sysctl_khttpd_stop==0) && (!signal_pending(current)) && (sysctl_khttpd_unload==0) )
+		/* Remember value of stop count.  If it changes, user must 
+		 * have asked us to stop.  Sensing this is much less racy 
+		 * than directly sensing sysctl_khttpd_stop. - dank
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
+			/* Used to restart dead threads here, but it was buggy*/
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
-	
+	sysctl_khttpd_start = 0;
 	sysctl_khttpd_stop = 1;
+	atomic_inc(&khttpd_stopCount);
 
 	/* Wait for the daemons to stop, one second per iteration */
 	while (atomic_read(&DaemonCount)>0)
  		interruptible_sleep_on_timeout(&WQ,HZ);
-		
-		
-	waitpid_result = 1;
+	StopListening();
 	/* reap the zombie-daemons */
-	while (waitpid_result>0)
+	do
 		waitpid_result = waitpid(-1,NULL,__WCLONE|WNOHANG);
-		
-	StopListening();
-	
+	while (waitpid_result>0);
 	
 	(void)printk(KERN_NOTICE "kHTTPd: Management daemon stopped. \n        You can unload the module now.\n");
 
@@ -344,16 +315,13 @@
 
 	MOD_INC_USE_COUNT;
 	
-	I=0;
-	while (I<CONFIG_KHTTPD_NUMCPU)
-	{
+	for (I=0; I<CONFIG_KHTTPD_NUMCPU; I++) {
 		CountBuf[I]=I;
-		
-		I++;
 	}
 	
 	atomic_set(&ConnectCount,0);
 	atomic_set(&DaemonCount,0);
+	atomic_set(&khttpd_stopCount,0);
 	
 
 	/* Maybe the mime-types will be set-able through sysctl in the future */	   
diff -x '*times*' -x '.*' -x '*.o' -Naur linux-2.4.17-orig/net/khttpd/sysctl.c linux/net/khttpd/sysctl.c
--- linux-2.4.17-orig/net/khttpd/sysctl.c	Fri Feb  9 11:34:13 2001
+++ linux/net/khttpd/sysctl.c	Mon May 27 18:55:19 2002
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
diff -x '*times*' -x '.*' -x '*.o' -Naur linux-2.4.17-orig/net/khttpd/sysctl.h linux/net/khttpd/sysctl.h
--- linux-2.4.17-orig/net/khttpd/sysctl.h	Wed Aug 18 09:45:10 1999
+++ linux/net/khttpd/sysctl.h	Mon May 27 17:56:28 2002
@@ -14,4 +14,7 @@
 extern int 	sysctl_khttpd_threads;
 extern int	sysctl_khttpd_maxconnect;
 
+/* incremented each time sysctl_khttpd_stop goes nonzero */
+extern atomic_t	khttpd_stopCount;
+
 #endif
diff -x '*times*' -x '.*' -x '*.o' -Naur linux-2.4.17-orig/net/khttpd/waitheaders.c linux/net/khttpd/waitheaders.c
--- linux-2.4.17-orig/net/khttpd/waitheaders.c	Mon Sep 10 07:57:00 2001
+++ linux/net/khttpd/waitheaders.c	Mon May 27 17:56:28 2002
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
--- linux-2.4.17-orig/Documentation/networking/khttpd.txt	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/networking/khttpd.txt	Mon May 27 23:19:03 2002
@@ -0,0 +1 @@
+See net/khttpd/README for documentation on khttpd, the kernel http server.
