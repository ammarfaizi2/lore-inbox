Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267618AbUHRU13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267618AbUHRU13 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 16:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267612AbUHRU13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 16:27:29 -0400
Received: from holomorphy.com ([207.189.100.168]:3257 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267618AbUHRU10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 16:27:26 -0400
Date: Wed, 18 Aug 2004 13:27:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Mark Hounschell <markh@compro.net>
Cc: Brian McGrew <Brian@doubledimension.com>, linux-kernel@vger.kernel.org
Subject: Re: Help with mapping memory into kernel space?
Message-ID: <20040818202722.GD11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mark Hounschell <markh@compro.net>,
	Brian McGrew <Brian@doubledimension.com>,
	linux-kernel@vger.kernel.org
References: <E6456D527ABC5B4DBD1119A9FB461E3501E00B@constellation.doubledimension.com> <20040818073141.GV11200@holomorphy.com> <41233AA3.47834A14@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41233AA3.47834A14@compro.net>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> You appear to be trying to ioremap() vast areas. ia32 has limited
>> address space, so you need to do one of two things:
>> (a) subdivide into portions mapped into different address spaces
>> (b) map portions on demand
>> There is no support for (a) in Linux.

On Wed, Aug 18, 2004 at 07:16:51AM -0400, Mark Hounschell wrote:
> You might try the bigphysarea patch. We have basically the same problem
> with hardware not capabile of hardware scatter/gather in DMA mode.
> Bigphysarea was our solution. It does not appear to be available for the
> 2.6 kernel however

It will not help him. He is trying to ioremap device memory AIUI, not
obtain physically contiguous memory. One "trick" here is to cache the
mappings and batch unmappings. So a cache of, say, 1024 64KB ioremap()
windows is maintained. Some data structure is used to LRU and track the
windows, a cache hit moves the window to the back of the LRU, a cache
miss with an empty freelist triggers unmapping of the window at the
front of the LRU, misses with nonempty freelists ioremap() afresh, etc.
In order for these to be accessible in interrupt context you will need
to either punt the work to be done in interrupts to process context
with schedule_work() and/or workqueue things, or to pin the window
while an interrupt-generating event may be pending and unpin it after
one knows no interrupt-generating event may be pending.

Alternatively, as a poor man's substitute for a u area, one may try to
shove the mapping into userspace, so mmap() (maybe with privileges only
suitable for the kernel) is done in a user process' address space at
the time of driver ->open() or ->mmap() or some such. When the user
process calls the driver the window established this way in the user
address space may be used instead of the extremely limited vmallocspace.
This kind of scheme may require interrupt-safe windowing into device
memory for interrupt processing, in which case some (hopefully small)
window not associated with any process must still be used, so it may
be simpler to just maintain a cache of windows.


-- wli
