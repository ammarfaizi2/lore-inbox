Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268333AbUJMEfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268333AbUJMEfg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 00:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268360AbUJMEff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 00:35:35 -0400
Received: from [155.35.46.20] ([155.35.46.20]:35614 "EHLO mail18.ca.com")
	by vger.kernel.org with ESMTP id S268333AbUJMEfW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 00:35:22 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6547.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Kernel stack
Date: Wed, 13 Oct 2004 10:05:15 +0530
Message-ID: <577528CFDFEFA643B3324B88812B57FE305968@inhyms21.ca.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel stack
Thread-Index: AcSwXQqOC2htYpYZT7+h7Rocs5shFAAfUxXQ
From: "Dhiman, Gaurav" <Gaurav.Dhiman@ca.com>
To: "Jan Hudec" <bulb@ucw.cz>, "aq" <aquynh@gmail.com>
Cc: "suthambhara nagaraj" <suthambhara@gmail.com>,
       "main kernel" <linux-kernel@vger.kernel.org>,
       "kernel" <kernelnewbies@nl.linux.org>
X-OriginalArrivalTime: 13 Oct 2004 04:35:16.0209 (UTC) FILETIME=[0983FE10:01C4B0DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You discussed that kernel do not keep track of SS for process specific
kernel stack as it always starts from fixed offset of task_struct, but
does that mean, linux kernel do not make use of SS element in the TSS of
process. I think the kernel can not by-pass the rules defined by
processor. Processor expects the SS and SP elements to be right at the
time of stack switching, so we need to initialize them to the right
values while forking a process.

I think kernel definitely keep tracks of SS and SP for all CPU levels
including kernel mode also (ring 0), so that when we are switching form
user space to kernel space the processor can switch the stacks
automatically. At stack switching time CPU expects the SS and SP
elements of TSS to be right, it's just going to copy those values in SS
and SP registers of CPU, so that now we can push and pop the things on
the kernel stack.

Yes it definitely can happen (and I think this is the way to do it) that
SS in process's TSS is initialized to the memory address just next to
task_struct (as the kernel stack can grow downwards till this limit)
while the forking of a process and also sets the SP to the fixed offset
from task_struct from where the kernel stack starts growing downwards
(as you mentioned kernel stack starts from there). Now whenever this
process will be scheduled by the scheduler or a process enters the
kernel mode, CPU's SS and SP registers are re-set to the SS and SP
elements in TSS of that process.

At the time of scheduling, scheduler also change the TSS descriptor for
that CPU on which the process is going to be scheduled. It changes this
TSS descriptor in GDT to point to the TSS of the selected process.

Correct me if I am wrong.

Cheers !!
Gaurav


-----Original Message-----
From: Jan Hudec [mailto:bulb@vagabond.light.src] On Behalf Of Jan Hudec
Sent: Tuesday, October 12, 2004 6:42 PM
To: aq
Cc: suthambhara nagaraj; Dhiman, Gaurav; main kernel; kernel
Subject: Re: Kernel stack

On Tue, Oct 12, 2004 at 21:30:54 +0900, aq wrote:
> > > >From what you all discuss, I can say: kernel memory is devided
into 2
> > > part, and the upper part are shared between processes. The below
part
> > > (the kernel stack, or 8K traditionally) is specifict for each
process.
> > >
> > > Is that right?
> > 
> > No, it's not. There is just one kernel memory. In it each process
has
> > it's own task_struct + kernel stack (by default 8K). There is no
special
> > address mapping for these, nor are they allocated from a special
area.
> > 
> > When a context of some process is entered, esp is pointed to the top
of
> > it's stack. That's exactly all it takes to exchange stacks.
> 
> OK, lets say there are 20 processes running in the system. Then the
> kernel must allocate 20 * 8K = 160K just for the stacks of these
> processes. All of these 160K always occupy the kernel (kernel memory
> is never swapped out). When a process actives, ESP would switch to
> point to the corresponding stack (of that process).

This is correct.

> The remainding memory of kernel therefore is equally accessible to all
> the processes.

This is not. There is nothing like "remaining memory". **ALL* kernel
memory is equally accessible to all the processes.

There is noting special about the stacks and task-structs. They are
normal 8K structures somewhere in kernel memory.

> Is that correct ?

------------------------------------------------------------------------
-------
						 Jan 'Bulb' Hudec
<bulb@ucw.cz>
