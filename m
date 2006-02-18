Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWBRMXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWBRMXS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWBRMXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:23:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20942 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751178AbWBRMXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:23:18 -0500
Date: Sat, 18 Feb 2006 12:23:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org, SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com,
       HNGUYEN@de.ibm.com, MEDER@de.ibm.com
Subject: Re: [PATCH 03/22] pHype specific stuff
Message-ID: <20060218122317.GF911@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc64-dev@ozlabs.org, openib-general@openib.org,
	SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
	MEDER@de.ibm.com
References: <20060218005532.13620.79663.stgit@localhost.localdomain> <20060218005709.13620.77409.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218005709.13620.77409.stgit@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +u64 hipz_galpa_load(struct h_galpa galpa, u32 offset)
> +{
> +	u64 addr = galpa.fw_handle + offset;
> +	u64 out;
> +	EDEB_EN(7, "addr=%lx offset=%x ", addr, offset);
> +	out = *(u64 *) addr;

why does this cast an u64 to a pointer?

> +#ifndef EHCA_USERDRIVER
> +inline static int hcall_map_page(u64 physaddr, u64 * mapaddr)
> +{
> +	*mapaddr = (u64)(ioremap(physaddr, 4096));
> +
> +	EDEB(7, "ioremap physaddr=%lx mapaddr=%lx", physaddr, *mapaddr);
> +	return 0;

ioremap returns void __iomem * and casting that to any integer type is
wrong.

> +inline static int hcall_unmap_page(u64 mapaddr)
> +{
> +	EDEB(7, "mapaddr=%lx", mapaddr);
> +	iounmap((void *)(mapaddr));
> +	return 0;

dito for iounmap and casting back.

guys, please run this driver through sparse, thanks.

> +	/* if phype returns LongBusyXXX,
> +	 * we retry several times, but not forever */
> +	for (i = 0; i < 5; i++) {
> +		__asm__ __volatile__("mr 3,%10\n"
> +				     "mr 4,%11\n"
> +				     "mr 5,%12\n"

assembly code under drivers/ is not acceptable.  please create
and <asm/ehca.h> for it or something similar.

