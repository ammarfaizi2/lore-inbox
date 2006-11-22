Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757039AbWKVVgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757039AbWKVVgy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 16:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757040AbWKVVgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 16:36:54 -0500
Received: from smtp.osdl.org ([65.172.181.25]:11206 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757039AbWKVVgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 16:36:53 -0500
Date: Wed, 22 Nov 2006 13:36:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       David Miller <davem@davemloft.net>
Subject: Re: [PATCH] dont insert pipe dentries into dentry_hashtable.
Message-Id: <20061122133618.da95e48e.akpm@osdl.org>
In-Reply-To: <200611221848.41330.dada1@cosmosbay.com>
References: <a769871e0611211233n20eb9d74j661cd73e9315fade@mail.gmail.com>
	<20061121224613.548207f9.akpm@osdl.org>
	<200611221602.29597.dada1@cosmosbay.com>
	<200611221848.41330.dada1@cosmosbay.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006 18:48:41 +0100
Eric Dumazet <dada1@cosmosbay.com> wrote:

> We currently insert pipe dentries into the global dentry hashtable.
> This is *suboptimal* because there is currently no way these entries can be 
> used for a lookup(). (/proc/xxx/fd/xxx uses a different mechanism). Inserting 
> them in dentry hashtable slow dcache lookups.
> 
> 
> To let __dpath() still work correctly (ie not adding a " (deleted)") after 
> dentry name, we do : 
> 
> - Right after d_alloc(), pretend they are hashed by clearing the 
> DCACHE_UNHASHED bit. 
> 
> - Call d_instantiate() instead of d_add() : dentry is not inserted in hash 
> table.
> 
> __dpath() & friends work as intended during dentry lifetime.
> 
> - At dismantle time, once dput() must clear the dentry, setting again 
> DCACHE_UNHASHED bit inside the custom d_delete() function provided by pipe 
> code, so that dput() can just kill_it.
> 
> This patch, combined with the next one (avoid RCU for never hashed dentries) 
> reduced time of { pipe(p); close(p[0]); close(p[1]);} on my UP machine 
> (1.6GHz Pentium-M) from 3.23 us to 2.86 us 
> (But this patch does not depend on other patches, only bench results)

The DCACHE_UNHASHED games seem hacky.

Would it be cleaner to define a new dentry.d_flags bit which can be used to
indicate that this is a hashing-not-needed dentry, and to handle that over
in dcache.c?
