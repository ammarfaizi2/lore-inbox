Return-Path: <linux-kernel-owner+w=401wt.eu-S1947256AbWLHVXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947256AbWLHVXI (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 16:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947257AbWLHVXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 16:23:07 -0500
Received: from ns2.suse.de ([195.135.220.15]:34648 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947256AbWLHVXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 16:23:06 -0500
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: proxy_pda was Re: What was in the x86 merge for .20
Date: Fri, 8 Dec 2006 22:22:33 +0100
User-Agent: KMail/1.9.5
Cc: Arkadiusz Miskiewicz <arekm@maven.pl>, linux-kernel@vger.kernel.org
References: <200612080401.25746.ak@suse.de> <200612082206.20409.ak@suse.de> <4579D496.6080201@goop.org>
In-Reply-To: <4579D496.6080201@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612082222.33673.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 December 2006 22:09, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> > Looking at Arkadiusz' output file it looks like gcc 4.2 decided to CSE the
> > address :/
> >
> > 	movl	$_proxy_pda+8, %edx	#, tmp65
> >
> > Very sad, but legitimate.
> >   
> 
> Yes, that was my conclusion too.  Though in this case the code could be
> cleaned up by cutting down on the number of uses of "current" - but
> that's hardly a general fix.
> 
> > The only workaround I can think of would be to define it as a symbol
> > (or away in vmlinux.lds.S)
> 
> Yes.  I was thinking about setting it in vmlinux.lds to some obviously
> bad address so that any access will be highly visible.
> 
> > . Or do away with the idea of proxy_pda
> > again.
> >   
> 
> That would be very sad indeed.

The trouble is when it's CSEd it actually causes worse code because
a register is tied up. That might not be worth the advantage of having it?

Hmm, maybe marking it volatile would help? Arkadiusz, does the following patch
help?

-Andi

Work around gcc 4.2 CSEing the proxy_pda

proxy_pda doesn't exactly exist -- we just use it to describe side effects
of the PDA manipulation to gcc. But when gcc 4.2 CSEs the address
it generates references and worse code and the link breaks.

Let's cast it to volatile and see if it that helps.

TBD same for x86-64
Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/include/asm-i386/pda.h
===================================================================
--- linux.orig/include/asm-i386/pda.h
+++ linux/include/asm-i386/pda.h
@@ -40,19 +40,19 @@ extern struct i386_pda _proxy_pda;
 		switch (sizeof(_proxy_pda.field)) {			\
 		case 1:							\
 			asm(op "b %1,%%gs:%c2"				\
-			    : "+m" (_proxy_pda.field)			\
+			    : "+m" (*(volatile T__ *)&_proxy_pda.field)			\
 			    :"ri" ((T__)val),				\
 			     "i"(pda_offset(field)));			\
 			break;						\
 		case 2:							\
 			asm(op "w %1,%%gs:%c2"				\
-			    : "+m" (_proxy_pda.field)			\
+			    : "+m" (*(volatile T__ *)&_proxy_pda.field)			\
 			    :"ri" ((T__)val),				\
 			     "i"(pda_offset(field)));			\
 			break;						\
 		case 4:							\
 			asm(op "l %1,%%gs:%c2"				\
-			    : "+m" (_proxy_pda.field)			\
+			    : "+m" (*(volatile T__ *)&_proxy_pda.field)			\
 			    :"ri" ((T__)val),				\
 			     "i"(pda_offset(field)));			\
 			break;						\
@@ -63,24 +63,25 @@ extern struct i386_pda _proxy_pda;
 #define pda_from_op(op,field)						\
 	({								\
 		typeof(_proxy_pda.field) ret__;				\
+		typedef typeof(_proxy_pda.field) T__;			\
 		switch (sizeof(_proxy_pda.field)) {			\
 		case 1:							\
 			asm(op "b %%gs:%c1,%0"				\
 			    : "=r" (ret__)				\
 			    : "i" (pda_offset(field)),			\
-			      "m" (_proxy_pda.field));			\
+			      "m" (*(volatile T__ *)&_proxy_pda.field));			\
 			break;						\
 		case 2:							\
 			asm(op "w %%gs:%c1,%0"				\
 			    : "=r" (ret__)				\
 			    : "i" (pda_offset(field)),			\
-			      "m" (_proxy_pda.field));			\
+			      "m" (*(volatile T__ *)&_proxy_pda.field));			\
 			break;						\
 		case 4:							\
 			asm(op "l %%gs:%c1,%0"				\
 			    : "=r" (ret__)				\
 			    : "i" (pda_offset(field)),			\
-			      "m" (_proxy_pda.field));			\
+			      "m" (*(volatile T__ *)&_proxy_pda.field));			\
 			break;						\
 		default: __bad_pda_field();				\
 		}							\
