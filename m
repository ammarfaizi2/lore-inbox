Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154361AbPFCQ6h>; Thu, 3 Jun 1999 12:58:37 -0400
Received: by vger.rutgers.edu id <S154045AbPFCQy4>; Thu, 3 Jun 1999 12:54:56 -0400
Received: from mnh-1-17.mv.com ([207.22.10.49]:5693 "EHLO ccure.karaya.com") by vger.rutgers.edu with ESMTP id <S154313AbPFCQox>; Thu, 3 Jun 1999 12:44:53 -0400
Message-Id: <199906031647.MAA05672@ccure.karaya.com>
X-Mailer: exmh version 2.0zeta 7/24/97
To: linux-kernel@vger.rutgers.edu
Subject: A user-mode kernel implementation
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Jun 1999 12:47:16 -0300
From: Jeff Dike <jdike@karaya.com>
Sender: owner-linux-kernel@vger.rutgers.edu

I have implemented a user-mode version of the kernel.  This was done
by porting the kernel to its own system call interface.

This was done on the 2.0.32 kernel.  I apologize for the antiquity of
this, but it's what I had lying around.  Updating it to use a 2.3
kernel is high on my list of things to do.

Here's how everything works:

vm - The kernel and all of its processes run in a single address
space.  Its processes come from standard unmodified binaries. This
causes two major problems.  The first is that those binaries are going
to expect to occupy the usual areas in the address space, and the
kernel process is already going to be occupying them.  This was solved
by loading the kernel into a shared library, and have the non-shared
code do nothing but call into the kernel.  Once in the kernel, it
abandons the process text, data, and stack by using clone to get a new
stack which contains no references to its non-shared text and data.  At
this point, those areas are unmapped, and are available for processes
to use. 

The second problem is emulating multiple virtual address spaces in
one.  The kernel expects to have some physical memory which can be
arbitrarily mapped into its own and process virtual address spaces.
This is emulated by reserving an area of the address space to be
physical memory and the kernel virtual address space.  An anonymous
physmem-sized file is created and mapped into the physical memory
area.  Pages from this file are mapped as needed into the kernel and
process address spaces.  The flush_tlb_* family of hooks is used to
keep the mappings in sync with the page tables.  With this in place,
supporting demand loading and cow is easy.  The one tricky bit is
handling stack growth.  As far as I knew when I wrote that code, it is
impossible for a process to take signals on a separate stack.  So, a
separate thread ptraces all the others and handles their signals.

processes and context switching - Every thread gets a thread in the
real kernel.  These threads share much, especially CLONE_VM.
Switching is a matter of sending the new thread a SIGCONT and sending
the old one a SIGSTOP.  flush_tlb_all is used to map out the old
address space and map in the new.

system calls - Since unmodified binaries are being run, their system
calls are going to end up in the wrong kernel.  This is fixed with a
new exec_domain module which passes the system calls and their arguments out
to a system call thread through a file in /proc.  This
thread executes the system call and passes the result back to the
module, which returns it to the original thread.

hardware emulation - The root filesystem is in a file in the external
filesystem.  There is a disk driver which operates on this file rather
than a physical disk.  There is a console driver which works ok until
it needs to scroll.  Since there is no keyboard, I added a serial line
to make it possible to log in.

Kernel modifications:

I tried to keep this a straight port, implementing the
architecture-dependent interface without touching anything above it,
but it didn't turn out that way.

The underlying kernel didn't support switching exec domains for int 80
syscalls, just lcall7 ones, so I added a bit of code to entry.S to fix
this.  It also didn't appear to be willing to supply the fault address
when a segv happens, so I added /proc/<pid>/fault.  When I later had a
look at the signal delivery code, it appears that that information is
in fact on the stack.  So, it might be reasonable to get rid of
/proc/<pid>/fault at some point.

I added some hardware initialization to the architecture-independent
portions of the user-mode kernel.  It also turned out to be necessary
to make some stupid changes in procfs.  There are a number of calls
like:
	proc_register(&proc_root, &((proc_dir_entry) { fields ... }));

The proc_dir_entry is modified during that call, and that causes a seg
fault since the compiler apparently sticks the anonymous structure in
a read-only part of the library.  I changed these to:

static struct proc_dir_entry proc_foo = { fields ... };

proc_register(&proc_root, &proc_foo);

What's broken:

It's based on an old kernel.

