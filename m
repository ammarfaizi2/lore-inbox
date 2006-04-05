Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWDENRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWDENRI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 09:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWDENRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 09:17:08 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21512 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751005AbWDENRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 09:17:08 -0400
Date: Wed, 5 Apr 2006 15:17:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Eric Sesterhenn <snakebyte@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Pointer dereference in net/irda/ircomm/ircomm_tty.c
Message-ID: <20060405131706.GB8673@stusta.de>
References: <1143067566.26895.8.camel@alice> <20060322232247.GD7790@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322232247.GD7790@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 02:22:47AM +0300, Alexey Dobriyan wrote:
> On Wed, Mar 22, 2006 at 11:46:05PM +0100, Eric Sesterhenn wrote:
> > this fixes coverity bugs #855 and #854. In both cases tty
> > is dereferenced before getting checked for NULL.
> 
> Before Al will flame you,
> 
> IMO, what should be done is removing asserts checking for "self",
> because ->driver_data is filled in ircomm_tty_open() with valid pointer.

That's not what the Coverity checker is warning about.

It warns that "tty" is first dereferenced and later checked for NULL.

> > --- linux-2.6.16/net/irda/ircomm/ircomm_tty.c.orig
> > +++ linux-2.6.16/net/irda/ircomm/ircomm_tty.c
> > @@ -493,7 +493,7 @@ static int ircomm_tty_open(struct tty_st
> >   */
> >  static void ircomm_tty_close(struct tty_struct *tty, struct file *filp)
> >  {
> > -	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
> > +	struct ircomm_tty_cb *self;
> >  	unsigned long flags;
> >
> >  	IRDA_DEBUG(0, "%s()\n", __FUNCTION__ );
> > @@ -501,6 +501,8 @@ static void ircomm_tty_close(struct tty_
> >  	if (!tty)
> >  		return;
> >
> > +	self = (struct ircomm_tty_cb *) tty->driver_data;
> > +
> >  	IRDA_ASSERT(self != NULL, return;);
> >  	IRDA_ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
> >
> > @@ -1006,17 +1008,19 @@ static void ircomm_tty_shutdown(struct i
> >   */
> >  static void ircomm_tty_hangup(struct tty_struct *tty)
> >  {
> > -	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
> > +	struct ircomm_tty_cb *self;
> >  	unsigned long	flags;
> >
> >  	IRDA_DEBUG(0, "%s()\n", __FUNCTION__ );
> >
> > -	IRDA_ASSERT(self != NULL, return;);
> > -	IRDA_ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
> > -
> >  	if (!tty)
> >  		return;
> >
> > +	self = (struct ircomm_tty_cb *) tty->driver_data;
> > +
> > +	IRDA_ASSERT(self != NULL, return;);
> > +	IRDA_ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
> > +
> >  	/* ircomm_tty_flush_buffer(tty); */
> >  	ircomm_tty_shutdown(self);

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

