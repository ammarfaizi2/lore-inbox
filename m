Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262758AbVENNVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbVENNVy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 09:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVENNVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 09:21:54 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:29097 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S262758AbVENNVN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 09:21:13 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 7/8] ppc64: SPU file system
Date: Sat, 14 May 2005 15:05:06 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <200505132117.37461.arnd@arndb.de> <200505132129.07603.arnd@arndb.de> <20050514074524.GC20021@kroah.com>
In-Reply-To: <20050514074524.GC20021@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505141505.08999.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sünnavend 14 Mai 2005 09:45, Greg KH wrote:
> On Fri, May 13, 2005 at 09:29:06PM +0200, Arnd Bergmann wrote:
> > /run	A stub file that lets us do ioctl.
> 
> No, as Ben said, do not do this.  Use write.  And as you are only doing
> 1 type of ioctl, it shouldn't be an issue.  Also it will be faster than
> the ioctl due to lack of BKL usage :)

I've been back and forth between a number of interfaces here and haven't
found one that I'm really happy with. Using write() is probably my least
favorite one, but these are the alternatives I've come up with so far:

1. ioctl:
 pro:
     - easy to do in a file system
     - can have both input and output arguments
 contra:
     - ugly
     - weakly typed
     - unpopular

2. sys_spufs_run(int fd, __u32 pc, __u32 *new_pc, __u32 *status):
 pro:
     - strong types
     - can have both input and output arguments
 contra:
     - does not fit file system semantics well
     - bad for prototyping

3. read:
 pro:
     - fits file system semantics
     - can still return a struct { __u32 new_pc; __u32 status; };
 contra:
     - no way to pass updated instruction pointer directly

4. write:
 pro:
     - fits file system semantics
     - can take instruction pointer as input
 contra:
     - no output data

The main problem is the way that the ABI requires the main loop
to work, which is roughly:

pc = initial_instruction_pointer;
do {
	set_pc(pc);
	status = enter_spu();
	if ((status & 0xff00) == SPU_WANTS_EXIT)
        	return (status & 0xff);
	if ((status & 0xffff) == SPU_LIBRARY_CALL) {
		pc = get_pc();
		do_library_call(*(unsigned int)(local_store_pointer + pc));
		pc += 4;
	}
	if ((status & 0xffff) < SPU_USER_CODE)
		do_user_defined_stuff(status);
} while (!(status & 0xffff0000) & ERROR_MASK));

Currently, I'm doing all this in user space, i.e. the kernel does not
need to know about the different status codes that are reserved for
exit or library calls.

Having a new system call would keep the basic concept of the ioctl
and may or may not be nicer but is certainly harder to debug for now.

One thing I could do instead is have the kernel automatically increment
the program counter when the spu requests a library call. This should
be ok, because the SPU_LIBRARY_CALL stuff has already been defined
to have a very specific operating system independent meaning and as
soon as we want to do system calls from the SPU, the kernel needs to
know about some status codes anyway.

In that case, I can make the SPU instruction pointer another file
in the SPU context directory that only needs to be written once.
The operation that starts the SPU code could be an eight byte read
system call returning the new instruction pointer (needed to get
the library call arguments) and the status code that lets the
user determine the required action. 

Using a write call instead of read makes the interface even more
complicated because it would require the user to read the status
from a separate file after write returns to check what needs to
be done and then use lseek() or yet another file to access the
instruction pointer.

> And I don't quite think you do the proper permission and validate of the
> data in your code, you should verify this is all correct.

Yes, I'm sure I got that wrong. I'll put that on my todo list.
 
