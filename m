Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267211AbUGMXGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267211AbUGMXGr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 19:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267215AbUGMXGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 19:06:47 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:9192 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S267211AbUGMXGh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 19:06:37 -0400
Message-ID: <40F46A7F.5000703@pacbell.net>
Date: Tue, 13 Jul 2004 16:04:31 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: Stuart_Hayes@Dell.com, whbeers@mbio.ncsu.edu, olh@suse.de,
       Gary_Lerhaupt@Dell.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] proper bios handoff in ehci-hcd
References: <7A8F92187EF7A249BF847F1BF4903C046304CF@ausx2kmpc103.aus.amer.dell.com> <20040713145628.27ae43e7@lembas.zaitcev.lan>
In-Reply-To: <20040713145628.27ae43e7@lembas.zaitcev.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:

> I hit regressions when we implemented the proper handoff as requested
> by Stuart @Dell, so I think for the moment the right thing would be this:
> 
> --- linux-2.4.21-15.18.EL/drivers/usb/host/ehci-hcd.c	2004-07-01
> 08:07:56.000000000 -0700
> +++ linux-2.4.21-15.18-usb/drivers/usb/host/ehci-hcd.c	2004-07-08
> 15:15:05.944863675 -0700
> @@ -302,7 +302,8 @@
>  		if (cap & (1 << 16)) {
>  			ehci_err (ehci, "BIOS handoff failed (%d, %04x)\n",
>  				where, cap);
> -			return 1;
> +			pci_write_config_dword (ehci->hcd.pdev, where, 0);
> +			return 0;
>  		} 
>  		ehci_dbg (ehci, "BIOS handoff succeeded\n");
>  	}
> 
> Essentially, here I insist on doing the right thing with cap|=(1<<24),
> which fixes Dell boxes which implement proper handoff, but then if we
> time out as on Thinkpads, write zero as the old code did (probably
> pointless, but just to be safe) and continue.

I'd rather not change the config space again ... that's clearly wrong.
Or is there some policy about what sorts of BIOS bugs we should assume?

Instead, how about:  (a) longer timeout, 5 seconds to match OHCI's
absurdly long default there; (b) change that "handoff failed" message
to add "continuing anyway"; and (c) return 0 as you do, which I'm
expecting is the key part of that patch.

That'll evidently work for Will, as well as correctly functioning hardware
with EHCI-aware BIOS (the Dell boxes and the AMI BIOS box I tested) also
the classic EHCI-unaware BIOS setups.

- Dave


