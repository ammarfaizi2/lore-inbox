Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264765AbUDWIts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264765AbUDWIts (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 04:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264766AbUDWItc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 04:49:32 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:38905 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S264765AbUDWItY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 04:49:24 -0400
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
To: ganzinger@mvista.com
Cc: akpm@osdl.org, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF4961FAC3.DE4EDE65-ONC1256E7F.002F1D0B-C1256E7F.003069AA@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Fri, 23 Apr 2004 10:48:47 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 23/04/2004 10:48:49
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> Here is where this thing falls down.  Some time ago I put together a tick
less
> system (which is what this amounts to).  The patch is still on
sourceforge (see
> the HRT URL in my signature).

On the HRT sourceforge page you'll find the i386 version of the tick less system
patch. The initial s390 patch can be found here:
http://www10.software.ibm.com/developerworks/opensource/linux390/current2_4_x-august2001.shtml#timer20031205

> On context switch the scheduler needs to figure the minimum time to the next
> event for the new task.  This would be the minimum of the remaining slice,
> profile timer, virtual time, and the cpu limit timer (at least).  It would then
> do an add_timer for this time.  On the next context switch it would, most
> likely, cancel the timer (most code does not run to the end of its slice which
> is the most likely limit).  The computation to find the minimum time, with a bit
> of hand waving, could be shortened to eliminate a few of the timers. On switch
> out, all the tasks timers would need to be updated with the actual time the task
> used.  The problem is that all this work is in the VERY lean and mean context
> switch path.  In my tests a context switching could easily occur often enough
> that the savings from not doing the tick interrupts was over whelmed by the
> added context switch over head with a medium cpu load.  And it is down hill from
> here.  I.e. the tick less system incurres accounting overhead in  direct
> proportion to the number of context switches, while the ticking system has a
> fixed accounting overhead.  AND the cross over point (where the tick less system
> overhead is more that the ticked system overhead) occurs with a medium load.

I do agree that is very likely a bad idea to do a tick less system for i386 and
friends. I still haven't given up the idea for s390 though. I plan to use the
cpu timer for all the process related stuff and the clock comparator for the
wall clock. This adds just two instructions to the system call entry path:
a store cpu timer "stpt" and a set cpu timer "spt" to switch from the process
cpu timer to the system cpu timer. The overhead is 27 cycles and benefit is
no more ticks and a much more accurate process accounting. This requires some
major surgery in the common timer code. I'm going to have fun with this.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