Shared libraries don't work.  For now, binaries run under this kernel
need to be statically linked.  I think one of the things that need to
be done is to produce a set of shared libraries that load somewhere
other than the standard places.

The system call redirection module traps processes in Z and D where
they can't be killed.  This normally wouldn't be a major problem,
since you can just renice +20 them and forget about them.  However, so
many processes get trapped that you start hitting the per-user process
limit pretty quickly.  The procedure I use for getting rid of them is:
      kill all of the processes to get rid of all the ones that are
willing to go gracefully
      dd if=/dev/zero of=/proc/remote_syscall_register bs=8 count=1
      this tells the redirection module to wake up and kill everything
      rmmod remote_syscall
      insmod it again
This produces a lot of nasty-looking oopses, but the machine stays up.      

The console gets very confused when the common console code starts
trying to scroll the screen.  I've bumped screen_info.lines up to 255
to avoid this.

There's no keyboard.  You have to log in over the serial line.  If
anything tries to read from the console, you get a panic.

Performance sucks.

It's not portable.  Ideally, this kernel should build with the same
sources on all architectures.  Now, there are many i386-isms, like the
headers being minimally modified asm-i386 headers, and some assembly.

The code is a mess.  It needs to be reorganized, commented, and reformatted.

A number of system calls haven't been hooked in yet.

What it's good for:

It's fun and cool.  It doesn't need to be good for anything.

Kernel debugging.

An MP emulator.  It ought to be possible to run an SMP kernel with
cpus > 1 on a uniprocessor.  This will let those of us without MP
hardware to play with an SMP kernel.

Applying other process-level tools to it, like profilers and test
coverage analyzers.  It would be a worthwhile project to develop a
coverage test suite for the kernel and run new kernels through it.

This might be a decent way for newbies to get into kernel hacking.
It certainly reduces the hardware requirements.

If performance improves, it might also be a decent way for kernel
kiddies to run the latest development kernels without risking damaging
their systems.

It also might make a decent jail for script kiddies.

How to run it:

Grab http://www.mv.com/ipusers/karaya/uml/umk.patch.gz and apply it to
a 2.0.32 pool.  Build linux, making sure that you don't run config and
that the include/asm link is in place.

Grab http://www.mv.com/ipusers/karaya/uml/umm.patch.gz and apply it to
your booted kernel pool.  Build the kernel and the remote_syscall module.

Build a root file system in the um kernel top-level directory by
creating a "root_fs" file of a decent size (I use 512 meg) and tarring a
root filesystem into it.

Look at all the "execing" lines in the output below for the binaries
that you will need to produce static versions of.

Make this:
brw-rw-rw-   1 root     root      62,   0 May 18 21:41 dev/fhd0

and make sure you've got this:
crw--w----   1 root     tty        5,  64 Jun  2 20:05 dev/cua0

Make fstab look like this:
/dev/fhd0                 /                         ext2   defaults 1 1
none                      /proc                     proc   defaults

Remove the normal gettys from inittab and add one for cua0.  Make
initdefault something other than 5.  I made mine 3 and removed
everything from /etc/rc.d/rc3.d.

Run linux.

Look for a line like "serial line 0 assigned pty /dev/ptyp7" and
kermit or tip or cu or whatever to the corresponding tty and log in.
Your username and newline won't echo for some reason.  Use ^J here to
end the username and password lines.  Once you're logged in, [Return]
works the way you'd expect.

If you take it down with a dirty root filesystem, you might want to
run fsck from the outside rather than letting it run inside.  It will
be a lot quicker that way.

Here is a the console boot output running under gdb:

Current directory is ~/linux/um/
GDB is free software and you are welcome to distribute copies of it
 under certain conditions; type "show copying" to see the conditions.
There is absolutely no warranty for GDB; type "show warranty" for details.
GDB 4.16 (i386-redhat-linux), Copyright 1996 Free Software Foundation, Inc...
(gdb) r
Starting program: /home/dike/linux/um/linux 
linux_main : pid = 11066

