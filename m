Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315928AbSGBOOq>; Tue, 2 Jul 2002 10:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSGBOOp>; Tue, 2 Jul 2002 10:14:45 -0400
Received: from mail12.svr.pol.co.uk ([195.92.193.215]:55641 "EHLO
	mail12.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S315928AbSGBOOo>; Tue, 2 Jul 2002 10:14:44 -0400
Date: Tue, 2 Jul 2002 15:17:02 +0100
To: linux-lvm@sistina.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] LVM2 modifies the buffer_head struct?
Message-ID: <20020702141702.GA9769@fib011235813.fsnet.co.uk>
References: <F19741gcljD2E2044cY00004523@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F19741gcljD2E2044cY00004523@hotmail.com>
User-Agent: Mutt/1.3.28i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom,

On Tue, Jul 02, 2002 at 09:40:56AM -0400, Tom Walcott wrote:
> Hello,
> 
> Browsing the patch submitted for 2.4 inclusion, I noticed that LVM2 
> modifies the buffer_head struct. Why does LVM2 require the addition of it's 
> own private field in the buffer_head? It seems that it should be able to 
> use the existing b_private field.

This is a horrible hack to get around the fact that ext3 uses the
b_private field for its own purposes after the buffer_head has been
handed to the block layer (it doesn't just use b_private when in the
b_end_io function).  Is this acceptable behaviour ?  Other filesystems
do not have similar problems as far as I know.

device-mapper uses the b_private field to 'hook' the buffer_heads so
it can keep track of in flight ios (essential for implementing
suspend/resume correctly).  See dm.c:dec_pending()

As a simple fix I added the b_bdev_private field with the intention
that this is the private field for use by the block layer, and
b_private then effectively becomes b_fs_private.  I wont pretend to be
remotely happy with it.

I would love any suggestions of how else I can implement this, it
seems unreasonable to penalise everybody - not just those using ext3.

> How does that extra field affect performance relative to the cache? Won't 
> any negative effects be seen by everything that uses buffer_heads? Also, as 
> I understand the slab code and hardware cache alignment, won't the addition 
> of the new field cause the each buffer_head to consume 128 bytes instead of 
> 96?

Obviously there will be some negative effect, though don't have a feel
for how significant it would be.  I'm not even sure of what the best
way to measure this would be; if people can point me towards the most
suitable benchmark I'll be happy to do some testing for the list.

- Joe
