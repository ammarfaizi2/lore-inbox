Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbVEMUBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbVEMUBv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 16:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262533AbVEMUBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 16:01:50 -0400
Received: from kanga.kvack.org ([66.96.29.28]:19861 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S262532AbVEMUA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 16:00:28 -0400
Date: Fri, 13 May 2005 16:03:12 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [rfc/patch] libata -- port configurable delays
Message-ID: <20050513200312.GA6555@kvack.org>
References: <20050513185850.GA5777@kvack.org> <4284FC6E.7060300@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4284FC6E.7060300@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 03:13:50PM -0400, Jeff Garzik wrote:
> This delay is based on field experience, rather than spec.  I'm open to 
> making this optional, as you have done.  Some issues related to this 
> delay, to consider:

Do you have the original bug reports so we know which chipsets / drive 
combinations are problematic?

> 1) Nothing in life is free.  This delay is useful on some platforms, 
> because banging away at the Status register for extended periods of time 
> can cause an insane amount of PCI IO traffic.  Removing the delay just 
> moves the punishment from one area to another.

In this case the time to complete the task is reduced by 18%, so the 
delay is definately excessive.  That 18% is remarkably close to the 
19.5% hit for __delay in the profile results.

> 2) In a few controllers, the SATA<->FIS emulation can go kerflooey if 
> you bang the Status register 'too hard'.

The patch only enables it on one variant of ICH6 SATA so far.

> 3) IIRC some rare PATA devices don't like having their Status register 
> banged "too hard".  No data, just a vague memory.
> 
> 4) It may be worthwhile to rewrite the loop to check the Status register 
> _first_, then delay.
> 
> Finally, simply disabling the delay is IMO _far_ too dangerous on such a 
> popular driver (ata_piix).

Have you a better suggestion for blacklisting devices?

> I would be conservative, and create a module option for libata (not 
> ata_piix) which allows a user to globally disable the delay.  And make 
> sure that option defaults to 'delay', the current behavior.

This option is undesirable for hardware which behaves correctly.  The 
vast majority of users aren't going to be fiddling with hdparm options
(I certainly don't want to see modern SATA being a repeat of the magic 
handwaving the IDE driver and DMA went through for years).

At the very least the option should be introduced and new drivers should 
start life without these legacy delays in place.  If doing it on a per 
port interface isn't good enough, what is?  Globally seems worse to me 
as then any system with a mix of old and new hardware isn't going to do 
the right thing.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
