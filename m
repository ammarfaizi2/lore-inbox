Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282981AbRLHI6H>; Sat, 8 Dec 2001 03:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282953AbRLHI55>; Sat, 8 Dec 2001 03:57:57 -0500
Received: from avplin.lanet.lv ([195.13.129.97]:26819 "HELO avplin.lanet.lv")
	by vger.kernel.org with SMTP id <S282946AbRLHI5m>;
	Sat, 8 Dec 2001 03:57:42 -0500
Date: Sat, 8 Dec 2001 10:39:25 +0200 (WET)
From: Andris Pavenis <pavenis@lanet.lv>
To: Doug Ledford <dledford@redhat.com>
Cc: Nathan Bryant <nbryant@optonline.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i810_audio fix for version 0.11
In-Reply-To: <3C110C43.4000801@redhat.com>
Message-ID: <Pine.A41.4.05.10112081022560.23064-100000@ieva06>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, but this patch is still not OK. It still causes system
locking up for me.

In some cases I have (I added printk in __start_dac):
	dmabuf->count = 0
	dmabuf->ready = 1
	dmabuf->enable = 1
	PCM_ENABLE_OUTPUT set in dmabuf->triger

in __start_dac(). As result nothing was done in this procedure
and I got system locking in __i810_update_lvi() immediatelly after
that. This was reason why I added return code to __start_dac,
__start_adc to skip the loop if there is nothing to wait for.
Perhaps checking return code is more efficient and less error prone
that repeating all conditions in __i810_update_lvi. 

Maybe really we should use wait_event_interruptible() instead
of plain loop in __i810_update_lvi(). This happens not so often,
so I don't think it could cause too big delays. At least we could
avoid kernel freezing in this way.

Andris

On Fri, 7 Dec 2001, Doug Ledford wrote:

> Doug Ledford wrote:
> 
> > Well, unfortunately, neither of the patches you guys sent do what I 
> > was looking for ;-)  My goal with that code was to enable a specific 
> > certain behaviour, and because of the deadlock I have to make a few 
> > changes elsewhere for it to work properly.  The workaround patches are 
> > fine for now, but later today I'll make a 0.12 that fixes it the way 
> > I'm looking for.  (Hint: it's legal for a program to call SETTRIGGER 
> > to disable PCM output, then call the write() routine to fill the 
> > buffer, then call SETTRIGGER again to start output, otherwise known as 
> > pre buffering, and I want to support that without forcing the DAC to 
> > be started on update_lvi())
> >
> > The real answer is multipart:
> >
> > 1) during i810_open go back to the old behaviour of setting 
> > dmabuf->trigger to PCM_ENABLE_INPUT and/or OUTPUT based on file mode.
> >
> > 2) make sure that i810_mmap clears dmabuf->trigger
> >
> > 3) make sure that in both i810_write and i810_read, we force the 
> > trigger setting when we can't output/input any data because count <= 0
> >
> > 4) in update_lvi make the check something like:
> >
> > if (!dmabuf->enable && dmabuf->trigger) {
> >    ....
> > }
> >
> > That should solve the problem, I just haven't written it up yet.
> >
> >
> >
> OK, the attached patch should do what is mentioned above.
> 
> Doug Ledford
> 
> 



