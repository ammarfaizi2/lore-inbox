Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSGYPBx>; Thu, 25 Jul 2002 11:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315202AbSGYPBw>; Thu, 25 Jul 2002 11:01:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:3017 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315200AbSGYPBv>;
	Thu, 25 Jul 2002 11:01:51 -0400
Message-Id: <200207251504.g6PF4vuk038804@westrelay01.boulder.ibm.com>
User-Agent: Pan/0.11.2 (Unix)
From: "Suparna Bhattacharya" <suparna@in.ibm.com>
To: "Rusty Russell" <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       dprobes@www-124.southbury.usf.ibm.com
Subject: Re: [PATCH] Kernel probes for i386 2.5.26
Date: Thu, 25 Jul 2002 20:35:11 +0530
References: <20020720044421.337A941AC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jul 2002 10:17:44 +0530, Rusty Russell wrote:

> Hi Linus,
> 
> 	This is a neat patch by Vamsi which allows code to trap on
> kernel instructions.  The IBM guys have stuff for non-intrusive testing,
> debugging, instrumentation on top of this.  It's also nice to insert
> assertions in core code without having to reboot 8)
> 
> Thanks,
> Rusty.
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
> 
> Name: Kernel Probes Patch
> Author: Vamsi Krishna S
> Status: Tested on 2.5.26 SMP
> 
> D: This patch allows trapping at almost any kernel address, useful for
> D: various kernel-hacking tasks, and building on for more D:
> infrastructure.  This patch is x86 only.
> 

Here is a somewhat brief writeup we had available about
kernel probes - hope it helps provide a little more 
information as suggested by some people offline.

Feedback, questions, comments welcome !

Regards
Suparna

Suparna Bhattacharya
Linux Technology Center
IBM Software Lab, India
E-mail : suparna@in.ibm.com


Kernel Dynamic Probes
---------------------

Kernel Dynamic Probes (kprobes) provides a lightweight interface 
for kernel modules to implant probes and register corresponding 
probe handlers. A probe is an automated breakpoint that is 
implanted dynamically in executing (kernel-space) modules without 
the need to modify their underlying source. Probes are intended 
to be used as an ad hoc service aid where minimal disruption 
to the system is required. They are particularly advocated in
production environments where the use of interactive debuggers 
is undesirable. kprobes also has substantial applicability in
test and development environments. During test, faults may be 
injected or simulated by the probing module. In development, 
debugging code (for example a printk) may be easily inserted 
without having to recompile to module under test. 

With each probe, a corresponding probe event handler address 
is specified. Probe event handlers run as extensions to the 
system breakpoint interrupt handler and are expected to have 
little or no dependence on system facilities. Because of this 
design point, probes are able to be implanted in the most 
hostile environments -- interrupt-time, task-time, disabled,
inter-context switch and SMP-enabled code paths -- without 
adversely skewing system performance. 

kprobes Interfaces
--------------------
kprobes provides two interfaces: register_probe and 
unregister_probe. 

register_probe:
----------------

Registration defines the probe location, which must be at an 
instruction boundary that precedes any associated opcode
prefixes. It also defines three call-back addresses for the 
probing module:

- the probe-event handler address, which is called as the 
  probed instruction is about to execute. On return kprobes 
  will single-step the probed instruction;
- the post-execution handler address, which is called when 
  single-stepping completes
- the fault handler address, which is called if an exception 
  is generated for any instruction within the fault-handler 
  or when kprobes single-steps the probed instruction.

register_probe passes a struct kprobe:

struct kprobe {
       u8 * addr;      /* location of the probe point */
       spinlock_t lock;
       struct list_head list;
       unsigned long status;
        /* Called before addr is executed. */
       kprobe_pre_handler_t pre_handler;
       /* Called after addr is executed, unless... */
       kprobe_post_handler_t post_handler;
        /* ... called if executing addr causes a fault (eg. page fault).
         * Return 1 if it handled fault, otherwise kernel will see it. */
       kprobe_fault_handler_t fault_handler;
       u8 opcode;
};

addr: 
the location of the probepoint, which must be at an instruction
boundary including any associated opcode prefixes - referencing 
label in C will guarantee this.

pre_handler:
the function that will be called when the probed instruction 
is about to execute.

post_handler:
the function that will be called on completion of successful 
execution of the probed instruction

fault_handler:
the function that will be called if any software 
exceptions occur
- while executing inside the probe_handler
- when single-stepping the probed instruction

The user is required to retain this structure in resident memory 
for as long as the probe remains active. Some of the fields are 
used internally by kprobes and must be initialised to NULL 
or ZERO. The fields the user is required to initialise are the addr
and the pre_handler fields. The post_handler and fault_handler
are optional.


unregister_probe:
-----------------

unregister_probe also requires struct kprobe. The user has
to unregister explicitely all registered probes 
before removing the probe handling module.

Extensions to Kernel Dynamic Probes
-----------------------------------

Kernel Dynamic Probes has been developed from the full 
Dynamic Probes patch. It includes the essential mechanism to 
allow probes to exist in kernel space. The RPN Language 
Interpreter, Watchpoints and User-space probes extensions, 
which are part of the Dynamic Probes Package, will be available 
as add-on patches from the Dynamic Probes web-site.

http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes/
