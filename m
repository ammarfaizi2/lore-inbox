Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129518AbQKHAqE>; Tue, 7 Nov 2000 19:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130356AbQKHApo>; Tue, 7 Nov 2000 19:45:44 -0500
Received: from catbert.rellim.com ([204.17.205.1]:23556 "EHLO
	catbert.rellim.com") by vger.kernel.org with ESMTP
	id <S129518AbQKHApm>; Tue, 7 Nov 2000 19:45:42 -0500
Date: Tue, 7 Nov 2000 16:45:21 -0800 (PST)
From: "Gary E. Miller" <gem@rellim.com>
To: Mike Galbraith <mikeg@wen-online.de>
cc: MOLNAR Ingo <mingo@chiara.elte.hu>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] deadlock fix
In-Reply-To: <Pine.Linu.4.10.10011040506240.793-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.30.0011071633250.16069-100000@catbert.rellim.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yo All!

I see this patch did not make it into test11-pre1.  Without it
raid1 and SMP do not work together.  Please consider for test11-pre2.

RGDS
GARY
---------------------------------------------------------------------------
Gary E. Miller Rellim 20340 Empire Ave, Suite E-3, Bend, OR 97701
	gem@rellim.com  Tel:+1(541)382-8588 Fax: +1(541)382-8676

> > > Here it is.
> > >
> > > --- drivers/md/raid1.c.org	Wed Oct 18 15:30:07 2000
> > > +++ drivers/md/raid1.c	Wed Oct 18 15:33:08 2000
> > > @@ -91,7 +91,8 @@
> > >
> > >  static inline void raid1_free_bh(raid1_conf_t *conf, struct buffer_head *bh)
> > >  {
> > > -	md_spin_lock_irq(&conf->device_lock);
> > > +	unsigned long flags;
> > > +	md_spin_lock_irqsave(&conf->device_lock, flags);
> > >  	while (bh) {
> > >  		struct buffer_head *t = bh;
> > >  		bh=bh->b_next;
> > > @@ -103,7 +104,7 @@
> > >  			conf->freebh_cnt++;
> > >  		}
> > >  	}
> > > -	md_spin_unlock_irq(&conf->device_lock);
> > > +	md_spin_unlock_irqrestore(&conf->device_lock, flags);
> > >  	wake_up(&conf->wait_buffer);
> > >  }
>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
