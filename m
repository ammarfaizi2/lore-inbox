Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVAPKdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVAPKdK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 05:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVAPKdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 05:33:09 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:45320 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262472AbVAPKdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 05:33:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=NgQCHZ4i4jfnPsMvn7gj8ESfVnoHyLsy9MDw4iOT8g2iwNdgzQMgSf8SJzlYDKy2eJkELUoSiL6mJMMIz/Ml16GKQgpzaC3FNWMRkN+4jx6nV9uQPEg6exYblM2786OZLdmDNJsM3YMGHSwtQMR6fJvQdcLKHECCDybOPv6jcLs=
Message-ID: <9e473391050116023344a5f954@mail.gmail.com>
Date: Sun, 16 Jan 2005 05:33:05 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
Cc: Helge Hafting <helgehaf@aitel.hist.no>, covici@ccs.covici.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e997050116020859687c4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41E64DAB.1010808@hist.no>
	 <16870.21720.866418.326325@ccs.covici.com>
	 <21d7e997050113130659da39c9@mail.gmail.com>
	 <20050115185712.GA17372@hh.idb.hist.no>
	 <21d7e997050116020859687c4a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use PCI Rage128 cards which are working fine. 

I suspect it is this code from radeon_drv.c. There is probably
something wrong with card's BIOS or whatever and it is saying that it
is an AGP card when it is really a PCI one.  We used to specify this
manually in xconfig but now DRM code does it automatically. Fix is
probably to add a special case on the PCI_ID of the card that is
failing.

        /* There are signatures in BIOS and PCI-SSID for a PCI card,
but they are not very reliable.
        Following detection method works for all cards tested so far.
        Note, checking AGP_ENABLE bit after drmAgpEnable call can also
give the correct result.
        However, calling drmAgpEnable on a PCI card can cause some
strange lockup when the server
        restarts next time.
        */
        pci_read_config_dword(dev->pdev, RADEON_AGP_COMMAND_PCI_CONFIG, &save);
        pci_write_config_dword(dev->pdev, RADEON_AGP_COMMAND_PCI_CONFIG,
                               save | RADEON_AGP_ENABLE);
        pci_read_config_dword(dev->pdev, RADEON_AGP_COMMAND_PCI_CONFIG, &temp);
        if (temp & RADEON_AGP_ENABLE)
                dev_priv->flags |= CHIP_IS_AGP;
        DRM_DEBUG("%s card detected\n",
                  ((dev_priv->flags & CHIP_IS_AGP) ? "AGP" : "PCI"));
        pci_write_config_dword(dev->pdev, RADEON_AGP_COMMAND_PCI_CONFIG, save);



-- 
Jon Smirl
jonsmirl@gmail.com
