Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264763AbUFGPJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbUFGPJA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264756AbUFGPJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:09:00 -0400
Received: from mail.timesys.com ([65.117.135.102]:27339 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S264766AbUFGPIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:08:45 -0400
Message-ID: <40C484F9.20504@timesys.com>
Date: Mon, 07 Jun 2004 11:08:41 -0400
From: Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] jffs2 aligment problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jun 2004 14:56:17.0734 (UTC) FILETIME=[963D7E60:01C44C9F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixed some jffs2 alignment problems we saw on an IXP425 based 
XScale board. I just got pinged that I was supposed to post this patch 
in case anyone else finds it usefull. This was against a modified 2.4.19 
kernel.

Greg Weeks

Signed-off-by: Greg Weeks <greg.weeks@timesys.com> under TS0067


--- kernel/drivers/mtd/chips/cfi_cmdset_0001.c-orig
+++ kernel/drivers/mtd/chips/cfi_cmdset_0001.c

@@ -933,7 +933,7 @@
        cfi_word status, status_OK;
        unsigned long cmd_adr, timeo;
        DECLARE_WAITQUEUE(wait, current);
-       int wbufsize, z, suspended=0, ret=0;
+       int wbufsize, z, y, suspended=0, ret=0;

        wbufsize = CFIDEV_INTERLEAVE << cfi->cfiq->MaxBufWriteSize;
        adr += chip->start;
@@ -1064,12 +1064,18 @@

        /* Write data */
        for (z = 0; z < len; z += CFIDEV_BUSWIDTH) {
+               cfi_word aligned_val;
+               u_char *align_ptr = (u_char *) &aligned_val;
+
+               for (y = 0; y < CFIDEV_BUSWIDTH; y++)
+                       align_ptr[y] = *(buf++);
+
                if (cfi_buswidth_is_1()) {
-                       map->write8 (map, *((__u8*)buf)++, adr+z);
+                       map->write8 (map, *((__u8 *) &aligned_val), adr+z);
                } else if (cfi_buswidth_is_2()) {
-                       map->write16 (map, *((__u16*)buf)++, adr+z);
+                       map->write16 (map, *((__u16 *) &aligned_val), 
adr+z);
                } else if (cfi_buswidth_is_4()) {
-                       map->write32 (map, *((__u32*)buf)++, adr+z);
+                       map->write32 (map, *((__u32 *) &aligned_val), 
adr+z);
                } else {
                        DISABLE_VPP(map);
                        ret = -EINVAL;

