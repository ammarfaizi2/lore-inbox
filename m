Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262911AbVGKWJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbVGKWJH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbVGKWHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:07:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:60380 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262871AbVGKWDv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:03:51 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: fix CRC calculation on bigendian platforms.
In-Reply-To: <1121119377358@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 11 Jul 2005 15:02:57 -0700
Message-Id: <11211193771329@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1: fix CRC calculation on bigendian platforms.

In the 2.6.13-rc1 code the "rn" structure is in the wrong-endianness
when passed to w1_attach_slave_device(). This causes problems like the
family and crc being swapped around.

Signed-off-by: Roger Blofeld <blofeldus@yahoo.com>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 0e65f82814e9828d3ff54988de9e7c0b36794daa
tree a4d5dfb9ab550160a453c6266fe67d18ace76857
parent 80efa8c72006a1c04004f8fb07b22073348e4bf2
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Thu, 30 Jun 2005 22:52:38 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 11 Jul 2005 14:10:37 -0700

 drivers/w1/w1.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -516,6 +516,7 @@ static void w1_slave_found(unsigned long
 	struct w1_reg_num *tmp;
 	int family_found = 0;
 	struct w1_master *dev;
+	u64 rn_le = cpu_to_le64(rn);
 
 	dev = w1_search_master(data);
 	if (!dev) {
@@ -544,10 +545,8 @@ static void w1_slave_found(unsigned long
 		slave_count++;
 	}
 
-	rn = cpu_to_le64(rn);
-
 	if (slave_count == dev->slave_count &&
-		rn && ((le64_to_cpu(rn) >> 56) & 0xff) == w1_calc_crc8((u8 *)&rn, 7)) {
+		rn && ((rn >> 56) & 0xff) == w1_calc_crc8((u8 *)&rn_le, 7)) {
 		w1_attach_slave_device(dev, tmp);
 	}
 

