Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271432AbRHZTDf>; Sun, 26 Aug 2001 15:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271466AbRHZTDZ>; Sun, 26 Aug 2001 15:03:25 -0400
Received: from hq2.fsmlabs.com ([209.155.42.199]:6419 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S271432AbRHZTDM>;
	Sun, 26 Aug 2001 15:03:12 -0400
Date: Sun, 26 Aug 2001 12:59:11 -0600
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <20010826125911.A20805@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010826164818Z16191-32383+1474@humbolt.nl.linux.org>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2001 at 06:54:55PM +0200, Daniel Phillips wrote:
> But it's a very interesting idea: instead of performing readahead in 
> generic_file_read the user thread would calculate the readahead window
> information and pass it off to a kernel thread dedicated to readahead.
> This thread can make an informed, global decision on how much IO to
> submit.  The user thread benefits by avoiding some stalls due to
> readahead->readpage, as well as avoiding thrashing due to excessive
> readahead.

And scheduling gets even more complex as we try to account for work done
in this thread on behalf of other processes. And, of course, we have
all sorts of wacky merge problems
	Process		Kthread
	----------------------------
	read block 1
			schedules to read block 2 readahead
	read block 2 
	not in cache so
	send to ll_rw
	get it.
	exit
			getting through the backlog, don't see block 2 anywhere
			so do the readahead not knowing that it's already been
			read, used, and discarded
	
Sound like it could keep you busy for a while.


BTW: maybe I'm oversimplifying, but since read-ahead is an optimization
trading memory space for time, why doesn't it just turn off when there's
a shortage of free memory?
		num_pages = (num_requestd_pages +  (there_is_a_boatload_of_free_space? readahead: 0)

