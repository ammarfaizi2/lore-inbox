Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbTH0Lfs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 07:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263288AbTH0Lfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 07:35:47 -0400
Received: from holomorphy.com ([66.224.33.161]:54710 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263379AbTH0Lfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 07:35:37 -0400
Date: Wed, 27 Aug 2003 04:36:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: cache limit
Message-ID: <20030827113646.GC4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Takao Indoh <indou.takao@soft.fujitsu.com>,
	Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
References: <20030827094512.GZ1715@holomorphy.com> <1AC36C8C57E018indou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1AC36C8C57E018indou.takao@soft.fujitsu.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003 02:45:12 -0700, William Lee Irwin III wrote:
>> How do you know it would be effective? Have you written a patch to
>> limit it in some way and tried running it?

On Wed, Aug 27, 2003 at 08:14:12PM +0900, Takao Indoh wrote:
> It's just my guess. You mean that "index cache" is on the pagecache?
> "index cache" is allocated in the user space by malloc,
> so I think it is not on the pagecache.

That will be in the pagecache.


On Wed, 27 Aug 2003 02:45:12 -0700, William Lee Irwin III wrote:
>> How do you know most of it is unmapped?

On Wed, Aug 27, 2003 at 08:14:12PM +0900, Takao Indoh wrote:
> I checked /proc/meminfo.
> For example, this is my /proc/meminfo(kernel 2.5.73)
[...]
> Buffers:         18520 kB
> Cached:         732360 kB
> SwapCached:          0 kB
> Active:         623068 kB
> Inactive:       179552 kB
[...]
> Dirty:           33204 kB
> Writeback:           0 kB
> Mapped:          73360 kB
> Slab:            32468 kB
> Committed_AS:   167396 kB
[...]
> According to this information, I thought that
> all pagecache was 732360 kB and all mapped page was 73360 kB, so
> almost of pagecache was not mapped...
> Do I misread meminfo?

No. Most of your pagecache is unmapped pagecache. This would correspond
to memory that caches files which are not being mmapped by any process.
This could result from either the page replacement policy favoring
filesystem cache too heavily or from lots of io causing the filesystem
cache to be too bloated and so defeating the swapper's heuristics (you
can do this by generating large amounts of read() traffic).

Limiting unmapped pagecache would resolve your issue. Whether it's the
right thing to do is still open to question without some knowledge of
application behavior (for instance, teaching userspace to do fadvise()
may be right thing to do as opposed to the /proc/ tunable).

Can you gather traces of system calls being made by the applications?


-- wli
