Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbTAFLgB>; Mon, 6 Jan 2003 06:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbTAFLgB>; Mon, 6 Jan 2003 06:36:01 -0500
Received: from packet.digeo.com ([12.110.80.53]:53438 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262038AbTAFLf5>;
	Mon, 6 Jan 2003 06:35:57 -0500
Message-ID: <3E196C17.7D318CAF@digeo.com>
Date: Mon, 06 Jan 2003 03:44:23 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: Pavel Machek <pavel@ucw.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] acpi_os_queue_for_execution()
References: <F760B14C9561B941B89469F59BA3A84725A107@orsmsx401.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jan 2003 11:44:27.0312 (UTC) FILETIME=[F783FB00:01C2B578]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Grover, Andrew" wrote:
> 
> > From: Pavel Machek [mailto:pavel@ucw.cz]
> > Acpi seems to create short-lived kernel threads, and I don't quite
> > understand why.
> >
> > In thermal.c
> >
> >
> >                         tz->timer.data = (unsigned long) tz;
> >                         tz->timer.function = acpi_thermal_run;
> >                         tz->timer.expires = jiffies + (HZ *
> > sleep_time) / 1000;
> >                         add_timer(&(tz->timer));
> >
> > and acpi_thermal_run creates kernel therad that runs
> > acpi_thermal_check. Why is not acpi_thermal_check called directly? I
> > don't like idea of thread being created every time thermal zone needs
> > to be polled...
> 
> Are we allowed to block in a timer callback? One of the things
> thermal_check does is call a control method, which in turn can be very
> slow, sleep, etc., so I'd guess that's why the code tries to execute
> things in its own thread.
> 

acpi_thermal_run is doing many sinful things.  Blocking memory
allocations as well as launching kernel threads from within a
timer handler.

Converting it to use schedule_work() or schedule_delayed_work()
would fix that up.
