Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268327AbUIPXcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268327AbUIPXcx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268404AbUIPX04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:26:56 -0400
Received: from peabody.ximian.com ([130.57.169.10]:27854 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268357AbUIPXYE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:24:04 -0400
Subject: Re: [RFC][PATCH] inotify 0.9
From: Robert Love <rml@novell.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1040916182127.20906B-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1040916182127.20906B-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Date: Thu, 16 Sep 2004 19:22:58 -0400
Message-Id: <1095376979.23385.176.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-16 at 18:34 -0400, Bill Davidsen wrote:

> >   Maybe you should not be so fast in using your flamethrower;)
> 
> I didn't intend this as a flame, but I do feel this implementation doesn't
> scale. I offered another approach off the top of my head, which appears to
> me to be more scalable. I claimed no expertise, I just made a suggestion,
> based on my first thought on how I would attack the problem in a way which
> appears more scalable.

The thing you are missing is that you absolutely have to pin something
or you have multiple VFS races.  Your bitmap suggestion, while cute,
really shows a lack of understanding of the problem space.

dnotify had to do it, inotify has to do it.

Do you want to go down the lets-find-a-race path with Al Viro? ;-)

> If we are going to 4k stack because larger memory blocks are hard to find,
> I have to suspect that anything which locks up blocks size in MB is going
> to cause problems. I didn't even ask what would happen on NUMA machines,
> because that's not my usual concern.

It is not the total size that is the concern, but the per-allocation
size, which has to be contiguous.  A first order allocation is hard to
do.  You can only find two contiguous free pages in physical memory so
often.

Inodes come from the slabcache.  NONE of this is an issue there.

Plus, as I have said, the slabcache is probably caching much of what you
are pinning.  So memory consumption is not changed.  Finally, these
numbers are WORST case.  Watch only a handful of files and you have a
handful of hundreds of bytes pinned.

	Robert Love


