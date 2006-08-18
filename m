Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751573AbWHRXDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbWHRXDT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 19:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWHRXDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 19:03:19 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:39420 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751572AbWHRXDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 19:03:18 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/6]: powerpc/cell spidernet bottom half
Date: Sat, 19 Aug 2006 01:03:04 +0200
User-Agent: KMail/1.9.1
Cc: Linas Vepstas <linas@austin.ibm.com>, Jeff Garzik <jgarzik@pobox.com>,
       akpm@osdl.org, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       ens Osterkamp <Jens.Osterkamp@de.ibm.com>
References: <20060818220700.GG26889@austin.ibm.com> <20060818222657.GL26889@austin.ibm.com>
In-Reply-To: <20060818222657.GL26889@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608190103.05649.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 August 2006 00:26, Linas Vepstas wrote:
> The recent set of low-waterark patches for the spider result in a
> significant amount of computing being done in an interrupt context.
> This patch moves this to a "bottom half" aka work queue, so that
> the code runs in a normal kernel context. Curiously, this seems to 
> result in a performance boost of about 5% for large packets.

I guess this one still needs some work. We already have a bottom
half mechanism in the network layer, using the NAPI poll function
that is strongly serialized.

Linas, you wrote that you have tried doing the TX descriptor cleanup
in dev->poll(), but I think you missed the point that this function
needs should then be scheduled whenever necessary.

This seems a little strange, but I think what we need to do is in the
low-watermark interrupt call netif_rx_schedule(netdev) in order to
arrange for the ->poll function to be called in the next softirq.

Someone should probably document that in 
Documentation/networking/NAPI_HOWTO.txt, I might end up doing that
once we get it right for spidernet.

	Arnd <><
