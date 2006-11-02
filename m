Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752650AbWKBVwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbWKBVwt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752685AbWKBVwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:52:49 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:3970 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1752650AbWKBVws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:52:48 -0500
Date: Thu, 2 Nov 2006 22:52:47 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: New filesystem for Linux
Message-ID: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

As my PhD thesis, I am designing and writing a filesystem, and it's now in 
a state that it can be released. You can download it from 
http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/

It has some new features, such as keeping inode information directly in 
directory (until you create hardlink) so that ls -la doesn't seek much, 
new method to keep data consistent in case of crashes (instead of 
journaling), free space is organized in lists of free runs and converted 
to bitmap only in case of extreme fragmentation.

It is not very widely tested, so if you want, test it.

I have these questions:

* There is a rw semaphore that is locked for read for nearly all 
operations and locked for write only rarely. However locking for read 
causes cache line pingpong on SMP systems. Do you have an idea how to make 
it better?

It could be improved by making a semaphore for each CPU and locking for 
read only the CPU's semaphore and for write all semaphores. Or is there a 
better method?

* This leads to another observation --- on i386 locking a semaphore is 2 
instructions, on x86_64 it is a call to two nested functions. Has it some 
reason or was it just implementator's laziness? Given the fact that locked 
instruction takes 16 ticks on Opteron (and can overlap about 2 ticks with 
other instructions), it would make sense to have optimized semaphores too.

* How to implement ordered-data consistency? That would mean that on 
internal sync event, I'd have to flush all pages of a files that were 
extended. I could scan all dirty inodes and find pages to flush --- what 
kernel function would you recommend for doing it? Currently I call only 
sync_blockdev which doesn't touch buffers attached to pages.

Mikulas
