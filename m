Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWJAW4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWJAW4c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 18:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWJAW4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 18:56:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60890 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932454AbWJAW4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 18:56:31 -0400
Date: Sun, 1 Oct 2006 15:56:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: ashwin.chaugule@celunite.com
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [RFC][PATCH 0/2] Swap token re-tuned
Message-Id: <20061001155608.0a464d4c.akpm@osdl.org>
In-Reply-To: <1159555312.2141.13.camel@localhost.localdomain>
References: <1159555312.2141.13.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2006 00:11:51 +0530
Ashwin Chaugule <ashwin.chaugule@celunite.com> wrote:

> 
> Hi, 
> Here's a brief up on the next two mails. 

When preparing patches, please give each one's email a different and
meaningful Subject:, and try to put the description of the patch within the
email which  contains that patch, thanks.

> PATCH 1: 
> 
> In the current implementation of swap token tuning, grab swap token is
> made from : 
> 1) after page_cache_read (filemap.c) and 
> 2) after the readahead logic in do_swap_page (memory.c) 
> 
> IMO, the contention for the swap token should happen _before_ the
> aforementioned calls, because in the event of low system memory, calls
> to freeup space will be made later from page_cache_read and
> read_swap_cache_async , so we want to avoid "false LRU" pages by
> grabbing the token before the VM starts searching for replacement
> candidates. 

Seems sane.

> PATCH 2: 
> 
> Instead of using TIMEOUT as a parameter to transfer the token, I think a
> better solution is to hand it over to a process that proves its
> eligibilty. 
> 
> What my scheme does, is to find out how frequently a process is calling
> these functions. The processes that call these more frequently get a
> higher priority. 
> The idea is to guarantee that a high priority process gets the token.
> The priority of a process is determined by the number of consecutive
> calls to swap-in and no-page. I mean "consecutive" not from the
> scheduler point of view, but from the process point of view. In other
> words, if the task called these functions every time it was scheduled,
> it means it is not getting any further with its execution. 
> 
> This way, its a matter of simple comparison of task priorities, to
> decide whether to transfer the token or not. 

Does this introduce the possibility of starvation?  Where the
fast-allocating process hogs the system and everything else makes no
progress?


> I did some testing with the two patches combined and the results are as
> follows: 
> 
> Current Upstream implementation: 
> =============================== 
> 
> root@ashbert:~/crap# time ./qsbench -n 9000000 -p 3 -s 1420300 
> seed = 1420300 
> seed = 1420300 
> seed = 1420300 
> 
> real    3m40.124s 
> user    0m12.060s 
> sys     0m0.940s 
> 
> 
> -------------reboot----------------- 
> 
> With my implementation : 
> ======================== 
> 
> root@ashbert:~/crap# time ./qsbench -n 9000000 -p 3 -s 1420300 
> seed = 1420300 
> seed = 1420300 
> seed = 1420300 
> 
> real    2m58.708s 
> user    0m11.880s 
> sys     0m1.070s 
> 

qsbench gives quite unstable results in my experience.  How stable is the
above result (say, average across ten runs?)

It's quite easy to make changes in this area which speed qsbench up with
one set of arguments, and which slow it down with a different set.  Did you
try mixing the tests up a bit?

Also, qsbench isn't really a very good test for swap-intensive workloads -
it's re-referencing and locality patterns seem fairly artificial.

Another workload which it would be useful to benchmark is a kernel compile
- say, boot with `mem=16M' and time `make -j4 vmlinux' (numbers may need
tuning).

