Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbUKWVwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbUKWVwv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 16:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbUKWVu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 16:50:28 -0500
Received: from 82-43-72-5.cable.ubr06.croy.blueyonder.co.uk ([82.43.72.5]:8188
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S261292AbUKWVtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 16:49:32 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: Jens Axboe <axboe@suse.de>
Subject: Re: ide-cd problem
Date: Tue, 23 Nov 2004 21:49:31 +0000
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200411201842.15091.alan@chandlerfamily.org.uk> <200411230713.32013.alan@chandlerfamily.org.uk> <20041123145112.GC13174@suse.de>
In-Reply-To: <20041123145112.GC13174@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411232149.31701.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 November 2004 14:51, Jens Axboe wrote:
> On Tue, Nov 23 2004, Alan Chandler wrote:
> > On Monday 22 November 2004 23:48, Alan Chandler wrote:
> > ...
> >
> > > If I make the delay 600ns it works - I guess my hardware is a little
> > > off spec.
> >
> > I did a binary chop on the value to find the cut off point between what
> > works and what doesn't.  Its approx 535ns (534 failed, 537 worked).
> >
> > All this was with 2.6.9,
> >
> > 2.6.10-rc2 is still failing during the cd initialisation on boot.  Here I
> > tried with bot 600ns and 700ns delays in drive_is_ready, but both values
> > fail with what looks like missed interrupts.  I'll try instrumenting this
> > a bit more to find out what is happening.
>
> It's getting more and more interesting! Look forward to hearing what
> your instrumentation brings.
>
> There are other reports of acpi causing interrupt problems with cdroms
> in 2.6.10-rc2, so it would be best if you stuck to 2.6.9 for testing
> this particular problem.

There is good and bad news related to 2.6.10-rc2

The good news is that the acpi problem was the cause of the startup issues.  
adding pci=noacpi to the boot command line fixed that.

The bad news is that with the delay at 800ns in drive_is_ready() I am getting 
the exact same symptoms I got with 2.6.9 before upping the delay to over 
540ns.

Before, I thought my hardware was a little out of spec - now I think there is 
something else at play here.

Firstly, the symptoms are the same between 2.6.9 and 2.6.10-rc2.  The halt 
seem to always be in exactly the same place. If it was a timing problem I 
would have thought it would have varied.

Secondly, the command before seems to have an expectation of a 2048 transfer 
rather than the 0 in the command, before the problem and then you get the 
strange DRQ=1 but 0 in the len register.

Nov 23 20:37:33 kanger kernel: ide-cd:ide_do_rq_cdrom - cmd = 0x0
Nov 23 20:37:33 kanger kernel: ide-cd:cdrom_newpc_intr - cmd=0x0 stat=0x50 
ireason=3 len=2048 rq len=0
Nov 23 20:37:33 kanger kernel: ide-cd:ide_do_rq_cdrom - cmd = 0x1b
Nov 23 20:37:33 kanger kernel: ide-cd:cdrom_newpc_intr - cmd=0x1b stat=0x58 
ireason=2 len=0 rq len=0

I have got myself a copy of the ATA/ATAPI spec (document T13/1410D revision 
3), I think I need to read more of it to understand what is the code is 
trying to do.



-- 
Alan Chandler
alan@chandlerfamily.org.uk
First they ignore you, then they laugh at you,
 then they fight you, then you win. --Gandhi
