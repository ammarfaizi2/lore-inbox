Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423007AbWJFXf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423007AbWJFXf3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423008AbWJFXf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:35:29 -0400
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:57440 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1423007AbWJFXf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:35:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=O321Ukelbh5ZIaHODb4dltrLrs4yCOP4p2YcA4Cn1faVu9qQrw6PtL9yi1sIfIqVL0u5cvZ7kf/KtiNwAUNEaF8okiuqUxi9sv09FVoRgW6b9rgn1n9p7rf6Td8NRHy4tCiMJeyJ6OlV/gHwk3t7eHp8vw72fmv9DpcXYEhmhZU=  ;
From: David Brownell <david-b@pacbell.net>
To: "Andrea Paterniani" <a.paterniani@swapp-eng.it>
Subject: Re: [patch 2.6.18-git] SPI -- Freescale iMX SPI controller driver
Date: Fri, 6 Oct 2006 16:35:23 -0700
User-Agent: KMail/1.7.1
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
References: <FLEPLOLKEPNLMHOILNHPKELOCMAA.a.paterniani@swapp-eng.it>
In-Reply-To: <FLEPLOLKEPNLMHOILNHPKELOCMAA.a.paterniani@swapp-eng.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610061635.24216.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 October 2006 9:08 am, Andrea Paterniani wrote:
> Here some questions and answers to your comments, (please consider I'm nearly new to kernel programming).
> 
> 
> 
> > ...
> > ug.  Why not simply open-code
> >
> > 	readl(addr + DATA);
> 
> I found usefull to define macros to use inside code something like
> 	rd_CONTROL(regs)
> instead of
> 	readl(regs + 0x08)
> since to me the macro sounds more friendly.
> Should I have to adhere to some standard ?

The standards are more or less to avoid creating namespace clutter,
and to make explicit where register access happens.  Defining new
macros violates the former; not being able to tell where the chip
registers are accessed (because they're wrapped in macros) violates
the latter.


> > The use of loops_per_jiffy seems inappropriate.  That's an IO-space read in
> > there, which is slow.  This timeout will be very long indeed.
> 
> Please suggest me what it's more appropriate.

Pick a constant, use it.



> > I see tasklets being scheduled, but no tasklet_disable() or tasklet_kill(),
> > etc.  Is this driver racy against shutdown or rmmod?
> 
> Do you mean I should use tasklet_kill() inside spi_imx_remove ?

That's how I read it.  :)


> > > +	drv_data->rd_data_phys = (dma_addr_t)res->start;
> >
> > I don't think it's correct to cast a kernel virtual address straight to a
> > dma_addr_t.
> 
> File include/asm-arm/types.h defines
> 	typedef u32 dma_addr_t;
> Also I think that for ARM architecture resource_size_t in practice
> is u32 since CONFIG_RESOURCES_64BIT isn't defined. 
> Is this construction correct ? If not what should I do ?

I think it's correct; it's certainly standard for converting physical
addresses to DMA addresses.  (Andrew got that one wrong; resource
addresses are physical, not virtual.)

- Dave

