Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbUC3RKA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 12:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263767AbUC3RJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 12:09:59 -0500
Received: from bad-attitude.baracus.preventsys.com ([207.158.60.2]:42958 "HELO
	face.preventsys.com") by vger.kernel.org with SMTP id S263765AbUC3RJo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 12:09:44 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: NULL pointer in proc_pid_stat -- oops.
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Tue, 30 Mar 2004 09:09:41 -0800
Message-ID: <8758F8D58219684FAB0239EE8967048A4A7D6A@calculon.preventsys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: NULL pointer in proc_pid_stat -- oops.
Thread-Index: AcQU5iPbvhwgjuNcQUGjPXfVfl9IwgBk2ayg
From: "Andrew Reiter" <areiter@preventsys.com>
To: "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, I was getting confused since proc_pid_status() is directly above
proc_pid_stat() in fs/proc/array.c, so I misinterpreted some of the
asm<-->C translation and was stating we were dying in task_name().
Sorry for the confusion.  Will apply Ricky's patch for now as a work
around as it seems fine to me for the moment.

Thanks for the help... 

Cheers,
Andrew

-----Original Message-----
From: OGAWA Hirofumi [mailto:hirofumi@mail.parknet.co.jp] 
Sent: Sunday, March 28, 2004 9:00 AM
To: Andrew Reiter
Cc: linux-kernel@vger.kernel.org
Subject: Re: NULL pointer in proc_pid_stat -- oops.


"Andrew Reiter" <areiter@preventsys.com> writes:

> 0x000004d4 <proc_pid_stat+124>: test   %ecx,%ecx
> 0x000004d6 <proc_pid_stat+126>: je     0x510 <proc_pid_stat+184>
> 0x000004d8 <proc_pid_stat+128>: mov    0x98(%ecx),%eax
> 0x000004de <proc_pid_stat+134>: mov    %eax,0x20(%esp,1)
> 0x000004e2 <proc_pid_stat+138>: mov    0x4(%ecx),%edx
> 0x000004e5 <proc_pid_stat+141>: movswl 0x64(%edx),%eax
> 0x000004e9 <proc_pid_stat+145>: movswl 0x66(%edx),%edx
> 0x000004ed <proc_pid_stat+149>: shl    $0x14,%eax
> 0x000004f0 <proc_pid_stat+152>: or     %edx,%eax
> 0x000004f2 <proc_pid_stat+154>: add    0x8(%ecx),%eax
> 
> And from the oops trace output (that is attached), we can see that
%edx
> is 0x0; so we can easily see here why we're crashing at least.  After
> examining the C source, I see that we're dying in the call to
> task_name() (inline) from proc_pid_stat().

Looks like this problem is same with BSD acct Oops.

	if (task->tty) {
		tty_pgrp = task->tty->pgrp;
		tty_nr = new_encode_dev(tty_devnum(task->tty));
	}

Some place doesn't take the any lock for ->tty. I think we need to
take the lock for ->tty.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