> > +/**** spufs attributes
> > + *

> > + * Perhaps these file operations could be put in debugfs or libfs instead,
> > + * they are not really SPU specific.
> 
> Yes they should.  I'll gladly take them for debugfs or like you state,
> libfs is probably the better place for them so everyone can use them.
> 
> If you make up a patch, I'll fix up debugfs to use them properly.

Ok. I'll do the patch for libfs then. I've been thinking about
changing

+#define spufs_attribute(name)						   \
+static int name ## _open(struct inode *inode, struct file *file)	   \
+{									   \
+	return spufs_attr_open(inode, file, &name ## _get, &name ## _set); \
+}									   \
+static struct file_operations name = {					   \
+	.open	 = name ## _open,					   \
+	.release = spufs_attr_close,					   \
+	.read	 = spufs_attr_read,					   \
+	.write	 = spufs_attr_write,					   \
+};

to take a format string argument as well, which is then used in the
spufs_attr_read function instead of the hardcoded "%ld\n". Do you think
I should do that or rather keep the current implementation?

> > +#define spufs_attribute(name)						   \
> > +static int name ## _open(struct inode *inode, struct file *file)	   \
> > +{									   \
> > +	return spufs_attr_open(inode, file, &name ## _get, &name ## _set); \
> > +}									   \
> > +static struct file_operations name = {					   \
> > +	.open	 = name ## _open,					   \
> > +	.release = spufs_attr_close,					   \
> > +	.read	 = spufs_attr_read,					   \
> > +	.write	 = spufs_attr_write,					   \
> > +};
> 
> No module owner set?  Be careful if not...

Right. Is there ever a reason to have file operations without owner?
Maybe dentry_open() could warn about this.

> > +static struct tree_descr spufs_dir_contents[] = {
> > +	{ "mem",  &spufs_mem_fops,  0644, },
> 
> Named identifiers are the better way to do this (yeah, longer code I
> know...)

Ok. I took the concept from fs/nfsd/nfsctl.c, thinking that Al knows
how to best do these things, but I can of course change this.

> > +/* This looks really wrong! */
> > +static int spufs_rmdir(struct inode *root, struct dentry *dir_dentry)
> 
> Why do you need this?  Doesn't 'simple_rmdir' work for you?

The idea was to keep the file system contents consistant with the
underlying data structures. If I allow users to unlink context
directories or files in there, there is no longer a way to extract
reliable information from the file system, e.g. for the debugger
or for implementing something like spu_ps.

My solution was to force the dentries in each directory to be
present. When the directory is created, the files are already
there and unlinking a single file is impossible. To destroy the
spu context, the user has to rmdir it, which will either remove
all files in there as well or fail in the case that any file is
still open.

Of course that is not really Posix behavior, but it avoids some
other pitfalls.
 
> The rest of your ramfs based fs code looks a bit complex.  Can't it be
> as "simple" as the debugfs code is (only 100 lines for a fs.)  Or is it
> doing different types of things that I'm completly misunderstanding?

Apart from my special directory semantics, I plan to have a rather
unusual way to map the "mem" files: Each spu context can be either
present on a physical SPU or stored in memory, so I can create a large
number of SPU contexts despite the limitation of physical SPUs present
in the machine.

When the SPU context is executing code, it obviously has to be on a
physical SPU and a memory map of the "mem" file accesses the actual
local store memory that is accessible in the real address space of
the kernel. The context save operation copies the local store memory
into a virtual file that lives only in page cache, exactly how
ramfs deals with its files. Switching between these two states should
be possible without breaking user space programs that have the
file mapped into their address space.

This mechanism is not implemented yet, but some of my code is already
prepared for it.

I also intend to split some parts out from inode.c, probably have
a file.c that contains all the file operations and another context.c
that deals with the interface to the low level spu code and with
abstracting logical spu context from physical spus.

I suppose I should also go over my code to find unnecessary functionality.

> Remember __u16 and friends for structures that cross the user/kernel
> boundry (like your ioctl that you will be rewriting...)

Yes. There are no data structures that are shared with user space
except the current ioctl argument. The MFC_TagSizeClassCmd (yes, I
need to remember to change the name some day, currently this still
uses the identifiers from the spec) and the others are defined
by the hardware interface.

Thanks for all your comments,

	Arnd <><
