Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbULOFpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbULOFpz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 00:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbULOFpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 00:45:55 -0500
Received: from almesberger.net ([63.105.73.238]:27398 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261897AbULOFpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 00:45:46 -0500
Date: Wed, 15 Dec 2004 02:45:12 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Hans Reiser <reiser@namesys.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       abiss-general@lists.sourceforge.net
Subject: Re: filesystem/kernel programmer needed for reiser4/low latency work [...]
Message-ID: <20041215024512.B4527@almesberger.net>
References: <41AE06BF.3030700@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41AE06BF.3030700@namesys.com>; from reiser@namesys.com on Wed, Dec 01, 2004 at 10:00:31AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> I have a US customer who needs work done that involves figuring out why 
> the kernel/filesystem/hard drive adds pauses that cause video glitches.  

Welcome to the club :-) We're working on fairly similar issues
in the ABISS project, http://abiss.sourceforge.net/

> This is much deeper and harder than you would guess, and involves 
> elevator work, filesystem work, vm work, working hand-in-hand with disk 
> drive vendors to do things I can't talk about here yet, etc.  There may 
> be work involving block allocators optimized for streaming media, 
> resizer work, repacker work, etc.

I can guess :-) Your shopping list looks similar to ours.

I think we've pretty much covered the elevator side. Our proof of
concept elevator does priorities and a number of related things.
This is synchronized with Jens' work, so these features should
eventually show up in CFQ and the block IO layer. (At which point
the ABISS elevator shall be unceremoniously scrapped.)

VM work is lined up next. So far, the most promising approach for
getting rid of VM interference seems to be to base things on the
NUMA infrastructure.

We currently support "real-time" reading from FAT, VFAT, ext2, and
ext3. There are also some scary things we can do for writing, such
as messing with the block allocation strategy (*). The latter are
currently only for FAT and VFAT.

(*) Doing file system brain surgery at this level may be a dead
    end. Just getting the various file systems to support
    reservations or an equivalent way for obtaining large
    contiguous allocations looks like a much nicer approach.

As far as doing unspeakable things with drive manufacturers is
concerned, control over defect management and thermal calibration
come to mind. Zoning and noise management details may also be of
interest.

I'm not sure how deep you really want to go there. I'd expect that
by selecting reasonably well-behaved drives and just measuring
what they do, a useful performance envelope could be determined,
that will allow you to provide adequate buffering and/or
prefetching to cover the occasional drive hickup.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
