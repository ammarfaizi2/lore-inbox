Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVAODiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVAODiS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 22:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVAODhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 22:37:41 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:20400 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262212AbVAODhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 22:37:34 -0500
To: hpa@zytor.com (H. Peter Anvin)
Cc: linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <9e47339105010609175dabc381@mail.gmail.com>
	<9e4733910501061205354c9508@mail.gmail.com>
	<20050106214159.GG16373@redhat.com>
	<9e47339105010721225c0cfb32@mail.gmail.com>
	<csa0kn$4eg$1@terminus.zytor.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 14 Jan 2005 19:37:29 -0800
In-Reply-To: <csa0kn$4eg$1@terminus.zytor.com> (H. Peter Anvin's message of
 "Sat, 15 Jan 2005 02:54:15 +0000 (UTC)")
Message-ID: <521xcnl5vq.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: chasing the four level page table
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: No (on eddore); Unknown failure
X-OriginalArrivalTime: 15 Jan 2005 03:37:32.0911 (UTC) FILETIME=[8C0F27F0:01C4FAB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    ak> Perhaps we should add a get_user_phys() or somesuch for this.

    hpa> There seems to be at least two classes of device drivers --
    hpa> graphics and RDMA -- which have a genuine need to DMA user
    hpa> pages, after appropriate locking, of course.

I'm working on InfiniBand drivers, which will be doing RDMA.  I'm
probably missing something, but get_user_pages() seems to be all I
need -- I don't see how get_user_phys() would help me.  Of course I
need to do dma_map_sg() or the like to get an address I can pass to
the InfiniBand device but I don't see anything wrong with that.

There are some issues around fork() and copy-on-write, but those
really require more access to vma handling than page tables.  What
would be nice would be an equivalent to do_mlock() that also sets or
clears the VM_DONTCOPY flag.  This is because an RDMA application
wants to do something like mlock() to keep any pages to be DMAed
present, but even after doing mlock(), if the application forks and
touches one of these locked pages, the COW will move the page to a new
physical address.

 - Roland
