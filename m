Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422806AbWJFSMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422806AbWJFSMv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422807AbWJFSMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:12:51 -0400
Received: from mx2.rowland.org ([192.131.102.7]:27656 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1422806AbWJFSMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:12:50 -0400
Date: Fri, 6 Oct 2006 14:12:49 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
cc: Jaroslav Kysela <perex@suse.cz>, Andrew Morton <akpm@osdl.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>,
       Castet Matthieu <castet.matthieu@free.fr>
Subject: Re: [Alsa-devel] [PATCH] Driver core: Don't ignore error returns
 from probing
In-Reply-To: <20061006131443.473c203c@gondolin.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610061400180.1311-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2006, Cornelia Huck wrote:

> On Fri, 6 Oct 2006 11:41:05 +0200 (CEST),
> Jaroslav Kysela <perex@suse.cz> wrote:
> 
> > > Hm, I don't think we should call device_release_driver if
> > > bus_attach_device failed (and I think calling bus_remove_device if
> > > bus_attach_device failed is unintuitive). I did a patch that added a
> > > function which undid just the things bus_add_device did (here:
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=115816560424389&w=2),
> > > which unfortunately got lost somewhere... (I'll rebase and resend.)

I'm still not sure why bus_attach_device() was split off from 
bus_add_device() in the first place.  Was it just so that the 
kobject_uevent() call could go in between?

Is there any reason they couldn't be recombined into a single function?

> > Yes, but it might be better to check dev->is_registered flag in 
> > bus_remove_device() before device_release_driver() call to save some code, 
> > rather than reuse most of code in bus_delete_device().

Agreed; I don't like the duplication of code.  It's wasteful and 
error-prone (somebody might change one routine and not the other).

> If we undid things (symlinks et al.) in the order we added them, we can
> factor out bus_delete_device() from bus_remove_device() and avoid both
> code duplication and calling bus_remove_device() if bus_attach_device()
> failed. Something like the patch below (untested).

This looks okay, but it would be better if bus_remove_device() did not
directly call bus_delete_device().  Just add an extra call inside
device_del(), so that everything remains symmetrical.

While I'm harping on style issues, you should also capitalize AttachError
so that it matches the form of the other statement labels nearby.  And in
bus_remove_device() you should put all the code inside the "if" block
instead of returning when dev->bus isn't set, just as the neighboring
subroutines do.

Alan Stern

