Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292638AbSCDSPO>; Mon, 4 Mar 2002 13:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292635AbSCDSPE>; Mon, 4 Mar 2002 13:15:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13320 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292638AbSCDSOr>; Mon, 4 Mar 2002 13:14:47 -0500
Subject: Re: [RFC] Arch option to touch newly allocated pages
To: jdike@karaya.com (Jeff Dike)
Date: Mon, 4 Mar 2002 18:29:27 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200203041742.MAA02717@ccure.karaya.com> from "Jeff Dike" at Mar 04, 2002 12:42:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hxDD-00007f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If UML can detect pages which tmpfs can't back as they leave the allocator,
> then it can prevent the rest of the UML kernel from getting randomly SIGBUSed
> as it touches those pages.

Yes I follow this.  I don't understand how it is related to your intended
solution.

> To recap in case it got lost in the confusion, I want __alloc_pages to call
> an arch hook before it return memory, turning every instance of

alloc_pages is only called at the time the backing page is created - by
then it doesnt matter - its too late. You'd need to hack up the same code
areas that are used for mlock MCL_FUTURE not alloc_pages

> Given that we are talking about tmpfs running out of space, the host still
> has plenty of free memory, and UML kernel stacks can receive the SIGBUS
> (because they've been allocated with this mechanism), is this still 
> objectionable?

With the vm no overcommit code the tmpfs cannot run out of space filling
in pages, only when you make a tmpfs file larger. The code guarantees there
are swap pages available to back between offset 0 and the file size.  A
write extending a tmpfs file may fail reporting the disk full.

The code guarantees (modulo bugs of course!) that the total number of
pages that could be created by touching addresses that have already been
mapped including accounting for tmpfs on the basis above never exceeds the
number of pages available.

The bugs at the moment being 
	1. ptrace isnt accounted for its special weirdnesses
	2. MAP_NORESERVE isnt forcibly accounted in these modes as required

