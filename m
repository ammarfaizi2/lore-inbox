Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129193AbRBMVBz>; Tue, 13 Feb 2001 16:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129211AbRBMVBo>; Tue, 13 Feb 2001 16:01:44 -0500
Received: from smtp.bellnexxia.net ([209.226.175.26]:63481 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129193AbRBMVBb>; Tue, 13 Feb 2001 16:01:31 -0500
Message-ID: <3A899FEB.D54ABBC7@sympatico.ca>
Date: Tue, 13 Feb 2001 15:58:19 -0500
From: Jeremy Jackson <jeremy.jackson@sympatico.ca>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Is this the ultimate stack-smash fix?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.  This is my first post on linux-kernel, I hope this is
appropriate.

The recent CERT IN-2001-01 's massive repercussions and CA-2001-02's
re-releasing
old material in an attempt to coerce admins to update their OS, has led
me to think about
buffer overrun exploits.   I have gained a new appreciation after being
rooted twice this month.

I believe there is a solution that can be implemented in the kernel
(Linux and probably most Unix)
that can prevent this type of exploit, has no effect on userspace code,
and is minimally obtrusive
for the kernel.

Making a few assumptions here - I'm writing to confirm or deny this
idea.

Background:

The virtual address space of a Linux process starts at a low address
(0?) with a block
containing

-the executable's code & constant data mmaped read-only from the
executable.
-the executable's static initialized data mmapped copy-on-write from
same file.
-more of each of the above, but for shared libraries.

each continuous address range from the above is described in a kernel
vm_area_struct,
and is mapped on demand and placed into hardware page-protection perms
(rwx) by the CPU's
PMMU hardware and the kernel's fault-handler's.

Next, there is a variable ammount of un mapped memory, Followed by the
Stack.

The stack's vm_area grows downward, unlike the others ( brk() call) and
begins at the high
address at the top of user space, which varies but is 3GB for a 1GB max
mem kernel.

beyond this there is no vm_area's, and the page tables contain mappings
which are marked
supervisor-only (is this right?), and definitely don't contain user
code.


Next, gcc doesn't generate any code which would be placed in the stack,
nor does it
generate any calls/jumps to the stack area.

Next, buffer overruns are the only source of code whch would execute
from the stack, and
from what I understand, remote (if not all)  buffer overruns depend on
this to "work".

Solution: if the kernel sets up the CPU's memory management unit (PMMU)
so that it won't
execute code in the stack address space, the exploits are foiled.

Problem: on intel, the page tables page permissions are not flexible
enough, so when a page
is marked (for userspace) read-write permissions, execute permission is
implied.

But, intel also has segment descriptors held in the GDT/LDTs, which
configure a base address
and range, and a different one can be selected for each segment register
of a process.   Under the current
Linux the code segment (CS) has a descriptor from the GDT which allows
code to be executed read-only from
base address 0 with a range of 4G (i.e. the entire linear address
space), and the data segment
allows read-write but not execute (can't be loaded into CS register).

SO, if the CS descriptor were changed by the kernel to track the bottom
of the stack (lower in memory),
then any attempt to execute code on the stack would segfault (or another
signal to help track exploit
attempts)  It could get the bottom page address from the vm_area_struct
for the stack (are there more than one GROWS_DOWN
vm areas in a process?)

Currently the CS for all linux programs gets it's descriptor from GDT,
so it would have to be manually
changed at each task-swap, and perhaps there are segment descriptor and
other cache flushing issues,
(maybe just store CS limit in the per-task data structure, and update
GDT then reload CS at each
context change)

I realize that the GDT/LDT must be accessible, and that they are in
kernel space (above 3GB), but I don't
think these go through CS register access controls.  The DS segment can
be left alone.

For other arch's, maybe they have separate read/write/execute perms per
page, or something similar
to segment descriptors.

I would appreciate thoughful comments; anybody who knows why it won't
work, tell me,
I haven't got my hopes up for the Nobel prize yet :)

Cheers,

Jeremy


