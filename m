Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267961AbUHTInx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267961AbUHTInx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267934AbUHTIng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:43:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8938 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267900AbUHTIkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:40:22 -0400
Date: Fri, 20 Aug 2004 01:40:05 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Oliver Neukum <oliver@neukum.org>, Hugh Dickins <hugh@veritas.com>,
       arjanv@redhat.com, alan@redhat.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, riel@redhat.com, sct@redhat.com,
       zaitcev@redhat.com
Subject: Re: PF_MEMALLOC in 2.6
Message-Id: <20040820014005.73383a43@lembas.zaitcev.lan>
In-Reply-To: <4125B111.2040308@yahoo.com.au>
References: <Pine.LNX.4.44.0408191320320.17508-100000@localhost.localdomain>
	<200408192025.53536.oliver@neukum.org>
	<412563F6.1080202@yahoo.com.au>
	<200408200956.50972.oliver@neukum.org>
	<4125B111.2040308@yahoo.com.au>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004 18:06:41 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >>So I'd say try to find a way to only use PF_MEMALLOC on behalf of
> >>a PF_MEMALLOC thread or use a mempool or something.
> > 
> > Then the SCSI layer should pass down the flag.
> 
> It would be ideal from the memory allocator's point of view to do it
> on a per-request basis like that.
> 
> When the rubber hits the road, I think it is probably going to be very
> troublesome to do it right that way. For example, what happens when
> your usb-thingy-thread blocks on a memory allocation while handling a
> read request, then the system gets low on memory and someone tries to
> free some by submitting a write request to the USB device?

If you let me gloat for a little bit, ub makes this discussion moot
because it has no helper thread. But getting back to usb-storage,
here's the actual bug:
 https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=130326

As you can see, it's muddled considerably. The original report
has no useful information, but if you look into an obscure but hefty
attachement, you see this:

Aug 18 20:23:47 trilobite kernel: kjournald starting.  Commit interval 5 seconds
Aug 18 20:23:47 trilobite kernel: EXT3 FS on sdc5, internal journal
Aug 18 20:23:47 trilobite kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 18 20:30:54 trilobite kernel: SCSI error : <2 0 0 0> return code = 0x70000
Aug 18 20:30:54 trilobite kernel: end_request: I/O error, dev sdc, sector 37625666
Aug 18 20:30:54 trilobite kernel: Buffer I/O error on device sdc5, logical block 1532371
Aug 18 20:30:54 trilobite kernel: lost page write due to I/O error on sdc5
Aug 18 20:31:04 trilobite kernel: SCSI error : <2 0 0 0> return code = 0x70000
Aug 18 20:31:04 trilobite kernel: end_request: I/O error, dev sdc, sector 37625674
Aug 18 20:31:04 trilobite kernel: Buffer I/O error on device sdc5, logical block 1532372
Aug 18 20:31:04 trilobite kernel: lost page write due to I/O error on sdc5
....
Aug 18 20:32:23 trilobite kernel: scsi2 (0:0): rejecting I/O to dead device
Aug 18 20:32:23 trilobite last message repeated 1723 times
 <----- which is basically what happens when the EH thread loses patience

This is what made me suspect that it's the diry memory writeout problem.
It's just like how it was on 2.4 before Alan added PF_MEMALLOC.

-- Pete
