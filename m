Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVANTtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVANTtc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 14:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVANTtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 14:49:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46769 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261463AbVANTtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 14:49:19 -0500
Date: Fri, 14 Jan 2005 14:49:10 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>
Subject: [PATCH] fix xenU kernel crash in dmi_iterate
Message-ID: <Pine.LNX.4.61.0501141446010.2701@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

In unprivileged Xen domains, all that __ioremap() does is a
"return NULL", which causes dmi_iterate() to crash the kernel
at boot time.

This trivial check bails dmi_iterate() out of the loop when
it finds that the ioremap() returned a NULL pointer.

Signed-off-by: Rik van Riel <riel@redhat.com>

--- linux/arch/i386/kernel/dmi_scan.c.orig	2005-01-12 14:55:14.000000000 -0500
+++ linux/arch/i386/kernel/dmi_scan.c	2005-01-12 16:06:27.000000000 -0500
@@ -105,6 +105,8 @@
  	char __iomem *p, *q;

  	for (p = q = ioremap(0xF0000, 0x10000); q < p + 0x10000; q += 16) {
+		if (p == NULL)
+			return -1;
  		memcpy_fromio(buf, q, 15);
  		if(memcmp(buf, "_DMI_", 5)==0 && dmi_checksum(buf))
  		{
