Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131599AbRCQLRA>; Sat, 17 Mar 2001 06:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131601AbRCQLQv>; Sat, 17 Mar 2001 06:16:51 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:22201 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131599AbRCQLQi>; Sat, 17 Mar 2001 06:16:38 -0500
Message-ID: <3AB347C0.FC73CC80@uow.edu.au>
Date: Sat, 17 Mar 2001 22:17:20 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: John R Lenton <john@grulic.org.ar>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: oops in 2.4.2-ac20
In-Reply-To: <20010317015326.A650@grulic.org.ar>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John R Lenton wrote:
> 
> What the subject says.
> 
> I copied the oops by hand, but the output of ksymoops doesn't
> seem too totally wrong, so I guess I didn't botch it :)
> 

The trace dosn't look right, but you've probably hit
the con_flush_chars-called-from-interrupt problem.

Please add these two lines, let me know if it recurs.

--- linux-2.4.2-ac20/drivers/char/console.c	Tue Mar 13 20:29:21 2001
+++ ac/drivers/char/console.c	Sat Mar 17 22:16:14 2001
@@ -2304,6 +2335,9 @@
 static void con_flush_chars(struct tty_struct *tty)
 {
 	struct vt_struct *vt = (struct vt_struct *)tty->driver_data;
+
+	if (in_interrupt())	/* from flush_to_ldisc */
+		return;
 
 	pm_access(pm_con);
 	acquire_console_sem();
