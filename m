Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315479AbSGTLKL>; Sat, 20 Jul 2002 07:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315525AbSGTLKL>; Sat, 20 Jul 2002 07:10:11 -0400
Received: from ns.suse.de ([213.95.15.193]:18189 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315479AbSGTLKJ>;
	Sat, 20 Jul 2002 07:10:09 -0400
Date: Sat, 20 Jul 2002 13:13:13 +0200
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [DOCUMENTATION] 32bit ioctl support for 64bit kernels
Message-ID: <20020720131313.A23704@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


64bit kernels that support a 32bit userland need to translate a lot of
ioctls from 32bit userland. A lot of this is done is done by special 
emulation modules in the architecture specific code, but many ioctls are 
still missing. When you define new ioctls or have an external module
that supports new ioctls and you want to support 64bit kernels properly
you should implement 32bit<->64bit conversion functions. This short
tutorial describes how to do this.

Feedback welcome,

-Andi


32bit ioctl emulation
---------------------
Andi Kleen, SuSE Labs. Send feedback to ak@suse.de

The 64bit kernel uses a 64bit ABI. The 32bit kernel uses a 32bit ABI
which can be different.  When your custom kernel module implements ioctls 
that read or write memory structures in user space it may be needed to add 
a 64bit conversion function for 32bit ioctl calls.

This is only needed when the ioctl is commonly used by 32bit software.
When the ioctl is just used for debugging or rare diagnostics it may be
better to recompile the user space program that uses it as a 64bit program.

When do you need to do that:
- You're using a custom kernel module that you ported to 64bit and when
you run 32bit binaries on it you see a kernel message like:
sys32_ioctl(program:pid): Unknown cmd fd(xxx) cmd(yyy) arg(zzz) 
and you determine the cmd yyy is a ioctl implemented by your kernel module.

When one of the following is true:
- The ioctl reads from or writes to an memory structure argument that
is passed as argument from the user space application.
- The memory structure contains long, pointers or long long data types.
then you need to implement a conversion function. When it is not true
you can likely just register the ioctl as compatible between 32bit
and 64bit

Note this alignment problems only exist on IA64/x86-64 <-> i386. Other
ports likely do have natural alignment for long long in 32bit too. It is
still recommended to convert ioctls that use long long in memory structures
on all architectures for portability.

The API for writing a conversion handler is the following: 

To register 32bit ioctls:
int register_ioctl32_conversion(unsigned cmd, 
							    int (*handler)(unsigned cmd,unsigned long arg,
								struct file *file);
Register a 32bit conversion handler for ioctl cmd. Note that when 
you use _IO{R,W,WR} to define cmd you need to redefine it with the 32bit
size of the ioctl argument.   When the ioctl is 64bit clean ("compatible")
as defined above you can pass sys_ioctl as the handler. If not handler must
be your custom conversion function. See below on how to write a conversion
function.
When it returns -EINVAL your ioctl is not globally unique and cannot be
converted.

int unregister_ioctl32_conversion(unsigned int cmd);
Remove the custom conversion function. This should be done at module unload
time.

These function exists on sparc64,ppc64,x86-64 currently. I expected other
64bit ports will implement them too in the future. On x86-64 the functions
are prototyped in asm/ioctl32.h. For other architectures you need to 
prototype them manually in your driver currently.

How to avoid conversion for new ioctls: 
- When you define a new ioctl always use types with explicit type sizes
(u32 instead of long) except for pointers or other memory address. 
For pointers/memory addresses always use unsigned long.
- Make sure that all fields in the structure are naturally aligned
to the beginning of the structure (u64 has an offset that is an 
multiple of 8 bytes, u32 an offset multiple of 4 bytes etc.) 
pointers/unsigned long should be 8 byte aligned as far as possible
(best is to cluster pointers/memory addresses at the end of the structure)
Use explicit padding to ensure the alignment.

When these rules are true the ioctl can be registered as compatible
by passing sys_ioctl as handler to register_ioctl32_conversion.

How to write a custom conversion function: 

Declare it as a 

int my_handler(unsigned cmd, unsigned long arg, struct file *file)

function and redefine the structures of its memory arguments in a 32bit clean 
way (conversion rules: long -> int, pointer -> u32,
long long/u64 -> long long __attribute__((packed)))
When an argument is read: 

	 struct myarg_32bit *arg32 = (struct myarg_32bit *)arg; 
	 struct myarg arg64; 
	 mm_segment_t old_fs; 
	 int err;

	/* for each field in myarg */	
	err = 0;
	err |= get_user(arg64.field1, &arg32->field1); 
	...

	if (err) return -EFAULT; 
	old_fs = get_fs();	
	set_fs(KERNEL_DS);  /* tell kernel to accept arguments in kernel space */
	err = sys_ioctl(file, cmd, &arg64)
	set_fs(old_fs);
	return err;

When an argument is written: 

	 struct myarg_32bit *arg32 = (struct myarg_32bit *)arg; 
	 struct myarg arg64; 
	 mm_segment_t old_fs; 
	 int err;

	old_fs = get_fs();	
	set_fs(KERNEL_DS);  /* tell kernel to accept arguments in kernel space */
	err = sys_ioctl(file, cmd, &arg64)
	set_fs(old_fs);
	if (err) return err;

	/* for each field in myarg */
	err |= put_user(arg64.field1, &arg32->field1); 
	...

	return err ? -EFAULT : 0;

The two patterns can be combined for read/write ioctls.	

Then register the handler function using register_ioctl32_conversion().	

Caveat: 
- The ioctl command has to have an globally unique ioctl number (this 
is usually ensured by using the _IOR/_IOW/_IOWR macros with an unique character 
to build the ioctl number).
When that is not true you need to add special handling to the custom
conversion handler  that checks if the major number 
MAJOR(file->f_dentry->d_inode->i_rdev) belongs to you.
If that check fails just pass the ioctl on uncoverted to sys_ioctl()
Unfortunately the functions do not support stacked handlers to support
multiple handlers for a single conflicting ioctl number currently.
If you need this please contact ak@suse.de

Examples can be found in /usr/src/linux/arch/x86_64/ia32/ia32_ioctl.c
