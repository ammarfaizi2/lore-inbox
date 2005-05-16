Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVEPUcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVEPUcD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVEPUcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:32:03 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:59884 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S261852AbVEPUbn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:31:43 -0400
Date: Mon, 16 May 2005 16:30:19 -0400 (Eastern Daylight Time)
From: Reiner Sailer <sailer@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
cc: davem@davemloft.net, herbert@gondor.apana.org.au,
       linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: crypto api initialized late
Message-ID: <Pine.WNT.4.63.0505161627130.820@laptop>
X-Warning: UNAuthenticated Sender
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris Wright <chrisw@osdl.org> wrote on 05/16/2005 04:03:17 PM:

> * Reiner Sailer (sailer@us.ibm.com) wrote:
> >
> > I am writing a Linux Security Module that needs SHA1 support very  early in
> > the kernel startup (before any fs are mounted,modules are loaded,  or
> > files are mapped; including initrd). Therefore, I use the __initcall
> > to initialize the security module. SHA1 can currently be used only
> > through the crypto-api (static definitions and hidden context structure).
> >
> > This crypto-API, however, initializes AFTER the security module
> > code in the __initicall block. Currently, I use the following patch into
> > the main Linux Makefile to start up the crypto-API earlier:
> >
> > diff -uprN linux-2.6.12-rc3_orig/Makefile
> > linux-2.6.12-rc3-ima-newpatch/Makefile
> > --- linux-2.6.12-rc3_orig/Makefile   2005-04-20 20:03:12.000000000 -0400
> > +++ linux-2.6.12-rc3-ima-newpatch/Makefile   2005-05-11
> > 15:18:32.000000000 -0400
> > @@ -560,7 +560,7 @@ export MODLIB
> >
> >
> >  ifeq ($(KBUILD_EXTMOD),)
> > -core-y      += kernel/ mm/ fs/ ipc/ security/ crypto/
> > +core-y      += kernel/ mm/ fs/ ipc/ crypto/ security/
>
> I'm surprised this helps at all.  Does this mean you are not using
> security_initcall() in your module?
>
> thanks,
> -chris

I use simply __initcall, which is the same level as the
module_initcall used in the crypto functions (sha1.c). Looking into
init.h, security_initcall should resolve to __initcall as well.

Changing the compile sequence orders, the crypto init and sha1
registration happens just ahead of my security module because
(so I assume) the order of the compilation determines the order
of the init calls inside the same initcall block.

Going later and using late_initcall, I seemed to sometimes loose
the mapping of the "nash" executed from the initrd.

Reiner

