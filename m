Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278215AbRJWUVM>; Tue, 23 Oct 2001 16:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278200AbRJWUVC>; Tue, 23 Oct 2001 16:21:02 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:52467 "EHLO
	e34.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S278222AbRJWUUt>; Tue, 23 Oct 2001 16:20:49 -0400
Date: Tue, 23 Oct 2001 15:19:45 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Issue with max_threads (and other resources) and highmem
Message-ID: <72940000.1003868385@baldur>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I recently had pointed out to me that the default value for max_threads (ie
the max number of tasks per system) doesn't work right on machines with
lots of memory.

A quick examination of fork_init() shows that max_threads is supposed to be
limited so its stack/task_struct takes no more than half of physical
memory.  This calculation ignores the fact that task_structs must be
allocated from the normal pool and not the highmem pool, which is a clear
bug.  On a machine with enough physical memory it's possible for all of
normal memory to be allocated to task_structs, which tends to make the
machine die.  

fork_init() gets its knowledge of physical memory passed in from
start_kernel(), which sets it from mum_physpages.  This parameter is also
passed to several other init functions.

My question boils down to this...  Should we change start_kernel() to limit
the physical memory size it passes to the init functions to not include
high memory, or should we only do it for fork_init()?  What is the best way
to do calculate this number?  I don't see any simple way in
architecture-independent code to get the size of high memory vs normal
memory.

What's the best approach here?

Thanks,
Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

