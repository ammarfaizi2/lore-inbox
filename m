Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUKRXdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUKRXdy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 18:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbUKRXcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 18:32:05 -0500
Received: from gate.crashing.org ([63.228.1.57]:52355 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263002AbUKRXaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 18:30:09 -0500
Subject: Re: [PATCH] MII bus API for PHY devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andy Fleming <afleming@freescale.com>
Cc: jason.mcmullan@timesys.com, netdev@oss.sgi.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <9B0D9272-398A-11D9-96F6-000393C30512@freescale.com>
References: <069B6F33-341C-11D9-9652-000393DBC2E8@freescale.com>
	 <9B0D9272-398A-11D9-96F6-000393C30512@freescale.com>
Content-Type: text/plain
Date: Fri, 19 Nov 2004 10:26:31 +1100
Message-Id: <1100820391.25521.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-18 at 11:52 -0600, Andy Fleming wrote:

> 1) How should we pass initialization information from the system to the 
> bus.  Information like which irq to use for each PHY, and what the 
> address space for the bus's controls is.  I would like to enforce 
> encapsulation so that the ethernet drivers don't need to know this 
> information, or pass it to the bus.

Unfortunately, this is all quite platform specific and the ethernet
driver may be the only one to know what to do here... add to that
various special cases of the way the PHY is wired or controlled, I think
we can't completely avoid special casing...

> 2) How should we reflect the dependency of the ethernet driver on the 
> mii bus driver?

The ethernet driver can instanciate the PHYs at it's childs, though the
case of several MACs sharing PHYs will be difficult to represent...

> 3) How should we bind ethernet drivers to PHY drivers?

I would have them instanciated by the ethernet driver. Besides, the PHY
driver will need to be able to identify it's "parent" driver in some
ways to deal with special cases. It would be nice to have a library of
utility code to independently deal with link tracking (basically what
drivers like sungem do independently), with a callback to the ethernet
driver to inform it of actual changes (notifier ?). MACs often have
autopoll features and PHY often have interrupts, but from experience,
that's not very useful and a good old timer based polling tend to do a
better job most of the time.

> Oh, and a 4th side-issue:
> Should each PHY have its own file?  Or should we dump all the PHY 
> drivers in one file?  And if so, should THAT file be separate from the 
> mii bus implementation file?

I'd put all bcm5xxx in the same file ... they can be put together by
families...

Also, 

