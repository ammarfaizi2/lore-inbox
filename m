Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRB1XOS>; Wed, 28 Feb 2001 18:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129381AbRB1XLu>; Wed, 28 Feb 2001 18:11:50 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:44980 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129339AbRB1XLY>; Wed, 28 Feb 2001 18:11:24 -0500
Message-ID: <3A9D857C.CF9EF272@uow.edu.au>
Date: Wed, 28 Feb 2001 23:10:52 +0000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Priban <david2@maincube.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: i2o & Promise SuperTrak100
In-Reply-To: <MPBBILLJAONHMANIJOPDOEFNFMAA.david2@maincube.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Priban wrote:
> 
> > > Kernel panic: Aiee, killing interrupt handler !
> > > In interrupt handler - not syncing
> >
> > Run it through ksymoops and I might be able to guess what went wrong.
> >
> > In theory however i2o is a standard and all i2o works alike. In
> > practice i2o
> > is a pseudo standard and nobody seems to interpret the spec the
> > same way, the
> > implementations all tend to have bugs and the hardware sometimes does too.
> >
> Alan,
> This is what ksymoops gave me. One thing I didn't mention before:
> kernel panics when I hit Ctrl-Alt-Del after it hangs telling me this:
> 

This untested patch should fix the scheduling-in-interrupt
thing.


--- kernel/sys.c.orig	Thu Mar  1 10:06:14 2001
+++ kernel/sys.c	Thu Mar  1 10:07:43 2001
@@ -330,6 +330,12 @@
 	return 0;
 }
 
+static void deferred_cad(void *dummy)
+{
+	notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
+	machine_restart(NULL);
+}
+
 /*
  * This function gets called by ctrl-alt-del - ie the keyboard interrupt.
  * As it's called within an interrupt, it may NOT sync: the only choice
@@ -337,10 +343,13 @@
  */
 void ctrl_alt_del(void)
 {
-	if (C_A_D) {
-		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
-		machine_restart(NULL);
-	} else
+	static struct tq_struct cad_tq = {
+		routine: deferred_cad,
+	};
+
+	if (C_A_D)
+		schedule_task(&cad_tq);
+	else
 		kill_proc(1, SIGINT, 1);
 }
 	
-
