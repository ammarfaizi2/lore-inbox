Return-Path: owner-linux-kernel-outgoing@vger.rutgers.edu 
Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971339-2954>; Mon, 8 Dec 1997 19:21:55 -0500
Received: from chiara.csoma.elte.hu ([157.181.71.18]:16416 "EHLO chiara.csoma.elte.hu" ident: "NO-IDENT-SERVICE") by vger.rutgers.edu with ESMTP id <971521-2954>; Mon, 8 Dec 1997 19:15:42 -0500
Date: Sat, 6 Dec 1997 07:16:59 +0100 (CET)
From: MOLNAR Ingo <mingo@chiara.csoma.elte.hu>
To: Randy Dees <rrd@amherst.com>
cc: Linux Kernel List <linux-kernel@vger.rutgers.edu>
Subject: Re: Bug - Re: memleak 'DeLuxe' detector, 2.0.32, patch
In-Reply-To: <19971205123800.34650@odo.amherst.com>
Message-ID: <Pine.LNX.3.96.971206071424.8322A-100000@chiara.csoma.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu
X-IMAPbase: 1021135429 1963


On Fri, 5 Dec 1997, Randy Dees wrote:

> Thanks - but it won't compile for me.  

ok, the problem is that kfree() is now a macro, and the NCR driver tries
to take it's address ... 

this little patch should help:

--- 53c7,8xx.c.orig	Sat Dec  6 08:14:24 1997
+++ 53c7,8xx.c	Sat Dec  6 08:16:20 1997
@@ -3396,6 +3396,11 @@
     NCR53c7x0_write8(STEST3_REG_800, STEST3_800_TE);
 }
 
+static void private_kfree (void * addr)
+{
+	kfree(addr);
+}
+
 /*
  * Function static struct NCR53c7x0_cmd *allocate_cmd (Scsi_Cmnd *cmd)
  * 
@@ -3467,7 +3472,7 @@
 #ifdef LINUX_1_2
 	tmp->free = ((void (*)(void *, int)) kfree_s);
 #else
-	tmp->free = ((void (*)(void *, int)) kfree);
+	tmp->free = ((void (*)(void *, int)) private_kfree);
 #endif
 	save_flags (flags);
 	cli();
