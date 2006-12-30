Return-Path: <linux-kernel-owner+w=401wt.eu-S1030282AbWL3FZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWL3FZK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 00:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWL3FZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 00:25:10 -0500
Received: from gateway.insightbb.com ([74.128.0.19]:18967 "EHLO
	asav05.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030276AbWL3FZI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 00:25:08 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AusRAIKGlUVKhRO4UGdsb2JhbACHN4ZJAQEq
From: Dmitry Torokhov <dtor@insightbb.com>
To: Rene Herman <rene.herman@gmail.com>
Subject: Re: [BUG 2.6.20-rc2] atkbd.c: Spurious ACK
Date: Sat, 30 Dec 2006 00:25:05 -0500
User-Agent: KMail/1.9.3
Cc: Laurent Riffard <laurent.riffard@free.fr>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <4592E685.5000602@gmail.com> <45950DD1.2010208@free.fr> <4595679F.6070905@gmail.com>
In-Reply-To: <4595679F.6070905@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612300025.06088.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 December 2006 14:08, Rene Herman wrote:
> Laurent Riffard wrote:
> 
> > Le 29.12.2006 06:54, Rene Herman a écrit :
> 
> >> Not even an analog camera, but with or without the above, I get a single:
> >>
> >> " <7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [ 902]"
> 
> ... and when I add "debug" as a kernel param so that I actually get to 
> see them (doh) I get the same as Laurent:
> 
> > ====
> > drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35172]
> > drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35172]
> > atkbd.c: Spurious ACK on isa0060/serio0. Some program might be trying 
> > access hardware directly.
> > drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35296]
> > drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35297]
> > atkbd.c: Spurious ACK on isa0060/serio0. Some program might be trying 
> > access hardware directly.
> > drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35420]
> > drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35421]
> > atkbd.c: Spurious ACK on isa0060/serio0. Some program might be trying 
> > access hardware directly.
> > drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35544]
> > drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35545]
> > atkbd.c: Spurious ACK on isa0060/serio0. Some program might be trying 
> > access hardware directly.
> > ===
> 
> I tried just ignoring more ACKs in i8042_interrupt() but that didn't do 
> anything other than alternating between 2 and 1 i8042.c printks between 
> atkbd.c printks when ignoring an even or oneven number, respectively. I 
> guess it's atkbd.c which needs to ack something to keep it from just 
> being delivered over and over again or something like it?
>

No, atkbd does not need to ACK anything, it is keyboard controller
ACKs commands set to it. Normally there is only one owner of a serio
port and atkbd rightfully complains when it gets ACks from keyboard
controller when it does not expect it. However during panic we cut
in the middle and start sending kommands to the keybaord without atkbd
knowledge. Keyboard ACKs commands we sent to it and these ACKs reach
atkbd causing it to complain.

Somehow you get 2 ACks in a row, I wonder if on your boxes i8042 pumps
command and data into keyboard before i8042_interrupt gets a chance to
run. Could you please apply the debug patch below and tell me the
pattern of the data flow.

Thank you.

-- 
Dmitry

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

Index: work/drivers/input/serio/i8042.c
===================================================================
--- work.orig/drivers/input/serio/i8042.c
+++ work/drivers/input/serio/i8042.c
@@ -371,7 +371,7 @@ static irqreturn_t i8042_interrupt(int i
 	if (unlikely(i8042_suppress_kbd_ack))
 		if (port_no == I8042_KBD_PORT_NO &&
 		    (data == 0xfa || data == 0xfe)) {
-			i8042_suppress_kbd_ack = 0;
+			i8042_suppress_kbd_ack--;
 			goto out;
 		}
 
@@ -838,13 +838,14 @@ static long i8042_panic_blink(long count
 	led ^= 0x01 | 0x04;
 	while (i8042_read_status() & I8042_STR_IBF)
 		DELAY;
-	i8042_suppress_kbd_ack = 1;
+	dbg("%02x -> i8042 (panic blink)", 0xed);
+	i8042_suppress_kbd_ack = 2;
 	i8042_write_data(0xed); /* set leds */
 	DELAY;
 	while (i8042_read_status() & I8042_STR_IBF)
 		DELAY;
 	DELAY;
-	i8042_suppress_kbd_ack = 1;
+	dbg("%02x -> i8042 (panic blink)", led);
 	i8042_write_data(led);
 	DELAY;
 	last_blink = count;
