Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVDBDxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVDBDxe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 22:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbVDBDxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 22:53:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2202 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261676AbVDBDxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 22:53:31 -0500
Date: Sat, 2 Apr 2005 04:53:30 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <gregkh@suse.de>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, greg@kroah.com, prarit@sgi.com
Subject: Re: PCI: fix an oops in some pci devices on hotplug remove when their resources are being freed.
Message-ID: <20050402035330.GH21986@parcelfarce.linux.theplanet.co.uk>
References: <11123992702166@kroah.com> <11123992703458@kroah.com> <20050402011023.GG21986@parcelfarce.linux.theplanet.co.uk> <20050402033141.GA16556@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050402033141.GA16556@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2005 at 07:31:41PM -0800, Greg KH wrote:
> I agree.  However, SGI seems to have some majorly <insert expletive here>
> hardware and drivers that cause this line to release a already released
> resource.  See the other part of this patch for the part where this
> resource is supposedly freed up.

That one's even more stupid:

+++ b/kernel/resource.c 2005-04-01 15:37:58 -08:00
@@ -505,6 +505,7 @@
                        *p = res->sibling;
                        write_unlock(&resource_lock);
                        kfree(res);
+                       res = NULL;
                        return;
                }
                p = &res->sibling;

This pointer is a local variable!  Setting it to null right before return
cannot possibly affect anything.

> I took the patch as it doesn't hurt anyone, and it gets them off of my
> back.  But if you so much as think this patch isn't needed, I'll gladly
> revert it, as I'm really not trusting any PCI hotplug patches coming out
> from them anymore...

I think the problem is that they have a majorly hacked tree they're
working from as well as some quite inexperienced people working on it.
They need to do more internal peer review ... and clearly I need to
start reviewing their patches more carefully.

So yes, please revert this patch.  There is no way it can possibly
affect anything.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
