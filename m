Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265344AbUAEVCX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 16:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265283AbUAEVCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 16:02:23 -0500
Received: from ns.suse.de ([195.135.220.2]:51082 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265211AbUAEVCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 16:02:20 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       gibbs@scsiguy.com
Subject: Re: [BUG] x86_64 pci_map_sg modifies sg list - fails multiple  map/unmaps
References: <200401051929.i05JTsM0000014248@mudpuddle.cs.wustl.edu.suse.lists.linux.kernel>
	<20040105112800.7a9f240b.davem@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Jan 2004 22:02:19 +0100
In-Reply-To: <20040105112800.7a9f240b.davem@redhat.com.suse.lists.linux.kernel>
Message-ID: <p73brpi1544.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> On Mon, 5 Jan 2004 13:29:54 -0600 (CST)
> Berkley Shands <berkley@cs.wustl.edu> wrote:
> 
> > 	The pci layer is modifying the sg list, and then placing a zero
> > in the length field. pci-gart.c at line 453 (2.6.0 sources) checks this length field
> > after a retry, sees that it is zero, and bughalts.
> 
> Oh that's a bug.  It is allowed to modify the dma_length field but not
> the physical length field.

It sets length to zero to terminate the list when entries were merged.
It doesn't have a dma_length.

It tripping over remapped lists is an side effect, but an useful one 
because remapping is not supported (merging destroys information that
cannot be reconstructed). If the bug didn't exist you would get data
corruption.

-Andi

P.S.: The x86-64 IOMMU code in 2.6.0 was buggy. Use current -bk*.
It will avoid the problem because merging is turned off by default, 
but it should be still fixed.
