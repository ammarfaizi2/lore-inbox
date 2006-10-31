Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945905AbWJaTuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945905AbWJaTuL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945906AbWJaTuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:50:11 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:20394 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1945905AbWJaTuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:50:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Fz0FEwu/x4bOhIj+qcdVOo7csKgpgwsPCjniOl1+Xu5gH7RRT0n/RrpR958kUdyuyQiThJkuHMzJ+JjLrJ/sMUDsY4SWGw0UZS49y3f620FK2ENXnpZUylElipS4HQq3ILGov65ZyAhWPexvhVsApXF6K/ij5CNyfUxUh3DtveU=
Date: Wed, 1 Nov 2006 04:49:59 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@suse.de>,
       Andy Adamson <andros@citi.umich.edu>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: [PATCH] sunrpc/auth_gss: auth_domain refcount fix
Message-ID: <20061031194959.GA9015@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Neil Brown <neilb@suse.de>, Andy Adamson <andros@citi.umich.edu>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Trond Myklebust <Trond.Myklebust@netapp.com>
References: <20061031015121.dfc7e02a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031015121.dfc7e02a.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please put this patch together with
auth_gss-unregister-gss_domain-when-unloading-module.patch.

Because recent auth_domain_lookup() refcounting change affected it.

Subject: [PATCH] sunrpc/auth_gss: auth_domain refcount fix

It is unnecessary to decrease refcount after auth_domain_lookup()
when new entry is inserted.

Cc: Neil Brown <neilb@suse.de>
Cc: Andy Adamson <andros@citi.umich.edu>
Cc: J. Bruce Fields <bfields@citi.umich.edu>
Cc: Trond Myklebust <Trond.Myklebust@netapp.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Index: 2.6-mm/net/sunrpc/auth_gss/svcauth_gss.c
===================================================================
--- 2.6-mm.orig/net/sunrpc/auth_gss/svcauth_gss.c
+++ 2.6-mm/net/sunrpc/auth_gss/svcauth_gss.c
@@ -770,7 +770,6 @@ svcauth_gss_register_pseudoflavor(u32 ps
 		kfree(new->h.name);
 		goto out_free_dom;
 	}
-	auth_domain_put(&new->h);
 	return 0;
 
 out_free_dom:
