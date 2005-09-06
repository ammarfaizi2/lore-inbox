Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbVIFW0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbVIFW0h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 18:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbVIFW0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 18:26:37 -0400
Received: from relay2.uli.it ([62.212.1.5]:41611 "EHLO relay2.uli.it")
	by vger.kernel.org with ESMTP id S1751054AbVIFW0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 18:26:36 -0400
From: Daniele Orlandi <daniele@orlandi.com>
To: linux-kernel@vger.kernel.org
Subject: proto_unregister sleeps while atomic
Date: Wed, 7 Sep 2005 00:26:34 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509070026.34999.daniele@orlandi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm looking at proto_unregister() in linux-2.6.13:

Il calls kmem_cache_destroy() while holding proto_list_lock:

void proto_unregister(struct proto *prot)
{
        write_lock(&proto_list_lock);

        if (prot->slab != NULL) {
                kmem_cache_destroy(prot->slab);


However, kmem_cache_destroy() may sleep:

int kmem_cache_destroy (kmem_cache_t * cachep)
{
         int i;
 
         if (!cachep || in_interrupt())
                BUG();
 
         /* Don't let CPUs to come and go */
         lock_cpu_hotplug();

        /* Find the cache in the chain of caches. */
        down(&cache_chain_sem);
        ^^^^^^^^^^^^^^^^^^^^^^^

Am I seeing it right?

Bye,

-- 
  Daniele Orlandi
