Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWIGPVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWIGPVv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 11:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWIGPVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 11:21:51 -0400
Received: from colo.lackof.org ([198.49.126.79]:31107 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S932072AbWIGPVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 11:21:50 -0400
Date: Thu, 7 Sep 2006 09:21:47 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Tejun Heo <htejun@gmail.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Arjan van de Ven <arjan@infradead.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: question regarding cacheline size
Message-ID: <20060907152147.GA17324@colo.lackof.org>
References: <44FFD8C6.8080802@gmail.com> <20060907111120.GL2558@parisc-linux.org> <45000076.4070005@gmail.com> <20060907120756.GA29532@flint.arm.linux.org.uk> <20060907122311.GM2558@parisc-linux.org> <1157632405.14882.27.camel@laptopd505.fenrus.org> <20060907124026.GN2558@parisc-linux.org> <45001665.9050509@gmail.com> <20060907130401.GO2558@parisc-linux.org> <45001C48.6050803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45001C48.6050803@gmail.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 03:19:04PM +0200, Tejun Heo wrote:
...
> For MWI, it will cause data corruption.  For READ LINE and MULTIPLE, I 
> think it would be okay.  The memory is prefetchable after all.

Within the context of DMA API, memory is prefetchable by the device
for "streaming" transactions but not for "coherent" memory.
PCI subsystem has no way of knowing which transaction a device
will use for any particular type of memory access. Only the
driver can embed that knowledge.

> Anyways, this shouldn't be of too much problem and probably
> can be handled by quirks if ever needed.
> 
> >Arguably devices which don't support the real system cacheline size
> >would only get data corruption if they used MWI, so we only have to
> >prevent them from using MWI; they could use a different cacheline size
> >for MRM and MRL without causing data corruption.  But I don't think we
> >want to go down that route; do you?
> 
> Oh yeah, that's what I was trying to say, and I don't want to go down 
> that route.  So, I guess this one is settled.

hrm...if the driver can put a safe value in cachelinesize register
and NOT enable MWI, I can imagine a significant performance boost
if the device can use MRM or MRL. But IMHO it's up to the driver
writers (or other contributors) to figure that out.

Current API (pci_set_mwi()) ties enabling MRM/MRL with enabling MWI
and I don't see a really good reason for that. Only the converse
is true - enabling MWI requires setting cachelinesize.

hth,
grant
