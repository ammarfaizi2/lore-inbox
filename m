Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266540AbTBGTlX>; Fri, 7 Feb 2003 14:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266615AbTBGTlX>; Fri, 7 Feb 2003 14:41:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4883 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266540AbTBGTlU>; Fri, 7 Feb 2003 14:41:20 -0500
Date: Fri, 7 Feb 2003 19:50:58 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Restore module support.
Message-ID: <20030207195058.D30927@flint.arm.linux.org.uk>
Mail-Followup-To: "Luck, Tony" <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org
References: <DD755978BA8283409FB0087C39132BD1A07C9E@fmsmsx404.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <DD755978BA8283409FB0087C39132BD1A07C9E@fmsmsx404.fm.intel.com>; from tony.luck@intel.com on Fri, Feb 07, 2003 at 10:43:19AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2003 at 10:43:19AM -0800, Luck, Tony wrote:
> > (2) has the disadvantage that its touching non-architecture specific
> > code, but this is the option I'd prefer due to the obvious performance
> > advantage.  However, I'm afraid that it isn't worth the effort to fix
> > up vmalloc and /proc/kcore.  vmalloc fix appears simple, but /proc/kcore
> > has issues (anyone know what KCORE_BASE is all about?)
> 
> KCORE_BASE is my fault ... it was an attempt to fix the "modules
> below PAGE_OFFSET" problem for the ia64 port.  For a few nanoseconds
> the code just here looked like this:
> 
> #if VMALLOC_START < PAGE_OFFSET
> #define	KCORE_BASE	VMALLOC_START
> #else
> #define	KCORE_BASE	PAGE_OFFSET
> #endif

Ah, ok.  What I'm thinking of is something like the following (untested
and probably improperly thought out patch...):

--- orig/fs/proc/kcore.c	Sat Nov  2 18:58:18 2002
+++ linux/fs/proc/kcore.c	Fri Feb  7 19:48:35 2003
@@ -99,7 +99,10 @@
 }
 #else /* CONFIG_KCORE_AOUT */
 
+#ifndef KCORE_BASE
 #define	KCORE_BASE	PAGE_OFFSET
+#define in_vmlist_region(x) ((x) >= VMALLOC_START && (x) < VMALLOC_END)
+#endif
 
 #define roundup(x, y)  ((((x)+((y)-1))/(y))*(y))
 
@@ -394,7 +397,7 @@
 		tsz = buflen;
 		
 	while (buflen) {
-		if ((start >= VMALLOC_START) && (start < VMALLOC_END)) {
+		if (in_vmlist_region(start)) {
 			char * elf_buf;
 			struct vm_struct *m;
 			unsigned long curstart = start;

An architecture could then define KCORE_BASE and in_vmlist_region()
alongside their VMALLOC_START definition if they needed to change
them.

> There was some discussion on a better way to do this, by adding the
> kernel itself to the vmlist, and eliminating all the special case code.
> I took a brief look at this, but realised that there were all sorts
> of ugly race conditions with /proc/kcore if a module is loaded/unloaded
> after some process has read the Elf header.

Well, only root can debug using /proc/kcore, and I'd suggest the best
answer to that problem is "if it hurts, don't do that."  I don't think
you should prevent modules from being unloaded just because you have
/proc/kcore open.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

