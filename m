Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314377AbSEFLZf>; Mon, 6 May 2002 07:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314380AbSEFLZf>; Mon, 6 May 2002 07:25:35 -0400
Received: from relay1.pair.com ([209.68.1.20]:3345 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S314377AbSEFLZe>;
	Mon, 6 May 2002 07:25:34 -0400
X-pair-Authenticated: 24.126.75.99
Message-ID: <3CD668DE.9D556B99@kegel.com>
Date: Mon, 06 May 2002 04:28:30 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: "David S. Miller" <davem@redhat.com>, arjanv@redhat.com,
        marcelo@conectiva.com.br, khttpd-users@alt.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Re: khttpd rotten?
In-Reply-To: <3CD5CE35.3EF2B62E@kegel.com> <20020505.191422.11638807.davem@redhat.com> <3CD5ECEE.E6C0B894@kegel.com> <20020506112259.A25629@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Sun, May 05, 2002 at 07:39:42PM -0700, Dan Kegel wrote:
> > ... I say pull it from 2.4.19-pre9.  
> > Marcello, put it out of its misery asap, please...
> > it'd time for khttpd to become a standalone patch again.
> 
> Okay, what about the following:
>  - the below patch remove khttpd from 2.4.19-pre, but lets the
>    sysctls in so it can compile out-of-tree
>  - http://verein.lst.de/~hch/khttpd/khttpd-20020506.tar.gz has a tarball
>    with khttpd as of 2.4.19-pre8, a simple makefile to build it and
>    a simple patch to allow loading it when CONFIG_IPV6 != m,
>    Arjan, could you please put it on the official khttpd website if one
>    still exists.
>  - for 2.5 the sysctls can go aswell

That's probably good.  However, I may have been a bit hasty in
my general condemnation of khttpd.  The following patch seems
to solve the nasty problems; perhaps removing khttpd can wait a bit.
(I only tested the patch briefly, but it makes a lot of sense,
and it did improve things here.)
- Dan

diff -aur linux-2.4.19-pre8.orig/net/khttpd/README linux-2.4.19-pre8/net/khttpd/README
--- linux-2.4.19-pre8.orig/net/khttpd/README	Mon May  6 11:37:33 2002
+++ linux-2.4.19-pre8/net/khttpd/README	Mon May  6 12:10:27 2002
@@ -44,6 +44,7 @@
  
    echo 1 > /proc/sys/net/khttpd/stop
    echo 1 > /proc/sys/net/khttpd/unload 
+   sleep 2
    rmmod khttpd
    
 
@@ -123,7 +124,9 @@
    ===============
    In order to change the configuration, you should stop kHTTPd by typing
    echo 1 > /proc/sys/net/khttpd/stop
-   on a command-prompt.
+   sleep 2
+   on a command-prompt.  (The sleep makes it more likely
+   that all kHTTPd threads notice the stop request.)
 
    If you want to unload the module, you should type
    echo 1 > /proc/sys/net/khttpd/unload
diff -aur linux-2.4.19-pre8.orig/net/khttpd/main.c linux-2.4.19-pre8/net/khttpd/main.c
--- linux-2.4.19-pre8.orig/net/khttpd/main.c	Mon May  6 11:37:33 2002
+++ linux-2.4.19-pre8/net/khttpd/main.c	Mon May  6 11:48:47 2002
@@ -226,6 +226,9 @@
 		if ( (signal_pending(current)) || (sysctl_khttpd_unload!=0) )
 		 	break;
 		 	
+		/* must clear 'stop' flag before starting threads!  -dank */
+		sysctl_khttpd_stop = 0;
+
 		/* Then start listening and spawn the daemons */
 		 	
 		if (StartListening(sysctl_khttpd_serverport)==0)
@@ -277,10 +278,20 @@
 		}
 		
 		/* Then wait for deactivation */
-		sysctl_khttpd_stop = 0;
 
 		while ( (sysctl_khttpd_stop==0) && (!signal_pending(current)) && (sysctl_khttpd_unload==0) )
 		{
+
+#if 0
+		/* FIXME This section seems to be here to restart worker 
+		 * threads that have died for any reason, but it has a bug:
+		 * if 'stop' is set briefly while this thread is asleep, and
+		 * a worker thread notices, it terminates and free its buffer,
+		 * and this thread will restart it without reallocating
+		 * its buffer.  This happened *every time* until I moved
+		 * the 'sysctl_khttpd_stop = 0' statement up above the thread
+		 * creation.  dank@kegel.com
+		 */
 			if (atomic_read(&DaemonCount)<ActualThreads)
 			{
 				I=0;
@@ -295,6 +306,8 @@
 					I++;
 				}
 			}
+#endif
+
 			interruptible_sleep_on_timeout(&WQ,HZ);
 			
 			/* reap the daemons */
diff -aur linux-2.4.19-pre8.orig/net/khttpd/waitheaders.c linux-2.4.19-pre8/net/khttpd/waitheaders.c
--- linux-2.4.19-pre8.orig/net/khttpd/waitheaders.c	Mon May  6 11:37:33 2002
+++ linux-2.4.19-pre8/net/khttpd/waitheaders.c	Mon May  6 11:54:23 2002
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
