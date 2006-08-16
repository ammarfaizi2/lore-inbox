Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWHPV1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWHPV1d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 17:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWHPV1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 17:27:33 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:27345 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932240AbWHPV1c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 17:27:32 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
Date: Wed, 16 Aug 2006 23:24:46 +0200
User-Agent: KMail/1.9.1
Cc: jeff@garzik.org, linas@austin.ibm.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       jklewis@us.ibm.com, Jens.Osterkamp@de.ibm.com, akpm@osdl.org
References: <44E34825.2020105@garzik.org> <44E38157.4070805@garzik.org> <20060816.134640.115912460.davem@davemloft.net>
In-Reply-To: <20060816.134640.115912460.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608162324.47235.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wednesday 16 August 2006 22:46 schrieb David Miller:
> I'm not familiar with the spidernet TX side interrupt capabilities
> so I can't say whether that is something that can be directly
> implied.  In fact, I get the impression that spidernet is limited
> in some way and that's where all the strange approaches are coming
> from :)

Actually, the capabilities of the chip are quite powerful, it only
seems to be hard to make it go fast using any of them. That may
be the fault of strange locking rules and other bugs we had in
the driver before, so maybe you can recommend which one to use.

Cleaning up the TX queue only from ->poll() like all the others
sounds like the right approach to simplify the code.

The spider hardware offers at least these options:

- end of TX queue interrupt
- set a per-descriptor bit to fire an interrupt at a specific frame
- an interrupt for each frame (may be multiple descriptors)
- an interrupt for each descriptor
- timers implemented in the spidernet hardware

We first had an interrupt per descriptor, then got rid of all TX
interrupts and replaced them by timers to reduce the interrupt load,
but reducing throughput in the case where user space sleeps on a full
socket buffer.

The last patches that were suggested introduce marking a single descriptor
(not the last one, but somewhere near the end of the queue) so we fire
an interrupt just before the TX queue gets empty.

	Arnd <><
