Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTKFG6L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 01:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbTKFG6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 01:58:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2218 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263387AbTKFG6I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 01:58:08 -0500
Date: Thu, 6 Nov 2003 06:58:06 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jason Papadopoulos <jasonp@boo.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alpha: ALi 15x3 DMA completely broken now
Message-ID: <20031106065806.GO7665@parcelfarce.linux.theplanet.co.uk>
References: <5.2.1.1.2.20031106012936.00a9b030@boo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.1.1.2.20031106012936.00a9b030@boo.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06, 2003 at 01:34:35AM -0500, Jason Papadopoulos wrote:
> 
> Hello. 2.4.21-rc could not start DMA at boot time on
> my system, but hdparm could turn it on afterwards. Now
> with 2.4.22, nothing will turn on DMA; using hdparm
> locks the machine immediately.
> 
> The machine in question is an DS10 Alphaserver, Ali
> M5229 rev c0 IDE controller. Has 2.4.23-pre made any
> fixes for this device?

Yes - setup_irq() fix in 2.4.23-pre8 (arch/alpha/kernel/irq.c) had
fixed IDE hangs on DS10 (verified for 5229 rev c1).  If that doesn't
help, try to narrow it down - try 2.4.21-* + irq.c change and see
where does it stop working.

It should be able to do DMA at boot time, BTW:

wynton:~# dmesg |head -2
Linux version 2.4.23-pre8 (al@wynton) (gcc version 3.3.2 20031005 (Debian prerelease)) #1 SMP Fri Oct 24 04:27:45 EDT 2003
Booting GENERIC on Tsunami variation Webbrick using machine vector Webbrick from SRM
wynton:~# lspci |grep M5229
00:0d.0 IDE interface: ALi Corporation M5229 IDE (rev c1)
wynton:~# hdparm -i /dev/hdc|grep modes
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 *udma2 udma3 udma4 
wynton:~# hdparm -i /dev/hda|grep modes
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2 

DS10 with cdrom on hda and disk on hdc, no ide-related arguments in command
line.  Revision c0 won't do UDMA, but it should be able to do DMA just fine...

What configuration do you have?
