Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264120AbTI2SA6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 14:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbTI2R6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:58:49 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:33274 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264051AbTI2Ryt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:54:49 -0400
Date: Mon, 29 Sep 2003 13:54:46 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030929135446.F539@devserv.devel.redhat.com>
References: <20030924001334.A19940@devserv.devel.redhat.com> <Pine.LNX.4.44.0309271332080.2874-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0309271332080.2874-100000@localhost.localdomain>; from marcelo.tosatti@cyclades.com on Mon, Sep 29, 2003 at 02:48:33PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Mon, 29 Sep 2003 14:48:33 -0300 (BRT)
> From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

> > > Date: Tue, 23 Sep 2003 13:15:15 -0700
> > > From: Chris Wright <chrisw@osdl.org>
> > 
> > > --- 1.38/sound/oss/ymfpci.c	Tue Aug 26 09:25:41 2003
> > > +++ edited/sound/oss/ymfpci.c	Tue Sep 23 12:42:45 2003
> > > @@ -2638,6 +2638,7 @@
> > >   out_free:
> > >  	if (codec->ac97_codec[0])
> > >  		ac97_release_codec(codec->ac97_codec[0]);
> > > +	kfree(codec);
> > >  	return -ENODEV;
> > 
> > Someone was savaging sound code, adding these bugs.
> > For 2.6, the above patch is probably ok; it's immaterial,
> > because ALSA won long ago.
> > 
> > A patch for 2.4 to undo the damage is attached.
> 
> So let me see if I get it right: The above "+ kfree(codec)" addition caused the bug?

No, bugs were added for 2.4.22 (a diff between 2.4.21 & .22
removes kfree's). Chris adds some kfrees back, but not all.

Also, 2.4.22 adds spinlocks around schedule(). My bigger patch
replaces them with semaphores, because interrupts are never
involved and they were done from a process context only.
However, Alan noted that ac97 operations can be called with
interrupts closed, and so the right approach is to retain
spinlocks, but replace schedule() with mdelay(). This is gonna
be one huge sleep under cli... Nonetheless, I'll send a better
patch soonish.

-- Pete
