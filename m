Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVAGDvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVAGDvI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 22:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVAGDvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 22:51:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:59544 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261203AbVAGDvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 22:51:02 -0500
Date: Thu, 6 Jan 2005 19:50:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: vgoyal@in.ibm.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: SCSI aic7xxx driver: Initialization Failure over a kdump reboot
Message-Id: <20050106195043.4b77c63e.akpm@osdl.org>
In-Reply-To: <1105013524.4468.3.camel@laptopd505.fenrus.org>
References: <1105014959.2688.296.camel@2fwv946.in.ibm.com>
	<1105013524.4468.3.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> On Thu, 2005-01-06 at 18:05 +0530, Vivek Goyal wrote:
>  > 
>  > In my machine Adaptec SCSI controller is not managing any devices. It
>  > is
>  > a lonely controller.
>  > 
> 
>  looks like the following is happening:
>  the controller wants to send an irq (probably from previous life)
>  then suddenly the driver gets loaded
>  * which registers an irq handler
>  * which does pci_enable_device()
>  and .. the irq goes through. 
>  the irq handler just is not yet expecting this irq, so
>  returns "uh dunno not mine"
>  the kernel then decides to disable the irq on the apic level
>  and then the driver DOES need an irq during init
>  ... which never happens.
> 

yes, that's exactly what e100 was doing on my laptop last month.  Fixed
that by arranging for the NIC to be reset before the call to
pci_set_master().

I expect the adaptec driver could be fixed by calling ahc_reset() from a
strategic place in either ahc_linux_pci_dev_probe() or in the shutdown
handler.  (Does the crashdump code call shutdown handlers?  Sounds like a
bad idea...)
