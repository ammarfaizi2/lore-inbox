Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTKXICP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 03:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTKXICP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 03:02:15 -0500
Received: from prv-mail25.provo.novell.com ([137.65.81.121]:18320 "EHLO
	prv-mail25.provo.novell.com") by vger.kernel.org with ESMTP
	id S263637AbTKXICK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 03:02:10 -0500
Message-Id: <sfc15891.016@prv-mail25.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Mon, 24 Nov 2003 01:01:49 -0700
From: "Subbu K. K." <kksubramaniam@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: Fix for "MT2032 Fatal Error: PLLs didn't lock"
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found a sign extension defect in the bttv driver code. The defect
will manifest itself when using any TV Channels above 133.25MHz using
xawtv or any other TV viewer. I just got a white noise hiss. I was able
to reproduce the defect on Mandrake 9.1, Knoppix (Oct 2003) even with
the latest bttv 0.7.107 and in the latest test10 bttv driver code.  The
symptoms for this defect in the mesage log are:
====/var/log/messages==
Nov 16 21:42:51 localhost kernel: mt2032: re-init PLLs by LINT
Nov 16 21:42:51 localhost kernel: mt2032: re-init PLLs by LINT
Nov 16 21:42:51 localhost kernel: MT2032 Fatal Error: PLLs didn't
lock.
=================

I saw others report same issues but didnt see any
fixes/patches/solutions. With the debug option on for bttv and tuner in
/etc/modules.conf and the TV frequency set to 133.25MHz and then
140.25MHz, the sign extension defect pops up in rfin value below. This
is because 133.25MHz is 0x7F13BD0 and 140.25MHz is 0x85C0B90. The high
bit gets sign extended in as 0xFFFFFFFFF85C0B90 (-128185456)
===
Nov 16 21:45:56 localhost kernel: tuner: tv freq set to 133.25
Nov 16 21:45:56 localhost kernel: mt2032_set_if_freq rfin=133250000
if1=1090000000 if2=38900000 from=32900000 to=39900000
..
Nov 16 21:45:58 localhost kernel: tuner: tv freq set to 140.25
Nov 16 21:45:58 localhost kernel: mt2032_set_if_freq rfin=-128185456
if1=1090000000 if2=38900000 from=32900000 to=39900000
===

The patch is fairly small and involves only three lines of code to
tuner.c. The first change is required and the next two changes are
strongly recommended. Now, I am able to watch all the cable channels
using Pinnacle PCTV/Rave (branded as PCTV Plus in India) on Mandrake 9.1
without any issues. Can others confirm if the patch works for them on
the recent kernel builds.

--- bttv-0.7.107/driver/tuner.c	2003-06-24 21:52:11.000000000
+0530
+++ bttv-0.7.107-fix/driver/tuner.c	2003-11-16 23:30:47.000000000
+0530
@@ -951,15 +951,15 @@
 	}
 	case VIDIOCSFREQ:
 	{
-		unsigned long *v = arg;
+		unsigned int *v = arg;
 
 		if (t->radio) {
 			dprintk("tuner: radio freq set to %d.%02d\n",
-				(*iarg)/16,(*iarg)%16*100/16);
+				(*v)/16,(*v)%16*100/16);
 			set_radio_freq(client,*v);
 		} else {
 			dprintk("tuner: tv freq set to %d.%02d\n",
-				(*iarg)/16,(*iarg)%16*100/16);
+				(*v)/16,(*v)%16*100/16);
 			set_tv_freq(client,*v);
 		}
 		t->freq = *v;
=====

Subbu K. K.
