Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262923AbUDZQR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbUDZQR0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 12:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbUDZQR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 12:17:26 -0400
Received: from fep12.inet.fi ([194.251.242.210]:26286 "EHLO fep12.inet.fi")
	by vger.kernel.org with ESMTP id S262923AbUDZQRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 12:17:21 -0400
Date: Mon, 26 Apr 2004 19:17:19 +0300 (EEST)
From: "Petri T. Koistinen" <petri.koistinen@iki.fi>
X-X-Sender: petri@dsl-prvgw1cc4.dial.inet.fi
To: "David S. Miller" <davem@redhat.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/sunrpc/svcauth_unix.c: unix_domain_find: return NULL if
 kmalloc fails
Message-ID: <Pine.LNX.4.58.0404261913550.5531@dsl-prvgw1cc4.dial.inet.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I browsed http://linuxbugs.coverity.com/ site and found this:

NULL_RETURNS error: Dereference of possibly NULL ptr "new" returned by "kmalloc".
/home/test/nightly-qa/test-packages/linux-2.6.4/net/sunrpc/svcauth_unix.c:53:unix_domain_find:
(also see line 54)
53            new = kmalloc(sizeof(*new), GFP_KERNEL);
NULL_RETURNS information here
(also see line 53)
54            cache_init(&new->h.h);

Is this correct fix? What happens when unix_domain_find return NULL?

Best regards,
Petri Koistinen

--- linux-2.5/net/sunrpc/svcauth_unix.c.orig	2004-04-26 18:58:04.000000000 +0300
+++ linux-2.5/net/sunrpc/svcauth_unix.c	2004-04-26 18:58:58.000000000 +0300
@@ -36,36 +36,38 @@ struct unix_domain {
 struct auth_domain *unix_domain_find(char *name)
 {
 	struct auth_domain *rv, ud;
 	struct unix_domain *new;

 	ud.name = name;

 	rv = auth_domain_lookup(&ud, 0);

  foundit:
 	if (rv && rv->flavour != RPC_AUTH_UNIX) {
 		auth_domain_put(rv);
 		return NULL;
 	}
 	if (rv)
 		return rv;

 	new = kmalloc(sizeof(*new), GFP_KERNEL);
+	if (new == NULL)
+		return NULL;
 	cache_init(&new->h.h);
 	atomic_inc(&new->h.h.refcnt);
 	new->h.name = strdup(name);
 	new->h.flavour = RPC_AUTH_UNIX;
 	new->addr_changes = 0;
 	new->h.h.expiry_time = NEVER;
 	new->h.h.flags = 0;

 	rv = auth_domain_lookup(&new->h, 2);
 	if (rv == &new->h) {
 		if (atomic_dec_and_test(&new->h.h.refcnt)) BUG();
 	} else {
 		auth_domain_put(&new->h);
 		goto foundit;
 	}

 	return rv;
 }
