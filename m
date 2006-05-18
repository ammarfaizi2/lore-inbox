Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWERPyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWERPyK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWERPyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:54:10 -0400
Received: from lea.cs.unibo.it ([130.136.1.101]:43960 "EHLO lea.cs.unibo.it")
	by vger.kernel.org with ESMTP id S932092AbWERPyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:54:09 -0400
Date: Thu, 18 May 2006 17:53:37 +0200
To: linux-kernel@vger.kernel.org
Cc: osd@cs.unibo.it
Subject: ptrace enhancements for VM support (patch proposals follow in sep.msgs)
Message-ID: <20060518155337.GA17498@cs.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: renzo@cs.unibo.it (Renzo Davoli)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am sending with three separate messages (as replies to this) a set of
proposed patches for a better support of virtual machines through ptrace.

We have developed the patches during the implementation of umview, the
user-mode prototype of the view-os project.
(Those interested in the project can read a short abstract after the signature
or refer to the project site on savannah: 
http://savannah.nongnu.org/projects/view-os
).
Although the patches have increased in a significant way the performance
of our partial virtual machine implementation, the patches can be useful
for any project related to virtualization, e.g. User-Mode Linux.

Here is a short summary of the patches:
#1: access_process_vm_user. This is a more efficient implementation of
ptrace_readdata, ptrace_writedata, access_process_vm (and it adds the
ptrace_readstringdata function). -- kernel/ptrace.c
#2: management of the PTRACE_MULTI tag for ptrace. It is possible by this
tag to pack several requests in a single system call reducing the number
of context switches.
#3: management of the PTRACE_SYSVM tag. With this call during the processing
of the pre-syscall ptraced process stop, it is possible to choose three
different behaviors:
- The ptraced process runs the syscall and then stops again(like PTRACE_SYSCALL)
- The ptraced process runs the syscall and does not stop until the next syscall
(useful to run the real syscall when the Virtual Machine does not manage the
call)
- The ptraced process does not run the syscall (and neither stops again).
This latter behavior is useful for syscall completely implemented by the
virtual machine.
PTRACE_SYSVM is an extension of the PTRACE_SYSCALL and includes also
the feature implemented by STRACE_SYSEMU. (We have a prototype User-Mode Linux 
patch which uses SYSVM instead of SYSEMU).

Patch #1 and #2 are architecture independent, #3 has been implemented on
i386/ppc/um.
The patches have been designed as incremental. They should be applied 
#1, 
#1 and #2,
or #1 #2 and #3.
#2 actually depends on #1 while applying #3 although logically independent
could just generate some complaints about the original files (shift of the 
hunks or differences in the hunk contexts) if applied alone. 
We suggest to patch #3 after #1 and #2.

These pathes are against 2.6.17-rc1, and we are posting them here for a general 
discussion. We are updating the set of patch to the latest rc, and we will
post them here if this community feels our development interesting.
I have try to apply the patches to rc4 and it seems that they applies
correctly with some lines of offset. 

>From the security point of view, these patch should not introduce new threats.
#1 re-implements what is already supported, #2 merges several system calls
in one call, the security checks formerly executed for each call are already
executed item per item, #3 integrates PTRACE_SYSCALL and PTRACE_SYSEMU
and extends the same features to other architectures.

We hope these proposals will be interesting for the ML and the kernel
development group.

I am sorry but I am not subscribed to the list, thus please 
Cc to osd@cs.unibo.it your answers/comments. 
Several members of the team, including myself, keep in touch with the ML by 
reading the archives.

renzo davoli
team leader and co-main developer of view-os, (and also of vde, lwipv6, virtual 
square).
together with Ludovico Gardenghi and Andrea Gasparini, main developers
and the entire staff of the project, all the members are listed on the web site. 

--------------------------
Brief abstract of view-os.

What is view-os: it is the idea to give each process its own view of the
executing environment.
The common behavior where each process running on a kernel must have the
same perpective on (say) networking, file system, IPC, devices, etc. is
just a social convention that can be broken.

umview is a prototype that shows the idea and its effectiveness.

umview is a partial virtual machine, when you start the first process
inside umview and you do not preload any umview module, umview is completely
transparent: the processes inside and outside umview see the same view.
In other words a system call run by a process inside umview has the same
effect as it were issued by the same process running outside umview.

umview supports modules (pre-loaded or loaded at run time).
each system call is presented to a "choice function" of the loaded modules.
If a module "chooses" the system call it executes the system call instead
of the real kernel.
This "choice" can be based on the path (e.g. for open), file system type
(e.g. mount), protocol family (socket), or automagically chosen by fd (when
a module choose to manage socket or open or creat, all the following calls
referring to the same fd are diverted to the same module).

The state-of-the-art, up to today is the following.

- umfuse module, it is possible to mount ext2/iso file systems and potentially
all "fuse" based file system implementations can be used with umfuse.
Note that the umfuse mounted file systems are accessible only by the processes 
running inside umview.
- lwipv6 module. it is possible to assign a virtual networking support to 
the processes running in umview (lwipv6 is another project of ours, it is a
complete user level implementation of a IPv4/IPv6 hybrid stack). The network
interfaces can be connected to tun/tap or the a Virtual Distributed Ethernet
switch (again a project of ours, this is on sourcefourge and already included
in Debian sid and other distributions). In this way it is possible to assign an 
IP addresses just to a process or to a group of processes.

There are some other younger modules included in the cvs:
- viewfs. the file system can be restructured as you want. You can
make a patchwork with the directories of your file system and say that 
this is the "view" of the process. It is possible to define copy on write 
access on a directory or on the entire file system. In this latter case 
the processes in umview modify the files in their view but the actual files 
have never been changed.
Very useful for application testing, if a buggy application messes up all 
the files everything can be rolled back by restarting umview.
viewfs can be used as a security cage to run browsers. In case of browser bug,
personal sensible data has one further layer of protection.
- devfs. It is possible to define virtual devices. All the syscall (ioctl
included) to specific special files or to specific devices can be virtualized).
It is (actually will be) possible to run fdisk, mkfs, and umfuse-mount file
systems from image files. It is useful to prepare or modify images for 
other virtual machines.
- umbinfmt. user-mode clone of binfmt_misc in the kernel. It is possible to 
define interpreters to run almost every program. The management is the same,
if the umbinfmt virtual partition gets mounted on /proc/sys/fs/binfmt_misc, 
the scripts access umbinfmt as it were binfmt_misc.

Some final remarks:
- umview supports the standard linux tools and programs (e.g. to mount a file
system, umview users run /bin/mount)
- umview runs on 2.6.x kernels (it runs *a bit slowly* on vanilla umpatched
kernels, but it runs. umview needs only ptrace). umview runs quite well on patched
kernels, expecially on >2.6.16 by exploiting the new pselect support.
- umview does not use any call or option that needs root access. umview
runs as a user-process with user permissions.
- (young feature) Module nesting is supported. e.g. It is possible to mount a 
file system image which is stored on another virtual file system or
accessible by a virtual network. It is also possible to run umview inside
umview. In this way it is possible for some processes to share some parts of
their view while having specific views for other aspects. This "nested" run of
umview does not "ptrace twice" the processes, the underlying umview support
is notified that the virtual environment has forked, and it will manage the
different views independently after the view-fork.
