Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbVH1AKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbVH1AKg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 20:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbVH1AKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 20:10:36 -0400
Received: from mail.dvmed.net ([216.237.124.58]:42937 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750874AbVH1AKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 20:10:35 -0400
Message-ID: <431100F1.2070207@pobox.com>
Date: Sat, 27 Aug 2005 20:10:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: [git patches] 2.6.x net driver fixes
Content-Type: multipart/mixed;
 boundary="------------030204010806000704080602"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030204010806000704080602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please pull from the 'upstream-fixes' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to obtain the fixes described in the diffstat/changelog/patch attached.


--------------030204010806000704080602
Content-Type: text/plain;
 name="netdev-2.6.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netdev-2.6.txt"

 drivers/net/hamradio/6pack.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)


commit 214838a2108b4b1e18abce2e28d37996e9bf7c68
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Wed Aug 24 18:01:33 2005 +0100

    [PATCH] Fix 6pack setting of MAC address
    
    Don't check type of sax25_family; dev_set_mac_address has already done
    that before and anyway, the type to check against would have been
    ARPHRD_AX25.  We only got away because AF_AX25 and ARPHRD_AX25 both happen
    to be defined to the same value.
    
    Don't check sax25_ndigis either; it's value is insignificant for the
    purpose of setting the MAC address and the check has shown to break
    some application software for no good reason.
    
    Signed-off-by: Ralf Baechle DL5RB <ralf@linux-mips.org>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

commit 84a2ea1c2cee0288f96e0c6aa4f975d4d26508c7
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Thu Aug 25 19:38:30 2005 +0100

    [PATCH] 6pack Timer initialization
    
    I dropped the timer initialization bits by accident when sending the
    p-persistence fix.  This patch gets the driver to work again on halfduplex
    links.
    
    Signed-off-by: Ralf Baechle DL5RB <ralf@linux-mips.org>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>


diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -308,12 +308,6 @@ static int sp_set_mac_address(struct net
 {
 	struct sockaddr_ax25 *sa = addr;
 
-	if (sa->sax25_family != AF_AX25)
-		return -EINVAL;
-
-	if (!sa->sax25_ndigis)
-		return -EINVAL;
-
 	spin_lock_irq(&dev->xmit_lock);
 	memcpy(dev->dev_addr, &sa->sax25_call, AX25_ADDR_LEN);
 	spin_unlock_irq(&dev->xmit_lock);
@@ -668,6 +662,9 @@ static int sixpack_open(struct tty_struc
 	netif_start_queue(dev);
 
 	init_timer(&sp->tx_t);
+	sp->tx_t.function = sp_xmit_on_air;
+	sp->tx_t.data = (unsigned long) sp;
+
 	init_timer(&sp->resync_t);
 
 	spin_unlock_bh(&sp->lock);

--------------030204010806000704080602--
