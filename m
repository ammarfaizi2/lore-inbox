Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265054AbUD3DkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265054AbUD3DkP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 23:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbUD3DkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 23:40:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:1683 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265051AbUD3DkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 23:40:09 -0400
Date: Thu, 29 Apr 2004 20:39:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Art Haas" <ahaas@airmail.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Problem with recent changes to fs/dcache.c
Message-Id: <20040429203901.4cd21fdc.akpm@osdl.org>
In-Reply-To: <20040430020525.GI27793@artsapartment.org>
References: <20040430020525.GI27793@artsapartment.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Art Haas" <ahaas@airmail.net> wrote:
>
> I run linux on a SparcStation SS20 in addition to a PC, and found that
>  none of the 2.6.6-rc kernels would boot. After trying the latest -rc3
>  kernel and seeing it fail also, my debugging quest began. Adding a few
>  printk() statements pointed the problem to be in fs/dcache.c in the
>  vfs_caches_init() function. The 1.69->1.70 changes to this file added in
>  a call to nr_free_pages() and used that result to adjust the global
>  mempages variable. This change caused the boot failures.
> 
>  The printk() statements I'd added showed that vfs_caches_init() was
>  being called with 'mempages' set to 46073. The nr_free_pages() call
>  returned 127661, and this value being subtracted from mempages went
>  negative, but the value is unsigned, so mempages became enormous. Things
>  ended up getting stuck in the inode_init() call down a bit, having
>  seeming survived the dcache_init() call only because of values
>  wrapping around.
> 
>  I commented out the 'mempages -= reserve;' line in the file, and the
>  boot continued along. Unfortunately I encounter a kernel trap when
>  mounting the hard drives, so there are other problems still needing to
>  be looked at.
> 
>  The possiblity of nr_free_pages() being larger than mempages looks like
>  a silent bug that was tripped. If not, then another bug in the Sparc
>  port may be responsible for values being used in these functions. The
>  memory-management gurus can take a peek and see what they find.

Yes, something's bust in the sparc port's calculation of num_physpages. 
Clearly it should be larger than nr_free_pages().
