Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266153AbUF3Gf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266153AbUF3Gf4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 02:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbUF3Gf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 02:35:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2497 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266153AbUF3Gfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 02:35:42 -0400
Date: Tue, 29 Jun 2004 23:35:37 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: schwidefsky@de.ibm.com
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: s390(64) per_cpu in modules (ipv6)
Message-Id: <20040629233537.523db68c@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Martin,

I tried to build ipv6 as a module in 2.6.7, and it bombs, producing a
module which wants per_cpu____icmpv6_socket (obviously, undefined).

The problem appears to be caused by this:

#define __get_got_cpu_var(var,offset) \
  (*({ unsigned long *__ptr; \
       asm ( "larl %0,per_cpu__"#var"@GOTENT" : "=a" (__ptr) ); \
       ((typeof(&per_cpu__##var))((*__ptr) + offset)); \
    }))

The net/ipv6/icmp.c has this:

static DEFINE_PER_CPU(struct socket *, __icmpv6_socket) = NULL;

It is a static variable, and all references to it come from asm code.
The gcc does not know that they are present and optimizes the variable
away. It simply emits no code to define per_cpu____icmpv6_socket
whatsoever, as verified with gcc -S.

If the DEFINE_PER_CPU() is used without static, or if a bogus
reference is added to the C code (a printk), everything works.

I tried to add a fake input argument to the asm, like this:

--- linux-2.6.7-1.459/include/asm-s390/percpu.h 2004-06-16 01:20:04.000000000 -0400
+++ linux-2.6.7-1.459.z1/include/asm-s390/percpu.h      2004-06-29 22:03:23.000000000 -0400
@@ -15,7 +15,7 @@
 #if defined(__s390x__) && defined(MODULE)
 #define __get_got_cpu_var(var,offset) \
   (*({ unsigned long *__ptr; \
-       asm ( "larl %0,per_cpu__"#var"@GOTENT" : "=a" (__ptr) ); \
+       asm ( "larl %0,per_cpu__"#var"@GOTENT" : "=a" (__ptr) : "a" (&per_cpu__##var) ); \
        ((typeof(&per_cpu__##var))((*__ptr) + offset)); \
     }))
 #undef __get_cpu_var

It seems to work fine, but I'm wondering if a better fix can be found.
Ideas?

-- Pete
