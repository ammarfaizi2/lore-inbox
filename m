Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266109AbUBKScC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 13:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266077AbUBKScC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 13:32:02 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:37135 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S266109AbUBKSbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 13:31:51 -0500
Date: Wed, 11 Feb 2004 13:31:48 -0500
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-rc3-mm1 won't boot: nfs hangs @ slab.c:1931
Message-ID: <20040211183147.GD16882@fieldses.org>
References: <20040211182032.GA28408@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040211182032.GA28408@middle.of.nowhere>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 07:20:32PM +0100, Jurriaan wrote:
> My debian system mentions
> 
> Exporting directories ... debug: sleeping function called from illegal
> context at mm/slab.c:1931
> 
> The system is an up-to-date Debian Unstable dual P3/450.
> I've search my lkml archives and can't find any mention of this.

You need the following.--Bruce Fields

diff -puN net/sunrpc/svcauth.c~neil_NfsdCacheImprove net/sunrpc/svcauth.c
--- linux-2.6.1/net/sunrpc/svcauth.c~neil_NfsdCacheImprove	2004-02-08 13:54:41.000000000 -0500
+++ linux-2.6.1-bfields/net/sunrpc/svcauth.c	2004-02-08 14:09:08.000000000 -0500
@@ -150,7 +150,11 @@ DefineCacheLookup(struct auth_domain,
 		  &auth_domain_cache,
 		  auth_domain_hash(item),
 		  auth_domain_match(tmp, item),
-		  kfree(new); if(!set) return NULL;
+		  kfree(new); if(!set) {
+		  if (new) write_unlock(&auth_domain_cache.hash_lock);
+		  else read_unlock(&auth_domain_cache.hash_lock);
+		  return NULL;
+		  }
 		  new=item; atomic_inc(&new->h.refcnt),
 		  /* no update */,
 		  0 /* no inplace updates */

_
