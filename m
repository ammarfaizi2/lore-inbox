Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265304AbUAEU6b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 15:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265283AbUAEU6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 15:58:31 -0500
Received: from ns.suse.de ([195.135.220.2]:13448 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265115AbUAEU6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 15:58:25 -0500
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [BUG] x86_64 pci_map_sg modifies sg list - fails multiple map/unmaps
References: <2938942704.1073325455@aslan.btc.adaptec.com.suse.lists.linux.kernel>
	<m3brpi41q0.fsf@averell.firstfloor.org.suse.lists.linux.kernel>
	<2997092704.1073333041@aslan.btc.adaptec.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Jan 2004 21:58:24 +0100
In-Reply-To: <2997092704.1073333041@aslan.btc.adaptec.com.suse.lists.linux.kernel>
Message-ID: <p73fzeu15an.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" <gibbs@scsiguy.com> writes:

> > "Justin T. Gibbs" <gibbs@scsiguy.com> writes:
> > 
> >> Berkley Shands recently tripped over this problem.  The 2.6.X pci_map_sg
> >> code for x86_64 modifies the passed in S/G list to compact it for mapping
> >> by the GART.  This modification is not reversed when pci_unmap_sg is
> >> called.  In the case of a retried SCSI command, this causes any attempt
> > 
> > Qlogic has the same bug.
> 
> Which bug is this?  Not updating use_sg, or mapping the command the
> second time when it is retried?  If the latter, I don't think this is an
> HBA bug.  The HBA driver doesn't know that the command has been mapped in
> the past, so it will blindly map/unmap it again.

In some cases x86-64 pci_map_sg causes a BUG() when you pass it an already
mapped list. I've got reports of that happening with Qlogic.

I haven't analyzed it in detail, whether the mid layer or the driver
or someone else is to blame.
 
> ...
> 
> >> DMA-API.txt doesn't seem to cover this issue.
> > 
> > It does actually, but not very clearly. I've suggested changes of wording
> > recently to make this more clear, but it hasn't gotten in.
> 
> Can you point to the section of the document you believe applies?

It documents that pci_map_sg rewrites the sg list and never guarantees
that the rewriting is undone on pci_unmap_sg.

> > You should never remap an already mapped sg list.
> 
> But the sg list is no longer mapped.  The HBA driver did call pci_unmap_sg
> on it.  Did you mean to say, "Never map an sg list again that has been
> mapped in the past"?

Yep. While it would be in theory possible to reconstruct the list at
unmap time it would be extremly costly (require lots of uncached
memory access on x86-64) and is not done.

> 
> > Either reuse the already mapped list or keep a copy of the original list
> > around. First is better because the later may have problems with the page
> > reference counts.
> 
> The mid-layer doesn't map the list.  The HBA drivers do.  So you're saying
> that either the mid-layer or the HBA drivers need to copy the list so it
> can be restored just in case the command will be retried?

I'm just pointing out the requirements of pci_map_sg.

Either you can keep a flag around somewhere that says if the list is
mapped or not and skip the remapping and don't do a unmap in
between. Or copy and make sure the page reference counts are correctly
maintained.  I'm not very intimate with the SCSI/block code so you
guys have to decide what is more convenient.

-Andi
