Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUKUMXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUKUMXW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 07:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbUKUMXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 07:23:22 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:62366 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261951AbUKUMXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 07:23:17 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200411211223.iALCNCTL005995@betty.it.uc3m.es>
Subject: can kfree sleep?
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Sun, 21 Nov 2004 13:23:12 +0100 (CET)
Reply-To: ptb@inv.it.uc3m.es
X-Anonymously-To: 
X-Mailer: ELM [version 2.4ME+ PL121 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a question: can kfree sleep?

I believe so, but slab.c does not enlighten me immediately:

 void
 kfree (const void *objp)
 {
        kmem_cache_t *c;
        unsigned long flags;

        if (!objp)
                return;
        local_irq_save (flags);
        c = GET_PAGE_CACHE (virt_to_page (objp));
        __cache_free (c, (void *) objp);
        local_irq_restore (flags);
 }

 static inline void __cache_free (kmem_cache_t *cachep, void* objp)
 {
        struct array_cache *ac = ac_data(cachep);

        check_irq_off();
        objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));

        if (likely(ac->avail < ac->limit)) {
                STATS_INC_FREEHIT(cachep);
                ac_entry(ac)[ac->avail++] = objp;
                return;
        } else {
                STATS_INC_FREEMISS(cachep);
                cache_flusharray(cachep, ac);
                ac_entry(ac)[ac->avail++] = objp;
        }
 }

 ...


Peter
