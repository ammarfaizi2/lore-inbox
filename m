Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbTJJXiX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 19:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbTJJXiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 19:38:22 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:63665 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263195AbTJJXiV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 19:38:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] x86_84 pci_map_sg fix for 2.6.0-test7
Date: Fri, 10 Oct 2003 16:37:22 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200310101426.33773.pbadari@us.ibm.com> <20031010231137.GA28985@wotan.suse.de>
In-Reply-To: <20031010231137.GA28985@wotan.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200310101637.22197.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 October 2003 04:11 pm, Andi Kleen wrote:
> On Fri, Oct 10, 2003 at 02:26:33PM -0700, Badari Pulavarty wrote:
> > Hi,
> >
> > Here is the patch to fix few minor issues with pci_map_sg() and
> > pci_map_cont() for x86_64. I ran into these asserts while testing with
> > qlogic fc driver.
>
> Sounds like the driver is buggy.

Hmm. Possible. I am not an expert in qlogic driver. Last time I looked
commands are getting retried due to hardware error returns.
(something like underruns). 

>
> > The patch fixes following:
> >
> > 1) pci_map_sg() coalsces "sg" entries without modifying command's
> > "use_sg" value. It sets the "sg" entries length to "0" to indicate that
> > these entires are coalsced. If the command gets retried, the pci_map_sg()
> > code trips on the assert that all entries length should be > 0.
>
> As I explained for your last patch this change is wrong. Remapping
> an already mapped sg is not possible - it leaks IOMMU space and
> cause eventually system failure when the aperture fills up.
>
> You have to somehow handle this in the caller, the pci-dma
> layer cannot do it. Eeither free the modified sg and retry with the
> original one or better just don't remap it and use the already mapped one)
>
> I will add an BUG for passing sgs with dma_address != NULL to
> pci_map_sg(). This should catch such abuses early.

Okay !! I will take a closer look at it. 

> > 2) __pci_map_cont() incorrectly assumes that "start" is always 0, so it
> > trips on few asserts.
>
> That's the same high level bug I think.

pci_map_sg() can call pci_map_cont() with different start values.

Thanks,
Badari
