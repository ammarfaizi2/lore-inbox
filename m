Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266078AbUGMVhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266078AbUGMVhu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 17:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266085AbUGMVhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 17:37:50 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:62441 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S266078AbUGMVhr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 17:37:47 -0400
Message-ID: <40F455B0.2090008@pacbell.net>
Date: Tue, 13 Jul 2004 14:35:44 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Will Beers <whbeers@mbio.ncsu.edu>
CC: Olaf Hering <olh@suse.de>, Gary_Lerhaupt@Dell.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Stuart_Hayes@Dell.com
Subject: Re: [linux-usb-devel] [PATCH] proper bios handoff in ehci-hcd
References: <FD3BA83843210C4BA9E414B0C56A5E5C07DD91@ausx2kmpc104.aus.amer.dell.com> <40CF0049.2010307@pacbell.net> <20040713180727.GA11583@suse.de> <40F4457F.2010005@pacbell.net> <40F449BD.2030508@mbio.ncsu.edu> <40F44FFB.80707@pacbell.net> <40F45327.1080703@mbio.ncsu.edu>
In-Reply-To: <40F45327.1080703@mbio.ncsu.edu>
Content-Type: multipart/mixed;
 boundary="------------060800020400070808000605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060800020400070808000605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Will Beers wrote:
>  > Sounds to me like your BIOS may be broken.  But if you're
>  > up for it, you could try using byte access to write that one
> 
> Changing the pci_read_config to a byte access fixes it, thanks!

You're reading byte 0 not byte 2 of that field ... I meant
more like the attached patch to _write_ the flag (untested).


> -                       pci_read_config_dword(pdev, where, &cap);
> +                       pci_read_config_byte(pdev, where, &cap);

--------------060800020400070808000605
Content-Type: text/plain;
 name="Diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Diff"

--- 1.89/drivers/usb/host/ehci-hcd.c	Wed Jun 30 19:10:04 2004
+++ edited/drivers/usb/host/ehci-hcd.c	Tue Jul 13 14:33:41 2004
@@ -293,8 +293,7 @@
 		struct pci_dev *pdev = to_pci_dev(ehci->hcd.self.controller);
 
 		/* request handoff to OS */
-		cap |= 1 << 24;
-		pci_write_config_dword(pdev, where, cap);
+		pci_write_config_byte(pdev, where + 3, 1);
 
 		/* and wait a while for it to happen */
 		do {

--------------060800020400070808000605--

