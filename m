Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751811AbWIGPr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbWIGPr6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 11:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbWIGPr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 11:47:58 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:25446 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751811AbWIGPr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 11:47:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=LutaXgEj7Qv0EF6p5j8/ILwrkLuTTgNsSmEd6rT/ixIIQ7Wjx1aPehivqJTQqKjJuNi8qh+thTeT9a/O+xtFvODrqQyszv4YZYW1i+cAnrX1XjEoBTF3k6HOwrwZmqM6avk5uqmxFwih8NFWklGrvp1K3RWTJzmZCbmXyrtAEMk=
Message-ID: <45003F1B.7000302@gmail.com>
Date: Thu, 07 Sep 2006 17:47:39 +0200
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
CC: Matthew Wilcox <matthew@wil.cx>, Arjan van de Ven <arjan@infradead.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: question regarding cacheline size
References: <44FFD8C6.8080802@gmail.com> <20060907111120.GL2558@parisc-linux.org> <45000076.4070005@gmail.com> <20060907120756.GA29532@flint.arm.linux.org.uk> <20060907122311.GM2558@parisc-linux.org> <1157632405.14882.27.camel@laptopd505.fenrus.org> <20060907124026.GN2558@parisc-linux.org> <45001665.9050509@gmail.com> <20060907130401.GO2558@parisc-linux.org> <45001C48.6050803@gmail.com> <20060907152147.GA17324@colo.lackof.org>
In-Reply-To: <20060907152147.GA17324@colo.lackof.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
> On Thu, Sep 07, 2006 at 03:19:04PM +0200, Tejun Heo wrote:
> ...
>> For MWI, it will cause data corruption.  For READ LINE and MULTIPLE, I 
>> think it would be okay.  The memory is prefetchable after all.
> 
> Within the context of DMA API, memory is prefetchable by the device
> for "streaming" transactions but not for "coherent" memory.
> PCI subsystem has no way of knowing which transaction a device
> will use for any particular type of memory access. Only the
> driver can embed that knowledge.

I think using larger cacheline value should be okay for both 
prefetchable and non-prefetchable memory.  Using larger value tells the 
device to be more conservative in issuing MRL, MRW or WMI.  As Russell 
has pointed out, cacheline-wrapping access wouldn't work but I think 
it's reasonable to expect for such device to be flexible about cacheline 
config.

>> Oh yeah, that's what I was trying to say, and I don't want to go down 
>> that route.  So, I guess this one is settled.
> 
> hrm...if the driver can put a safe value in cachelinesize register
> and NOT enable MWI, I can imagine a significant performance boost
> if the device can use MRM or MRL. But IMHO it's up to the driver
> writers (or other contributors) to figure that out.
> 
> Current API (pci_set_mwi()) ties enabling MRM/MRL with enabling MWI
> and I don't see a really good reason for that. Only the converse
> is true - enabling MWI requires setting cachelinesize.

arch/i386/pci/common.c overrides cacheline size to min 32 regardless of 
actual size.  So, we seem to be using larger cacheline size for MWI already.

Jeff pointed out that there actually are devices which limit CLS config. 
  IMHO, making PCI configure CLS automatically and provide helpers to 
LLD to override it if necessary should cut it.

Thanks.

-- 
tejun
