Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266749AbUG1Xak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266749AbUG1Xak (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 19:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267327AbUG1X1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 19:27:12 -0400
Received: from mail.convergence.de ([212.84.236.4]:59617 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S266749AbUG1XX4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 19:23:56 -0400
Date: Thu, 29 Jul 2004 01:24:53 +0200
From: Johannes Stezenbach <js@convergence.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm1
Message-ID: <20040728232453.GA6377@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040728020444.4dca7e23.akpm@osdl.org> <20040728222455.GC5878@convergence.de> <20040728224423.GJ12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728224423.GJ12308@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 11:44:23PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Thu, Jul 29, 2004 at 12:24:55AM +0200, Johannes Stezenbach wrote:
> > Signed-off-by: Johannes Stezenbach <js@convergence.de>
> > 
> > --- linux-2.6.8-rc2/drivers/media/dvb/dvb-core/dvb_functions.c.orig	2004-07-29 00:19:50.000000000 +0200
> > +++ linux-2.6.8-rc2/drivers/media/dvb/dvb-core/dvb_functions.c	2004-07-29 00:20:05.000000000 +0200
> > @@ -36,7 +36,7 @@ int dvb_usercopy(struct inode *inode, st
> >          /*  Copy arguments into temp kernel buffer  */
> >          switch (_IOC_DIR(cmd)) {
> >          case _IOC_NONE:
> > -                parg = NULL;
> > +                parg = (void *) arg;
> 
> Mind explaining why it is the right thing to do?  You are creating a kernel
> pointer out of value passed to you by userland and feed it to a function
> that expects a kernel pointer.  Which is an invitation for trouble - if
> it ends up dereferenced, we are screwed and won't notice that.

This is a hack introduced by someone years ago. The "pointer" is
actually an integer argument, e.g. in include/linux/dvb/audio.h:

#define AUDIO_SET_MUTE             _IO('o', 6)

actually takes an integer argument (!0 mute, 0 unmute), so one can write

	if (ioctl(fd, AUDIO_SET_MUTE, 1) == -1)
		perror("mute");

It is unusual (maybe even wrong?), but we cannot change it without
losing binary API compatibility. However, I see that sparse might
flag this as a possible bug :-(

Johannes
