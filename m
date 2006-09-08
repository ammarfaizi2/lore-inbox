Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWIHINj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWIHINj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 04:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWIHIN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 04:13:26 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:10978 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750980AbWIHINY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 04:13:24 -0400
Date: Fri, 8 Sep 2006 10:11:52 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Edward Falk <efalk@google.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Proper /proc/pid/cmdline behavior when command line is corrupt?
In-Reply-To: <4500D1E6.7020805@google.com>
Message-ID: <Pine.LNX.4.61.0609080919130.22545@yvahk01.tjqt.qr>
References: <mailman.3.1157626801.14788.linux-kernel-daily-digest@lists.us.dell.com>
 <4500D1E6.7020805@google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Edward,


> there's a few lines of code in fs/proc/base.c:proc_pid_cmdline() that
> I'm unable to make sense of.  There are a few lines that check the
> returned buffer to see if it's properly nul-terminated.  If not, the
> code assumes the user has overwritten and corrupted the command line
> buffer.
>
> The next step is to search for the first embedded nul, and truncate
> the buffer at that point.
>
> If no embedded nul is found, enough data is copied from the user's
> environment to fill the buffer.  Another search for an embedded nul
> is then made.
>
> Does anybody know what on earth this code is trying to accomplish? 
> Is this the intended behavior?  The best I can guess is that the user
> is assumed to have overwritten the end of the command line buffer and
> that the environment buffer is assumed to immediately follow the
> command line buffer.

The environment buffer is not assumed to be there, it is _known_ to come right
after the argument string, because that is how the kernel sets it up on execve
(for x86 at least). GDB verifies this:

(gdb) b main
(gdb) r 123
(gdb) p *argv[0]@3072
$3 = "/dev/shm/a.out\000123\000LESSKEY=/etc/lesskey.bin\000GREP_COLOR=1
\000MANPATH=/usr/local/man:/usr/share/man:/usr/X11R6/man:/opt/gnome/sha
re/man\000INFODIR=/usr/local/info:/usr/share/info:/usr/info\000NNTPSERV
ER=news\000SSH"...

$3 = "/dev/shm/a.out\000123\000LESSKEY=/etc/lesskey.bin\000GREP_COLOR=1
      ^                 ^      ^                           ^
      argv[0]           argv[1]envp[0]                     envp[1]
\000MANPATH=/usr/local/man:/usr/share/man:/usr/X11R6/man:/opt/gnome/sha
re/man\000INFODIR=/usr/local/info:/usr/share/info:/usr/info\000NNTPSERV
ER=news\000SSH"...

As you can see above, libc will set up the ARGV and ENVP arrays with
pointers to the respective strings. Writing over the end of the ENVP
string will cause

  - a segfault in the user program
  - a "cannot access that memory" in GDB
  - more bad things, if done in kernelspace


> I'm currently working on a patch that removes the one page limit on
> the returned command line buffer but I'm not convinced I should
> retain this behavior.

I think yes. proc_pid_cmdline() has these lines:

	len = mm->arg_end - mm->arg_start
  *	if (len > PAGE_SIZE)
  *		len = PAGE_SIZE;
	res = access_process_vm(task, mm->arg_start, buffer, len, 0);


and @buffer is allocated in the caller as only one page:


static ssize_t proc_info_read(struct file * file, char __user * buf,            
                          size_t count, loff_t *ppos)                           
{                                                                               
	...
        if (!(page = __get_free_page(GFP_KERNEL)))
                return -ENOMEM;
	length = PROC_I(inode)->op.proc_read(task, (char*)page);                
	...
}


> Is it possible that there's any code out there
> that depends on this behavior.  It would help if I knew why it was
> done this way.




Jan Engelhardt
-- 
