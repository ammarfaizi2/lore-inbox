Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751940AbWCAXfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbWCAXfP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 18:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbWCAXfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 18:35:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10904 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751940AbWCAXfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 18:35:12 -0500
Date: Wed, 1 Mar 2006 15:37:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: torvalds@osdl.org, ocfs2-devel@oss.oracle.com,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] ocfs2 updates
Message-Id: <20060301153714.56d20f24.akpm@osdl.org>
In-Reply-To: <20060301231034.GZ20175@ca-server1.us.oracle.com>
References: <20060301231034.GZ20175@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Fasheh <mark.fasheh@oracle.com> wrote:
>
> +					    "Extent %d at e_blkno %"MLFu64" of inode %"MLFu64" goes past ip_clusters of %u\n",

Sometime, please consider killing MLFu64 and friends.

#if (BITS_PER_LONG == 32) || defined(CONFIG_X86_64) || (defined(CONFIG_UML_X86) && defined(CONFIG_64BIT))
#define MLFi64 "lld"
#define MLFu64 "llu"
#define MLFx64 "llx"
#else
#define MLFi64 "ld"
#define MLFu64 "lu"
#define MLFx64 "lx"
#endif

You covered most cases there, but sh64 implements u64 as `unsigned long
long' (for example).

Generally we solve this problem by just using %ll and casting the args
appropriately.   That does have some runtime cost on 32-bit.

u64 and s64 are the easy case - it gets stickier on things like sector_t
whose size is controlled by a CONFIG_thing on 32-bit.

