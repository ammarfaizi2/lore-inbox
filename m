Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161202AbWJRPtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161202AbWJRPtL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161192AbWJRPtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:49:10 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61105 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161199AbWJRPtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:49:05 -0400
Subject: Re: [PATCH] Block on access to temporarily unavailable pci device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Brian King <brking@us.ibm.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, Adam Belay <abelay@MIT.EDU>
In-Reply-To: <20061018145104.GN22289@parisc-linux.org>
References: <20061017145146.GJ22289@parisc-linux.org>
	 <45354A59.3010109@us.ibm.com>  <20061018145104.GN22289@parisc-linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Oct 2006 16:50:51 +0100
Message-Id: <1161186652.9363.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-18 am 08:51 -0600, ysgrifennodd Matthew Wilcox:
> The existing implementation of pci_block_user_cfg_access() was recently
> criticised for providing out of date information and for returning errors
> on write, which applications won't be expecting.

It was also favoured by some of us as well. In addition this whole issue
was extensively debated in the past to select the current approach. That
said I do like the approach of a short wait *specifically* on power
transitions, its bounded in time, its neat and it makes sense. 

We must be very very sure its never triggered in the real world any
other way (eg your >block testing must be impossible)

So unless you distinguish between "back in a moment", "back someday" and
"not coming back" it isn't useful. Thus your patch is incomplete as it
does not provide the cache that is also needed. At least I don't think X
hanging forever mid mode switch is terribly useful...

> I also addressed the potential issue with nested attempts to block.
> Now pci_block_user_cfg_access() can return -EBUSY if it's already blocked,
> and pci_unblock_user_cfg_access() will WARN if you try to unblock an
> already unblocked device.

Gak that is IMHO a mistake. Just keep a counter. You've just added
another "what the hell do I do if this returns -EBUSY" problem for all
the driver authors.

> Signed-off-by: Matthew Wilcox <matthew@wil.cx>

NAK for all the above reasons. This is a cure looking for a disease, and
its a cure which is worse than the theoretical disease it wants to fix.


