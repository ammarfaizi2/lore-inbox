Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316517AbSEOXI0>; Wed, 15 May 2002 19:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316518AbSEOXIZ>; Wed, 15 May 2002 19:08:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16645 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316517AbSEOXIZ>;
	Wed, 15 May 2002 19:08:25 -0400
Message-ID: <3CE2EA24.961D2CF@zip.com.au>
Date: Wed, 15 May 2002 16:07:16 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Kravetz <kravetz@us.ibm.com>
CC: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Bug with shared memory.
In-Reply-To: <OF6D316E56.12B1A4B0-ONC1256BB9.004B5DB0@de.ibm.com> <3CE16683.29A888F8@zip.com.au> <20020515154200.B8975@w-mikek2.des.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz wrote:
> 
> On Tue, May 14, 2002 at 12:33:23PM -0700, Andrew Morton wrote:
> > Martin Schwidefsky wrote:
> > >                                          The system call that caused
> > > this has been sys_ipc with IPC_RMID and from there the call chain is
> > > as follows: sys_shmctl, shm_destroy, fput, dput, iput, truncate_inode_pages,
> > > truncate_list_pages, schedule. The scheduler picked a process that called
> > > sys_shmat. It tries to get the lock and hangs.
> >
> > There's no way the kernel can successfully hold a spinlock
> > across that call chain.
> >
> 
> Is adding a check for this type of situation (under CONFIG_DEBUG_SPINLOCK
> of course) worth the effort?  One would simply add a 'locks_held' count
> for each task and check for zero at certain places such as return to
> user mode, and during context switching.

I think it would be worth the effort.  One approach would be to
create a `can_sleep()' macro.  Add that to functions which may
schedule.  It's useful for documentation purposes as well as runtime
checks.

The Stanford checker caught a lot of these, but it seems that
the (high) amount of source-level obfuscation in the ipc code
defeated it.

> One would think these types of things are easily found, but this example
> suggests otherwise.  Has anyone run the kernel through an extensive
> (stress) test suite with any of the kernel debug options enabled?

There are at present no tools in the tree to trap this
problem.

-
