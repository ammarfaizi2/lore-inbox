Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbSLFONA>; Fri, 6 Dec 2002 09:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262828AbSLFONA>; Fri, 6 Dec 2002 09:13:00 -0500
Received: from holomorphy.com ([66.224.33.161]:16271 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262580AbSLFOM6>;
	Fri, 6 Dec 2002 09:12:58 -0500
Date: Fri, 6 Dec 2002 06:20:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.50-bk5-wli-1
Message-ID: <20021206142024.GP9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20021206080009.GB11023@holomorphy.com> <3DF05EA7.4BDCBFF0@digeo.com> <20021206085252.GO9882@holomorphy.com> <3DF06AB8.C31E6EFF@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF06AB8.C31E6EFF@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> This is actually the result of quite a bit of handwaving; in the OOM-
>> handling series of patches with the GFP_NOKILL business, I found that
>> tasks would block exessively in wait_on_inode() (which was tiobench
>> 16384).

On Fri, Dec 06, 2002 at 01:15:36AM -0800, Andrew Morton wrote:
> Yup.  I haven't really considered or tested any other strategies
> here, but it's part of writer throttling.  If we let these processes
> skip an inode which is already under writeback and go on to the next
> one there is a risk that we end up submitting IO all over the disk.
> Or not.  I have not tried it.

Part of the flavor of the experimentation was to stop throttling things
to death and back again and then to death again and then some, so I
wasn't terribly concerned about performance per-se.


On Fri, Dec 06, 2002 at 01:15:36AM -0800, Andrew Morton wrote:
> All those threads would end up throttling in get_request_wait() instead.
> Which is a single waitqueue.  But it is wake-one.

Well, not entirely, tiobench can only handle 256 or 512 threads in a
since invocation so a number of them were run in parallel, spread
across a bunch of disks and directories.


William Lee Irwin III wrote:
>> The entire summary of results
>> of that series of patches was "highmem drops dead under load".

On Fri, Dec 06, 2002 at 01:15:36AM -0800, Andrew Morton wrote:
> There really is no shame in sending out bugreports, you know.

Ah, but there is! I'm supposed to fix it myself. =)

At any rate, there were more problems floating around beneath it, like
various odd things using contig_page_data (I think buffer.c got fixed)
and OOM handling and data structure proliferation issues arising from
temporary allocations (e.g. poll wait tables, pathname buffers) held
over processes sleeping.


William Lee Irwin III wrote:
>> But performance benefits from this minor increase in size should be obvious.

On Fri, Dec 06, 2002 at 01:15:36AM -0800, Andrew Morton wrote:
> But they're all waiting on the same inode ;)

Well, see the above. It actually did make a difference; I was able to
get a good deal of blockage out by just jacking up the wait table and
request queue size.


Bill
