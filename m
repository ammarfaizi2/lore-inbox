Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbULIXak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbULIXak (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 18:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbULIXak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 18:30:40 -0500
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:60331 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261689AbULIXaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 18:30:23 -0500
Date: Thu, 9 Dec 2004 23:30:19 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: kernel-stuff@comcast.net
cc: Imanpreet Singh Arora <imanpreet@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question from Russells Spinlocks 
In-Reply-To: <120920042115.25628.41B8C082000394E30000641C220076219400009A9B9CD3040A029D0A05@comcast.net>
Message-ID: <Pine.LNX.4.60.0412092326260.2294@hermes-1.csi.cam.ac.uk>
References: <120920042115.25628.41B8C082000394E30000641C220076219400009A9B9CD3040A029D0A05@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2004 kernel-stuff@comcast.net wrote:
> Spinlocks are used in situations where multiple threads contend for a 
> lock and they can possibly run on more than one CPU. Example - Thread A 
> is executing on CPU-A, Thread B in executing on CPU-B. They contend for 
> a lock L1.  A acquires the lock first. B tries (on CPU-B) to acquire the 
> lock L1 and finds it is not free - so it just spins (executes a no-op 
> kind of loop ) until Thread A relinquishes the lock L1. Spinlocks are 
> used in cases where the operation performed under a lock is short one - 
> takes very less time. In these type of cases, spinning is less costlier 
> than sleeping which involves scheduler overhead. So if we take out CPU-B 
> from the above equation - there is no chance for Thread B to execute to 
> contend for lock L1 without thread A going to sleep. That's why 
> spinlocks are useless on 1 CPU machine.

Your last sentence is incorrect.  Spinlocks on 1 CPU machines still need 
to disable preemption (assuming preemption is compiled in obviously, if 
not then indeed you are right).  Otherwise preemption could take place in 
the middle of a data manipulation and you would still have the same race 
as you described with two cpus working concurrently.  Except that with 
preemption it is only logical concurrence not actual physical concurrence.

Best regards,

	Anton

>  The comment about atomic_t - It is due to the fact that some ( IA-32 
> for e.g.) architectures guarantees atomicity of integer operations for 
> only 24 bits. So you could possibly manipulate only 24 out of the 32 
> bits atomically - that's the hardware guarantee. The comments reflect 
> this fact. (Pointers are 32bits on IA32 so it applies to pointer as 
> well.)
> 
> Correct me if I am wrong :) !
> 
> Parag
> 
> 
> > 
> > Hello there,
> > 
> >     I was reading Russell's guide on spinlocks, and I have some 
> > questions regarding it.
> > 
> > 
> >     Question-->    Russell says that in case of non-SMP machines 
> > spinlocks don't exist _at_ALL_. Well they should do something don't they 
> > like disable interrupts and premptations. I checked linux/spinlock well 
> > they DO NOT do anything atleast not when DEBUG_SPINLOCKS == 0. My 
> > understanding is that since they aren't used anywhere outside kernel and 
> > drivers(?), they can't be prempted. At least that is what I have read.
> > 
> > 
> > What does the comment about gcc while defining atomic_t signify?
> >              --> What about the comment about the limit of 24 bits on 
> > atomic_t?    
> >              a)    Atomic operations on integers are guranteed only if 
> > there value can be stored in 24 bits.
> >              b)    Atomic operations are guranteed only if the pointer 
> > has 8 MSbits set zero.

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
