Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265337AbUAETsQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 14:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265333AbUAETro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 14:47:44 -0500
Received: from p50821721.dip.t-dialin.net ([80.130.23.33]:4494 "EHLO
	averell.firstfloor.org") by vger.kernel.org with ESMTP
	id S265328AbUAETre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 14:47:34 -0500
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: linux-kernel@vger.kernel.org, davem@redhat.com, linux-scsi@vger.kernel.org
Subject: Re: [BUG] x86_64 pci_map_sg modifies sg list - fails multiple
 map/unmaps
From: Andi Kleen <ak@muc.de>
In-Reply-To: <2938942704.1073325455@aslan.btc.adaptec.com> ("Justin T.
 Gibbs"'s message of "Mon, 05 Jan 2004 10:57:35 -0700")
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <2938942704.1073325455@aslan.btc.adaptec.com>
Date: Mon, 05 Jan 2004 20:47:19 +0100
Message-ID: <m3brpi41q0.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" <gibbs@scsiguy.com> writes:

> Berkley Shands recently tripped over this problem.  The 2.6.X pci_map_sg
> code for x86_64 modifies the passed in S/G list to compact it for mapping
> by the GART.  This modification is not reversed when pci_unmap_sg is
> called.  In the case of a retried SCSI command, this causes any attempt

Qlogic has the same bug.

Actually I disabled merging by default in the latest x86-64 code,
but it can be still enabled by the user using options (it makes some
adapters run several percent faster). I would appreciate if you could
fix the problem anyways.

I was actually planning to add a BUG() for this. Should do that.
There is already one that triggers often when the problem occurs.

> to map the command a second time to fail with a BUG assertion since the
> nseg parameter passed into the second map call is state.  nseg comes from
> the "use_sg" field in the SCSI command structure which is never touched
> by the HBA drivers invoking pci_map_sg.
>
> DMA-API.txt doesn't seem to cover this issue.  Should the low-level DMA

It does actually, but not very clearly. I've suggested changes of wording
recently to make this more clear, but it hasn't gotten in.

> code restore the S/G list to its original state on unmap or should the
> SCSI HBA drivers be changed to update "use_sg" with the segment count
> reported by the pci_map_sg() API?  If the latter, this seems to contradict

You should never remap an already mapped sg list. Either reuse the already mapped
list or keep a copy of the original list around. First is better because the later
may have problems with the page reference counts.

-Andi
