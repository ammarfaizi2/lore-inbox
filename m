Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbVL1NGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVL1NGn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 08:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbVL1NGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 08:06:43 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:2000 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964807AbVL1NGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 08:06:42 -0500
Date: Wed, 28 Dec 2005 14:06:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jakub Jelinek <jakub@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 02/2] allow gcc4 to optimize unit-at-a-time
Message-ID: <20051228130616.GA10355@elte.hu>
References: <20051228114701.GC3003@elte.hu> <20051228120435.GS22293@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228120435.GS22293@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jakub Jelinek <jakub@redhat.com> wrote:

> > +CFLAGS				+= $(shell if [ $(GCC_VERSION) -lt 0400 ] ; then echo "-fno-unit-at-a-time"; fi ;)
> 
> -fno-unit-at-a-time option has been introduced in GCC 3.4 (and 3.3-hammer
> branch).  So unless the minimum supported GCC version to compile kernel is
> 3.4+, you need to replace
> echo "-fno-unit-at-a-time"
> with
> $(call cc-option,-fno-unit-at-a-time)
> .

indeed - updated patch below.

	Ingo

Subject: allow gcc4 to optimize unit-at-a-time

allow gcc4 compilers to optimize unit-at-a-time - which results in gcc
having a wider scope when optimizing. This also results in smaller code
when optimizing for size. (gcc4 does not have the stack footprint
problem of gcc3 compilers.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>
----

 arch/i386/Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux/arch/i386/Makefile
===================================================================
--- linux.orig/arch/i386/Makefile
+++ linux/arch/i386/Makefile
@@ -42,9 +42,9 @@ include $(srctree)/arch/i386/Makefile.cp
 GCC_VERSION			:= $(call cc-version)
 cflags-$(CONFIG_REGPARM) 	+= $(shell if [ $(GCC_VERSION) -ge 0300 ] ; then echo "-mregparm=3"; fi ;)
 
-# Disable unit-at-a-time mode, it makes gcc use a lot more stack
-# due to the lack of sharing of stacklots.
-CFLAGS += $(call cc-option,-fno-unit-at-a-time)
+# Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
+# a lot more stack due to the lack of sharing of stacklots:
+CFLAGS				+= $(shell if [ $(GCC_VERSION) -lt 0400 ] ; then $(call cc-option,-fno-unit-at-a-time); fi ;)
 
 CFLAGS += $(cflags-y)
 
