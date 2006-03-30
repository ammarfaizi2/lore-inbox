Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWC3H7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWC3H7c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 02:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWC3H7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 02:59:31 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:10113 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751185AbWC3H7b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 02:59:31 -0500
Date: Thu, 30 Mar 2006 00:00:25 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pazke@donpac.ru, James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH] Cleanup subarch definitions in Linux/i386
Message-ID: <20060330080025.GC14724@sorel.sous-sol.org>
References: <442B5BF8.5000502@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442B5BF8.5000502@vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Comments, suggestions, anything welcome.  I think this is a much cleaner 
> approach, and both new and existing sub-architectures will benefit.  I 
> am sorry this patch is so large, but it is very difficult to separate 
> into multiple steps that still allow all the subarches to compile.

Zach, looks nice.  Saves Xen a partial copy of setup.c.  Did you have
further/similar consolidations in mind?

> --- linux-2.6.16.1.orig/arch/i386/Makefile	2006-03-29 19:38:47.000000000 -0800
> +++ linux-2.6.16.1/arch/i386/Makefile	2006-03-29 19:38:54.000000000 -0800
> @@ -45,37 +45,32 @@ CFLAGS				+= $(shell if [ $(call cc-vers
>  
>  CFLAGS += $(cflags-y)
>  
> -# Default subarch .c files
> -mcore-y  := mach-default
> +# Default subarch .c files (none)
> +mcore-y  := 
>  
>  # Voyager subarch support
>  mflags-$(CONFIG_X86_VOYAGER)	:= -Iinclude/asm-i386/mach-voyager
> -mcore-$(CONFIG_X86_VOYAGER)	:= mach-voyager
> +mcore-$(CONFIG_X86_VOYAGER)	:= arch/i386/mach-voyager/

Is this intended to make way for possible fine tuning?  Smth like:

mcore-$(CONFIG_X86_VOYAGER)	+= arch/i386/another_default.o
(hmm, not sure if that would even work)

Or just an aesthetic change?

> --- linux-2.6.16.1.orig/include/asm-i386/acpi.h	2006-03-29 19:38:47.000000000 -0800
> +++ linux-2.6.16.1/include/asm-i386/acpi.h	2006-03-29 19:38:54.000000000 -0800
> @@ -31,6 +31,7 @@
>  #include <acpi/pdc_intel.h>
>  
>  #include <asm/system.h>		/* defines cmpxchg */
> +#include <asm/processor.h>	/* defines boot_cpu_data */

that one necessary?

>  #define COMPILER_DEPENDENT_INT64   long long
>  #define COMPILER_DEPENDENT_UINT64  unsigned long long
> Index: linux-2.6.16.1/include/asm-i386/arch_hooks.h
> ===================================================================
> --- linux-2.6.16.1.orig/include/asm-i386/arch_hooks.h	2006-03-29 19:38:47.000000000 -0800
> +++ linux-2.6.16.1/include/asm-i386/arch_hooks.h	2006-03-29 19:38:54.000000000 -0800
> @@ -1,7 +1,13 @@
>  #ifndef _ASM_ARCH_HOOKS_H
>  #define _ASM_ARCH_HOOKS_H
>  
> +#include <linux/config.h>
> +#include <linux/smp.h>
> +#include <linux/init.h>
>  #include <linux/interrupt.h>
> +#include <asm/acpi.h>
> +#include <asm/arch_hooks.h>

extraneous include

> --- linux-2.6.16.1.orig/include/asm-i386/mach-default/mach_hooks.h	2006-03-29 19:38:54.000000000 -0800
> +++ linux-2.6.16.1/include/asm-i386/mach-default/mach_hooks.h	2006-03-29 19:38:54.000000000 -0800
> @@ -0,0 +1,6 @@
> +#ifndef _MACH_HOOKS_H
> +#define _MACH_HOOKS_H

should probably be consistent (_MACH_HOOKS_H vs. MACH_HOOKS_H)

> --- linux-2.6.16.1.orig/include/asm-i386/mach-visws/mach_hooks.h	2006-03-29 19:38:54.000000000 -0800
> +++ linux-2.6.16.1/include/asm-i386/mach-visws/mach_hooks.h	2006-03-29 19:38:54.000000000 -0800
> @@ -0,0 +1,15 @@
> +#ifndef MACH_HOOKS_H
> +#define MACH_HOOKS_H
