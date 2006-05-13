Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWEMSLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWEMSLx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 14:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWEMSLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 14:11:53 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12430 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932485AbWEMSLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 14:11:53 -0400
Date: Sat, 13 May 2006 11:11:46 -0700
From: Paul Jackson <pj@sgi.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc4 1/6] Base support for kmemleak
Message-Id: <20060513111146.9c9e4868.pj@sgi.com>
In-Reply-To: <20060513160541.8848.2113.stgit@localhost.localdomain>
References: <20060513155757.8848.11980.stgit@localhost.localdomain>
	<20060513160541.8848.2113.stgit@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please try to keep ifdef's out of the main kernel files.

Imagine what an unreadable mess the main kernel files
would be if every CONFIG option had its hooks wrapped
in #ifdef's.

==============================================

+#ifdef CONFIG_DEBUG_MEMLEAK
+#include <linux/memleak.h>
+#endif

should be changed to always include linux/memleak.h,
and bury the ifdefs with memleak.h so that if not
CONFIG'd, it just defines the empty stubs needed
to remove other ifdef's in the main files.

==============================================

+#ifdef CONFIG_DEBUG_MEMLEAK
+#define container_of(ptr, type, member) ({			\
+	DECLARE_MEMLEAK_OFFSET(container_of, type, member);	\
+	__container_of(ptr, type, member);			\
+})
+#else
+#define container_of(ptr, type, member) __container_of(ptr, type, member)
+#endif

could (not sure of this works - you'll have to experiment) become:

+#define container_of(ptr, type, member) ({			\
+	DECLARE_MEMLEAK_OFFSET(container_of, type, member);	\
+	__container_of(ptr, type, member);			\
+})

where DECLARE_MEMLEAK_OFFSET was an empty stub if not CONFIG'd

==============================================

+#ifdef CONFIG_DEBUG_MEMLEAK
+	memleak_init();
+#endif

becomes simply:

+	memleak_init();

where memleak_init() is an empty stuff if memleak if not CONFIG'd.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
