Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbTHZSEh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 14:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbTHZSEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 14:04:37 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:4781 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S262887AbTHZSEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 14:04:21 -0400
Message-Id: <200308261804.h7QI4OxB057826@d12relay02.megacenter.de.ibm.com>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH resend #1] fix cu3088 group write
To: Guillaume Morin <guillaume@morinfr.org>, linux-kernel@vger.kernel.org
Date: Mon, 25 Aug 2003 12:47:29 +0200
References: <mi9I.54n.13@gated-at.bofh.it> <oqcQ.6L8.11@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Morin wrote:

> Hi Linus, Andrew
>  
> The current cu3088 ccwgroup write code overwrite the last char of the
> given arguments. This following patch fixes the problem. It is been
> tested and applies on latest bk.

Your fix doesn't look right either. The input string should not 
be longer than BUS_ID_SIZE, including the trailing zero.
AFAICS, the correct way to solve this is the patch below,
but I did not test it. Thanks for reporting the problem.

        Arnd <><

===== drivers/s390/net/cu3088.c 1.5 vs edited =====
--- 1.5/drivers/s390/net/cu3088.c       Mon May 26 02:00:00 2003
+++ edited/drivers/s390/net/cu3088.c    Mon Aug 25 12:42:39 2003
@@ -79,7 +79,7 @@
 
                if (!(end = strchr(start, delim[i])))
                        return count;
-               len = min_t(ptrdiff_t, BUS_ID_SIZE, end - start);
+               len = min_t(ptrdiff_t, BUS_ID_SIZE, end - start + 1);
                strlcpy (bus_ids[i], start, len);
                argv[i] = bus_ids[i];
                start = end + 1;