Program exited normally.
(gdb) signal thread pid = 11067
idle thread pid = 11066
Console: mono STDOUT 80x255, 1 virtual console (max 63)
Calibrating delay loop.. ok - 66.19 BogoMIPS
Memory: 224k reserved, 7960k available
Swansea University Computer Society NET3.035 for Linux 2.0
NET3: Unix domain sockets 0.13 for Linux NET3.035.
Swansea University Computer Society TCP/IP for NET3.034
IP Protocols: ICMP, UDP, TCP
Linux version 2.0.32 (jdike@ccure.karaya.com) (gcc version 2.7.2.3) #1512 Wed 
Jun 2 22:15:01 EDT 1999
Starting kswapd v 1.4.2.2 
Initializing software serial port version 0
serial line 0 assigned pty /dev/ptyp7
ssl receive thread is pid 11071
VFS: Mounted root (ext2 filesystem) readonly.
INIT: version 2.71 booting
execing "/etc/rc.d/rc.sysinit"
Activating swap partitions
execing "/sbin/swapon"
execing "/bin/hostname"
execing "/bin/hostname"
hostname: ccure.karaya.com
execing "/bin/domainname"
Checking root filesystems.
execing "/sbin/fsck"
Parallelizing fsck version 1.10 (24-Apr-97)
[/sbin/fsck.ext2] fsck.ext2 -a /dev/fhd0 
execing "/sbin/fsck.ext2"
/dev/fhd0: clean, 30665/131072 files, 493939/524288 blocks
Turning on user and group quotas for root filesystem
execing "/sbin/quotaon"
execing "/bin/mount"
execing "/bin/grep"
Remounting root filesystem in read-write mode.
execing "/bin/mount"
execing "/bin/mount"
execing "/bin/mount"
execing "/bin/grep"
Checking filesystems.
execing "/sbin/fsck"
Parallelizing fsck version 1.10 (24-Apr-97)
Checking all file systems.
----------------------------------
Mounting local filesystems.
execing "/bin/mount"
Turning on user and group quotas for local filesystems
execing "/sbin/quotaon"
execing "/bin/touch"
execing "/bin/rm"
execing "/bin/rm"
execing "/bin/rm"
execing "/bin/rm"
execing "/bin/rm"
Setting clock: execing "/sbin/hwclock"
execing "/bin/date"
Wed Jun  2 22:31:38 EDT 1999
Enabling swap space.
execing "/sbin/swapon"
execing "/bin/grep"
execing "/bin/dmesg"
execing "/etc/rc.d/init.d/random"
Initializing random number generator...
execing "/bin/cat"
execing "/bin/chmod"
execing "/bin/dd"
execing "/bin/touch"
INIT: Entering runlevel: 3
execing "/etc/rc.d/rc"
execing "/sbin/runlevel"
execing "/sbin/update"
execing "/sbin/mingetty"
execing "/bin/login"
execing "/bin/bash"
execing "/usr/bin/id"
execing "/usr/bin/id"
execing "/usr/bin/id"
execing "/usr/bin/id"
execing "/bin/hostname"
execing "/bin/df"
execing "/bin/ps"
execing "/bin/mount"
execing "/bin/cat"
execing "/bin/cat"

And here is the corresponding kermit session:

Red Hat Linux release 5.0 (Hurricane)
Kernel 2.0.32 on a proc
ccure login: Password: 
Last login: Wed Jun  2 22:32:21 on cua0
[jdike@ccure dike]$ df
Filesystem         1024-blocks  Used Available Capacity Mounted on
/dev/fhd0             507583  477241     4128     99%   /
[jdike@ccure dike]$ ps uax
USER       PID %CPU %MEM  SIZE   RSS TTY STAT START   TIME COMMAND
jdike       62  0.2  9.1 27348   728  a0 S    22:35   0:00 -bash 
jdike       74  0.0  5.8 27016   468  a0 R    22:35   0:00 ps uax 
root         1  1.9  1.7 26248   140  ?  S    22:35   0:00 init 
root         2  0.0  0.0     0     0  ?  SW   22:35   0:00 (kflushd)
root         3  0.0  0.0     0     0  ?  SW<  22:35   0:00 (kswapd)
root        46  0.0  0.5 26128    44  ?  S    22:35   0:00 update (bdflush) 
[jdike@ccure dike]$ mount
/dev/fhd0 on / type ext2 (rw)
none on /proc type proc (rw)
[jdike@ccure dike]$ cd /proc
[jdike@ccure /proc]$ cat uptime
31.80 21.00
[jdike@ccure /proc]$ cat meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:   8159232  3112960  5046272   819200   397312  3596288
Swap:        0        0        0
MemTotal:      7968 kB
MemFree:       4928 kB
MemShared:      800 kB
Buffers:        388 kB
Cached:        3512 kB
SwapTotal:        0 kB
SwapFree:         0 kB
[jdike@ccure /proc]$ 

Try it out and let me know about whatever problems you find.

			    Jeff



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
