Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261563AbTCOUuR>; Sat, 15 Mar 2003 15:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261565AbTCOUuR>; Sat, 15 Mar 2003 15:50:17 -0500
Received: from pcp02781107pcs.eatntn01.nj.comcast.net ([68.85.61.149]:20210
	"EHLO linnie.riede.org") by vger.kernel.org with ESMTP
	id <S261563AbTCOUuQ>; Sat, 15 Mar 2003 15:50:16 -0500
Date: Sat, 15 Mar 2003 16:01:20 -0500
From: Willem Riede <wrlk@riede.org>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: dan carpenter <d_carpenter@sbcglobal.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Any hope for ide-scsi (error handling)?
Message-ID: <20030315210120.GI7082@linnie.riede.org>
Reply-To: wrlk@riede.org
References: <Pine.LNX.4.50.0303151343140.9158-100000@montezuma.mastecende.com> <200303151926.h2FJQLnB103490@pimout1-ext.prodigy.net> <Pine.LNX.4.50.0303151453010.9158-100000@montezuma.mastecende.com> <200303152012.h2FKCulK283698@pimout2-ext.prodigy.net> <Pine.LNX.4.50.0303151519240.9158-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.50.0303151519240.9158-100000@montezuma.mastecende.com>; from zwane@holomorphy.com on Sat, Mar 15, 2003 at 15:23:04 -0500
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003.03.15 15:23 Zwane Mwaikambo wrote:
> On Sat, 15 Mar 2003, dan carpenter wrote:
> 
> > > Apart from the schedule with the ide_lock held, what is that code actually
> > > doing?
> > >
> > > 	Zwane
> > 
> > Hm...  Good question.  I have no idea what the while loop is for.
> 
> I suppose the magik is in the comments;
> 
> /* first null the handler for the drive and let any process
>  * doing IO (on another CPU) run to (partial) completion
>  * the lock prevents processing new requests */
> 
Indeed. If you get there, the command in progress is hung.
To be able to restart the device, the old command needs to be
aborted. But that is an inherently racy undertaking. 

Nominally, I just want to set HWGROUP(drive)->handler = NULL.
But there is a small chance, that there is actually (interrupt) 
activity going on for the command, which would result in a new 
entry in HWGROUP(drive)->handler popping up after it is cleared.

The loop as programmed significantly increases the odds that 
the old command is really aborted. 

It may not be elegant to schedule(1) with the lock taken, but it
does work.

However, my latest patch doesn't seem to be applied, since in my
version I have a set_current_state(TASK_INTERRUPTIBLE); before 
the schedule.

Regards, Willem Riede.
