Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbVIJVHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbVIJVHJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 17:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVIJVHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 17:07:09 -0400
Received: from mx1.rowland.org ([192.131.102.7]:9489 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S932304AbVIJVHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 17:07:07 -0400
Date: Sat, 10 Sep 2005 17:07:04 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
Message-ID: <Pine.LNX.4.44L0.0509101655520.7081-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2005, Linus Torvalds wrote:
> 
> On Fri, 9 Sep 2005, Linus Torvalds wrote:
> > 
> > There are functions where it is really _important_ to check the error 
> > return, because they return errors often enough - and the error case is 
> > something you have to do something about - that it's good to force people 
> > to be aware.
> > 
> > But "pci_set_power_state()"?
> > 
> > I don't think so.
> 
> Btw, a perfect example of this is
> 
> 	pci_set_power_state(pdev, 0);
> 
> which is a very common thing to do in a driver init routine. And it has
> absolutely _no_ valid return values: it either succeeds, or it doesn't,
> and the only reason it wouldn't succeed is because the device doesn't
> support power management in the first place (in which case it already
> effectively is in state 0).
> 
> In other words, there's nothing you can or should do about it. Testing the 
> return value is pointless. And thus adding a "must_check" is really really 
> wrong: it might make people do
> 
> 	if (pci_set_power_state(pdev, 0))
> 		return -ENODEV
> 
> which is actually actively the _wrong_ thing to do, and would just cause 
> old revisions of the chip that might not support PM capabilities to no 
> longer work.

Funny you should say this -- exactly that problem _did_ arise.  See

http://marc.theaimsgroup.com/?l=linux-pci&m=112621842604724&w=2

pci_enable_device_bars() would an error when trying to initialize 
devices without PM support, because it started checking the return value
from pci_set_power_state().

Alan Stern

