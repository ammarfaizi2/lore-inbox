Return-Path: <linux-kernel-owner+w=401wt.eu-S965092AbWL2TJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbWL2TJo (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 14:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbWL2TJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 14:09:44 -0500
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:43152 "EHLO
	smtpq1.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965092AbWL2TJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 14:09:43 -0500
Message-ID: <4595679F.6070905@gmail.com>
Date: Fri, 29 Dec 2006 20:08:15 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Dmitry Torokhov <dtor@insightbb.com>
CC: Laurent Riffard <laurent.riffard@free.fr>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [BUG 2.6.20-rc2] atkbd.c: Spurious ACK
References: <4592E685.5000602@gmail.com> <200612290000.12791.dtor@insightbb.com> <4594A4DC.5090404@gmail.com> <200612290028.01531.dtor@insightbb.com> <4594ADAD.1030400@gmail.com> <45950DD1.2010208@free.fr>
In-Reply-To: <45950DD1.2010208@free.fr>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Riffard wrote:

> Le 29.12.2006 06:54, Rene Herman a écrit :

>> Not even an analog camera, but with or without the above, I get a single:
>>
>> " <7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [ 902]"

... and when I add "debug" as a kernel param so that I actually get to 
see them (doh) I get the same as Laurent:

> ====
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35172]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35172]
> atkbd.c: Spurious ACK on isa0060/serio0. Some program might be trying 
> access hardware directly.
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35296]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35297]
> atkbd.c: Spurious ACK on isa0060/serio0. Some program might be trying 
> access hardware directly.
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35420]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35421]
> atkbd.c: Spurious ACK on isa0060/serio0. Some program might be trying 
> access hardware directly.
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35544]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35545]
> atkbd.c: Spurious ACK on isa0060/serio0. Some program might be trying 
> access hardware directly.
> ===

I tried just ignoring more ACKs in i8042_interrupt() but that didn't do 
anything other than alternating between 2 and 1 i8042.c printks between 
atkbd.c printks when ignoring an even or oneven number, respectively. I 
guess it's atkbd.c which needs to ack something to keep it from just 
being delivered over and over again or something like it?

If I apply the following, things seem to be working for me; no "Spurious 
ACK" messages anymore (but a steady stream of fa's from i8042). Not a 
real fix, but I hope it's enough of a clue for someone who understands 
the infrastructure here. Vojtech added to CC as well.

I by the way also tried plugging in a PS/2 mouse (I normally use a USB 
mouse), adding atkbd_reset=1 to the kernel params and lifting the

        if (!flags && data == ATKBD_RET_ACK)
                 atkbd->resend = 0;

out of the ! __i386__ define. No help.

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index c621a91..5f88dde 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -372,9 +372,8 @@ #if !defined(__i386__) && !defined (__x8
  		atkbd->resend = 0;
  #endif

-	if (unlikely(atkbd->ps2dev.flags & PS2_FLAG_ACK))
-		if  (ps2_handle_ack(&atkbd->ps2dev, data))
-			goto out;
+	if (ps2_handle_ack(&atkbd->ps2dev, data))
+		goto out;

  	if (unlikely(atkbd->ps2dev.flags & PS2_FLAG_CMD))
  		if  (ps2_handle_response(&atkbd->ps2dev, data))

Rene.

