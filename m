Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129623AbRCLIoF>; Mon, 12 Mar 2001 03:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129624AbRCLInp>; Mon, 12 Mar 2001 03:43:45 -0500
Received: from zeus.kernel.org ([209.10.41.242]:9448 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129623AbRCLIne>;
	Mon, 12 Mar 2001 03:43:34 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: george anzinger <george@mvista.com>
cc: mingo@elte.hu, Andrew Morton <andrewm@uow.edu.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] serial console vs NMI watchdog 
In-Reply-To: Your message of "Mon, 12 Mar 2001 00:27:14 -0800."
             <3AAC8862.3461A1A8@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Mar 2001 19:41:43 +1100
Message-ID: <24342.984386503@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2001 00:27:14 -0800, 
george anzinger <george@mvista.com> wrote:
>Keith Owens wrote:
>> kdb uses NMI IPI to get the other cpu's attention.  One cpu is in
>> control and may or may not be accepting NMI, it depends on the event
>> that entered kdb.  The other cpus end up in kdb code, spinning waiting
>> for a cpu switch.  Initially they are not receiving NMI because they
>> were invoked via NMI which is masked until they exit.
>
>Are you actually twiddling the hardware, or just changing what happens
>on NMI?

No hardware twiddling.  One cpu gets an event which triggers kdb, that
event may or may not be via NMI.  kdb on ix86 then uses NMI to get the
attention of the other cpus, even if they are in a disabled spinloop.
ix86 hardware will not deliver another NMI to a cpu until the cpu
issues iret to return from the NMI handler.

Initially all but one cpu is forced into kdb via the NMI handler so no
more NMI events will occur on those cpus.  The first cpu may or may not
be receiving NMI, it depends on how kdb was invoked on the first cpu.
To do single stepping of code, kdb allows one cpu out of kdb state so
it can execute one instruction at the point it was interrupted.  If the
cpu was entered via NMI then that means exiting from the NMI handler
back to the original code, do single step then back into kdb again.

Having exited the NMI handler, that cpu will start receiving NMI events
again, even though it is still under kdb control.  So some cpus will
get NMI, some will not, depending on user actions.  kdb uses a software
mechanism to selectively disable the NMI watchdog.

