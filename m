Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267552AbUH3OYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267552AbUH3OYN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 10:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267619AbUH3OYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 10:24:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51138 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267552AbUH3OYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 10:24:10 -0400
Message-ID: <41333879.2040902@redhat.com>
Date: Mon, 30 Aug 2004 10:23:53 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Marc_Str=E4mke?= <marcstraemke.work@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem accessing Sandisk CompactFlash Cards (Connected to the
 IDE bus)
References: <cgs2c1$ccg$1@sea.gmane.org> <4131DC5D.8060408@redhat.com> <cgsuq2$7cb$1@sea.gmane.org> <41326FE1.2050508@redhat.com> <20040830010712.GC12313@logos.cnet> <cguj7n$gur$1@sea.gmane.org>
In-Reply-To: <cguj7n$gur$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Strämke wrote:
> Marcelo Tosatti wrote:
> 
>> Indeed this is a typo but has been fixed on 2.4.26:
>>
>>         if (drive->removable && id != NULL) {
> 
> It never gets past this check because drive->removable is not set!
Theres actually a more interesting difference to notice:

In the working dmesg output I see this:
 > hda: SanDisk SDCFB-128, CFA DISK drive

While in the non working dmesg output we have:
 > hdb: SanDisk SDCFB-128, ATA DISK drive

Tracing back through the code it looks to me like we get the ATA disk 
print in the event that this test in do_identify:
/*
  * Check for an ATAPI device
  */
  if (cmd == WIN_PIDENTIFY) {

that would explain why the drive_is_flashcard test is getting skipped, 
why setting removable is making no difference, and why your card is 
being identified as an ATA device.  It looks as though the WIN_PIDENTIFY 
command is sent down to this routine from ide_probe_for_drive in this 
snip of code:

/* if !(success||timed-out) */
                 if (do_probe(drive, WIN_IDENTIFY) >= 2) {
                         /* look for ATAPI device */
                         (void) do_probe(drive, WIN_PIDENTIFY);
                 }

So it would seem that WIN_PIDENTIFY is issued only if a WIN_IDENTIFY 
command fails with an rc greater than 2.  I would suggest instrumenting 
this area of the code to see what the WIN_IDENTIFY command is returning 
on the working and non-working systems.  I'm betting you will find a 
difference, and we'll be able to track down the problem from there.

HTH
Neil
-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
