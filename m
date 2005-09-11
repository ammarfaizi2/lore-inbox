Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932728AbVIKARo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932728AbVIKARo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 20:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbVIKARo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 20:17:44 -0400
Received: from mail.dvmed.net ([216.237.124.58]:57238 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932393AbVIKARn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 20:17:43 -0400
Message-ID: <432377A3.5070805@pobox.com>
Date: Sat, 10 Sep 2005 20:17:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
References: <Pine.LNX.4.44L0.0509101655520.7081-100000@netrider.rowland.org> <Pine.LNX.4.58.0509101410300.30958@g5.osdl.org> <43235707.7050909@pobox.com> <20050910153110.36a44eba.akpm@osdl.org> <Pine.LNX.4.58.0509101548230.30958@g5.osdl.org> <43236FD2.6010501@pobox.com> <Pine.LNX.4.58.0509101658080.30958@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509101658080.30958@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 10 Sep 2005, Jeff Garzik wrote:
> 
>>I -do- want to use iomap.  The problem is that no one has yet come up 
>>with a few that does all the proper resource reservation.  Everybody 
>>(including myself) did the ioread/iowrite part, but gave up before 
>>handling all cases of (a) legacy ISA iomap, (b) native PCI IDE iomap, 
>>and (c) non-standard MMIO iomap.
> 
> 
> It should all be trivial. The only ugly issue in the patch I just sent out 
> is that it needs to save the "legacy_mode" bits that were calculated at 
> initialization time somewhere in the ap structure. Then the 
> release_regions should match the request_regions.

More ugly issues abound, see below :)


> That's a cleanup, the current code is literally buggy. It may end up
> releasing IO address 0x1f0 twice, if somebody wasn't marked legacy, but
> actually had 0x1f0 in the PCI resource pointers (maybe that doesn't ever

Haven't run into anything yet that trips up the legacy/native detection 
in libata except for mixed mode (1 port legacy, 1 port native).  But 
those bugs aren't in the area of code we're discussing.


> happen, but still.. Relying on the legacy-value of the IO port instead of
> relying on whether you did a legacy request_region() is definitely at
> least conceptually wrong).

Its not that simple.  grep for ____request_region in both libata and the 
PCI quirks code.  libata grabs the SATA port on ICH boxes in combined 
mode... but has to do so before built-in IDE driver grabs them.

	Jeff


