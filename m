Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbVGSMNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVGSMNO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 08:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVGSMNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 08:13:14 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:43168 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261974AbVGSMNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 08:13:08 -0400
Subject: Re: How linear address translate to physical address in kernel
	space?
From: Steven Rostedt <rostedt@goodmis.org>
To: "liyu@WAN" <liyu@ccoss.com.cn>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <42DCE551.80104@ccoss.com.cn>
References: <42DCE551.80104@ccoss.com.cn>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 19 Jul 2005 08:12:57 -0400
Message-Id: <1121775177.6125.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-19 at 19:34 +0800, liyu@WAN wrote:
> HI, every in LKML.
> 
>     I have a question that can not understand.
> 
>     In kernel space, how linear address translate to physical address ? 
> In many kernel bookes,
> they said "directly mappd", I think I seen what they said, their mean is 
> use __pa()/__va() macro
> pair.
> 
>     (My platform is i386.)

Hi Liyu,

I'm not that strong in the Intel world, but after all the fancy
registers, intel is not much different than say PPC. So I'll keep this
more of a generic platform discussion, and only talk about physical and
virtual address space.

The kernel is usually mapped down to the lower end of memory, which in
most platforms starts at physical address zero (I've worked with
platforms that don't do this, but that's offtopic). Then the kernel maps
this physical location to some upper address (with intel it's usually
0xc0000000).

All the user space addresses are mapped below this kernel address. Now
the magic here, and it probably confuses you, is that all
tasks/processes have the kernel address mapped to the same location.  So
on context switches, the kernel is still in the same location in virtual
address.  It's just that when the CPU is in user mode, the kernel
address is protected from being read or written to. So if a user space
process tries to write or read from it (like *(char*)(0xc0000000) = 1;)
it will get a page fault. But when the CPU switches to kernel mode
(through a system call or interrupt), it has full access to this area.

So you have this mapping:

             Physical               Virtual
0x00000000  ------------          -------------
            | kernel   | --+      |  user      |
            |          |   |      |            | 
            +----------+   |      |            |
            | general  |   |      |            |
            | memory   |   |      |            |
            .          .   |      .            .
            .          .   |      .            . 
            | end of   |   |      |            |
            | memory   |   |      |            |
            +----------+   |      |            |
            |          |   +--->  +------------+ 0xc0000000
            |          |          |  kernel    |
            .          .          .            .
            .          .          .            .

Usually all of memory is mapped to the address 0xc0000000. But this
becomes a problem when you have a gig or more of RAM.  Since you run out
of virtual space to map there. And you still need room to map device
memory as well (you can't have user space conflicting with devices). So
if you have a lot of RAM, you need to turn on highmem support, which
then plays around to get memory above a certain point. But that's
another discussion.

So to access physical memory from the kernel, you can use __pa and back
with __va.  These are used to communicate with devices usually, which
are also mapped to some location.  But these only work when the mapping
is direct as show above. When highmem support is on, you can't get to
memory that is not mapped in. But there's no need to use __pa or __va to
get to memory just for itself.  Usually they are used when dealing with
devices that have DMA or some other need to find a physical address. If
a device needs to write to memory (usually only knowing about the
physical location of the memory) you get that memory with GFP_DMA flag,
which guarantees that you will get memory that is mapped directly.

-- Steve


