Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWIYPrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWIYPrH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 11:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWIYPrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 11:47:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36307 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751028AbWIYPrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 11:47:06 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1159198774.11049.87.camel@localhost.localdomain> 
References: <1159198774.11049.87.camel@localhost.localdomain>  <1159186771.11049.63.camel@localhost.localdomain> <1159183568.11049.51.camel@localhost.localdomain> <20060924223925.GU29920@ftp.linux.org.uk> <22314.1159181060@warthog.cambridge.redhat.com> <5578.1159183668@warthog.cambridge.redhat.com> <7276.1159186684@warthog.cambridge.redhat.com> <20060925142016.GI29920@ftp.linux.org.uk> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Al Viro <viro@ftp.linux.org.uk>, David Howells <dhowells@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore libata build on frv 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 25 Sep 2006 16:45:38 +0100
Message-ID: <22061.1159199138@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > Fine by me.  In that case we need to add
> > 	depends on !FRV || BROKEN
> > to drivers/ata/Kconfig and be done with that.  BTW, empty libata-portmap.h
> > is equivalent to absent one - it still won't build.
> 
> From every public piece of info I can find and from looking at the FRV
> tree your changes are correct for the ports Al. I can't find any info on
> how legacy IRQ routing is done on FRV systems but if it is not then set
> the IRQ values to zero and maybe Dave will stop complaining.

Sigh.

On FRV, inX() and outX() take fully qualified memory-space addresses, exactly
as readX() and writeX() (in/out just wrap readX/writeX).  This is because:

 (1) The FRV has a limited number of static mappings, and these have to specify
     _all_ access windows to I/O, RAM, ROM, etc.  The FRV arch uses a single
     mapping to handle *all* I/O (which happens to be through the region from
     0xE0000000 to 0xFFFFFFFF) thus allowing it to use the remaining mappings
     for other purposes.

 (2) inX() and outX() would have to adjust the addresses to otherwise make
     them appear PC compatible.  Making in() and out() just pass the addresses
     straight through means I don't have to do any calculation on the address
     in order to use it.

inb(0x1F0) will, for example, oops because there's no mapping for the bottom
virtual megabyte to anywhere, otherwise NULL pointer detection would not be
possible.

Don't forget, also, that things like FRV systems generally _won't_ have
pluggable PCI buses, and so any devices attached to it will be known in
advance, and generalisations can be waived.

David
