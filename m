Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbTJJXMK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 19:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263220AbTJJXMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 19:12:10 -0400
Received: from ns.suse.de ([195.135.220.2]:61119 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263215AbTJJXMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 19:12:07 -0400
Date: Sat, 11 Oct 2003 01:11:37 +0200
From: Andi Kleen <ak@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] x86_84 pci_map_sg fix for 2.6.0-test7
Message-ID: <20031010231137.GA28985@wotan.suse.de>
References: <200310101426.33773.pbadari@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310101426.33773.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 02:26:33PM -0700, Badari Pulavarty wrote:
> Hi,
> 
> Here is the patch to fix few minor issues with pci_map_sg() and pci_map_cont()
> for x86_64. I ran into these asserts while testing with qlogic fc driver.

Sounds like the driver is buggy.

> 
> The patch fixes following:
> 
> 1) pci_map_sg() coalsces "sg" entries without modifying command's
> "use_sg" value. It sets the "sg" entries length to "0" to indicate that
> these entires are coalsced. If the command gets retried, the pci_map_sg() 
> code trips on the assert that all entries length should be > 0.

As I explained for your last patch this change is wrong. Remapping
an already mapped sg is not possible - it leaks IOMMU space and 
cause eventually system failure when the aperture fills up.

You have to somehow handle this in the caller, the pci-dma
layer cannot do it. Eeither free the modified sg and retry with the original 
one or better just don't remap it and use the already mapped one) 

I will add an BUG for passing sgs with dma_address != NULL to 
pci_map_sg(). This should catch such abuses early.

> 
> 2) __pci_map_cont() incorrectly assumes that "start" is always 0, so it
> trips on few asserts.

That's the same high level bug I think.  

-Andi

