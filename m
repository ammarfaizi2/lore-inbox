Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWDMEq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWDMEq0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 00:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWDMEq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 00:46:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29877 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964781AbWDMEqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 00:46:25 -0400
Date: Wed, 12 Apr 2006 21:46:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dan Bonachea <bonachead@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
Message-Id: <20060412214613.404cf49f.akpm@osdl.org>
In-Reply-To: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu>
References: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Bonachea <bonachead@comcast.net> wrote:
>
> Hi - I believe I've discovered a thread-safety bug in the Linux 2.6.x kernel 
>  implementation of write(2).
> 
>  The small C program below the problem - in a nutshell, if multiple threads 
>  write() to STDOUT_FILENO, and stdout has been redirected to a file, then some 
>  of the output lines get lost. The actual result is non-deterministic (even in 
>  a "correct" run) - however the expected correct behavior is 10 lines of output 
>  (in some non-deterministic order). However, the test program reproducibly 
>  generates some lost output (less than 10 lines of total output) on every run 
>  where the output is redirected to a new file. This appears to be a violation 
>  of the POSIX spec (POSIX 1003.1-2001:2.9.1 requires thread-safety of write()). 
> 
> 
>  The problem does not appear to occur if output goes to the console, or is 
>  redirected to append to an existing file, only when stdout is redirected to a 
>  new file.

This comes up occasionally.  Is very simple:

asmlinkage ssize_t sys_write(unsigned int fd, const char __user * buf, size_t count)
{
	struct file *file;
	ssize_t ret = -EBADF;
	int fput_needed;

	file = fget_light(fd, &fput_needed);
	if (file) {
		loff_t pos = file_pos_read(file);
		ret = vfs_write(file, buf, count, &pos);
		file_pos_write(file, pos);
		fput_light(file, fput_needed);
	}

	return ret;
}

we can have multiple threads in vfs_write() using the same `pos'.

Locking for file.f_pos is generally file->f_dentry->d_inode->i_mutex.  We
could use that if we were to restructure the code a lot.  Or we could add a
new lock to `struct file'.

Or we could do nothing, because a) the application is going to produce
inderterminate output anyway and b) because it only affects silly testcases
and not real-world apps.

OK, there _might_ be a real-world case: threads appending logging
information to a flat file.  Trivially workable-around with a userspace
lock, or by switching to stdio (same thing).

Yes, really we should fix it.  But it's not worth adding more overhead to
do so.  So the fix would involve widespread (but simple) change, to draw
that f_pos update inside i_mutex.

(We could pseudo-fix it by updating f_pos _before_ entering vfs_write(), too).
