Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132284AbQKKTtl>; Sat, 11 Nov 2000 14:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132336AbQKKTtb>; Sat, 11 Nov 2000 14:49:31 -0500
Received: from relay03.valueweb.net ([216.219.253.237]:27408 "EHLO
	relay03.valueweb.net") by vger.kernel.org with ESMTP
	id <S132335AbQKKTtV>; Sat, 11 Nov 2000 14:49:21 -0500
Message-ID: <3A0DA3CC.520BEAB2@opersys.com>
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Michael Vines <mjvines@undergrad.math.uwaterloo.ca>
CC: "Magnus Naeslund(b)" <mag@bahnhof.se>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Tracing files that opens.
In-Reply-To: <Pine.LNX.4.10.10011111257010.1996-100000@barkingdogstudios.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sat, 11 Nov 2000 14:49:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It seems that no one on that thread thought about using the Linux Trace
Toolkit which would allow you to do exactly what is asked for. Plus,
there's a basic hooking mechanism than enables you to hook onto any
file-system events and then do what you want with that.

In the case of trapping open() or stat() you'd only need to:
1) Patch the kernel with the LTT patch
2) Write a kernel module that uses the hooking interface to hook
onto system call entries and filter those out as needed. Moreover,
you could also hook onto file-system events which would give you
greater detail about the file-system related system calls occurring.

Eventually, I'd like to see item #1 disappear and the tracing patches
admitted part of the kernel tree. Other OSes have had such a capability
for a very long time. This, by itself, doesn't justify including it,
but it certainly does go to show usefulness. Moreover, Alan has suggested
that this might be a good way to implement C2 security into the kernel
since all system entries are monitored.

That said, here's an example module that could be a basis for trapping
open() and stat(). Although, it could be used to monitor other events:

#define MODULE

#include <linux/module.h>
#include <linux/trace.h>

int my_callback(uint8_t pmEventID,
		void*   pmStruct)
{
  trace_syscall_entry* syscall_event = (trace_syscall_entry*) pmStruct;

  printk("System call %d occured at address 0x%08X \n",
         syscall_event->syscall_id,
         syscall_event->address);
}

int init_module(void)
{
  printk("callback initialized \n");
 
  trace_register_callback(&my_callback,
			  TRACE_EV_SYSCALL_ENTRY);
 
  return 0;
}

void cleanup_module(void)
{
  trace_unregister_callback(&my_callback,
			    TRACE_EV_SYSCALL_ENTRY);
}

The only "problem" here being that you can't specify "open" or "stat" as
strings, but as their respective system call ID as seen in arch/i386/entry.S
for the i386. Note the patches available now include support for the PowerPC.

If anyone is interested in adding support for other architectures, feel
free to dig in.

You can find LTT and all relevant patches at: http://www.opersys.com/LTT

Best regards

Karim

Michael Vines wrote:
> 
> On Sat, 11 Nov 2000, Magnus Naeslund(b) wrote:
> 
> > Is there a nice way to trap on file open() and stat() ?
> > That way i could have nice file statistics.
> 
> There was a thread about this a couple days ago.
> 
> http://x52.deja.com/threadmsg_ct.xp?AN=690272012.1&mhitnum=0&CONTEXT=973965178.1986985995
> 
>         Michael
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
===================================================
                 Karim Yaghmour
               karym@opersys.com
          Operating System Consultant
 (Linux kernel, real-time and distributed systems)
===================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
