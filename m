Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268937AbUJPWi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268937AbUJPWi0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 18:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268947AbUJPWi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 18:38:26 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:63358 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S268937AbUJPWiE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 18:38:04 -0400
Date: Sun, 17 Oct 2004 02:38:08 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make gcc -align options .config-settable
Message-ID: <20041017003808.GE15006@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	sam@ravnborg.org, linux-kernel@vger.kernel.org
References: <200410012226.23565.vda@port.imtp.ilyichevsk.odessa.ua> <20041001151751.3917d9d5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041001151751.3917d9d5.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2004 at 03:17:51PM -0700, Andrew Morton wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> >
> > With all alignment options set to 1 (minimum alignment),
> > I've got 5% smaller vmlinux compared to one built with
> > default code alignment.
> > 
> 
> Sam, can you process this one?
> 
> > 
> >  
> > +GCC_VERSION	= $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
> 
> It bugs me that we're evaluating the same thing down in arch/i386/Makefile.
>  Perhaps we should evaluate GCC_VERSION once only, as some top-level kbuild
> thing.  So everyone can assume that it's present and correct?

Started looking into this.
gcc does not document what happens if -falign-functions=x is specified more than
once. It works but I have not checked the effect.
It will occur for some CPU's

	Sam

Current patch to top-level Makefile looks like this.

===== Makefile 1.542 vs edited =====
--- 1.542/Makefile	2004-10-17 02:00:48 +02:00
+++ edited/Makefile	2004-10-17 02:29:56 +02:00
@@ -295,6 +295,11 @@
 cc-option-yn = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
                 > /dev/null 2>&1; then echo "y"; else echo "n"; fi;)
 
+# cc-option-align
+# Prefix align with either -falign or -malign
+cc-option-align = $(subst -functions=0,,\
+	$(call cc-option,-falign-functions=0,-malign-functions=0))
+
 # cc-version
 # Usage gcc-ver := $(call cc-version $(CC))
 cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh \
@@ -497,6 +502,13 @@
 else
 CFLAGS		+= -O2
 endif
+
+#Add aling options in CONFIG_CC_ not equal to 0
+add-align = $(if $(filter-out 0,$($(1))),$(cc-option-align)$(2)=$($(1)))
+CFLAGS		+= $(call add-align,CONFIG_CC_ALIGN_FUNCTIONS,-functions)
+CFLAGS		+= $(call add-align,CONFIG_CC_ALIGN_LABELS,-labels)
+CFLAGS		+= $(call add-align,CONFIG_CC_ALIGN_LOOPS,-loops)
+CFLAGS		+= $(call add-align,CONFIG_CC_ALIGN_JUMPS,-jumps)
 
 ifdef CONFIG_FRAME_POINTER
 CFLAGS		+= -fno-omit-frame-pointer
