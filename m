Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268502AbUH3PsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268502AbUH3PsX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 11:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268515AbUH3PsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 11:48:22 -0400
Received: from main.gmane.org ([80.91.224.249]:12191 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268502AbUH3PrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 11:47:05 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Marc_Str=E4mke?= <marcstraemke.work@gmx.net>
Subject: Re: Problem accessing Sandisk CompactFlash Cards (Connected to the
   IDE bus)
Date: Mon, 30 Aug 2004 17:49:40 +0200
Message-ID: <cgvi5l$t0d$1@sea.gmane.org>
References: <cgs2c1$ccg$1@sea.gmane.org> <4131DC5D.8060408@redhat.com> <cgsuq2$7cb$1@sea.gmane.org> <41326FE1.2050508@redhat.com> <20040830010712.GC12313@logos.cnet> <cguj7n$gur$1@sea.gmane.org> <41333879.2040902@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p508ea078.dip.t-dialin.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
In-Reply-To: <41333879.2040902@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tracing back through the code it looks to me like we get the ATA disk 
> print in the event that this test in do_identify:
> /*
>  * Check for an ATAPI device
>  */
>  if (cmd == WIN_PIDENTIFY) {
> 
> that would explain why the drive_is_flashcard test is getting skipped, 
> why setting removable is making no difference, and why your card is 
> being identified as an ATA device.  It looks as though the WIN_PIDENTIFY 
> command is sent down to this routine from ide_probe_for_drive in this 
> snip of code:
> 
> /* if !(success||timed-out) */
>                 if (do_probe(drive, WIN_IDENTIFY) >= 2) {
>                         /* look for ATAPI device */
>                         (void) do_probe(drive, WIN_PIDENTIFY);
>                 }
Both Cards, the old and the new on dont get to the ATAPI probing (which 
seems correct to me, or is compactflash an ATAPI device???)


> 
> So it would seem that WIN_PIDENTIFY is issued only if a WIN_IDENTIFY 
> command fails with an rc greater than 2.  I would suggest instrumenting 
WIN_IDENTIFY returns a rc of 0 (for success) with both the old and the 
new card. Still the old ones gets detected as CFA!


One thing i did notice when tracing these functions, is that the new 
card returns 0x44a in drive->id->config, while the old one returns 
0x848a, according to the manual from 
SanDisk(http://www.sandisk.com/pdf/industrial/ProdManualIndustrialGradeATAv2.6.pdf) 
Should only be returned in memory mapped(cardbus/pc-card) mode, and not 
in True IDE mode, which the card is appearently running, otherwise the 
bios couldnt not boot from it, nor would the electrical interface be 
compatible (if i get the manual right). That is imo why hdparm -I doesnt 
detect the card as beein removable and Compactflash too, i looked as the 
sourcode of hdparm, and it seems to read the ATA configuration registers 
trough a proc file, and interpret it directly (without intervention of 
the kernel).
So the data the does return indeed marks it as an ATA harddisk, and not 
as a compactflash card, the real question then is why doesnt it work as 
a harddisk, which according to the specifications it should? Iam not 
really experienced in the ide stuff, so iam not sure what the 
CompactFlash detection in linux changes in behaviour.
I can get the kernel to report it as a "CFA DISK Drive" in dmesg by 
forcing the flags i mentioned before, but the error is exactly the same.

Thx for your help,
Marc

