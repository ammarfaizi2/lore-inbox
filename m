Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVALTkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVALTkw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVALThP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 14:37:15 -0500
Received: from fire.osdl.org ([65.172.181.4]:53390 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261320AbVALTfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:35:52 -0500
Message-ID: <41E57B0C.30905@osdl.org>
Date: Wed, 12 Jan 2005 11:31:24 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Question regarding ERR in /proc/interrupts.
References: <Pine.LNX.4.61.0501121410360.11524@p500>
In-Reply-To: <Pine.LNX.4.61.0501121410360.11524@p500>
Content-Type: multipart/mixed;
 boundary="------------030002040703080105060908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030002040703080105060908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Justin Piszcz wrote:
> Is there anyway to log each ERR to a file or way to find out what caused 
> each ERR?
> 
> For example, I know this is the cause of a few of them:
> spurious 8259A interrupt: IRQ7.
> 
> But not all 20, is there any available option to do this?

Are you sure about that?

MOTD:  what kernel version?

2.6.10 (and probably all) prints such message one time for each
"spurious" IRQ, sets a flag for that IRQ, and then doesn't
print such message for that IRQ any more (i.e., so that
log isn't spammed).  Each distinct spurious IRQ should be
logged (one time).  If you want more, you'll need to patch
a source file and rebuild the kernel (attached, for i8259
PIC, not for APIC, since that's what you seem to have).

> $ cat /proc/interrupts
>            CPU0
>   0:  887759057          XT-PIC  timer
>   1:       3138          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   5:       5811          XT-PIC  Crystal audio controller
>   9:  265081861          XT-PIC  ide4, eth1, eth2
>  10:    9087912          XT-PIC  ide6, ide7
>  11:     837707          XT-PIC  ide2, ide3
>  12:      13854          XT-PIC  i8042
>  14:   63373075          XT-PIC  eth0
> NMI:          0
> ERR:         20

-- 
~Randy

--------------030002040703080105060908
Content-Type: text/x-patch;
 name="irq_err_msg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="irq_err_msg.patch"

linux-2610-bk13

Print all spurious IRQs. (!)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 arch/i386/kernel/i8259.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./arch/i386/kernel/i8259.c~irq_err ./arch/i386/kernel/i8259.c
--- ./arch/i386/kernel/i8259.c~irq_err	2004-12-24 13:35:28.000000000 -0800
+++ ./arch/i386/kernel/i8259.c	2005-01-12 11:28:44.233785256 -0800
@@ -225,7 +225,7 @@ spurious_8259A_irq:
 		 * At this point we can be sure the IRQ is spurious,
 		 * lets ACK and report it. [once per IRQ]
 		 */
-		if (!(spurious_irq_mask & irqmask)) {
+		/* if (!(spurious_irq_mask & irqmask)) */ {
 			printk(KERN_DEBUG "spurious 8259A interrupt: IRQ%d.\n", irq);
 			spurious_irq_mask |= irqmask;
 		}

--------------030002040703080105060908--
