Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbTGCObR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 10:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTGCObQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 10:31:16 -0400
Received: from verein.lst.de ([212.34.189.10]:41934 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263610AbTGCOad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 10:30:33 -0400
Date: Thu, 3 Jul 2003 16:44:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Holger Waechtler <holger@convergence.de>
Cc: linux-kernel@vger.kernel.org, Michael Hunold <hunold@convergence.de>,
       Johannes Stezenbach <js@convergence.de>
Subject: Re: Patch: replacing devfs_register(), please revert
Message-ID: <20030703144439.GA7744@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Holger Waechtler <holger@convergence.de>,
	linux-kernel@vger.kernel.org,
	Michael Hunold <hunold@convergence.de>,
	Johannes Stezenbach <js@convergence.de>
References: <3F0154BD.3040901@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F0154BD.3040901@convergence.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5 () EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 01, 2003 at 11:30:37AM +0200, Holger Waechtler wrote:
> Christoph, by applying the API change you announced in this mail you 
> significantly crippled the functionality of the devfs system.

I don't think crippling is the right term, but yes I've been removing
lots of functionality from devfs lately that belongs into different
layers.

> The first major problem is that you removed the option to pass a pointer 
> for file->private_data. This is usually worked around by static device 
> lookup tables (evil, they cost static memory, usually about 80% of this 
> memory is never used, in the remaining cases you are limited to 
> NUM_MAX_XXX_DEVICES) or device lists that are searched using the minor 
> number (still not very elegant).

I think I already explained this in a mail to Michael with lkml CC'ed..

Please take a look at drivers/base/map.c and fs/char_dev.c in some
recent 2.5 tree.  The map a dev_t to private data functionality has been
moved to common code now, devfs is a very wrong place for this.

> Even more serious is the fact that you removed the possibility to pass 
> the file operation struct on a per device basis.

Again, this was absolutely intentional.  We now have generic code to
map a dev_t to a struct file_operations and is horrible to duplicate
this in devfs.

> As side effect you always have to use both register_chrdev() and 
> devfs_mk_cdev() in a driver. Useless bloat and error prone.

No.  Remember that devfs is just _some_ way to represent device nodes
to userspace and not even the preferred one.  You always need to claim
a dev_t range and if you want to support devfs in your driver you can
also create a devfs node.

> The third limitation introduced by removing the possibility of automatic 
> major/minor allocation, the DEVFS_FL_AUTO_DEVNUM flag.
> 
> This causes an artificial limit in new DVB driver revisions to only 4 
> DVB adapters because of the limited number of available minor devices 
> per major. (we need up to 64 minors per DVB adapter in complex settop 
> box environments where we have multiple demultiplexers, MPEG decoders 
> and conditional access devices per adapter). I suppose similiarly 
> structured subsystems like the linux input subsystem will run in 
> similiar troubles.

Just use the proper APIs instead - that would be alloc_chrdev_region in
this case.

> Well, we could work around this by allocating multiple major numbers for 
> the DVB subsystem,

the major/minor split has become almost meaningless in Linux 2.5.  We
care about dev_t regions now.

> so please revert your changes, or even better -- implement something 
> like this:
> 
> extern int devfs_mk_node (dev_t proposed_major_minor,
>                           umode_t mode,
>                           struct file_operations *fops,
>                           void *private_data,
>                           const char *fmt, ...);

no.  devfs has no business knowing about driver private data or
file operations - that's for a different layer.

> You don't need any devfs_mk_dir() function anymore.

There's still two places it is needed, and I haven't yet decided about
some API changes that might make it mandatory in most drivers.

> @Christoph: Sorry for the harsh tone, but your ignorance and arrogance 
> caused about 6 men-weeks useless work and workarounds in the DVB 
> subsystem code

Maybe you should try to work with kernel people instead of agains us?
I remember I tried to explain you all the API changes in detail and
even explained you the old devfs APIs you didn't understand until you
tried to piss me off as much as possible.  After that fortunately
Michael took over representing dvb to lkml and I had absolutely no
problems working with him.

> (many thanks to Michael for his patience with your 
> person), we just don't have the menpower to work around your toy API 
> changes just for fun. We have 3 support for 4 new types of DVB PCI and 
> USB adapters in the pipeline, we support a few more frontends but these 
> patches are now delayed since months. Please keep compabitlity with 
> existing APIs in mind when you break things next time.

Not with APIs as broken as the old devfs code, sorry.

> Functions that 
> get a different semantic should get a different name,

What functions got different semantics but kept the old name?

