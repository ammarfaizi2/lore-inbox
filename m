Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129871AbQKGXH5>; Tue, 7 Nov 2000 18:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130300AbQKGXHr>; Tue, 7 Nov 2000 18:07:47 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:5383 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129871AbQKGXHm>; Tue, 7 Nov 2000 18:07:42 -0500
Message-ID: <3A088A3D.2CD0BC53@timpanogas.org>
Date: Tue, 07 Nov 2000 16:03:25 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Dual XEON - >>SLOW<< on SMP
In-Reply-To: <Pine.LNX.3.95.1001107174352.436A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marc Lehman verified that PII systems will generate tons of AGIs with
gcc.  Perhaps this is the cause of this problem.  You could run EMON and
see if there is something obvious in the numbers ...

Jeff

"Richard B. Johnson" wrote:
> 
> On Wed, 8 Nov 2000, Keith Owens wrote:
> 
> > On Tue, 7 Nov 2000 17:31:19 -0500 (EST),
> > "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> > >Also, I get some CPU watchdog timeout that I didn't ask for Grrr...
> > >
> > >Nov  7 17:17:54 chaos nmbd[115]:   Samba server CHAOS is now a domain master browser for workgroup LINUX on subnet 204.178.40.224
> > >Nov  7 17:17:54 chaos nmbd[115]:
> > >Nov  7 17:17:54 chaos nmbd[115]:   *****
> > >Nov  7 17:18:54 chaos kernel: NMI Watchdog detected LOCKUP on CPU0,
>  registers:
> > >Nov  7 17:18:54 chaos kernel: CPU:    0
> > >Nov  7 17:19:01 chaos login: ROOT LOGIN ON tty2
> >
> > Which means that one of the cpus is spinning for 5 seconds with
> > interrupts disabled.  CPU watchdogs are *good*.
> >
> 
> Well no. I won't buy that. What it means is that some so-called
> watchdog timer code is broken.
> 
> The following, tight loop user-mode code will trip it off and the
> interrupts are not disabled from user-mode code:
> 
> #include <stdio.h>
> 
> int main(void);
> int main()
> {
>    for(;;)
>   {
>    __asm__ __volatile__(
>    "\tpushl     %ecx\n"
>    "\txorl      %ecx,%ecx\n"
>    "1:\tloop    1b\n"
>    "\tpopl      %ecx\n"
>         );
>    }
>    return 0;
> }
> 
> When it trips off, this code is seg-faulted without any core-dump.
> This code must never seg-fault. It doesn't access memory that was
> not allocated upon startup and, if the kernel wants the CPU, it
> will take it away. It is, after all , supposed to be premptive.
> 
> Somebody has severly broken Linux.
> 
> > >
> > >           CPU0       CPU1
> > >  0:      10945      11869    IO-APIC-edge  timer
> > >  1:        419        393    IO-APIC-edge  keyboard
> > >  2:          0          0          XT-PIC  cascade
> > >  8:          0          0    IO-APIC-edge  rtc
> > > 10:       2990       2904   IO-APIC-level  eth0
> > > 11:       1066       1124   IO-APIC-level  BusLogic BT-958
> > > 13:          0          0          XT-PIC  fpu
> > >NMI:      22748      22748
> > >LOC:      21731      22229
> > >ERR:          0
> > >
> > >
> > >The NMI and LOC (timers) run faster than timer channel 0. This
> > >cannot be correct. Anybody know what this is and how to get
> > >rid of these CPU time stealers?
> >
> > The timer is directed both as a normal interrupt 0 and as a broadcast
> > non maskable interrupt.  The NMI count on each cpu should be roughly
> > the sum of the interrupt 0 count across all cpus.
> >
> 
> How do I get these things turned OFF? These CPUs and this machine
> worked fine for two years. It now runs at 1/4 the speed.
> 
> > The NMI path is fairly fast so the overhead is small.  When it does
> > trip you have a problem, a cpu is spinning for far too long.  Extract
> > the NMI report from the log, run it through ksymoops and mail the
> > decoded result.
> >
> 
> I sincerely doubt that the overhead is small. The overhead is
> enormous. It can be felt!
> 
> All I got from the log was what was reported. There is a colon
> after 'registers' and that's that. The system continued to run.
> It did not panic.
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).
> 
> "Memory is like gasoline. You use it up when you are running. Of
> course you get it all back when you reboot..."; Actual explanation
> obtained from the Micro$oft help desk.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
