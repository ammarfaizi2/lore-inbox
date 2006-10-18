Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161164AbWJRPQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161164AbWJRPQF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161168AbWJRPQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:16:05 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:20713 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1161164AbWJRPQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:16:02 -0400
Date: Wed, 18 Oct 2006 09:16:01 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Brian King <brking@us.ibm.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       Adam Belay <abelay@MIT.EDU>
Subject: Re: [PATCH] Block on access to temporarily unavailable pci device
Message-ID: <20061018151601.GR22289@parisc-linux.org>
References: <20061017145146.GJ22289@parisc-linux.org> <45354A59.3010109@us.ibm.com> <20061018145104.GN22289@parisc-linux.org> <4536446A.6000405@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4536446A.6000405@yahoo.com.au>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 01:12:42AM +1000, Nick Piggin wrote:
> Matthew Wilcox wrote:
> 
> >I also addressed the potential issue with nested attempts to block.
> >Now pci_block_user_cfg_access() can return -EBUSY if it's already blocked,
> >and pci_unblock_user_cfg_access() will WARN if you try to unblock an
> >already unblocked device.
> 
> Why not just WARN if it is already blocked as well? Presumably if the

Because the driver can check the return value and fail the higher level
operation.

> driver needs nested blocking, it is going to have to carry some state
> to know when to do the final unblock anyway, so it may as well just
> not do these redundant blocks either.

No driver needs nested blocking, but blocks may be imposed on a driver's
device by the PCI core, for example.

> ** or ** just do a counting block/unblock to properly support nesting
> them. That is, go one way or the other, and do it properly.

I don't think that's necessary.  Right now, we have one user (IPR's
BIST) and I'm trying to add a second (D-state transitions).  We don't
need nested blocks, but we do need to fail in the highly unlikely case
someone tries to do them.

If it turns out we actually need them later, let's revisit this when we
have a user.
