Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267897AbTBEKQm>; Wed, 5 Feb 2003 05:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267898AbTBEKQm>; Wed, 5 Feb 2003 05:16:42 -0500
Received: from ns.suse.de ([213.95.15.193]:64268 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267897AbTBEKQl>;
	Wed, 5 Feb 2003 05:16:41 -0500
Date: Wed, 5 Feb 2003 11:26:14 +0100
From: Marcus Meissner <meissner@suse.de>
To: jgarzik@pobox.com, davem@redhat.com, linux-kernel@vger.kernel.org
Cc: engebret@us.ibm.com
Subject: [PATCH] fixed pcnet32 multicast listen on big endian
Message-ID: <20030205102614.GA10223@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Lotus Notes Linux/PPC Pre-Release 5.0.1  October 21, 2002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This fixes multicast listen for pcnet32 on at least powerpc and powerpc64
kernels.

The mcast_table is in memory referenced by the card and so it needs
to be accessed in little endian mode.

Ciao, Marcus

--- linux-2.4.19/drivers/net/pcnet32.c.be	2003-02-05 07:59:27.000000000 +0100
+++ linux-2.4.19/drivers/net/pcnet32.c	2003-02-05 08:00:22.000000000 +0100
@@ -1534,7 +1534,9 @@
 	
 	crc = ether_crc_le(6, addrs);
 	crc = crc >> 26;
-	mcast_table [crc >> 4] |= 1 << (crc & 0xf);
+	mcast_table [crc >> 4] = le16_to_cpu(
+		le16_to_cpu(mcast_table [crc >> 4]) | (1 << (crc & 0xf))
+	);
     }
     return;
 }
