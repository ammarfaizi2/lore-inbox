Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264080AbTEOPqk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 11:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264081AbTEOPqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 11:46:40 -0400
Received: from palrel11.hp.com ([156.153.255.246]:38842 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264080AbTEOPqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 11:46:38 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16067.47444.422275.965510@napali.hpl.hp.com>
Date: Thu, 15 May 2003 08:59:16 -0700
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: davidm@hpl.hp.com, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net,
       Jeff.Wiedemeier@hp.com
Subject: Re: Improved DRM support for cant_use_aperture platforms
In-Reply-To: <1052921284.18105.168.camel@thor>
References: <200305101009.h4AA9GZi012265@napali.hpl.hp.com>
	<1052653415.12338.159.camel@thor>
	<16062.37308.611438.5934@napali.hpl.hp.com>
	<20030511195543.GA15528@suse.de>
	<1052690133.10752.176.camel@thor>
	<16063.60859.712283.537570@napali.hpl.hp.com>
	<1052768911.10752.268.camel@thor>
	<16064.453.497373.127754@napali.hpl.hp.com>
	<1052774487.10750.294.camel@thor>
	<16064.5964.342357.501507@napali.hpl.hp.com>
	<1052786080.10763.310.camel@thor>
	<16064.41491.952068.159814@napali.hpl.hp.com>
	<1052921284.18105.168.camel@thor>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

In regards to the Alpha platform: Jeff Wiedemeier was able to get things
to work after applying the attached small patch.  He says:

  What was happening is that the offset was a system-relative
  representation of the address and the (agpmem->bound) was
  bus-relative, so it couldn't find the right agpmem.

  This patch makes the offset bus-relative before the scan (and with
  this patch, DRI/DRM is working on a Marvel...)

If it looks OK to you, can you add it?

Thanks,

	--david

diff -Nuar pre/drivers/char/drm/drm_memory.h post/drivers/char/drm/drm_memory.h
--- pre/drivers/char/drm/drm_memory.h	Wed May 14 20:04:17 2003
+++ post/drivers/char/drm/drm_memory.h	Wed May 14 20:05:31 2003
@@ -75,6 +75,10 @@
 
 	size = PAGE_ALIGN(size);
 
+#ifdef __alpha__
+	offset -= dev->hose->mem_space->start;
+#endif
+
 	for (agpmem = dev->agp->memory; agpmem; agpmem = agpmem->next)
 		if (agpmem->bound <= offset
 		    && (agpmem->bound + (agpmem->pages << PAGE_SHIFT)) >= (offset + size))
