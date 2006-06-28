Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWF1ScY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWF1ScY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWF1ScY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:32:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8084 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750876AbWF1ScX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:32:23 -0400
Date: Wed, 28 Jun 2006 20:33:21 +0200
From: Jan Kara <jack@suse.cz>
To: Marcin Glogowski <marcin.glogowski@interia.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about buffer.c
Message-ID: <20060628183321.GJ27621@atrey.karlin.mff.cuni.cz>
References: <20060628112828.fbcc4a86.marcin.glogowski@interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628112828.fbcc4a86.marcin.glogowski@interia.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  please try to post mails with lines shorter than 75 characters. It
easier to read them... Now to your problem:

> I have big problem with my filesystem based on squash (also ROM)
> compressed filesystem.  My problem is when I'm copying something from
> mounted loop device the buffer cache memory is growing up - I want to
> disable block caching because Linux is killing processess because of
> the buffered inodes.
  This is stange. Linux frees the buffers automatically under memory
pressure (and you seem to really get under pressure when kernel starts
killing processes) unless they are pinned in memory - e.g. someone holds
a reference to them. 

> Please tell me how to remove free list or touched buffer heads, or how
> to set the minimum cache size.  I tried to delete the bh with the
> brelse(bh); function but the /proc/memory shows that the buffer head
> wasn't released.  Is there an alternative for the getblk or
> ll_rw_block functions that don't use cache memory?
  You have to always have a buffer on which ll_rw_block/getblk works.
However nothing prevents you from creating your private buffer head and
freeing it when you are done with everything. But you really should not
need it. There is a bug somewhere else which prevents kernel from really
freeing those buffers.
  Note that buffers are used just to make access to data in pagecache
easier (and doing IO with them) - each buffer is bound to some page in
pagecache (either a device cache or mapping of data of an inode). So
maybe you are doing something bad so that those pages cannot be freed...

								Honza
