Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbVJ3UGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVJ3UGM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 15:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVJ3UGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 15:06:12 -0500
Received: from S01060013109fe3d4.vc.shawcable.net ([24.85.133.133]:33219 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S1750771AbVJ3UGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 15:06:11 -0500
Date: Sun, 30 Oct 2005 12:12:13 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/5] i386 generic cmpxchg
In-Reply-To: <4364171C.7020103@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0510301157440.1526@montezuma.fsmlabs.com>
References: <436416AD.3050709@yahoo.com.au> <4364171C.7020103@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Sun, 30 Oct 2005, Nick Piggin wrote:

+#define cmpxchg(ptr,o,n)						\
+({									\
+	__typeof__(*(ptr)) __ret;					\
+	if (likely(boot_cpu_data.x86 > 3))				\
+		__ret = __cmpxchg((ptr), (unsigned long)(o),		\
+					(unsigned long)(n), sizeof(*(ptr))); \
+	else								\
+		__ret = cmpxchg_386((ptr), (unsigned long)(o),		\
+					(unsigned long)(n), sizeof(*(ptr))); \
+	__ret;								\
+})
+#endif

How about something similar to the following to remove the branch on 
optimised kernels?

static inline int __is_i386(void)
{
#ifdef CONFIG_M386
	return boot_cpu_data.x86 == 3;
#else
	return 0
#endif
}

#define cmpxchg(ptr,o,n)                                               \
({                                                                     \
       __typeof__(*(ptr)) __ret;                                       \
       if (likely(!__is_i386()))                              \
               __ret = __cmpxchg((ptr), (unsigned long)(o),            \
                                       (unsigned long)(n), sizeof(*(ptr))); \
       else                                                            \
               __ret = cmpxchg_386((ptr), (unsigned long)(o),          \
                                       (unsigned long)(n), 
sizeof(*(ptr))); \
       __ret;                                                          \
})
