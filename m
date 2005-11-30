Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbVK3Q0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbVK3Q0E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 11:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbVK3Q0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 11:26:03 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:23286 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751442AbVK3Q0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 11:26:01 -0500
Subject: Re: [PATCH] race condition in procfs
From: Steven Rostedt <rostedt@goodmis.org>
To: Grzegorz Nosek <grzegorz.nosek@gmail.com>
Cc: vserver@list.linux-vserver.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <121a28810511300729p6983c9a2x@mail.gmail.com>
References: <121a28810511282317j47a90f6t@mail.gmail.com>
	 <20051129000916.6306da8b.akpm@osdl.org>
	 <121a28810511290038h37067fecx@mail.gmail.com>
	 <121a28810511290525m1bdf12e0n@mail.gmail.com>
	 <121a28810511290604m68c56398t@mail.gmail.com>
	 <1133274524.6328.56.camel@localhost.localdomain>
	 <121a28810511290639g79617c85h@mail.gmail.com>
	 <Pine.LNX.4.58.0511290945380.7838@gandalf.stny.rr.com>
	 <121a28810511300641pca9596fl@mail.gmail.com>
	 <1133363652.25340.17.camel@localhost.localdomain>
	 <121a28810511300729p6983c9a2x@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 11:25:51 -0500
Message-Id: <1133367951.6635.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Andrew, this will be the last email that I include you on.  I'm taking
you off unless you want to stay on this thread, and say so.  I figure
that you get enough spam without having to read through this. I'll
obviously add you back if this results in a patch.)

On Wed, 2005-11-30 at 16:29 +0100, Grzegorz Nosek wrote:
> 2005/11/30, Steven Rostedt <rostedt@goodmis.org>:
> >
> > OK, Remove your patches, run the system where you can capture the log,
> > and provide a full output of the oops.  Make sure you have
> > CONFIG_KALLSYMS set.
> >
> 
> OK, attached an oops from netconsole.
> 

The oops happened at address a01b50eb.  Could you go into the compiled
directory run gdb on vmlinux and type li *0xa01b50eb and show what you
get.

For example:

~/work/ernie/linux-2.6.15-rc2-git5$ gdb vmlinux
GNU gdb 6.3-debian
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-linux"...Using host libthread_db library "/lib/tls/libthread_db.so.1".

(gdb) li *0xc01019e0
0xc01019e0 is in sys_clone (arch/i386/kernel/process.c:768).
763     {
764             return do_fork(SIGCHLD, regs.esp, &regs, 0, NULL, NULL);
765     }
766
767     asmlinkage int sys_clone(struct pt_regs regs)
768     {
769             unsigned long clone_flags;
770             unsigned long newsp;
771             int __user *parent_tidptr, *child_tidptr;
772
(gdb)

Obviously, use "li *0xa01b50eb" instead of 0xc01019e0.

Now if you get an error in starting gdb like:

$ gdb vmlinux
GNU gdb 6.3.90_20051119-debian
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i486-linux-gnu"...(no debugging symbols found)
Using host libthread_db library "/lib/tls/libthread_db.so.1".

(gdb) li *0xa01b50eb
No symbol table is loaded.  Use the "file" command.
(gdb)

Notice the (no debugging symbols found).  Then start up make menuconfig,
goto "Kernel Hacking", set "Kernel Debugging" and "Compile the kernel
with debug info".  And try again.  It may also be helpful to have
"Compile the kernel with frame pointers" also set.  If you do this, you
will probably need to use something other than the 0xa01b50eb.  Look at
the output of the oops and see the following:

Nov 27 00:15:26 s35 [43281574.240000] CPU:    1
Nov 27 00:15:26 s35 [43281574.240000] EIP:    0060:[<a01b50eb>]    Not tainted VLI
Nov 27 00:15:26 s35 [43281574.240000] EFLAGS: 00010257   (2.6.14.2amd64smp.17)

That EIP is what I want.

-- Steve


