Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965565AbWKDRgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965565AbWKDRgt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 12:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965568AbWKDRgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 12:36:49 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:34441 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S965565AbWKDRgs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 12:36:48 -0500
Date: Sat, 4 Nov 2006 23:07:16 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: New filesystem for Linux
Message-ID: <20061104173716.GA618@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 10:52:47PM +0100, Mikulas Patocka wrote:
> Hi

Hi Mikulas
> 
> As my PhD thesis, I am designing and writing a filesystem, and it's now in 
> a state that it can be released. You can download it from 
> http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/
> 
> It has some new features, such as keeping inode information directly in 
> directory (until you create hardlink) so that ls -la doesn't seek much, 
> new method to keep data consistent in case of crashes (instead of 
> journaling), free space is organized in lists of free runs and converted 
> to bitmap only in case of extreme fragmentation.
> 
> It is not very widely tested, so if you want, test it.
> 
> I have these questions:
> 
> * There is a rw semaphore that is locked for read for nearly all 
> operations and locked for write only rarely. However locking for read 
> causes cache line pingpong on SMP systems. Do you have an idea how to make 
> it better?
> 
> It could be improved by making a semaphore for each CPU and locking for 
> read only the CPU's semaphore and for write all semaphores. Or is there a 
> better method?

I am currently experimenting with a light-weight reader writer semaphore 
with an objective to do away what you call a reader side cache line
"ping pong". It achieves this by using a per-cpu refcount.

A drawback of this approach, as Eric Dumazet mentioned elsewhere in this
thread, would be that each instance of the rw_semaphore would require
(NR_CPUS * size_of(int)) bytes worth of memory in order to keep track of
the per-cpu refcount, which can prove to be pretty costly if this
rw_semaphore is for something like inode->i_alloc_sem.

So the question I am interested in is, how many *live* instances of this
rw_semaphore are you expecting to have at any given time?
If this number is a constant (and/or not very big!), the light-weight
reader writer semaphore might be useful.

Regards
Gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
