Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932617AbVIMLpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbVIMLpr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 07:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbVIMLpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 07:45:47 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:49629 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S932617AbVIMLpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 07:45:46 -0400
Date: Tue, 13 Sep 2005 15:45:29 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Olaf Hering <olh@suse.de>
Cc: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Marcus Wegner <wegner3000@hotmail.com>
Subject: Re: 2.6.13: Crash in Yenta initialization
Message-ID: <20050913154529.C15709@jurassic.park.msu.ru>
References: <200509030138.11905.koch@esa.informatik.tu-darmstadt.de> <200509030245.12610.koch@esa.informatik.tu-darmstadt.de> <20050903223401.A7470@jurassic.park.msu.ru> <20050912174209.GA3965@suse.de> <20050913000733.A14261@jurassic.park.msu.ru> <20050913063053.GA24158@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050913063053.GA24158@suse.de>; from olh@suse.de on Tue, Sep 13, 2005 at 08:30:53AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 08:30:53AM +0200, Olaf Hering wrote:
> The reporter has updated the bug.
> 
> https://bugzilla.novell.com/attachment.cgi?id=49717
> https://bugzilla.novell.com/attachment.cgi?id=49715
> https://bugzilla.novell.com/attachment.cgi?id=49716

Thanks, that helped.

The reason was that Acer BIOS left only _two_ bus numbers available
for _three_ cardbus controllers, so pci_scan_bridge() assigns both
numbers to the first controller and leaves two other ones uninitialized.

Please try the patch here, but note that you'll apparently have only
one cardbus slot working. If you want more, use "pci=assign-busses"
boot option.

Ivan.

--- 2.6.14-rc1/drivers/pcmcia/yenta_socket.c	Tue Sep 13 14:16:34 2005
+++ linux/drivers/pcmcia/yenta_socket.c	Tue Sep 13 14:40:40 2005
@@ -1045,7 +1045,18 @@ static int __devinit yenta_probe (struct
 {
 	struct yenta_socket *socket;
 	int ret;
-	
+
+	/*
+	 * If we failed to assign proper bus numbers for this cardbus
+	 * controller during PCI probe, its subordinate pci_bus is NULL.
+	 * Bail out if so.
+	 */
+	if (!dev->subordinate) {
+		printk(KERN_ERROR "Yenta: no bus associated with %s!\n",
+			pci_name(dev));
+		return -ENODEV;
+	}
+
 	socket = kmalloc(sizeof(struct yenta_socket), GFP_KERNEL);
 	if (!socket)
 		return -ENOMEM;
