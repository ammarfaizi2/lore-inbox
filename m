Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264627AbUF1BpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264627AbUF1BpG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 21:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264633AbUF1BpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 21:45:05 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:38897 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264627AbUF1Bo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 21:44:59 -0400
Date: Sun, 27 Jun 2004 18:44:43 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Erik Jacobson <erikj@subway.americas.sgi.com>,
       Christoph Hellwig <hch@infradead.org>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
Message-ID: <20040628014443.GA24247@taniwha.stupidest.org>
References: <200406231754.56837.jbarnes@engr.sgi.com> <Pine.SGI.4.53.0406242153360.343801@subway.americas.sgi.com> <20040625083130.GA26557@infradead.org> <Pine.SGI.4.53.0406250742350.377639@subway.americas.sgi.com> <20040625124807.GA29937@infradead.org> <Pine.SGI.4.53.0406250751470.377692@subway.americas.sgi.com> <20040626235248.GC12761@taniwha.stupidest.org> <Pine.SGI.4.53.0406271908390.524706@subway.americas.sgi.com> <20040628003311.GA23017@taniwha.stupidest.org> <20040628021439.A17654@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040628021439.A17654@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 02:14:39AM +0100, Russell King wrote:

> It's the way its always been done, and the way the tty layer works.
> You register a range of ttys that you're going to be driving, and
> you own those ttys whether or not you actually have hardware for
> them.

How about this (yes, it's a hack but it's really not that bad and will
get things working until we can fix this up in 2.7.x):

===== drivers/serial/8250.c 1.55 vs edited =====
--- 1.55/drivers/serial/8250.c	2004-04-17 02:48:54 -07:00
+++ edited/drivers/serial/8250.c	2004-06-27 18:42:55 -07:00
@@ -2175,6 +2175,12 @@
 {
 	int ret, i;
 
+#if defined(__ia64__) && defined(ia64_platform_is)
+	/* SN2 cannot have 8250-like serial ports. */
+	if (ia64_platform_is("sn2"))
+		return -ENODEV;
+#endif
+
 	printk(KERN_INFO "Serial: 8250/16550 driver $Revision: 1.90 $ "
 		"%d ports, IRQ sharing %sabled\n", (int) UART_NR,
 		share_irqs ? "en" : "dis");


Completely untested of source, and we might want to move things around
a bit if early console stuff causes problems.

   --cw
