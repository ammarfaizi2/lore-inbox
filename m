Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268277AbUH2TRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268277AbUH2TRR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 15:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268279AbUH2TRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 15:17:17 -0400
Received: from holomorphy.com ([207.189.100.168]:41391 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268277AbUH2TRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 15:17:15 -0400
Date: Sun, 29 Aug 2004 12:17:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: rl@hellgate.ch, linux-kernel@vger.kernel.org, albert@users.sourceforge.net
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
Message-ID: <20040829191707.GU5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, rl@hellgate.ch,
	linux-kernel@vger.kernel.org, albert@users.sourceforge.net
References: <20040827122412.GA20052@k3.hellgate.ch> <20040827162308.GP2793@holomorphy.com> <20040828194546.GA25523@k3.hellgate.ch> <20040828195647.GP5492@holomorphy.com> <20040828201435.GB25523@k3.hellgate.ch> <20040829160542.GF5492@holomorphy.com> <20040829170247.GA9841@k3.hellgate.ch> <20040829172022.GL5492@holomorphy.com> <20040829120733.455f0c82.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829120733.455f0c82.pj@sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> get_tgid_list() is a sad story I don't have time to go into in depth.
>> The short version is that larger systems are extremely sensitive to

On Sun, Aug 29, 2004 at 12:07:33PM -0700, Paul Jackson wrote:
> Thanks, Roger and William, for your good work here.  I'm sure that SGI's
> big bertha's will benefit.
> In glancing at the get_tgid_list() I see it is careful to only pick off
> 20 (PROC_MAXPIDS) slots at a time.  But elsewhere in the kernel, I see
> several uses of "do_each_thread()" which rip through the entire task
> list in a single shot.
> Is there a simple explanation for why it is ok in one place to take on
> the entire task list in a single sweep, but in another it is important
> to drop the lock every 20 slots?

PROC_MAXPIDS is the size of the buffer used to temporarily store the
pid's while doing user copies, so that potentially blocking operations
may be done to transmit the pid's to userspace.

Introducing another whole-tasklist scan, even if feasible, is probably
not a good idea.


On Sun, Aug 29, 2004 at 12:07:33PM -0700, Paul Jackson wrote:
> From the code and nice comments, I see that:
>   (1) the work that had to be done by proc_pid_readdir(), the caller of
>       get_tgid_list(), required dropping the task list lock, and
>   (2) so the harvested tgid's had to be stashed in a temp buffer.
> So perhaps the reason for not doing this in a single pass is:
>   (3) it was not doable or not desirable (which one?) to size that temp
>       buffer large enough to hold all the harvested tgid's in one pass.
> But my understanding is losing the scent of the trail at this point.

Using a larger, dynamically-allocated buffer may be better. e.g.
allocating a page to buffer pid's with.

A solution to the problem of the quadratic algorithm I wrote long ago
restructured the tasklist as an rbtree so that the position in the
tasklist could be recovered in O(lg(n)) time. Unfortunately, this
increases the write hold time of tasklist_lock.


-- wli
