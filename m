Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTDNRGP (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263569AbTDNRGP (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:06:15 -0400
Received: from enigma.lanl.gov ([128.165.250.185]:61061 "EHLO enigma.lanl.gov")
	by vger.kernel.org with ESMTP id S263568AbTDNRGN (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 13:06:13 -0400
Date: Mon, 14 Apr 2003 11:18:01 -0600
From: hendriks@lanl.gov
To: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: Syscall numbers for BProc
Message-ID: <20030414171801.GI12496@lanl.gov>
References: <20030404193218.GD15620@lanl.gov> <20030404203531.A29501@infradead.org> <20030405004427.GG15620@lanl.gov> <20030405064559.A2331@infradead.org> <20030405201537.GA18755@lanl.gov> <20030410072910.A15440@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030410072910.A15440@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 10, 2003 at 07:29:10AM +0100, Christoph Hellwig wrote:
> On Sat, Apr 05, 2003 at 01:15:37PM -0700, hendriks@lanl.gov wrote:
> > The reason it is the way it is because when I'm trying to avoid
> > stomping on other syscalls, having a small foot print is a good thing.
> 
> Adding more syscalls isn't really a big deal - whether you add one or
> a bunch of them in a diff doesn't really matter.
>
> > Breaking out every call into a separate syscall number would also make
> > it more difficult to add new features in the future.
> 
> Which is a good thing :)  Having syscall multiplexers leads to very
> messy APIs like the one you proposed :)

I think this is a bit of a religious argument.  I know it's easy to
add syscalls, it's the question of adding a lot of goop.  I'm looking
for a situation for BProc that's similar to Tux's situation:

It's a project which exists outside main kernel development.  It's
foot print in the main line kernel is as small as possible - it's got
a single system call.  That system call *IS* a good size mux which
does a number of semi-related things.  Given the non-mainstream nature
of that feature, I think this is an entirely reasonable state of
affairs.

When it comes down to it, a system call mux is really no different
than an ioctl mux, the only question is whether or not you have a file
descriptor in the loop.

I don't believe that this leads to messy APIs.  I'm not saying that
BProc's API isn't messy - it is.  Some of it is ok.  Having the mux
allows the messy parts to exist until they are cleaned up.  I do want
to clean them up but that's not a trivial task.  I like some of the
file system ideas you've mentioned.

> > Since our nodes are running *nothing* but the Bproc slave, you can't
> > log in some other way to kill the slave and then reboot and you can't
> > run shutdown -r or something like that becuase there are no init
> > scripts.
> 
> We have a reboot notifier call chain in the kernel.

Yep.  It works great for kernel stuff.  Not so great for user space
stuff.

> > > Should be read() on a special file.
> > 
> > It started life like that but then I liked the idea of being able to
> > do it from any node in the system.  (remember no shared fs) 
> 
> You have this no shared fs argument a few times - why don't you _add_
> a shared virtual filesystem for kerne, information?  This would clean
> up many of the messier APIs.

I really like the filesystem idea for the front end but...  Shared
filesystems are really a can of worms.  This would introduce a n^2
coherency problem that BProc has avoided so far.

Still, I like the idea for a file system interface on the master.  The
back end might be able to do something similar - but slowly.  The
wrinkle is that there's no information about nodes, etc. currently
stored in the kernel on any of the nodes.  That's all maintianed in
user space.

> > VMADump doesn't depend on BProc at all.  You will, however, need a
> > system call for it the way it's written now :)
> 
> Yeah, conviencded.  Care to submit a separated out vmadump aptch with
> the syscalls for 2.5?

Sure... as soon as I get time to do a port.

> > So, the dumper needs to know what it can expect to find on the remote
> > system and what it can't.  That's where the library list comes in.  It
> > probably should just be called the remote file list or something.
> > It's a gross hack where we tell the kernel code what it doesn't need
> > to dump.  Anything that isn't dumped gets stored in the dump file as a
> > reference to a file.  (e.g. map X bytes of /lib/libc-2.3.2.so @ offset
> > Y)
> > 
> > And yeah, this might be cleaner as a writable special file but this
> > was easy given the big syscall mux.
> 
> I don't think you really want a device for this.  It's more an attribute
> of the mapping, so a MAP_ALWAYS_LOCAL flag to mmap sounds like the right
> thing.

That's really just shifting the responsibility to another hunk of
code.  Now, the dynamic linker (or any other piece of code that could
potentially mmap something like that) would need to know to tag the
region.  I'm sure there's a cleaner way to handle this than dealing in
lists of strings but involving the dynamic linker (another moving
target) doesn't seem like the right answer to me.

- Erik
