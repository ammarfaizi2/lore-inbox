Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263886AbTJ1Ikd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 03:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263887AbTJ1Ikd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 03:40:33 -0500
Received: from eta.fastwebnet.it ([213.140.2.50]:22180 "EHLO eta.fastwebnet.it")
	by vger.kernel.org with ESMTP id S263886AbTJ1Ikb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 03:40:31 -0500
Message-ID: <3F9E2B6C.30000@revicon.com>
Date: Tue, 28 Oct 2003 09:40:12 +0100
From: Lars Knudsen <gandalf@revicon.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mufasa@sis.com.tw
Subject: SiS900 driver multicast problems and patch.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading to kernel 2.4.22 we discovered that multicast was no 
longer handled properly by the SiS900. Examining the changes between 
2.4.19 and 2.4.22 it is clear that the handling of multicast was changed 
but a bug was introduced.

A simple set_bit call from 2.4.19 was changed to the following:

u16 mc_filter[16] = {0};

unsigned int bit_nr =
         sis900_mcast_bitnr(mclist->dmi_addr, revision);
          mc_filter[bit_nr >> 4] |= (1 << bit_nr);

This will not work for bit_nr larger than 16 and hence the failure. 
Reverting to use set_bit causes multicast to be handled properly.

\Lars Knudsen

--- sis900.c    Mon Oct 27 17:49:36 2003
+++ sis900.c.orig       Mon Oct 27 17:48:52 2003
@@ -2101,8 +2101,9 @@
                rx_mode = RFAAB;
                for (i = 0, mclist = net_dev->mc_list; mclist && i < 
net_dev->mc_count;
                     i++, mclist = mclist->next) {
-                       set_bit(sis900_mcast_bitnr(mclist->dmi_addr, 
revision),
-                               mc_filter);
+                       unsigned int bit_nr =
+                               sis900_mcast_bitnr(mclist->dmi_addr, 
revision);
+                       mc_filter[bit_nr >> 4] |= (1 << bit_nr);
                }
        }


