Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbTJGUlH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 16:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbTJGUlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 16:41:06 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:29850 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262819AbTJGUk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 16:40:59 -0400
Date: Tue, 7 Oct 2003 22:40:56 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: keyboard repeat speed went nuts since 2.6.0-test5, even in 2.6.0-test6-mm4
Message-ID: <20031007204056.GB20844@ucw.cz>
References: <20031007203316.GA1719@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20031007203316.GA1719@middle.of.nowhere>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2003 at 10:33:16PM +0200, Jurriaan wrote:
> I like my keyboard fast (must be from playing a lot of angband).
> 
> In 2.6.0-test5, after '/sbin/kbdrate -r 30 -d 250', I get some 2000
> characters in a minute (pressing n continuously, stopwatch in hand).
> In 2.6.0-test6 and 2.6.0-test6-mm4, after '/sbin/kbdrate -r 30 -d 250',
> I get some 820 characters in a minute.
> 
> 30 cps != 800/60 s, that's more like half that rate.
> 
> Booting with or without atkbd_softrepeat=1 on the kernel commandline
> makes no difference at all.

It's a bug. I have a fix, it went through LKML already, but Linus
didn't merge it yet. I'll be resending it.

> It's not only the repeat-speed that has gone down, the delay before
> repeat kicks in is notably slower as well. This is perhaps even more
> frustrating, but harder to measure :-(
> 
> This is on a plain Chicony KB-7903 PS/2 keyboard. It is connected via a
> Vista Rose KVM to a VIA KT400 chipset motherboard.
> 
> Any patches to test are very welcome here.

Fix attached.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kbdrate-fix

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1386, 2003-09-29 17:00:25+02:00, vojtech@suse.cz
  input: Fix AT keyboard repeat rate setting, also make rate selection
         in finer steps.


 atkbd.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Mon Sep 29 17:16:17 2003
+++ b/drivers/input/keyboard/atkbd.c	Mon Sep 29 17:16:17 2003
@@ -370,10 +370,11 @@
 static int atkbd_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
 	struct atkbd *atkbd = dev->private;
-	struct { int p; u8 v; } period[] =	
-		{ {30, 0x00}, {25, 0x02}, {20, 0x04}, {15, 0x08}, {10, 0x0c}, {7, 0x10}, {5, 0x14}, {0, 0x14} };
-	struct { int d; u8 v; } delay[] =
-        	{ {1000, 0x60}, {750, 0x40}, {500, 0x20}, {250, 0x00}, {0, 0x00} };
+	const short period[32] =
+		{ 33,  37,  42,  46,  50,  54,  58,  63,  67,  75,  83,  92, 100, 109, 116, 125,
+		 133, 149, 167, 182, 200, 217, 232, 250, 270, 303, 333, 370, 400, 435, 470, 500 };
+	const short delay[4] =
+		{ 250, 500, 750, 1000 };
 	char param[2];
 	int i, j;
 
@@ -407,11 +408,11 @@
 			if (atkbd_softrepeat) return 0;
 
 			i = j = 0;
-			while (period[i].p > dev->rep[REP_PERIOD]) i++;
-			while (delay[j].d > dev->rep[REP_DELAY]) j++;
-			dev->rep[REP_PERIOD] = period[i].p;
-			dev->rep[REP_DELAY] = delay[j].d;
-			param[0] = period[i].v | delay[j].v;
+			while (i < 32 && period[i] < dev->rep[REP_PERIOD]) i++;
+			while (j < 4 && delay[j] < dev->rep[REP_DELAY]) j++;
+			dev->rep[REP_PERIOD] = period[i];
+			dev->rep[REP_DELAY] = delay[j];
+			param[0] = i | (j << 5);
 			atkbd_command(atkbd, param, ATKBD_CMD_SETREP);
 
 			return 0;

--LZvS9be/3tNcYl/X--
