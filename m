Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263238AbREWT6W>; Wed, 23 May 2001 15:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263239AbREWT6M>; Wed, 23 May 2001 15:58:12 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:32197 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263238AbREWT55>; Wed, 23 May 2001 15:57:57 -0400
Date: Wed, 23 May 2001 20:57:48 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: DVD blockdevice buffers
Message-ID: <20010523205748.L8080@redhat.com>
In-Reply-To: <20010523183419.I27177@redhat.com> <Pine.LNX.4.21.0105231104200.6320-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0105231104200.6320-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, May 23, 2001 at 11:12:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 23, 2001 at 11:12:00AM -0700, Linus Torvalds wrote:
> 
> On Wed, 23 May 2001, Stephen C. Tweedie wrote:
> No, you can actually do all the "prepare_write()"/"commit_write()" stuff
> that the filesystems already do. And you can do it a lot _better_ than the
> current buffer-cache-based approach. Done right, you can actually do all
> IO in page-sized chunks, BUT fall down on sector-sized things for the
> cases where you want to. 

Right, but you still lose the caching in that case.  The write works,
but the "cache" becomes nothing more than a buffer.

This actually came up recently after the first posting of the
bdev-on-pagecache patches, when somebody was getting lousy
database performance for an application I think they had developed
from scratch --- it was using 512-byte blocks as the basic write
alignment and was relying on the kernel caching that.  In fact, in
that case even our old buffer cache was failing due to the default
blocksize of 1024 bytes, and he had had to add an ioctl to force the
blocksize to 512 bytes before the application would perform at all
well on Linux.

So we do have at least one real-world example which will fail if we
increase the IO granularity.  We may well decide that the pain is
worth it, but the page cache really cannot deal properly with this
right now without having an uptodate labeling at finer granularity
than the page (which would be unnecessary ugliness in most cases).

--Stephen
