Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268300AbUHYFi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268300AbUHYFi2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 01:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268280AbUHYFi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 01:38:28 -0400
Received: from av9-1-sn4.m-sp.skanova.net ([81.228.10.108]:21977 "EHLO
	av9-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S268482AbUHYFiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 01:38:20 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speed up the cdrw packet writing driver
References: <m33c2py1m1.fsf@telia.com> <20040823114329.GI2301@suse.de>
	<m3llg5dein.fsf@telia.com> <20040824202951.GA24280@suse.de>
	<m3hdqsckoo.fsf@telia.com> <20040824144707.100e0cfd.akpm@osdl.org>
	<m3d61gchyb.fsf@telia.com> <20040824155635.3d1a1dd6.akpm@osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 25 Aug 2004 07:38:16 +0200
In-Reply-To: <20040824155635.3d1a1dd6.akpm@osdl.org>
Message-ID: <m36577dbg7.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Peter Osterlund <petero2@telia.com> wrote:
> >
> > > Are you saying that your requests are so huge that each one has 1000 BIOs? 
> > > That would be odd, for an IDE interface.
> > 
> > No, the thing is that the packet driver doesn't create requests at
> > all. It stuffs incoming bio's in the rbtree, then the worker thread
> > collects bio's from the rbtree for the same "zone" on the disc (each
> > zone is 64kb on a CDRW and 32KB on a DVD). The driver then creates a
> > new bio with the same size as the zone size and submits it to the real
> > CD/DVD device.
> 
> Good lord.  I assume there's a good reason for this?

The reason is that generic_make_request() takes a bio, not a request.
Loop and md don't deal with "struct request" either, they also work
directly at the bio level.

The reason the driver doesn't process the bios in sequential order
like md and loop seems to do, is because it wants to maximize I/O
performance. With a typical DVD drive, write bandwidth is 5.3MB/s and
seek times when writing are 500ms. Also, there is a big penalty for
not being able to completely fill a "zone", because it means that the
driver will have to read the missing pieces from the disc before being
able to submit the "write bio".

Is there some problem doing what the pktcdvd driver is doing?

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
