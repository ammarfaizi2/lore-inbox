Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263189AbTLOGG5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 01:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbTLOGG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 01:06:57 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:11021 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S263189AbTLOGGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 01:06:54 -0500
Message-ID: <3FDD4F7C.7090303@nishanet.com>
Date: Mon, 15 Dec 2003 01:06:52 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IRQ disabled (SATA) on NForce2 and my theory
References: <frodoid.frodo.87wu8zzgly.fsf@usenet.frodoid.org>
In-Reply-To: <frodoid.frodo.87wu8zzgly.fsf@usenet.frodoid.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sii chips have a long history of needing to
hdparm off the unmask interrupt feature.

I don't know about that chip but for
sii680 there is a special option "-p9"
for hdparm which is to say pio mode 9
is a special instruction in addition to
standard hdparm opt "-u0" turning off
irq unmask.

/sbin/hdparm -d1 -c1 -p9 -X70 -u0 -k0 -i $a

also the sii sata chips can have the kernel config
low-level scsi driver CONFIG_SCSI_SATA=y
which you should read about in this list archive.
I don't personally know about that.

-Bob

Julien Oster wrote:

>Hello!
>
>I got an ASUS A7N8X Deluxe v2.0 and APIC and I/O APIC enabled, thanks
>to athcool. (I didn't apply any patches, I just disable CPU Disconnect
>with 'athcool off' as first thing on boot).
>
>Now, however, since I am running with APIC, the following error occurs
>quite often:
>
>[...]
>Dec  8 19:16:20 frodo kernel: hde: DMA disabled
>Dec  8 19:16:20 frodo kernel: ide2: reset phy, status=0x00000113, siimage_reset
>[...]
>
>Shortly after that, the kernel would report:
>
>Dec  8 19:16:21 frodo kernel: Disabling IRQ #18
>Dec  8 19:16:22 frodo kernel: irq 18: nobody cared!
>
>This happens sometimes under very high load on my onboard SATA where
>both harddrivers (fast 10000rpm Raptors) are attached to a Linux
>Softraid RAID0. IRQ18 is attached to this.
>
>The drive/controller won't recover afterwards, only a reboot helps.
>
>Now, my theory about this: One patch to fix the NForce2 lockups was to
>insert a small delay in the acknowledgement of the timer
>interrupt. Apparently, the machine would lock up if the timer
>interrupt gets acknowledged too fast, meaning too soon.
>
>I now suspect that my IRQ18 problems are a result of exactly the same
>cause: IRQ18 getting acknowledged too soon on very high load, thus all
>further interrupts won't occur anymore and disk operations come to a
>halt.
>
>It was most noticeable for the timer interrupt, because the timer
>interrupt is basically always at "high load" and a lack of it would
>result in a hard lockup of the board. However, it now seems like the
>timer interrupt isn't the only interrupt suffering from this issue.
>
>So, I think inserting the small delay in the appropriate IRQ
>handler might fix this, too.
>
>But there's still the question, why the delay is actually needed for
>NForce2 boards. That would basically mean that you'll have to
>introduce the delay for *every* IRQ, to avoid a lockup of any device
>that will do high load at some time. I bet that, if I put my Firewire
>Card back in (or just use the onboard Firewire ports) and stream a
>video from my DV cam onto the harddisk, it would lock up as well after
>a very short time, since those who know DV also know that DV has a
>very high bandwidth, half an hour of film is like 40GB or the
>like. (However, I can't test this right now, because my DV cam is
>currently not accessible)
>
>So, we're still not "rock solid" with NForce2, I guess...
>Any idea?
>
>Regards,
>Julien
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

