Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbUJYGd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbUJYGd1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 02:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUJYGaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 02:30:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:39886 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261591AbUJYG0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 02:26:43 -0400
Subject: Re: Concerns about our pci_{save,restore}_state()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <417C991C.2070806@pobox.com>
References: <1098677182.26697.21.camel@gaston>  <417C991C.2070806@pobox.com>
Content-Type: text/plain
Date: Mon, 25 Oct 2004 16:24:24 +1000
Message-Id: <1098685464.26695.32.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-25 at 02:11 -0400, Jeff Garzik wrote:
> Benjamin Herrenschmidt wrote:
> >  - What about saving/restoring more registers ? I'm not sure wether it
> > should be the responsibility of the driver to save and restore things
> > above dword 15, but we should at least deal with the case of P2P bridges
> > who have more "standard" registers
> 
> 
> This is a key concern of mine.
> 
> The _driver_ is the only entity that knows really how much space to 
> save/restore, and the generic versions are obviously _not_ sufficient to 
> support:
> 
> * hardware errata such as S3 Trio, where _reading_ or writing certain 
> registers in the standard range cause a system lockup

Currently, the default does nothing (doesn't even save/restore). It
would be nice if it did though, in absence of a driver, eventually with
a quirk call, so we can add "workarounds" for things like the S3 without
having a full pci_driver for it (it may well be using vgacon).

> * saving/restoring the standard-defined capability lists, which 
> certainly could extend way beyond what's stored now

Apple in Darwin doesn't quite bother apparently... If there is more to
save/restore, it's expected that you have a driver doing it, however,
they definitely do have the default save/restore P2P bridges. In fact,
they even (and I'll need that for pmac too), have a separate "hook" that
allow restoring all P2P bridges outside of the normal loop which is to
be called by the arch code early during resume. Can be necessary to
access some on-board things like the ACPI controller I suppose, on
pmacs, it's for accessing the "mac-io" IO chip early during resume to
re-enable various clocks.

> * saving/restoring the new PCI-Express 4K config area

Ok, I don't know about that one.

> This is _clearly_ something that should be decided upon in the driver. 
> The PCI layer should _only_ present standard helper functions, and maybe 
> a standard storage space that works for most drivers; not force all 
> drivers through a narrow funnel.

Agreed. However, my concern is to have some "default" stuff that will
take over in absence of a driver. This is, I think, important for things
like P2P bridges which are rather standard and will usually survive well
with a simple save/retore of whatever is there. I suppose it would be
interesting to define a pair of quirk types to hook on the "default"
implementation, unless we actually want to have a bunch of pci_driver's
just for things that don't have normally a driver but need some specific
save/restore procedure ...

Ben.


