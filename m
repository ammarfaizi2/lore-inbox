Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263089AbVFWUiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbVFWUiI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 16:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbVFWUeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 16:34:01 -0400
Received: from fmr21.intel.com ([143.183.121.13]:39065 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262954AbVFWUcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 16:32:52 -0400
Date: Thu, 23 Jun 2005 13:32:39 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Rajesh Shah <rajesh.shah@intel.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-mm1
Message-ID: <20050623133238.A24026@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050619233029.45dd66b8.akpm@osdl.org> <42B6746B.4020305@ens-lyon.org> <20050620081443.GA31831@isilmar.linta.de> <42B6831B.3040506@ens-lyon.org> <20050620085449.GA32330@isilmar.linta.de> <42B6C06F.4000704@ens-lyon.org> <20050622163427.A10079@unix-os.sc.intel.com> <42BA55D2.7020900@ens-lyon.org> <20050623100536.A21592@unix-os.sc.intel.com> <42BAFADF.2030804@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42BAFADF.2030804@ens-lyon.org>; from Brice.Goglin@ens-lyon.org on Thu, Jun 23, 2005 at 08:09:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 08:09:35PM +0200, Brice Goglin wrote:
> dmesg and dsdt are attached.
> 
The host bridge resources being reported were fine. I think this
failure is a yenta bug exposed by the combination of the host
bridge resource collection patch and the patch to improve the
handling for transparent bridges. I think the yenta code thinks
there's a resource conflict for the ranges being decoded by the
cardbus bridge when in fact there isn't any conflict in this case.
It then claims and reprograms the cardbus bridge to IO resources
that are already programmed into another device (winmodem in this
case), causing problems.

Does the following patch to 2.6.12-mm1 fix the problem?
------------------------------

Index: linux-2.6.12-mm1/drivers/pcmcia/yenta_socket.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/pcmcia/yenta_socket.c
+++ linux-2.6.12-mm1/drivers/pcmcia/yenta_socket.c
@@ -562,9 +562,6 @@ static int yenta_try_allocate_res(struct
 	bus = socket->dev->subordinate;
 	res = socket->dev->resource + PCI_BRIDGE_RESOURCES + nr;
 	res->name = bus->name;
-	res->flags = type;
-	res->start = 0;
-	res->end = run;
 	root = pci_find_parent_resource(socket->dev, res);
 
 	if (!root)
