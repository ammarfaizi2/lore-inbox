Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbTARACG>; Fri, 17 Jan 2003 19:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbTARACG>; Fri, 17 Jan 2003 19:02:06 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:8363 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261205AbTARACF>; Fri, 17 Jan 2003 19:02:05 -0500
Date: Fri, 17 Jan 2003 18:11:01 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: rusty@rustcorp.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.59 vmlinux.lds.S change broke modules
In-Reply-To: <15911.64825.624251.707026@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0301171808010.15056-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2003, Mikael Pettersson wrote:

> This oops occurs for every module, not just af_packet.ko, at
> resolve_symbol()'s first call to __find_symbol().

Okay, the details I received so far seem to indicate that the appended 
patch will fix it, though I didn't get actual confirmation it does.

If you experience crashes when loading modules (and have RH 8 binutils), 
please give it a shot.

--Kai


-----------------------------------------------------------------------------
ChangeSet@1.947.1.2, 2003-01-16 16:29:31-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Fix __start_SECTION, __stop_SECTION
  
  In a discussion with Sam Ravnborg, the following problem became apparent:
  Most vmlinux.lds.S (but the ARM ones) used the following construct:
  
         __start___ksymtab = .;                                          
         __ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {         
                 *(__ksymtab)                                            
         }                                                               
         __stop___ksymtab = .;                                           
  
  However, the link will align the beginning of the section __ksymtab
  according to the requirements for the input sections. If '.' (current
  location counter) wasn't sufficiently aligned before, it's possible
  that __ksymtab actually starts at an address after the one
  __start___ksymtab points to, which will confuse the users of
  __start___ksymtab badly. The fix is to follow what the ARM Makefiles
  did for this case, ie
  
         __ksymtab : AT(ADDR(__ksymtab) - LOAD_OFFSET) {                 
                 __start___ksymtab = .;                                  
                 *(__ksymtab)                                            
                 __stop___ksymtab = .;                                   
         }                                                               

  ---------------------------------------------------------------------------

diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h	Fri Jan 17 10:09:57 2003
+++ b/include/asm-generic/vmlinux.lds.h	Fri Jan 17 10:09:57 2003
@@ -13,18 +13,18 @@
 	}								\
 									\
 	/* Kernel symbol table: Normal symbols */			\
-	__start___ksymtab = .;						\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
+		__start___ksymtab = .;					\
 		*(__ksymtab)						\
+		__stop___ksymtab = .;					\
 	}								\
-	__stop___ksymtab = .;						\
 									\
 	/* Kernel symbol table: GPL-only symbols */			\
-	__start___gpl_ksymtab = .;					\
 	__gpl_ksymtab     : AT(ADDR(__gpl_ksymtab) - LOAD_OFFSET) {	\
+		__start___gpl_ksymtab = .;				\
 		*(__gpl_ksymtab)					\
+		__stop___gpl_ksymtab = .;				\
 	}								\
-	__stop___gpl_ksymtab = .;					\
 									\
 	/* Kernel symbol table: strings */				\
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\


