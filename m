Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSF0Qw3>; Thu, 27 Jun 2002 12:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316889AbSF0Qw2>; Thu, 27 Jun 2002 12:52:28 -0400
Received: from chfdns01.ch.intel.com ([143.182.246.24]:2242 "EHLO
	pan.ch.intel.com") by vger.kernel.org with ESMTP id <S316842AbSF0Qw1>;
	Thu, 27 Jun 2002 12:52:27 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C057B49F4@orsmsx111.jf.intel.com>
From: "Gross, Mark" <mark.gross@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'gibbs@scsiguy.com'" <gibbs@scsiguy.com>
Subject: Linux 2.5.24 and aic7xxx oopsing in ahc_linux_isr on system with 
	LOTs of SCSI cards.
Date: Thu, 27 Jun 2002 09:54:41 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a box with a LOT of SCSI adapters that isn't happy with 2.5 kernels,
but is solid with the 2.4 kernels.

I'm trying to test the 2.5.24 on my block I/O system with effectively 8
aic7xxx adapters  (one on board, 3 dual channel PCI cards, and 1 single
channel PCI card).

It panics with a NULL dereference in the ahc_linux_isr in aic7xxx_linux.c

I found the following in the archives and I wonder if I'm getting a similar
failure.  What is the status for the fix to this problem?

I'm using the new AIC7xxx support from make menuconfig for my 2.5.24 kernel.

--mgross



On Thu, Feb 28, 2002 at 05:39:36PM -0700, Justin T. Gibbs wrote:
>
>> >The irq is enabled (request_irq called) via ahc_linux_pci_probe; 
>> >host is initialized via ahc_linux_register_host, see ahc_linux_detect.
>> 
>> Actually, the interrupt is enabled in the driver PCI core in
aic7xxx_pci.c
>> (looking at v6.2.5 of the driver).  It seems that this will have to move
>> out of common code and into the OSM to satisfy Linux.
>
>Can't we call the interrupt handler for a shared irq? So, even if the
>aic interrupt is disabled, its interrupt handler can be called?

The call is out to the OSM to register the handler.  This is only
performed once all setup is already performed, so a shared interrupt
is handled correctly.  After the registration, the aic7xxx's interrupt
source is enabled.

>
>> >Anyone have a fix for this problem? The correct fix looks more complex
>> >than just moving up the ahc_linux_register_host() calls.
>> >
>> >For now, I'll try modifying ahc_linux_isr() to return early if host is
NULL
>.
>
>The above is working for me for now.

Unless this has changed in 2.5, the crux of the problem is that you only
get your host structure once you've registered your controller instance.
In the process of registering the controller, you can be called back to
handle commands.  If you can't preallocate the host structure prior to
registering it to the system, using a lock in side of it will cause these
kinds of issues.  Checking for a NULL host structure on every interrupt is
bogus.

--
Justin
-

(W) 503-712-8218
MS: JF1-05
2111 N.E. 25th Ave.
Hillsboro, OR 97124
