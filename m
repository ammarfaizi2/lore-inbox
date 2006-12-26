Return-Path: <linux-kernel-owner+w=401wt.eu-S932244AbWLZEpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWLZEpf (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 23:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWLZEpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 23:45:35 -0500
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:35228 "EHLO
	liaag2aa.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932244AbWLZEpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 23:45:34 -0500
Date: Mon, 25 Dec 2006 23:42:32 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: ebtables problems on 2.6.19.1 *and* 2.6.16.36
To: "Christopher S. Aker" <caker@theshore.net>
Cc: Patrick McHardy <kaber@trash.net>,
       Santiago Garcia Mantinan <manty@manty.net>,
       linux-kernel@vger.kernel.org, ebtables-devel@lists.sourceforge.net
Message-ID: <200612252344_MC3-1-D65C-20B2@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <458DEF02.90908@theshore.net>

On Sat, 23 Dec 2006 22:07:46 -0500, Christopher S. Aker wrote:

> We're hitting this too, on both 2.6.16.36 and 2.6.19.1.
> 
> BUG: unable to handle kernel paging request at virtual address f8cec008
>   printing eip:
> c0462272
> *pde = 00000000
> Oops: 0000 [#1]
> SMP
> Modules linked in: e1000
> CPU:    1
> EIP:    0060:[<c0462272>]    Not tainted VLI
> EFLAGS: 00010286   (2.6.19.1-1-bigmem #1)
> EIP is at translate_table+0x2b3/0xddf

> Considering I've never had these problems before, and that both stable 
> (2.6.16.36) and current (2.6.19.1) exhibit this issue, I'd venture to 
> guess that it's something that went into both of them very recently.

Bingo!

It is dying here:

 static inline int
 ebt_check_entry(struct ebt_entry *e, struct ebt_table_info *newinfo,
    const char *name, unsigned int *cnt, unsigned int valid_hooks,
    struct ebt_cl_stack *cl_s, unsigned int udc_cnt)
 {
        struct ebt_entry_target *t;
        struct ebt_target *target;
        unsigned int i, j, hook = 0, hookmask = 0;
        size_t gap = e->next_offset - e->target_offset; <================
        int ret;

        /* don't mess with the struct ebt_entries */
        if (e->bitmask == 0)
                return 0;


when trying to access e->next_offset, which may or may not exist because
'e' sometimes points to a 'struct ebt_entries', not 'struct ebt_entry'
(note the comment before the 'if'.) This code was recently added.

So this (untested) patch should fix it (I tried to move the computation to
a place where it's efficient.)  If so it's needed for 2.6.16.x, 2.6.18.x,
2.6.19.x and 2.6.20-rc.


ebtables: don't compute gap until we know we have an ebt_entry

We must check the bitmap field to make sure we have an ebt_entry and
not an ebt_entries struct before using fields from ebt_entry.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.19.1-32smp.orig/net/bridge/netfilter/ebtables.c
+++ 2.6.19.1-32smp/net/bridge/netfilter/ebtables.c
@@ -575,7 +575,7 @@ ebt_check_entry(struct ebt_entry *e, str
 	struct ebt_entry_target *t;
 	struct ebt_target *target;
 	unsigned int i, j, hook = 0, hookmask = 0;
-	size_t gap = e->next_offset - e->target_offset;
+	size_t gap;
 	int ret;
 
 	/* don't mess with the struct ebt_entries */
@@ -625,6 +625,7 @@ ebt_check_entry(struct ebt_entry *e, str
 	if (ret != 0)
 		goto cleanup_watchers;
 	t = (struct ebt_entry_target *)(((char *)e) + e->target_offset);
+	gap = e->next_offset - e->target_offset;
 	target = find_target_lock(t->u.name, &ret, &ebt_mutex);
 	if (!target)
 		goto cleanup_watchers;
-- 
MBTI: IXTP
