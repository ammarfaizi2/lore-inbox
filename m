Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVBNT7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVBNT7G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 14:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVBNT7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 14:59:06 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:63875 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261548AbVBNT7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 14:59:04 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: avoiding pci_disable_device()...
X-Message-Flag: Warning: May contain useful information
References: <4210021F.7060401@pobox.com> <20050214190619.GA9241@kroah.com>
	<4211013E.6@pobox.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 14 Feb 2005 11:58:38 -0800
In-Reply-To: <4211013E.6@pobox.com> (Jeff Garzik's message of "Mon, 14 Feb
 2005 14:51:26 -0500")
Message-ID: <52hdke29sh.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 14 Feb 2005 19:58:38.0675 (UTC) FILETIME=[932E6A30:01C512CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jeff> * pci_request_regions() should be axiomatic.  By that I mean,
    Jeff> pci_enable_device() should
    Jeff> 	(a) handle pci_request_regions() completely
    Jeff> 	(b) fail if regions are not available

There's one pitfall here: for a device using MSI-X, the MSI-X table is
going to be somewhere in one of the device's BARs.  When the device
driver does pci_enable_msix(), drivers/pci/msi.c will do
request_region() on this table.  If the device driver has already done
pci_request_regions(), then this will fail and the driver won't be
able to use MSI-X.  The current solution is for the driver to avoid
requesting the whole BAR where the MSI-X table is.

 - R.
