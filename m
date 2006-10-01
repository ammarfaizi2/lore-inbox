Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWJAO6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWJAO6n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 10:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWJAO6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 10:58:43 -0400
Received: from havoc.gtf.org ([69.61.125.42]:37098 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750877AbWJAO6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 10:58:42 -0400
Date: Sun, 1 Oct 2006 10:58:41 -0400
From: Jeff Garzik <jeff@garzik.org>
To: minyard@acm.org, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ipmi: fix uninit'd data bug
Message-ID: <20061001145841.GA3703@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc issues the following warning:

drivers/char/ipmi/ipmi_si_intf.c: In function ‘init_ipmi_si’:
drivers/char/ipmi/ipmi_si_intf.c:1729: warning: ‘data.irq’ may be used uninitialized in this function

This is indeed a bug.  data.irq is completely uninitialized in some code
paths.  Worse than that, data from a previous decode_dmi() run can
easily leak through successive calls.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index abca98b..0afd7f8 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1730,6 +1730,7 @@ static void __devinit dmi_find_bmc(void)
 	int                  rv;
 
 	while ((dev = dmi_find_device(DMI_DEV_TYPE_IPMI, NULL, dev))) {
+		memset(&data, 0, sizeof(data));
 		rv = decode_dmi((struct dmi_header *) dev->device_data, &data);
 		if (!rv)
 			try_init_dmi(&data);
