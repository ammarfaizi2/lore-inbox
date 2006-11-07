Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752255AbWKGMiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbWKGMiH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 07:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753048AbWKGMiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 07:38:07 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43020 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752255AbWKGMiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 07:38:04 -0500
Date: Tue, 7 Nov 2006 13:38:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [Alsa-devel] [2.6 patch] sound/core/control.c: remove dead code
Message-ID: <20061107123806.GE8099@stusta.de>
References: <20061106183018.GB8099@stusta.de> <s5h8xinfsez.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h8xinfsez.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 11:43:48AM +0100, Takashi Iwai wrote:
> At Mon, 6 Nov 2006 19:30:18 +0100,
> Adrian Bunk wrote:
> > 
> > This patch removes some obviously dead code spotted by the Coverity 
> > checker.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> I think it's a wrong fix.  result could be > 0 indeed.
> 
> Takashi
> 
> > 
> > --- linux-2.6/sound/core/control.c.old	2006-11-06 19:11:32.000000000 +0100
> > +++ linux-2.6/sound/core/control.c	2006-11-06 19:11:52.000000000 +0100
> > @@ -1267,23 +1267,23 @@ static ssize_t snd_ctl_read(struct file 
> >  			if ((file->f_flags & O_NONBLOCK) != 0 || result > 0) {

That is already checked here ->                                  ^^^^^^^^^^

And after this point, result is never assigned any value.

> >  				err = -EAGAIN;
> >  				goto __end_lock;
> >  			}
> >  			init_waitqueue_entry(&wait, current);
> >  			add_wait_queue(&ctl->change_sleep, &wait);
> >  			set_current_state(TASK_INTERRUPTIBLE);
> >  			spin_unlock_irq(&ctl->read_lock);
> >  			schedule();
> >  			remove_wait_queue(&ctl->change_sleep, &wait);
> >  			if (signal_pending(current))
> > -				return result > 0 ? result : -ERESTARTSYS;
> > +				return -ERESTARTSYS;
> >  			spin_lock_irq(&ctl->read_lock);
> >  		}
> >  		kev = snd_kctl_event(ctl->events.next);
> >  		ev.type = SNDRV_CTL_EVENT_ELEM;
> >  		ev.data.elem.mask = kev->mask;
> >  		ev.data.elem.id = kev->id;
> >  		list_del(&kev->list);
> >  		spin_unlock_irq(&ctl->read_lock);
> >  		kfree(kev);
> >  		if (copy_to_user(buffer, &ev, sizeof(struct snd_ctl_event))) {
> >  			err = -EFAULT;
> > 

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

