Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVETNYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVETNYo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 09:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVETNYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 09:24:35 -0400
Received: from mail.baslerweb.com ([145.253.187.130]:20965 "EHLO
	mail.baslerweb.com") by vger.kernel.org with ESMTP id S261468AbVETNYR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 09:24:17 -0400
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: "Linux/MIPS Development" <linux-mips@linux-mips.org>,
       linux-kernel@vger.kernel.org
Subject: vmap() problem, possible bug?
Date: Fri, 20 May 2005 15:23:52 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Message-Id: <200505201523.52194.thomas.koeller@baslerweb.com>
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

writing a device driver I came across something that looks
to me like a bug in the vmap() function. I am using kernel
2.6.11-rc1 (from linux-mips.org cvs, but the problem is
probably not mips-specific).

My driver transfers large amounts of data using DMA to a
buffer passed in from userland and translated to a page
list via get_user_pages(). Due to alignment restrictions
imposed by the DMA hardware, I have to use a temporary
buffer page for a part of the data buffer, and to copy
the data from this page to the actual buffer using
memcpy(). To be able to to so, I am using vmap() to create
a temporary mapping for the part of the buffer where the
data is to be copied, do the copy, and then call vunmap()
to remove the mapping:



if (pkt->copy_size) {
	const unsigned int page_order =
		(pkt->copy_size > PAGE_SIZE) ? 1 : 0;
	void * const dst = vmap(pkt->copy_pg, 0x1 << page_order,
				VM_MAP, PAGE_USERIO);

	if (dst) {
		memcpy(dst + pkt->copy_offs, pkt->copy_src,
		       pkt->copy_size);
		free_pages((unsigned long) pkt->copy_src, page_order);
		vunmap(dst);
	} else {
		pkt->pset->status = XICAP_BUFSTAT_VMERR;
	}
}



The code above is executed once for every data buffer
processed. It works as expected most of the time, but
every once in a while the data copied is not written to
the correct location, but to the previously processed
buffer instead. It looks as if the mapping established
for that buffer had survived the vunmap() / vmap() sequence.

In case it matters, my system is single core (not SMP).
Any ideas, anybody?

tk
-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================

