Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWH3Jnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWH3Jnj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 05:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWH3Jnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 05:43:39 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:35774 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750764AbWH3Jni
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 05:43:38 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 02/13] IB/ehca: includes
Date: Wed, 30 Aug 2006 11:43:34 +0200
User-Agent: KMail/1.9.1
Cc: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, abergman@de.ibm.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       Christoph Raisch <RAISCH@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
References: <OF23CA96AE.C7DBFD52-ONC12571DA.00321849-C12571DA.00324865@de.ibm.com>
In-Reply-To: <OF23CA96AE.C7DBFD52-ONC12571DA.00321849-C12571DA.00324865@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608301143.35320.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 August 2006 11:13, Hoang-Nam Nguyen wrote:
> Further comments/suggestions are appreciated!

There are a few places in the driver where you declare
external variables (mostly ehca_module and ehca_debug_level)
from C files instead of a header.  This sometimes leads
to bugs when a type changes and is therefore considered
bad style.

ehca_debug_level is already declared in a header so you
should not need any other declaration.

For ehca_module, the usage pattern is very uncommon.
Declaring the structure in a header helps a bit, but I
don't really see the need for this structure at all.

Each member of the struct seems to be used mostly in a
single file, so I would declare it statically in there.
E.g. in drivers/infiniband/hw/ehca/ehca_pd.c, you can do

static struct kmem_cache *ehca_pd_cache;

int ehca_init_pd_cache(void)
{
	ehca_pd_cache = kmem_cache_init("ehca_cache_pd",
		sizeof(struct ehca_pd), 0, SLAB_HWCACHE_ALIGN,
		NULL, NULL);

	if (!ehca_pd_cache)
		return -ENOMEM;
	return 0;
}

void ehca_cleanup_pd_cache(void)
{
	if (ehca_pd_cache)
		kmem_cache_destroy(ehca_pd_cache);
}

Moreover, for some of your more heavily used caches, you may
want to look into using constructor/destructor calls to
speed up allocation.

	Arnd <><
