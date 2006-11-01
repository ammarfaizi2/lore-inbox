Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946654AbWKAHTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946654AbWKAHTy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 02:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946661AbWKAHTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 02:19:54 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11985
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1946654AbWKAHTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 02:19:53 -0500
Date: Tue, 31 Oct 2006 23:19:54 -0800 (PST)
Message-Id: <20061031.231954.23010447.davem@davemloft.net>
To: dada1@cosmosbay.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH] dont insert sockets/pipes dentries into
 dentry_hashtable.
From: David Miller <davem@davemloft.net>
In-Reply-To: <200610311948.48970.dada1@cosmosbay.com>
References: <20061025084726.GE18364@nuim.ie>
	<20061025.230615.92585270.davem@davemloft.net>
	<200610311948.48970.dada1@cosmosbay.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <dada1@cosmosbay.com>
Date: Tue, 31 Oct 2006 19:48:48 +0100

> We currently insert sockets/pipes dentries into the global dentry
> hashtable.  This is *useless* because there is currently no way
> these entries can be used for a lookup(). (/proc/xxx/fd/xxx uses a
> different mechanism)

It turns out that while procfs uses a different "mechanism", those
procfs symlinks do point to the real socket dentry, so when you
readlink() on it you do d_path() on the real socket dentry.

If you unhash these things, I'm pretty sure you'll see an ugly
"(deleted)" at the end of the symlink string for /proc/$pid/fd/$X
files that are sockets or something like that.

Al Viro just suggested a way around this to me:

1) Just mark the dentry HASHED by hand in the dentry flags, but don't
   actually hash it.

2) Create a special dentry->d_deleted method for sockets that returns
   0 and clears by hand the HASHED flag bit in the dentry (see what
   dput() does when this happens).

It's an abuse but it will work.
