Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161398AbWI2SmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161398AbWI2SmA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 14:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161400AbWI2SmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 14:42:00 -0400
Received: from rs384.securehostserver.com ([72.22.69.69]:40722 "HELO
	rs384.securehostserver.com") by vger.kernel.org with SMTP
	id S1161398AbWI2Sl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 14:41:59 -0400
Subject: [RFC][PATCH 0/2] Swap token re-tuned
From: Ashwin Chaugule <ashwin.chaugule@celunite.com>
Reply-To: ashwin.chaugule@celunite.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 30 Sep 2006 00:11:51 +0530
Message-Id: <1159555312.2141.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 
Here's a brief up on the next two mails. 

PATCH 1: 

In the current implementation of swap token tuning, grab swap token is
made from : 
1) after page_cache_read (filemap.c) and 
2) after the readahead logic in do_swap_page (memory.c) 

IMO, the contention for the swap token should happen _before_ the
aforementioned calls, because in the event of low system memory, calls
to freeup space will be made later from page_cache_read and
read_swap_cache_async , so we want to avoid "false LRU" pages by
grabbing the token before the VM starts searching for replacement
candidates. 

PATCH 2: 

Instead of using TIMEOUT as a parameter to transfer the token, I think a
better solution is to hand it over to a process that proves its
eligibilty. 

What my scheme does, is to find out how frequently a process is calling
these functions. The processes that call these more frequently get a
higher priority. 
The idea is to guarantee that a high priority process gets the token.
The priority of a process is determined by the number of consecutive
calls to swap-in and no-page. I mean "consecutive" not from the
scheduler point of view, but from the process point of view. In other
words, if the task called these functions every time it was scheduled,
it means it is not getting any further with its execution. 

This way, its a matter of simple comparison of task priorities, to
decide whether to transfer the token or not. 

I did some testing with the two patches combined and the results are as
follows: 

Current Upstream implementation: 
=============================== 

root@ashbert:~/crap# time ./qsbench -n 9000000 -p 3 -s 1420300 
seed = 1420300 
seed = 1420300 
seed = 1420300 

real    3m40.124s 
user    0m12.060s 
sys     0m0.940s 


-------------reboot----------------- 

With my implementation : 
======================== 

root@ashbert:~/crap# time ./qsbench -n 9000000 -p 3 -s 1420300 
seed = 1420300 
seed = 1420300 
seed = 1420300 

real    2m58.708s 
user    0m11.880s 
sys     0m1.070s 



My test machine: 

1.69Ghz CPU 
64M RAM 
7200rpm hdd 
2MB L2 cache 
vanilla kernel 2.6.18 
Ubuntu dapper with gnome. 


Any comments, suggestions, ideas ? 

Cheers, 
Ashwin 








