Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310180AbSB1WlK>; Thu, 28 Feb 2002 17:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310184AbSB1Whi>; Thu, 28 Feb 2002 17:37:38 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:18563 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S310181AbSB1Wfl>; Thu, 28 Feb 2002 17:35:41 -0500
Message-Id: <200202282147.OAA27067@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Dave Jones <davej@suse.de>, Steven Cole <elenstev@mesatop.com>
Subject: Re: [PATCH] 2.5.5-dj2, modify arch/i386/Config.help for highpte options.
Date: Thu, 28 Feb 2002 15:32:48 -0700
X-Mailer: KMail [version 1.3.1]
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <200202281827.LAA26782@tstac.esa.lanl.gov> <20020228220158.I32662@suse.de>
In-Reply-To: <20020228220158.I32662@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 February 2002 02:01 pm, Dave Jones wrote:
> On Thu, Feb 28, 2002 at 12:12:51PM -0700, Steven Cole wrote:
>  > Here is a snippet from arch/i386/config.in both 2.5.5-dj2 and
>  > 2.5.6-pre1: choice 'High Memory Support' \
>  >         "off           CONFIG_NOHIGHMEM \
>  >          4GB           CONFIG_HIGHMEM4G \
>  >          4GB-highpte   CONFIG_HIGHMEM4G_HIGHPTE \
>  >          64GB          CONFIG_HIGHMEM64G \
>  >          64GB-highpte  CONFIG_HIGHMEM64G_HIGHPTE" off
>
>  Would this not be better done using a "use highpte" bool in
>  the !CONFIG_NOHIGHMEM case ?

Maybe.  Here is a patch to arch/i386/config.in to try it that way.

Ingo, is this OK?

After the first patch, is another small patch to arch/i386/Config.help which
provides some explanation of CONFIG_HIGHPTE, which I hope is not
too inaccurate.  This supercedes the original change to arch/i386/Config.help.

Steven

--- linux-2.5.5-dj2/arch/i386/config.in.orig	Thu Feb 28 14:33:48 2002
+++ linux-2.5.5-dj2/arch/i386/config.in	Thu Feb 28 15:20:18 2002
@@ -161,25 +161,20 @@
 choice 'High Memory Support' \
 	"off           CONFIG_NOHIGHMEM \
 	 4GB           CONFIG_HIGHMEM4G \
-	 4GB-highpte   CONFIG_HIGHMEM4G_HIGHPTE \
-	 64GB          CONFIG_HIGHMEM64G \
-	 64GB-highpte  CONFIG_HIGHMEM64G_HIGHPTE" off
-if [ "$CONFIG_HIGHMEM4G" = "y" ]; then
-   define_bool CONFIG_HIGHMEM y
+	 64GB          CONFIG_HIGHMEM64G" off
+
+if [ "$CONFIG_HIGHMEM4G" = "y" -o "$CONFIG_HIGHMEM64G" = "y" ]; then
+   bool 'Use high memory pte support' CONFIG_HIGHPTE
 fi
-if [ "$CONFIG_HIGHMEM4G_HIGHPTE" = "y" ]; then
+
+if [ "$CONFIG_HIGHMEM4G" = "y" ]; then
    define_bool CONFIG_HIGHMEM y
-   define_bool CONFIG_HIGHPTE y
 fi
+
 if [ "$CONFIG_HIGHMEM64G" = "y" ]; then
    define_bool CONFIG_HIGHMEM y
    define_bool CONFIG_X86_PAE y
 fi
-if [ "$CONFIG_HIGHMEM64G_HIGHPTE" = "y" ]; then
-   define_bool CONFIG_HIGHMEM y
-   define_bool CONFIG_HIGHPTE y
-   define_bool CONFIG_X86_PAE y
-fi
 
 bool 'Math emulation' CONFIG_MATH_EMULATION
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR

--- linux-2.5.5-dj2/arch/i386/Config.help.orig  Thu Feb 28 10:58:01 2002
+++ linux-2.5.5-dj2/arch/i386/Config.help       Thu Feb 28 15:07:42 2002
@@ -128,6 +128,12 @@

   If unsure, say "off".

+CONFIG_HIGHPTE
+  The VM uses one page table entry for each page of physical memory.
+  For systems with a lot of RAM, this can be wasteful of precious
+  low memory.  Setting this option will put user-space page table
+  entries in high memory.
+
 CONFIG_HIGHMEM4G
   Select this if you have a 32-bit processor and between 1 and 4
   gigabytes of physical RAM.

