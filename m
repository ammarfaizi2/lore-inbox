Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbSKIXiV>; Sat, 9 Nov 2002 18:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262823AbSKIXiV>; Sat, 9 Nov 2002 18:38:21 -0500
Received: from air-2.osdl.org ([65.172.181.6]:22703 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262821AbSKIXiT>;
	Sat, 9 Nov 2002 18:38:19 -0500
Date: Sat, 9 Nov 2002 15:39:50 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: [lkcd-devel] Re: What's left over.
In-Reply-To: <m1u1iqcpjg.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33L2.0211091533260.10722-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

{warning: cc: list too large :}

On 9 Nov 2002, Eric W. Biederman wrote:

| There are two cases I am seeing users wanting.
| 1) Load a new kernel on panic.
|    - Extra care must be taken so what broke the first kernel does
|      not break this one, and so that the shards of the old kernel
|      do not break it.
|    - Care must be taken so that loading the second kernel does not
|      erase valuable data that is desirable to place in a crash dump.
|    - This kernel cannot live at the same address as the old one, (at
|      least not initially).

Conceptually we would like a new kernel on panic, although
I doubt that it's normally safe to "load a new kernel on panic."
Or maybe it depends on the definition of "load."

What I'm trying to say is that I think the new kernel must
already be loaded when the panic happens.
Is that what you describe later (below)?

| 2) Load a new kernel under normal operating conditions.
|    And when you have a normal user space that boils down to:
|    - Acquire the kernel you are going to boot.
|    - Run the user space shutdown scripts, so the system is in
|      a clean state.
|    - Execute the new kernel.
|    - The normal case is that the newly loaded kernel will live at the
|      same physical location where the current kernel lives.
|
|
| Currently my code handles starting a new kernel under normal operating
| conditions.  There are currently two ways I can implement a clean user
| space shutdown with out needing locked buffers in the kernel until the
| very last moment.
|
| Method 1 (This works today with my sample user space):
| - copy the kernel to /newkernel
| - init 6
| - if [ -r /newkernel ]; then
|         /sbin/kexec /newkernel
|   else
|         /sbin/reboot
|   fi
| - /sbin/kexec reads in /newkernel
| - /newkernel is parsed to figure out how it should be loaded
| - sys_kexec is called to copy the kernel from user space anonymous
|   memory to temporary kernel buffers.
|
| Method 2 (For people with read only roots):
| - /sbin/delayed_kexec /path/to/new/kernel
| - Read in the /path/to/new/kernel into anonymous pages
| - Parse it and figure out how it should be loaded
| - Run the shutdown scripts from /etc/rc6.d/
| - Call sys_kexec, which will copy the data from user space anonymous
|   pages, to kernel space.
|
| This is to just make it clear that I am not working from a
| FUNDAMENTALLY BROKEN interface, nor from a broken model of machine
| maintenance.  I am quite willing to make changes assuming I understand
| what is gained with the change.
|
|
| What I currently support is a moderately nice interface, that has the
| kernel doing as much as it can without being bogged down in the
| specific details in any one file format, or needing something besides
| a 32bit entry point to jump to.
|
| I model an image as a set of segments of physical memory.  And I copy
| the image loaded with sys_kexec to it's final location, before jumping
| to the new image.  There are two reasons for this.  It takes 3
| segments to load a bzImage (setup.S, vmlinux, and an initrd).  And an
| arbitrary number of segments maps cleanly to a static ELF binary.
|
| There is only one difficult case.  What happens when the buffers the
| kernel allocates are physically in one of the segments of memory of
| the new kernel image.  Possible especially for the initrd which is
| loaded at the end of memory.
|
| I then use the following algorithm to sort the potential mess out
| before I jump to the new code.  And since this code depends on
| swapping the contents of pages, knowing the physical location of
| the pages, and is not limited to 128MB I am reluctant to look a
| vmalloc variant.  I can more get my pages from a slab if I need to
| report I have them.
|
[code deleted]
|
| Having had time to digest the idea of starting a new kernel on panic
| I can now make some observations and what I believe it would take to
| make it as robust as possible.
|
| - On panic because random pieces of the kernel may be broken we want
|   to use as little of the kernel as possible.
|
| - Therefore machine_kexec should not allocate any memory, and as
|   quickly as possible it should transition to the new kernel
|
| - So a new page table should be sitting around with the new kernel
|   already mapped, and likewise other important tables like the
|   gdt, and the idt, should be pre-allocated.
|
| - Then machine_kexec can just switch stacks, page tables, and other
|   machine dependent tables and jump to the new kernel.
|
| - The load stage needs to load everything at the physical location it
|   will initially run at.  This would likely need support from rmap.
|
| - The load stage needs to preallocate page tables and buffers.
|
| - The load stage would likely work easiest by either requiring a mem=xxx
|   line, reserving some of physical memory for the new kernel.  Or
|   alternatively using some rmap support to clear out a swath of
|   physical memory the new kernel can be loaded into.
|
| - The new kernel loaded on panic must know about the previous kernel,
|   and have various restrictions because of that.
|
|
| Supporting a kernel loaded from a normal environment is a rather
| different problem.
|
| - It cannot be loaded at it's run location (The current kernel is
|   sitting there).
|
| - It should not need to know about the previously executing kernel.
|
| - Work can be done in machine_kexec to allocate memory so everything
|   does not need to be pre allocated.
|
| - I can safely use multiple calls to the page allocator instead of
|   needing a special mechanism to allocate memory.
|
|
| And now I go back to the silly exercise of factoring my code so the
| new kernel can be kept in locked kernel memory, instead of in a file
| while the shutdown scripts are run.
|
| Unless the linux kernel is modified to copy itself to the top of
| physical memory when it loads I have trouble seeing how any of this
| will help make the panic case easier to implement.
|
| Eric
| -

-- 
~Randy

