Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVEOJDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVEOJDu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 05:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVEOJDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 05:03:50 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:5618 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261567AbVEOJDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 05:03:47 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH][CFT] CDRW/DVD packet writing data corruption fix
From: Peter Osterlund <petero2@telia.com>
Date: 15 May 2005 11:03:44 +0200
Message-ID: <m3wtq0svwv.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a bug in the packet writing driver that could cause data
corruption. The problem arised if the driver got a write request for a
sector in a "zone" it was already working on. In that case it was
supposed to queue the write request until it was done processing
earlier requests for the same zone, and instead work on some other
zone in the mean time. However, if there was no other zone to work on,
the driver would initiate two packet_data objects for the same zone,
causing unpredictable things to happen.

I haven't tested this as much as I want yet, so I don't know if there
are more data corruption bugs in the driver. Test reports would be
appreciated.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/block/pktcdvd.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN drivers/block/pktcdvd.c~packet-corruption-fix drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-corruption-fix	2005-05-15 10:53:00.000000000 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2005-05-15 10:53:00.000000000 +0200
@@ -926,8 +926,10 @@ static int pkt_handle_queue(struct pktcd
 		bio = node->bio;
 		zone = ZONE(bio->bi_sector, pd);
 		list_for_each_entry(p, &pd->cdrw.pkt_active_list, list) {
-			if (p->sector == zone)
+			if (p->sector == zone) {
+				bio = NULL;
 				goto try_next_bio;
+			}
 		}
 		break;
 try_next_bio:
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
