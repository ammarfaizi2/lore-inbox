Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269385AbRHCOcC>; Fri, 3 Aug 2001 10:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269392AbRHCObw>; Fri, 3 Aug 2001 10:31:52 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:6576 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S269385AbRHCObh>; Fri, 3 Aug 2001 10:31:37 -0400
Date: Fri, 3 Aug 2001 10:31:41 -0400
To: Sujal Shah <sujal@sujal.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FS Development (or interrupting ls)
Message-ID: <20010803103141.A25450@cs.cmu.edu>
Mail-Followup-To: Sujal Shah <sujal@sujal.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3B69EF9C.74DF18D6@sujal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B69EF9C.74DF18D6@sujal.net>
User-Agent: Mutt/1.3.20i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 08:26:04PM -0400, Sujal Shah wrote:
> 
> I'm working on a userspace filesystem daemon which replaces Venus (from
> CODA) or podfuk (UserVFS) using the CODA driver.  I'm still early in my
> development process, but I've run into one frustrating problem.  While
> testing my code, I have started causing ls to hang. 
> 
> It keeps the directory open, which means I can't do things like, oh,
> unmount the filesystem. :-)  Anyone have any suggestions on recovering
> gracefully when this happens short of rebooting (which is what I do
> now)?  Basically, 'ls' hangs, and can't be killed (even kill -9) and
> 'lsof' lists the directory as open (which is furthered confirmed by
> umount complaining about the filesystem being busy).

Kill the userspace daemon, when the /dev/cfs0 device is closed all
pending upcalls are aborted and further accesses to /coda will return
EIO or something.

You still won't be able to unmount until all processes that have a
reference to a file in /coda, typically caused by their 'cwd', i.e.
use cd to move shell's out of the /coda tree and kill off any
applications that were started from a shell that was at the time in
/coda.

It is unusual that you are unable to kill ls, all upcalls to the
userspace process should be interruptable (except for close). There
might be something wrong in the way you created your directory container
files and the kernel gets stuck in readdir, but strace or enabling
verbose debugging from the kernel module should help you narrow it down.
(echo 1 > /proc/sys/coda/printentry ; echo 4095 > /proc/sys/coda/debug)

Jan

