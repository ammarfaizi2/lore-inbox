Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWE3GhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWE3GhH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 02:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWE3GhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 02:37:06 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:10705 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932164AbWE3GhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 02:37:05 -0400
Date: Tue, 30 May 2006 08:37:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
Message-ID: <20060530063724.GE19870@elte.hu>
References: <20060529212109.GA2058@elte.hu> <1148964741.7704.10.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148964741.7704.10.camel@homer>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Galbraith <efault@gmx.de> wrote:

> Darn.  It said all tests passed, then oopsed.
> 
> (have .config all gzipped up if you want it)

yeah, please.

> EIP:    0060:[<b103a872>]    Not tainted VLI
> EFLAGS: 00010083   (2.6.17-rc4-mm3-smp #157)
> EIP is at count_matching_names+0x5b/0xa2

> 1151            list_for_each_entry(type, &all_lock_types, lock_entry) {
> 1152                    if (new_type->key - new_type->subtype == type->key)
> 1153                            return type->name_version;
> 1154                    if (!strcmp(type->name, new_type->name))  <--kaboom
> 1155                            count = max(count, type->name_version);

hm, while most code (except the one above) is prepared for type->name 
being NULL, it should not be NULL. Maybe an uninitialized lock slipped 
through? Please try the patch below - it both protects against 
type->name being NULL in this place, and will warn if it finds a NULL 
lockname.

	Ingo

Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -1151,7 +1151,7 @@ int count_matching_names(struct lock_typ
 	list_for_each_entry(type, &all_lock_types, lock_entry) {
 		if (new_type->key - new_type->subtype == type->key)
 			return type->name_version;
-		if (!strcmp(type->name, new_type->name))
+		if (type->name && !strcmp(type->name, new_type->name))
 			count = max(count, type->name_version);
 	}
 
@@ -1974,7 +1974,8 @@ void lockdep_init_map(struct lockdep_map
 
 	if (DEBUG_WARN_ON(!key))
 		return;
-
+	if (DEBUG_WARN_ON(!name))
+		return;
 	/*
 	 * Sanity check, the lock-type key must be persistent:
 	 */
