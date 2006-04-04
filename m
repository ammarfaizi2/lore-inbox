Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWDEAAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWDEAAw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWDEAAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:00:44 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:65167
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750951AbWDEAA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:00:27 -0400
Date: Tue, 4 Apr 2006 16:59:43 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Eugene Teo <eugene.teo@eugeneteo.net>,
       David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 02/26] USB: Fix irda-usb use after use
Message-ID: <20060404235943.GC27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-0079-Fix-irda-usb-use-after-use.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't read from free'd memory after calling netif_rx().  docopy is used as
a boolean (0 and 1) so unsigned int is sufficient.

Coverity bug #928

Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>
Cc: "David Miller" <davem@davemloft.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/net/irda/irda-usb.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.16.1.orig/drivers/net/irda/irda-usb.c
+++ linux-2.6.16.1/drivers/net/irda/irda-usb.c
@@ -740,7 +740,7 @@ static void irda_usb_receive(struct urb 
 	struct sk_buff *newskb;
 	struct sk_buff *dataskb;
 	struct urb *next_urb;
-	int		docopy;
+	unsigned int len, docopy;
 
 	IRDA_DEBUG(2, "%s(), len=%d\n", __FUNCTION__, urb->actual_length);
 	
@@ -851,10 +851,11 @@ static void irda_usb_receive(struct urb 
 	dataskb->dev = self->netdev;
 	dataskb->mac.raw  = dataskb->data;
 	dataskb->protocol = htons(ETH_P_IRDA);
+	len = dataskb->len;
 	netif_rx(dataskb);
 
 	/* Keep stats up to date */
-	self->stats.rx_bytes += dataskb->len;
+	self->stats.rx_bytes += len;
 	self->stats.rx_packets++;
 	self->netdev->last_rx = jiffies;
 

--
