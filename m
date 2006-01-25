Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWAYW7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWAYW7a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWAYW7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:59:30 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:51206 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932207AbWAYW73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:59:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=sHYfzMV5craEa9i6whmae2nafnaVqhlbvPf8+5cauxaN6FYa6SDWp4LXMTa16OY67WUoouPO1ywOxqtHwfJoWRGu3F092Tt9dYwPOfD8PaeMXhIXaKEX8f2kbq5zvW4L0BWMMz3wde028KvxdQsNLT9k9XF43UR5NC8UMDXAmDA=
Message-ID: <4807377b0601251459p76e4a6a1x1295ee3fd0cf95a5@mail.gmail.com>
Date: Wed, 25 Jan 2006 14:59:28 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: Sai Bathina <sai.bathina@gmail.com>
Subject: Re: 2.6.14.3 and page allocation failures..
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <32e47b670601231255l16fa0fa5i20823aab0c213971@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_70343_20163799.1138229968941"
References: <1138048153.136509.119540@f14g2000cwb.googlegroups.com>
	 <32e47b670601231255l16fa0fa5i20823aab0c213971@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_70343_20163799.1138229968941
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 1/23/06, Sai Bathina <sai.bathina@gmail.com> wrote:
> Hi,
>      I am seeing page allocation errors and I have a snapshot of the
> /var/log/messages.
>
> My Hardware configs are
> Dell 750, using e1000 driver(e1000-6.2.15)

there is a leak in the 6.2.15 driver (this leak was not in the code
submitted to the kernel)

you can either use 6.3.9 or you can fix this by applying this attached
patch (or something similar)

Jesse

------=_Part_70343_20163799.1138229968941
Content-Type: application/octet-stream; 
	name="allocate_rx_buffer_change from 6.2.15-to-6.3.9.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="allocate_rx_buffer_change from 6.2.15-to-6.3.9.patch"

--- linux-2.6.5-7.244/drivers/net/e1000/e1000_main.c.orgi	2006-01-12 22:03:43.147940808 -0600
+++ linux-2.6.5-7.244/drivers/net/e1000/e1000_main.c	2006-01-12 22:03:38.000000000 -0600
@@ -441,9 +441,14 @@ e1000_up(struct e1000_adapter *adapter)
 	e1000_configure_tx(adapter);
 	e1000_setup_rctl(adapter);
 	e1000_configure_rx(adapter);
-	for (i = 0; i < adapter->num_queues; i++)
-		adapter->alloc_rx_buf(adapter, &adapter->rx_ring[i],
-					adapter->rx_ring[i].count);
+	/* call E1000_DESC_UNUSED which always leaves
+	 * at least 1 descriptor unused to make sure
+	 * next_to_use != next_to_clean */
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		struct e1000_rx_ring *ring = &adapter->rx_ring[i];
+		adapter->alloc_rx_buf(adapter, ring,
+		                      E1000_DESC_UNUSED(ring));
+	}
 
 #ifdef CONFIG_PCI_MSI
 	if(adapter->hw.mac_type > e1000_82547_rev_2) {

------=_Part_70343_20163799.1138229968941--
