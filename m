Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVFVMME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVFVMME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 08:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVFVMME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 08:12:04 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:27318 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261176AbVFVML7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 08:11:59 -0400
Date: Wed, 22 Jun 2005 16:11:42 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Grant Coady <grant_lkml@dodo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm1 breaks Toshiba laptop yenta cardbus
Message-ID: <20050622161142.A32391@jurassic.park.msu.ru>
References: <s32db1toatpgar8nun4m5rtqq97hkbk2ab@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <s32db1toatpgar8nun4m5rtqq97hkbk2ab@4ax.com>; from grant_lkml@dodo.com.au on Mon, Jun 20, 2005 at 07:15:34PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 07:15:34PM +1000, Grant Coady wrote:
> Yenta: CardBus bridge found at 0000:00:0b.0 [1179:0001]
> yenta 0000:00:0b.0: Preassigned resource 0 busy, reconfiguring...

In -mm1 the cardbus resources might be assigned in
pci_assign_unassigned_resources() pass. From your dmesg:
PCI: Bus 2, cardbus bridge: 0000:00:0b.0
  IO window: 00002000-00002fff
  IO window: 00003000-00003fff
  PREFETCH window: 12000000-13ffffff
  MEM window: 14000000-15ffffff

Then yenta_allocate_res() tries to assign these resources again and,
naturally, fails.

This adds check for already assigned cardbus resources.

Ivan.

--- 2.6.12-mm1/drivers/pcmcia/yenta_socket.c	Wed Jun 22 15:56:20 2005
+++ linux/drivers/pcmcia/yenta_socket.c	Wed Jun 22 16:01:40 2005
@@ -553,6 +553,11 @@ static int yenta_try_allocate_res(struct
 	unsigned offset;
 	unsigned mask;
 
+	res = socket->dev->resource + PCI_BRIDGE_RESOURCES + nr;
+	/* Already allocated? */
+	if (res->parent)
+		return 0;
+
 	/* The granularity of the memory limit is 4kB, on IO it's 4 bytes */
 	mask = ~0xfff;
 	if (type & IORESOURCE_IO)
@@ -560,7 +565,6 @@ static int yenta_try_allocate_res(struct
 
 	offset = 0x1c + 8*nr;
 	bus = socket->dev->subordinate;
-	res = socket->dev->resource + PCI_BRIDGE_RESOURCES + nr;
 	res->name = bus->name;
 	res->flags = type;
 	res->start = 0;
