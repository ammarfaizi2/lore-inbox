Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265584AbUBJAG6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 19:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265581AbUBJAGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 19:06:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:30159 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265422AbUBIX47 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:56:59 -0500
Date: Mon, 9 Feb 2004 15:58:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Philippe =?ISO-8859-1?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.3-rc1-mm1
Message-Id: <20040209155823.6f884f23.akpm@osdl.org>
In-Reply-To: <20040209151818.32965df6@philou.gramoulle.local>
References: <20040209014035.251b26d1.akpm@osdl.org>
	<20040209151818.32965df6@philou.gramoulle.local>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Gramoullé  <philippe.gramoulle@mmania.com> wrote:
>
> Starting with 2.6.3-rc1-mm1, nfsd isn't working any more. Exportfs just hangs.

Yes, sorry.  The nfsd patches had a painful birth.  This chunk got lost.

--- 25/net/sunrpc/svcauth.c~nfsd-02-sunrpc-cache-init-fixes	Mon Feb  9 14:04:03 2004
+++ 25-akpm/net/sunrpc/svcauth.c	Mon Feb  9 14:06:26 2004
@@ -150,7 +150,13 @@ DefineCacheLookup(struct auth_domain,
 		  &auth_domain_cache,
 		  auth_domain_hash(item),
 		  auth_domain_match(tmp, item),
-		  kfree(new); if(!set) return NULL;
+		  kfree(new); if(!set) {
+			if (new)
+				write_unlock(&auth_domain_cache.hash_lock);
+			else
+				read_unlock(&auth_domain_cache.hash_lock);
+			return NULL;
+		  }
 		  new=item; atomic_inc(&new->h.refcnt),
 		  /* no update */,
 		  0 /* no inplace updates */

_
