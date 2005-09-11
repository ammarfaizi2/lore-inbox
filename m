Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932730AbVIKAeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932730AbVIKAeT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 20:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbVIKAeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 20:34:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7405 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932733AbVIKAeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 20:34:17 -0400
Date: Sat, 10 Sep 2005 17:27:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
In-Reply-To: <432377A3.5070805@pobox.com>
Message-ID: <Pine.LNX.4.58.0509101723550.30958@g5.osdl.org>
References: <Pine.LNX.4.44L0.0509101655520.7081-100000@netrider.rowland.org>
 <Pine.LNX.4.58.0509101410300.30958@g5.osdl.org> <43235707.7050909@pobox.com>
 <20050910153110.36a44eba.akpm@osdl.org> <Pine.LNX.4.58.0509101548230.30958@g5.osdl.org>
 <43236FD2.6010501@pobox.com> <Pine.LNX.4.58.0509101658080.30958@g5.osdl.org>
 <432377A3.5070805@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Sep 2005, Jeff Garzik wrote:
> 
> > happen, but still.. Relying on the legacy-value of the IO port instead of
> > relying on whether you did a legacy request_region() is definitely at
> > least conceptually wrong).
> 
> Its not that simple.  grep for ____request_region in both libata and the 
> PCI quirks code.  libata grabs the SATA port on ICH boxes in combined 
> mode... but has to do so before built-in IDE driver grabs them.

That's not what I'm talking about.

The _request_ side is fine, and yes, it needs to be done early.

It's the module unload time that is broken - it doesn't remember whether
it requested the legacy mode addresses, so instead it uses the address
_values_ to determine if it did so or not, and that's broken: it is
conceivable at least in theory that a PCI BAR would contain the legacy
mode address value, without the legacy mode bit being set. In that case we 
have _not_ done the legacy-mode "request_region()", but we _will_ do the 
"release_region()".

Exactly because the code checks the wrong thing. That's also the thing 
that makes for problems for iomap. What used to be the wrong thing to test 
now becomes _impossible_ to test.

If the code had just saved the value of "legacy_mode" from the probing 
phase, the release phase wouldn't have any ambiguous cases, and the iomap 
code wouldn't have any issues either..

		Linus
