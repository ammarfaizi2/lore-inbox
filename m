Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWJJCJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWJJCJm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 22:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWJJCJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 22:09:42 -0400
Received: from [198.99.130.12] ([198.99.130.12]:47333 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751939AbWJJCJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 22:09:40 -0400
Date: Mon, 9 Oct 2006 12:32:08 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 01/14] uml: fix compilation options for USER_OBJS
Message-ID: <20061009163208.GA4931@ccure.user-mode-linux.org>
References: <20061005213212.17268.7409.stgit@memento.home.lan> <20061005213836.17268.96038.stgit@memento.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005213836.17268.96038.stgit@memento.home.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 11:38:36PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> Again, move inclusion of arch's Makefile after CFLAGS setting - I remember
> merging the same patch eons ago in 2.6, so I added a comment.
> 
> I discovered this because debug info weren't enabled for USER_OBJS - they're
> compiled with USER_CFLAGS which is calculated from CFLAGS (the whole thing is a
> bit of an hack but fixing it is not easy, so we're leaving it as-is).

What's the matter with this:

Index: linux-2.6.18-mm/arch/um/Makefile
===================================================================
--- linux-2.6.18-mm.orig/arch/um/Makefile       2006-10-03 17:44:32.000000000 -0400
+++ linux-2.6.18-mm/arch/um/Makefile    2006-10-09 12:29:32.000000000 -0400
@@ -64,9 +64,8 @@ CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSU
 
 AFLAGS += $(ARCH_INCLUDE)
 
-USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
-USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS)) $(ARCH_INCLUDE) \
-       $(MODE_INCLUDE) -D_FILE_OFFSET_BITS=64
+USER_CFLAGS = $(patsubst -D__KERNEL__,,$(patsubst -I%,,$(CFLAGS))) \
+       $(ARCH_INCLUDE) $(MODE_INCLUDE) -D_FILE_OFFSET_BITS=64
 
 # -Derrno=kernel_errno - This turns all kernel references to errno into
 # kernel_errno to separate them from the libc errno.  This allows -fno-common

The real problem is the use of := which assigns USER_CFLAGS from the
current value of CFLAGS, which is incomplete, as you noted.

Moving the include around seems slightly bogus, since its precise
location shouldn't matter.

If we switch to plain =, then it will be lazy-evaluated with the full
CFLAGS.

And we should check other uses of := to make sure they don't have
similar problems.

				Jeff
