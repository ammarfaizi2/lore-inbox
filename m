Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWJAS2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWJAS2u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 14:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWJAS2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 14:28:49 -0400
Received: from mout2.freenet.de ([194.97.50.155]:31691 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S932165AbWJAS2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 14:28:48 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net
Subject: Re: [PATCH] Reset file->f_op in snd_card_file_remove(). Take 2
Date: Sun, 1 Oct 2006 20:29:36 +0200
User-Agent: KMail/1.9.4
Cc: mingo@elte.hu
References: <200609282228.02611.annabellesgarden@yahoo.de> <200609291429.21183.annabellesgarden@yahoo.de> <s5hbqoy4z9g.wl%tiwai@suse.de>
In-Reply-To: <s5hbqoy4z9g.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QkAIFl6BUuXjgyy"
Message-Id: <200610012029.36694.annabellesgarden@yahoo.de>
X-Warning: yahoo.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_QkAIFl6BUuXjgyy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Freitag, 29. September 2006 14:45 schrieb Takashi Iwai:
> At Fri, 29 Sep 2006 14:29:20 +0200,
> Karsten Wiese wrote:
> > 
> > Am Freitag, 29. September 2006 12:48 schrieb Takashi Iwai:
> > > At Thu, 28 Sep 2006 22:28:02 +0200,
> > > Karsten Wiese wrote:
> > > > 
> > > > Hi
> > > > 
> > > > It oopses with 2.6.18-rt4 + alsa-kernel-1.0.13rc3 now.
> > > > I wrote before, 2.6.18-rt3 + alsa-driver-1.0.13rc3 would be ok,
> > > > but its not. bug showed again reliably under memory-pressure.
> > > > 
> > > >       Karsten
> > > > 
> > > > ===
> > > > 
> > > > Reset file->f_op in snd_card_file_remove(). Take 2
> > > > 
> > > > 
> > > > i think what happens here is:
> > > > 
> > > >   us428control runs, kernel has allocated a struct file for /dev/hwC1D0.
> > > > 
> > > >   usb disconnect
> > > > 
> > > >   snd_usb_usx2y calls snd_card_disconnect,
> > > >   tells us428control to exit.
> > > > 
> > > >   snd_card_disconnect replaces /dev/hwC1D0's file->f_op
> > > >   with a kmalloc()ed version, that would only allow releases.
> > > > 
> > > >   us428control starts exiting
> > > > 
> > > >   __fput is called with struct file for /dev/hwC1D0.
> > > > 
> > > >   snd_card_file_remove() is called, alsa notices struct file
> > > >   for /dev/hwC1D0 is about to be closed.
> > > >   with patch below, file->f_op would be set NULL now.
> > > > 
> > > >   snd_usb_usx2y's free()s snd_card instance and /dev/hwC1D0's
> > > >   file->f_ops, those that would only allow releases.
> > > > 
> > > >   for reason I would like to know,
> > > >   __fput is called again with struct file for /dev/hwC1D0
> > > >   from us428control's do_exit().
> > > >   __fput see's file->f_op is still set.
> > > >   Without patch and under memory pressure, file->f_op can
> > > >   point to anything now.
> > > > 
> > > > 
> > > > Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
> > > 
> > > I guess this bug is fixed by Florin's patch below, juding from your
> > > explanation.  Could you check it?
> > > 
> > Florin's patch fixes it.
> > 
> > This one for immediate consumation by mainline, mm, rt,
> > and the stable teams, hmm?
> 
> It'll be pushed to mainline soon together with other ALSA fixes.  Then
> I'll forward to stable, too.
> 
bug is back. Florin's patch _is_ right.
And installed, unless im getting confuzed.
To help me proove,
please consider this controll of flow:

	usb disconnect

	usX2Y_usb_disconnect() calls snd_card_free(card);

	snd_card_free waits:
		wait_event(card->shutdown_sleep, card->files == NULL);

	us428control starts exiting, closes /dev/hwC1D0, calls __fput.
	__fput calls snd_hwdep_release,
	snd_hwdep_release calls snd_card_file_remove.
	snd_card_file_remove sees lastclose is set, does
		wake_up(&card->shutdown_sleep);

lets assume, snd_card_free's thread prio is FIFO, we are on UP
and us428control' prio is not FIFO:

What keeps snd_card_free from waking up now, deleting /dev/hwC1D0's
file->f_op _before_  __fput is rescheduled,
seeing a set but freeed file->f_op?

Attached crash dmesg also has "BUG: time warp detected!", but that BUG
is propably unrelated.


      Karsten






--Boundary-00=_QkAIFl6BUuXjgyy
Content-Type: application/x-bzip2;
  name="crash9.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="crash9.bz2"

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
cHSDtf/F3JFOFCQbcfViwA==

--Boundary-00=_QkAIFl6BUuXjgyy--
