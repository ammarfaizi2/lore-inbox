Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbTEGJQZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 05:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbTEGJQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 05:16:25 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:9994 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263016AbTEGJQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 05:16:24 -0400
Date: Wed, 7 May 2003 10:28:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Hunold <hunold@convergence.de>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH[[2.5][3-11] update dvb subsystem core
Message-ID: <20030507102857.C14040@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Hunold <hunold@convergence.de>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <3EB7DCF0.2070207@convergence.de> <20030506214918.A18262@infradead.org> <3EB8CFA2.5090405@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EB8CFA2.5090405@convergence.de>; from hunold@convergence.de on Wed, May 07, 2003 at 11:19:30AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 11:19:30AM +0200, Michael Hunold wrote:
> The code does not behave differently. If DVB_DEVFS_ONLY is set, then the 
> old chardev register interface is omitted.

Which is a different behaviour, now you can't create a device node
manually anymor.  Also note that the feature you rely on here (devfs
presetting file->private_data) will go away in the next round of patches,
see Al Viro's patchit for a generic replacement that works with or
without devfs.

> > Just removing this makes the code even more incorrect.  You need to
> > add a ->owner member and call try_module_get on it before calling into
> > the module (and handle the return value..)
> 
> There is a functional dependency between the dvb-core and the actual dvb 
> driver. So there is no need to increase the module count of the dvb-core 
> if a new adapter is registered IMHO, because you cannot unload the 
> dvb-core before the driver anyway.

Okay, you're right I should have read more of the code to get the global
picture.  You still wan't an owner field for at least struct dvb_device
device, though - but the try_module_get must go into dvb_generic_open
and maybe in more other places where you use the "backend" modules.

