Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129486AbRCLEtD>; Sun, 11 Mar 2001 23:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129491AbRCLEsy>; Sun, 11 Mar 2001 23:48:54 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:28820 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S129486AbRCLEsr>; Sun, 11 Mar 2001 23:48:47 -0500
Message-ID: <3AAC53E4.A8BECB23@mvista.com>
Date: Sun, 11 Mar 2001 20:43:16 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: mingo@elte.hu, Andrew Morton <andrewm@uow.edu.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] serial console vs NMI watchdog
In-Reply-To: <15829.984297122@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Sun, 11 Mar 2001 08:44:24 +0100 (CET),
> Ingo Molnar <mingo@elte.hu> wrote:
> >Andrew,
> >
> >your patch looks too complex, and doesnt cover the case of the serial
> >driver deadlocking. Why not add a "touch_nmi_watchdog_counter()" function
> >that just changes last_irq_sums instead of adding locking? This way
> >deadlocks will be caught in the serial code too. (because touch_nmi() will
> >only "postpone" the NMI watchdog lockup event, not disable it.)
> 
> kdb has to completely disable the nmi counter while it is in control.
> All interrupts are disabled, all but one cpus are spinning, the control
> cpu does busy wait while it polls the input devices.  With that model
> there is no alternative to a complete disable.
> 
Consider this.  Why not use the NMI to sync the cpus.  Kdb would have a
function that is called each NMI.  If it is doing nothing, just return
false, else, if waiting for this cpu, well here it is, put it in spin
AFTER saving where it came from so the operator can figure out what it
is doing.  In kgdb I just put the interrupt registers in the task_struct
where they are put when a context switch is done.  Then the debugger can
do a trace, etc. on that task.  A global var that the debugger can see
is also set to the cpus, "current".  

If the cpu is already spinning, return to the nmi code with a true flag
which will cause it to ignore the nmi.  Same thing if it is the cpu that
is doing debug i/o.

I went to this for kgdb after the system failed to return from the call
to force the other cpus to execute a function (which means they have to
be alive).  For extra safety I also time the sync.  If one or more
expected cpus, don't show while looping reading the cycle counter, the
code just continues with out the sync.

George
