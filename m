Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263963AbUD2J06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbUD2J06 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 05:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbUD2J06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 05:26:58 -0400
Received: from gw.exalead.com ([212.234.111.157]:32728 "EHLO exalead.com")
	by vger.kernel.org with ESMTP id S263963AbUD2J0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 05:26:55 -0400
Date: Thu, 29 Apr 2004 11:26:42 +0200
From: Xavier Roche <roche+kml@exalead.com>
To: linux-kernel@vger.kernel.org
Subject: Overstep the kernel 512GB mmap limit ?
Message-ID: <20040429092642.GB6848@exalead.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

There is currently a limit per process in the kernel vm that prevent from mmapp'ing more 
than 512GB of data. This 512G limit - as far as understood - also includes all the code + 
data, the heap (all growing up), and the stack (growing down). There is a possibility to 
tune the barrier between mmap and stack, but ther's always the "512G" limit anyway.
This matter was previously raised by Andrea Arcangeli and Andi Kleen, and it was at this 
epoch not a critical issue - that may be solved later, maybe in the upcoming 2.7.

Here's an ugly ascii map (time to switch to fixed font :) ):

--------------------------------+ 512G (the "512 barrier")
| stack ||                      |
|       ||                      |
|       \/                      |
|                               |
|         /\                    |
|         ||                    |
| mmap's  ||                    |
+-------------------------------+ TASK_UNMAPPED_BASE (1/3 of 512G?)
|                /\             |
|                ||             |
| code/data/heap ||             |
+ ------------------------------+ 1GB
| not mapped (?)                |
+-------------------------------+ 0

Now that 64-bit processing tend to be widely used thanks to cheap processors, mapping areas 
overstepping the classical 32-bit space is common. And if having 512G of ram is not really 
used, mouting few TB of data is now something common (512GB is only a matter of two cheap 
IDE disks mounted in raid).
The problem is that when working with huge filesystems/files mounted in mmap, or huge 
databases, you are limited by this barrier, even with 64-bit archs.
We (Exalead) reached this barrier several times on Linux, when dealing with big "userspace 
filesystem" contents.

According to Andi Kleen, the limit is related to the generic vm kernel code which only 
supports 3 levels of page tables.

Would it be possible to consider (Andrew / Linus ?) the inclusion of a "process can mmap more 512GB of data" 
option [as more than 3 tables can potentially decrease the performances in the vm 
bottleneck] in the kernel ? Andi Kleen told me that he was ok to help in this direction, but 
maintaining such a major / critical patch outside the kernel is not an easy thing to do.


-- 
Regards,
Xavier

