Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263135AbSKHX3F>; Fri, 8 Nov 2002 18:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263216AbSKHX3F>; Fri, 8 Nov 2002 18:29:05 -0500
Received: from thunk.org ([140.239.227.29]:62885 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S263135AbSKHX3F>;
	Fri, 8 Nov 2002 18:29:05 -0500
Date: Fri, 8 Nov 2002 18:35:30 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@digeo.com>
Cc: Ross Biro <rossb@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Failed writes marked clean?
Message-ID: <20021108233530.GA23888@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@digeo.com>, Ross Biro <rossb@google.com>,
	linux-kernel@vger.kernel.org
References: <3DCC1EB5.4020303@google.com> <3DCC252F.65C0F70B@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DCC252F.65C0F70B@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 12:57:19PM -0800, Andrew Morton wrote:
> Well before going and changing stuff, we need to decide what to
> change it _to_.  What do we want to happen if there's a read error?
> And a write error?
> 
> For reads, it makes sense for the page/buffer to be left not uptodate,
> and return an error.

In some circumstances, it may actually make sense to try writing a
random block of data to the disk, since that may force the disk to
remap the block.  (Disks generally only remap a block from the pool of
spare blocks on writes, not on reads.)

Unfortuantely, if the error was just a transient one, you might end up
smashing the block when you write random garbage in an attempt to
remap the block.  So perhaps the answer is to retry the read, and if
that fails, *then* try to do a forced rewrite of the block.

The next question is whether to do this in userspace or in the kernel.
And if in the kernel, whether it should be done at the device driver
layer, or in the block I/O layer, or in the filesystem?  

I can make a case for doing it in userspace, since that gives us the
most amount of flexibility, and it gives us ample opportunity to do
special things, such as paging an operator for help, etc.  On the
other hand, there are arguments for doing it in the kernel.  It may be
that an appropriately clever filesystem might be able to do more
intelligent recovery while keeping the filesystem mounted.  

						- Ted
