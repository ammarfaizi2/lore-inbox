Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030980AbVIIX2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030980AbVIIX2Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 19:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030981AbVIIX2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 19:28:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12754 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030980AbVIIX2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 19:28:24 -0400
Date: Fri, 9 Sep 2005 16:28:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: davej@codemonkey.org.uk, arjan@infradead.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
In-Reply-To: <Pine.LNX.4.58.0509091613310.3051@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0509091623500.3051@g5.osdl.org>
References: <20050909220758.GA29746@kroah.com> <Pine.LNX.4.58.0509091535180.3051@g5.osdl.org>
 <20050909225421.GA31433@suse.de> <Pine.LNX.4.58.0509091613310.3051@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Sep 2005, Linus Torvalds wrote:
> 
> There are functions where it is really _important_ to check the error 
> return, because they return errors often enough - and the error case is 
> something you have to do something about - that it's good to force people 
> to be aware.
> 
> But "pci_set_power_state()"?
> 
> I don't think so.

Btw, a perfect example of this is

	pci_set_power_state(pdev, 0);

which is a very common thing to do in a driver init routine. And it has
absolutely _no_ valid return values: it either succeeds, or it doesn't,
and the only reason it wouldn't succeed is because the device doesn't
support power management in the first place (in which case it already
effectively is in state 0).

In other words, there's nothing you can or should do about it. Testing the 
return value is pointless. And thus adding a "must_check" is really really 
wrong: it might make people do

	if (pci_set_power_state(pdev, 0))
		return -ENODEV

which is actually actively the _wrong_ thing to do, and would just cause 
old revisions of the chip that might not support PM capabilities to no 
longer work.

The problem with warnings is that people may take them too seriously, and 
generate bugs when trying to "fix" them.

		Linus
