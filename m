Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313862AbSEIQXf>; Thu, 9 May 2002 12:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313867AbSEIQXe>; Thu, 9 May 2002 12:23:34 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:57864 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313862AbSEIQXd>;
	Thu, 9 May 2002 12:23:33 -0400
Date: Thu, 9 May 2002 08:23:29 -0700
From: Greg KH <greg@kroah.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Problems with 2.5.14 PCI reorg and non-PCI architectures
Message-ID: <20020509152329.GC17158@kroah.com>
In-Reply-To: <20020509084424.GC15460@kroah.com> <200205091300.g49D0TY01841@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 11 Apr 2002 13:35:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2002 at 09:00:28AM -0400, James Bottomley wrote:
> greg@kroah.com said:
> > arch/i386/pci/dma.c now only contains pci_alloc_consistent() and
> > pci_free_consistent().  What kind of configuration are you using that
> > works without CONFIG_PCI and yet calls those functions?  Is it a
> > ISA_PNP type configuration?  Do you have a .config that this fails on?
> 
> The problem is that this is not necessarily PCI related on other platforms.
> 
> My cross platform SCSI driver, 53c700.c, uses pci_alloc_consistent because it 
> has to work on parisc archs as well (which do have consistent memory even 
> though a few of them don't have PCI busses).  It was failing a test compile.  
> I can manipulate the #ifdefs so that it doesn't use the consistent allocation 
> functions on x86, but I think, in principle, cross platform drivers should be 
> able to use these functions.

But parisc has it's own implementation of pci_alloc_consistent(), so
you're ok on that platform.  And it looks like only 2 scsi drivers use
the 53c700.c code, lasi700.c and NCR_D700.c.  The NCR driver looks to
need pci, and the lasi700 driver doesn't look like it will even compile
on i386.

No wait, the NCR driver needs Microchannel, is that true?

I would like to push back and ask why you are calling a pci_* function
from a driver that does not need pci.  Yes, I know it's a nice, generic
function, but that hasn't stopped people from rewriting that same
function a number of times in different forms in different places in the
tree :)

In a perfect world, we should probably create a function like:
	void *alloc_consistent (int flags, size_t size, dma_addr_t *dma_handle);
to solve everyone's needs, but I'm not volunteering to do that :)

I'll go move the file and send the changeset to Linus.

thanks,

greg k-h
