Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130065AbRCPDMq>; Thu, 15 Mar 2001 22:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130079AbRCPDMg>; Thu, 15 Mar 2001 22:12:36 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:54965 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130065AbRCPDMa>;
	Thu, 15 Mar 2001 22:12:30 -0500
Date: Thu, 15 Mar 2001 22:11:46 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Dawson Engler <engler@csl.Stanford.EDU>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 9 potential copy_*_user bugs in 2.4.1
In-Reply-To: <200103160224.SAA03920@csl.Stanford.EDU>
Message-ID: <Pine.GSO.4.21.0103152146550.10709-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Mar 2001, Dawson Engler wrote:

> Hi,
> 
> I wrote an extension to gcc that does global analysis to determine
> which pointers in 2.4.1 are ever treated as user space pointers (i.e,
> passed to copy_*_user, verify_area, etc) and then makes sure they are
> always treated that way.
> 
> It found what looks to be 9 errors, and  3 cases I'm not sure about.
> I've tried to eliminate false positives, but if any remain, please let
> me know.

Looks like you've missed at least one place. Have you marked pointer
arguments of syscalls as tainted? Path in question looks so:

* 2nd argument of sys_write() (buf) is tainted	[SYSCALL]
* sys_write() passes buf  as 2nd argument to file_operations::write()
  (fs/read_write.c:159-160)
* proc_file_write() is an instance of the above (buffer is the 2nd argument)
  (fs/proc/generic.c:36--40)
* proc_file_write() passes buffer as 2nd argument to
proc_dir_entry::write_proc() (fs/proc/generic.c:136)
* proc_write_register() is an instance of the above (buffer is the 2nd
argument) (fs/binfmt_misc.c:494)
* proc_write_register() directly dereferences buffer. (fs/binfmt_misc.c:298)
(line numbers as per 2.4.2, 2.4.1 is essentially the same)

And yes, that's an oopsable bug (fixed in more or less recent -ac).
Since a lot of code is only accessed as methods... If you could add support
for that kind of checks you'd probably find much more.

Relevant rules:
	* all arguments of syscalls are tainted. Casting can't change that.
	* verify_area() cleans the value, but you'll be better off
considering these as dangerous - it only checks that range is OK and if
pointer arithmetics moves you out of that range or you access piece longer
than range in question...
	* if method's argument is ever tainted - all instances of that
method have that argument tainted.

Is it possible to implement? The last rule may be tricky - we need to
remember that field foo of structure bar has tainted nth argument and
keep track of all functions assigned to foo, either by initialization
or by direct assignment. Could that be done?
							Cheers,
								Al

