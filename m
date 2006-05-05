Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWEEOyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWEEOyl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 10:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWEEOyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 10:54:41 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51029 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751130AbWEEOyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 10:54:41 -0400
Date: Fri, 5 May 2006 16:54:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Constantine Sapuntzakis <csapuntz@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loop.c: respect bio barrier and sync
Message-ID: <20060505145437.GW4324@suse.de>
References: <ea59786f0605041919w337c7164id5f4e7b3efa818e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea59786f0605041919w337c7164id5f4e7b3efa818e0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04 2006, Constantine Sapuntzakis wrote:
> I believe that the loop block device does not currently respect
> barriers or syncs issued by its clients. As a result, I have seen
> corrupted log errors when a loopback mounted ext3 file system is
> remounted after a hard stop.
> 
> The attached patch attempts to fix this problem by respecting the
> barrier and sync flags on the I/O request. The sync_file function was
> cut-and-paste from the implementation of fsync (I think there's no fd
> so I can't call fsync) to allow the patch to be deployed as an updated
> module. Is there another function that could be used?
> 
> Comments are welcome. I am not on the list so please cc: me on any 
> response..

Please inline your patches, so one can actually comment on them...

- You should handle sync_file() failure. If we don't have !f_op (will
  that ever hit, btw?) or ->fsync(), then fail the barrier with
  -EOPNOTSUPP. For fsync failure, well... You probably want to just
  error the bio with -EIO then.

- bio_sync() doesn't have the semantics you define it to, it is a hint
  to the block layer to start request processing instead of plugging. So
  don't treat it as a barrier, ignore it.

- Does this work for all loop_device types?

-- 
Jens Axboe

