Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbUCCDya (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 22:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbUCCDya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 22:54:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:27605 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262344AbUCCDy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 22:54:27 -0500
Date: Tue, 2 Mar 2004 19:55:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: jbarnes@sgi.com (Jesse Barnes)
Cc: kenneth.w.chen@intel.com, linux-kernel@vger.kernel.org
Subject: Re: per-cpu blk_plug_list
Message-Id: <20040302195548.4056b0a1.akpm@osdl.org>
In-Reply-To: <20040303034432.GA31277@sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2AB4C@scsmsx401.sc.intel.com>
	<20040303034432.GA31277@sgi.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbarnes@sgi.com (Jesse Barnes) wrote:
>
> On Mon, Mar 01, 2004 at 01:18:40PM -0800, Chen, Kenneth W wrote:
> > blk_plug_list/blk_plug_lock manages plug/unplug action.  When you have
> > lots of cpu simultaneously submits I/O, there are lots of movement with
> > the device queue on and off that global list.  Our measurement showed
> > that blk_plug_lock contention prevents linux-2.6.3 kernel to scale pass
> > beyond 40 thousand I/O per second in the I/O submit path.
> 
> This helped out our machines quite a bit too.  Without the patch, we
> weren't able to scale above 80000 IOPS, but now we exceed 110000 (and
> parity with our internal XSCSI based tree).
> 
> Maybe the plug lists and locks should be per-device though, rather than
> per-cpu?  That would make the migration case easier I think.  Is that
> possible?

It's possible, yes.  It is the preferred solution.  We need to identify all
the queues which need to be unplugged to permit a VFS-level IO request to
complete.  It involves running down the device stack and running around all
the contributing queues at each level.

Relatively straightforward, but first those dang sempahores in device
mapper need to become spinlocks.  I haven't looked into what difficulties
might be present in the RAID implementation.
