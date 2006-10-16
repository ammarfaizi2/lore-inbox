Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWJPP4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWJPP4b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWJPP4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:56:31 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:32527 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932138AbWJPP4a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:56:30 -0400
Date: Mon, 16 Oct 2006 11:56:29 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
cc: Duncan Sands <duncan.sands@math.u-psud.fr>, Greg K-H <greg@kroah.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/3] Driver core: Per-subsystem multithreaded probing.
In-Reply-To: <20061016172631.47d3eb70@gondolin.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610161135050.7648-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006, Cornelia Huck wrote:

> On Mon, 16 Oct 2006 10:59:28 -0400 (EDT),
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > That's not quite true.  You could acquire dev->parent->sem always, just to
> > be certain.  
> 
> But dev->parent->sem wouldn't be taken in the non-multithreaded path,
> so we would change the semantics.

You would only be changing it for the multithreaded path, which itself is 
very new.  But this is all hypothetical anyway...


> > Some other things were left out of the patch.  Since we can no longer know 
> > whether any drivers will get bound at all, device_attach() should now 
> > return void.
> 
> But device_bind_driver() may still return an error, if creating the
> links failed.

So the question is what do do if someone calls device_register() or
device_add() with dev->driver set.  If everything succeeds except for
creation of the symlinks, should the device remain registered?  The driver
core has been vacillating about this recently.  I'm not sure what the 
right answer is.

However the kerneldoc for device_attach() should be updated to mention
that when multithreaded probing is used, a driver might end up getting
bound even though the return value is 0.

Alan Stern

P.S.: If you initialize probe_task to ERR_PTR(-ENOMEM) or something 
similar, then you could eliminate one of the calls to bus_for_each_drv() 
in device_attach().

