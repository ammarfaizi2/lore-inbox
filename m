Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263938AbTDJGRe (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 02:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263985AbTDJGRd (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 02:17:33 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:8208 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263938AbTDJGRc (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 02:17:32 -0400
Date: Thu, 10 Apr 2003 07:29:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: hendriks@lanl.gov
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Syscall numbers for BProc
Message-ID: <20030410072910.A15440@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, hendriks@lanl.gov,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20030404193218.GD15620@lanl.gov> <20030404203531.A29501@infradead.org> <20030405004427.GG15620@lanl.gov> <20030405064559.A2331@infradead.org> <20030405201537.GA18755@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030405201537.GA18755@lanl.gov>; from hendriks@lanl.gov on Sat, Apr 05, 2003 at 01:15:37PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 01:15:37PM -0700, hendriks@lanl.gov wrote:
> The reason it is the way it is because when I'm trying to avoid
> stomping on other syscalls, having a small foot print is a good thing.

Adding more syscalls isn't really a big deal - whether you add one or
a bunch of them in a diff doesn't really matter.

> Breaking out every call into a separate syscall number would also make
> it more difficult to add new features in the future.

Which is a good thing :)  Having syscall multiplexers leads to very
messy APIs like the one you proposed :)

> Since our nodes are running *nothing* but the Bproc slave, you can't
> log in some other way to kill the slave and then reboot and you can't
> run shutdown -r or something like that becuase there are no init
> scripts.

We have a reboot notifier call chain in the kernel.

> > Should be read() on a special file.
> 
> It started life like that but then I liked the idea of being able to
> do it from any node in the system.  (remember no shared fs) 

You have this no shared fs argument a few times - why don't you _add_
a shared virtual filesystem for kerne, information?  This would clean
up many of the messier APIs.

> > I'm pretty sure this would better be a /proc/<pid>/image file you
> > can read from.
> 
> I'm a little fuzzy on what you mean here.  If you're suggesting that a
> process read from its own /proc/pid/image, then that's hard because
> the process is changing while you do it.  In the 3rd party case (which
> vmadump doesn't support) it gets more tricky because you need to make
> sure the process is stopped and the CPU state stored while you're
> reading this.

Okay, you're right - this should be a syscall.

> VMADump doesn't depend on BProc at all.  You will, however, need a
> system call for it the way it's written now :)

Yeah, conviencded.  Care to submit a separated out vmadump aptch with
the syscalls for 2.5?

> 
> > > 0x1030 - VMAD_LIB_CLEAR - clear the library list
> > >   no arguments
> > 
> > What library lists are all those calls about?  Needs more explanation.
> 
> If you look at the virtual memory space of a dynamically linked
> program, the percentage of space used by the program itself (i.e. not
> libraries) is often very small.  In an effort to make process
> migration really cheap, we're willing to say that files X, Y and Z are
> available on the machine where we'll be restoring the process image.
> The candidates for remote caching are, obviously, large shared
> libraries.
> 
> So, the dumper needs to know what it can expect to find on the remote
> system and what it can't.  That's where the library list comes in.  It
> probably should just be called the remote file list or something.
> It's a gross hack where we tell the kernel code what it doesn't need
> to dump.  Anything that isn't dumped gets stored in the dump file as a
> reference to a file.  (e.g. map X bytes of /lib/libc-2.3.2.so @ offset
> Y)
> 
> And yeah, this might be cleaner as a writable special file but this
> was easy given the big syscall mux.

I don't think you really want a device for this.  It's more an attribute
of the mapping, so a MAP_ALWAYS_LOCAL flag to mmap sounds like the right
thing.

