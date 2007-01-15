Return-Path: <linux-kernel-owner+w=401wt.eu-S1750774AbXAOVGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbXAOVGE (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 16:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbXAOVGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 16:06:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:10079 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbXAOVGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 16:06:03 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=i44+hoO/PC7xy41XL/Oq5VRizsjNmZVd37CplF5nd1HAlUZieflQRsyBbzogtdiOJI6b+Ktei5I9iWR51TgfqtQFmh1iBYgF6sffg/sMt2Bsqaau1GJPrqgN+cWPrrzN6imtl2qbH6NQhH1DolT6cCqyI6Ie8Db9GboMVl0KuPU=
Message-ID: <59ad55d30701151306q492e07aep9c640afd7b6c442f@mail.gmail.com>
Date: Mon, 15 Jan 2007 16:06:00 -0500
From: "=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <krh@bitplanet.net>
To: "David Moore" <dcm@mit.edu>
Subject: Re: allocation failed: out of vmalloc space error treating and VIDEO1394 IOC LISTEN CHANNEL ioctl failed problem
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       linux1394-devel@lists.sourceforge.net,
       theSeinfeld@users.sourceforge.net, "Bill Davidsen" <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org, libdc1394-devel@lists.sourceforge.net
In-Reply-To: <1168890881.10136.29.camel@pisces.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <mailman.59.1168027378.1221.libdc1394-devel@lists.sourceforge.net>
	 <200701100023.39964.theSeinfeld@users.sf.net>
	 <tkrat.c0a43c7c901c438c@s5r6.in-berlin.de>
	 <1168802934.3123.1062.camel@laptopd505.fenrus.org>
	 <45ABC1A2.90109@tmr.com>
	 <1168885223.3122.304.camel@laptopd505.fenrus.org>
	 <1168890881.10136.29.camel@pisces.mit.edu>
X-Google-Sender-Auth: 3ae13678af66a5ee
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/07, David Moore <dcm@mit.edu> wrote:
> On Mon, 2007-01-15 at 10:20 -0800, Arjan van de Ven wrote:
> > if you need that much you probably should redesign your algorithms to
> > not need vmalloc in the first place....
>
> I think you've convinced me that vmalloc is not a good choice when a
> driver needs a large buffer (many megabytes) for DMA.
>
> In this case, we need a large ring buffer for reception of isochronous
> packets from a firewire device.  If I understand you correctly, you are
> suggesting that this buffer be obtained as followed:
>
> 1. Application performs malloc() in user-space and mmap()s it.
> 2. Driver uses vmalloc_to_page() on every page of the malloc'ed memory
> and constructs a scatter-gather list.
> 3. Map the sg list with pci_map_sg().
> 4. Commence DMA.
>
> Is that correct?  In particular, does it do the right thing in terms of
> pinning the memory and dealing with high memory?
>
> I notice that the block I/O API has some convenience functions for this,
> but this is not a block device.  Are there some other convenience
> functions that can be used?
>
> Forgive me if these are obvious questions -- I'm not the developer of
> video1394, but I'd still like get it right for the new firewire stack
> that's being developed.

David, thanks for bringing this up.  Indeed if vmalloc is not the
right way for allocating big buffers, we need to figure something else
out.  My impression was that the vmalloc group of functions could be
used for big allocations since they don't require the underlying
memory to be physically contiguous.

What I'm doing currently in the new firewire stack is to vmalloc the
memory to be used for isochronous payload and then use
remap_vmalloc_range() to map the memory to the user.  I never access
the contents from the kernel side, I just use vmalloc so I can pass
the pointer to remap_vmalloc_range().  Maybe this is overkill and a
better way to do this is to call get_page() a number of times and
manually add these pages to the process address space without ever
setting up a kernel side mapping for these.

However, what I'd really like to do is to leave it to user space to
allocate the memory as David describes.  In the transmit case, user
space allocates memory (malloc or mmap) and loads the payload into
that buffer.  Then is does an ioctl() on the firewire control device
to indicate the location of this buffer, describe how that payload is
to be split into packets, and optionally a header per packet to
prepend.  The kernel side driver then converts the user space
addresses to pages, pins the pages in question, and sets up dma
programs to transmit the packets.

Likewise for reception, user space allocates buffers for receiving the
data and then instructs the kernel the receive a certain amount of
data into this buffer.  The kernel pins the pages backing the user
space buffer and sets up dma to received into those pages.  Once a
page it full, it's unpinned and userspace is notified.

It's not too difficult from what I'm doing now, I'd just like to give
user space more control over the buffers it uses for streaming (i.e.
letting user space allocate them).  What I'm missing here is: how do I
actually pin a page in memory?  I'm sure it's not too difficult, but I
haven't yet figured it out and I'm sure somebody knows it off the top
of his head.

cheers,
Kristian
