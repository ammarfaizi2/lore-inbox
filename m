Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbWEYPpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbWEYPpH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 11:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWEYPpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 11:45:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3822 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030232AbWEYPpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 11:45:05 -0400
Date: Thu, 25 May 2006 08:44:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn, mstone@mathom.us
Subject: Re: [PATCH 00/33] Adaptive read-ahead V12
Message-Id: <20060525084415.3a23e466.akpm@osdl.org>
In-Reply-To: <348469535.17438@ustc.edu.cn>
References: <348469535.17438@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
> Andrew,
> 
> This is the 12th release of the adaptive readahead patchset.
> 
> It has received tests in a wide range of applications in the past
> six months, and polished up considerably.
> 
> Please consider it for inclusion in -mm tree.
> 
> 
> Performance benefits
> ====================
> 
> Besides file servers and desktops, it is recently found to benefit
> postgresql databases a lot.
> 
> I explained to pgsql users how the patch may help their db performance:
> http://archives.postgresql.org/pgsql-performance/2006-04/msg00491.php
> [QUOTE]
> 	HOW IT WORKS
> 
> 	In adaptive readahead, the context based method may be of particular
> 	interest to postgresql users. It works by peeking into the file cache
> 	and check if there are any history pages present or accessed. In this
> 	way it can detect almost all forms of sequential / semi-sequential read
> 	patterns, e.g.
> 		- parallel / interleaved sequential scans on one file
> 		- sequential reads across file open/close
> 		- mixed sequential / random accesses
> 		- sparse / skimming sequential read
> 
> 	It also have methods to detect some less common cases:
> 		- reading backward
> 		- seeking all over reading N pages
> 
> 	WAYS TO BENEFIT FROM IT
> 
> 	As we know, postgresql relies on the kernel to do proper readahead.
> 	The adaptive readahead might help performance in the following cases:
> 		- concurrent sequential scans
> 		- sequential scan on a fragmented table
> 		  (some DBs suffer from this problem, not sure for pgsql)
> 		- index scan with clustered matches
> 		- index scan on majority rows (in case the planner goes wrong)
> 
> And received positive responses:
> [QUOTE from Michael Stone]
> 	I've got one DB where the VACUUM ANALYZE generally takes 11M-12M ms;
> 	with the patch the job took 1.7M ms. Another VACUUM that normally takes
> 	between 300k-500k ms took 150k. Definately a promising addition.
> 
> [QUOTE from Michael Stone]
> 	>I'm thinking about it, we're already using a fixed read-ahead of 16MB
> 	>using blockdev on the stock Redhat 2.6.9 kernel, it would be nice to
> 	>not have to set this so we may try it.
> 
> 	FWIW, I never saw much performance difference from doing that. Wu's
> 	patch, OTOH, gave a big boost.
> 
> [QUOTE: odbc-bench with Postgresql 7.4.11 on dual Opteron]
> 	Base kernel:
> 	 Transactions per second:                92.384758
> 	 Transactions per second:                99.800896
> 
> 	After read-ahvm.readahead_ratio = 100:
> 	 Transactions per second:                105.461952
> 	 Transactions per second:                105.458664
> 
> 	vm.readahead_ratio = 100 ; vm.readahead_hit_rate = 1:
> 	 Transactions per second:                113.055367
> 	 Transactions per second:                124.815910

These are nice-looking numbers, but one wonders.  If optimising readahead
makes this much difference to postgresql performance then postgresql should
be doing the readahead itself, rather than relying upon the kernel's
ability to guess what the application will be doing in the future.  Because
surely the database can do a better job of that than the kernel.

That would involve using posix_fadvise(POSIX_FADV_RANDOM) to disable kernel
readahead and then using posix_fadvise(POSIX_FADV_WILLNEED) to launch
application-level readahead.

Has this been considered or attempted?
