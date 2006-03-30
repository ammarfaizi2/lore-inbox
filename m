Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWC3BeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWC3BeM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 20:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWC3BeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 20:34:12 -0500
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:8095 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S1751139AbWC3BeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 20:34:11 -0500
Subject: Re: [spi-devel-general] SPI bus driver synchronous support
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>,
       spi-devel-general@lists.sourceforge.net
In-Reply-To: <7C75FBEB-F962-4860-A797-AC6B454D6E6E@kernel.crashing.org>
References: <7C75FBEB-F962-4860-A797-AC6B454D6E6E@kernel.crashing.org>
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Wed, 29 Mar 2006 17:34:03 -0800
Message-Id: <1143682443.4496.20.camel@ststephen.streetfiresound.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.streetfiresound.liquidweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - streetfiresound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-29 at 13:49 -0600, Kumar Gala wrote:
> I was wondering if there was any thought to providing a mechanism for  
> SPI bus drivers to implement a direct synchronous interface so we  
> don't have to use wait_for_completion.
> 
> The case I have is I need to talk to a microcontroller connected over  
> SPI.  I'd like to be able to issue a command to the microcontroller  
> in a MachineCheck handler before the system reboots.  I need a truly  
> synchronous interface opposed to one fronting the async interface.
> 
While is should be possible (it only software after all, right) there
may be complications:

1) The SPI framework relies heavy on the 2.6 driver model and I do not
know much of the system is running in a "MachineCheck handler" before a
reboot.

2) Most of current SPI controller drivers rely on kernel threads to
drive and internal queue. See spi_bitbang.c for an example. Are kernel
threads still running by the time you want to invoke a fully synchronous
transfer? 

3) Some SPI controller drivers are completely interrupt driven with DMA
transfers. See pxa2xx_spi.c for an example.  Are interrupts still
enabled by the time you want to invoke a fully synchronous transfer? 

This in mind it should be possible to add a transfer_sync function
similar to this:

struct spi_master {
	...
	int (*transfer_sync)(struct spi_device *spi,
				struct spi_message *mesg);

	...
};

static inline int
spi_full_sync(struct spi_device *spi, struct spi_message *message)
{
	if (spi->master->transfer_sync) {
		message->spi = spi;
		return spi->master->transfer_sync(spi, message);
	}

	return -EOPNOTSUPP;
}

Off course, all SPI controller drivers would need some kind of interlock
between the standard transfer and transfer_sync.

Do you have SPI hardware or are you using spi_bitbang?  If you have
dedicated hardware what type?

What do you think David?

> Also, who is the maintainer for the SPI subsystem?
> 
David Brownell

-Stephen

