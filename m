Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbUDTJGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUDTJGa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 05:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbUDTJGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 05:06:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:38060 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262422AbUDTJFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 05:05:30 -0400
Date: Tue, 20 Apr 2004 11:05:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Warren Togami <wtogami@redhat.com>
Cc: Markus Lidel <Markus.Lidel@shadowconnect.com>,
       Arjan van de Ven <arjanv@redhat.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] i2o_block Fix, possible CFQ elevator problem?
Message-ID: <20040420090523.GE25806@suse.de>
References: <4083BA03.1090606@redhat.com> <20040419121225.GT1966@suse.de> <408471E2.8060201@redhat.com> <40848159.7090605@togami.com> <20040420070805.GC25806@suse.de> <4084D83D.8060405@redhat.com> <20040420080325.GD25806@suse.de> <4084E671.4090509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4084E671.4090509@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19 2004, Warren Togami wrote:
> Jens Axboe wrote:
> >>We figured removing error handling was not safe, the previous post was 
> >>only reporting test results to ask for more suggestions.  I have now 
> >>tested your suggested patch above and it seems to crash in the same way 
> >>as originally.
> >>
> >>http://togami.com/~warren/archive/2004/i2o_cfq_quad_bonnie2.txt
> >
> >
> >As a temporary safe work-around, you can apply this patch.
> >
> >
> >>This makes me curious, the other elevators lacked this type of error 
> >>checking.  Did this mean they were possibly allowing data corruption to 
> >>happen with buggy drivers like this?  Kind of scary!  We were lucky to 
> >>test this now, because this was one of the first FC kernels that 
> >>included cfq by default.
> >
> >
> >Not necessarily, it's most likely a CFQ bug. Otherwise it would have
> >surfaced before :-)
> >
> 
> I forgot to mention in the previous reports:
> 
> Prior to three of your original suggested cleanups of i2o_block, four 
> simultaneous bonnie++'s on four independent arrays would almost 
> immediately cause the crash while running elevator=cfq.  After those 
> three cleanups four simultaneous bonnie++ would survive for a while 
> without crashing... until you run "sync" in another terminal.  We 
> however did not test it enough times to determine if without "sync" it 
> can survive the test run.  Do you want this tested without "sync"?

Repeat the tests that made it crash. The last patch I sent should work
for you, at least until the real issue is found.

> With the deadline scheduler "sync" would take maybe 30 seconds and 
> return.  With the cfq scheduler "sync" would be stuck there for much 
> longer, then trigger the crash.  Markus has suspected that it crashes 
> when sync returns, but we have not confirmed that.

Probably not the case. Running sync only initiates the dirty data
flushing, the actual write out happens out of that context. So it's
probably just running the sync that changes the timings a little bit,
triggering the bug.

-- 
Jens Axboe

