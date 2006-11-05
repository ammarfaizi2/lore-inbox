Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422829AbWKEXqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422829AbWKEXqH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 18:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932750AbWKEXqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 18:46:06 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:17353 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932749AbWKEXqF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 18:46:05 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2.6.19 1/4] ehca: assure 4k alignment for firmware control block in 64k page mode
Date: Mon, 6 Nov 2006 00:45:58 +0100
User-Agent: KMail/1.9.5
Cc: Hoang-Nam Nguyen <hnguyen@de.ibm.com>, rolandd@cisco.com,
       raisch@de.ibm.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
References: <200611052140.38445.hnguyen@de.ibm.com>
In-Reply-To: <200611052140.38445.hnguyen@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611060045.59074.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 November 2006 21:40, Hoang-Nam Nguyen wrote:

> +/* constructor ctblk_cache */
> +void ehca_ctblk_ctor(void *ptr, kmem_cache_t *cache, unsigned long flags)
> +{
> + memset(ptr, 0, EHCA_PAGESIZE);
> +}
> +
> +void *ehca_alloc_fw_ctrlblock(void)
> +{
> + void *ret = kmem_cache_alloc(ctblk_cache, SLAB_KERNEL);
> + if (!ret)
> +  ehca_gen_err("Out of memory for ctblk");
> + return ret;
> +}
> +
> +void ehca_free_fw_ctrlblock(void *ptr)
> +{
> + if (ptr)
> +  kmem_cache_free(ctblk_cache, ptr);
> +

This seems broken. You have a constructor for newly allocated objects, but
there is no destructor and it seems that objects passed to
ehca_free_fw_ctrlblock are not guaranteed to be initialized either.

I'd simply move the memset into the alloc function and get rid of the
constructor here.

	Arnd <><
