Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129079AbQJ0GYq>; Fri, 27 Oct 2000 02:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129094AbQJ0GYf>; Fri, 27 Oct 2000 02:24:35 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:20984 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S129079AbQJ0GYU>; Fri, 27 Oct 2000 02:24:20 -0400
From: kumon@flab.fujitsu.co.jp
Date: Fri, 27 Oct 2000 15:24:07 +0900
Message-Id: <200010270624.PAA22920@asami.proc.flab.fujitsu.co.jp>
To: kumon@flab.fujitsu.co.jp
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Negative scalability by removal of lock_kernel()?
	(Was: Strange performance behavior of 2.4.0-test9)
In-Reply-To: <200010261405.XAA19135@asami.proc.flab.fujitsu.co.jp>
In-Reply-To: <200010250736.QAA12373@asami.proc.flab.fujitsu.co.jp>
	<Pine.LNX.4.21.0010251242050.943-100000@duckman.distro.conectiva>
	<200010260138.KAA17028@asami.proc.flab.fujitsu.co.jp>
	<200010261405.XAA19135@asami.proc.flab.fujitsu.co.jp>
Reply-To: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finally, I found:
Removal of lock_kernel in fs/fcntl.c causes the strange performance of
2.4.0-test9.


The removal causes following negative scalability on Apache-1.3.9:
	* 8-way performance dropped to 60% of 4-way performance.
	* Adding lock_kernel() gains 2.4x performance on 8-way.

This suggests some design malfunction exist in the fs-code.

The lock_kernel() is removed in test9, as shown in below, then the
strange behavior appeared.

linux-2.4.0-test8/fs/fcntl.c:
asmlinkage long sys_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg)
{	
	struct file * filp;
	long err = -EBADF;

	filp = fget(fd);
	if (!filp)
		goto out;

-->	lock_kernel();
	err = do_fcntl(fd, cmd, arg, filp);
-->	unlock_kernel();

 	fput(filp);
out:
	return err;
}

Adding the lock_kernel()/unlock_kernel() to test9:fs/fcntl.c,
	The performance is restored,
	The number of task switch is reduced, and
	Positive scalability is observed.

The lock region may be narrowed to around call of posix_lock_file()
in fcntl_setlk() (fs/locks.c).

I usually prefer removal of kernel_lock, but at this time,
the removal severy struck the performance.

Please give me suggestions..


kumon@flab.fujitsu.co.jp writes:
 > kumon@flab.fujitsu.co.jp writes:
 >  > Rik van Riel writes:
 >  >  > On Wed, 25 Oct 2000 kumon@flab.fujitsu.co.jp wrote:
 >  >  > > I found very odd performance behavior of 2.4.0-test9 on a large SMP
 >  >  > > server, and I want some clues to investigate it.
 >  >  > > 
 >  >  > > 1) At the 8 cpu configuration, test9 shows extremely inferior
 >  >  > >    performance.
 >  >  > > 2) on test8, 8-cpu configuration shows about 2/3 performance of 4-cpu.
 >  >  >         ^^^^^ test9 ??
 > 
 > IMHO, the modification of file-system code causes the weird
 > performance.
 > 
 > Most of processes are slept at:
 > 	posix_lock_file()->locks_block_on()->interruptible_sleep_on_locks()
 > 
 > We revert two of test9 files (fs/fcntl.c fs/flock.c), to the previous
 > version, the performance problem disappeared and it becomes to the
 > same level as test8.
 > 
 > To narrow the problem, we measured performance of 3 configuration:
 > 1) test9 with test8 fs/fcntl.c, test8 fs/flock.c
 > 2) test9 with test8 fs/fcntl.c
 > 3) test9 with test8 fs/flock.c
 > 
 > Only 3) shows the problem, so the main problem reside in fcntl.c (not
 > in flock.c).
 > 
 > So it seems:
 > the web-server, apache-1.3.9 in the redhat-6.1, issues lots of fcntl
 > to the file and those fcntls collide each other, and the processes
 > are blocked.
 > 
 > 
 > What has happend to fcntl.c?
 > 
 > --
 > Computer Systems Laboratory, Fujitsu Labs.
 > kumon@flab.fujitsu.co.jp
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
