Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264189AbTEWU6T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 16:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264190AbTEWU6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 16:58:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51206 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264189AbTEWU6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 16:58:14 -0400
Date: Fri, 23 May 2003 22:11:13 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org, ak@suse.de,
       David Mosberger <davidm@napali.hpl.hp.com>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: /proc/kcore - how to fix it
Message-ID: <20030523221113.C4584@flint.arm.linux.org.uk>
Mail-Followup-To: "Luck, Tony" <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org, ak@suse.de,
	David Mosberger <davidm@napali.hpl.hp.com>,
	Andrew Morton <akpm@digeo.com>
References: <DD755978BA8283409FB0087C39132BD101B00E04@fmsmsx404.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <DD755978BA8283409FB0087C39132BD101B00E04@fmsmsx404.fm.intel.com>; from tony.luck@intel.com on Fri, May 23, 2003 at 12:13:04PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 12:13:04PM -0700, Luck, Tony wrote:
> Not a lot of replies to this on the list, but I did notice
> that the lse-tech IRC discussion mentioned me by name, saying
> that I had a proposal for a fix ... and Andrew has stuck my
> name against this in the must-fix list for 2.6.  So, not wanting
> to be the person who is holding up 2.6 ... here's what I am
> proposing.

This is what I currently have hacked into kcore.c which works (but
*will* break for non-ARM stuff.)

I suspect the easiest thing may be to arrange for the discontig direct
mapped memory blocks to appear on the vmlist and then remove the special
case for the direct mapped RAM.  I don't see why architecture support
needs to come into the picture really.

I don't believe any races here are that important (except of course
ensuring that we produce consistent data for a particular read() and
not oopsing the kernel) - take a moment to think where the information
/proc/kcore provides ends up and realise that as soon as it hits
userspace, you can't rely on it.  eg, Today, if you're using it and
you insert a module, the structure of the file changes, and gdb's
idea of offsets of data into the "core" becomes invalid.

--- orig/fs/proc/kcore.c	Sat Nov  2 18:58:18 2002
+++ linux/fs/proc/kcore.c	Mon May 19 23:30:41 2003
@@ -99,7 +99,13 @@
 }
 #else /* CONFIG_KCORE_AOUT */
 
+#define KCORE_BASE	(PAGE_OFFSET - 0x01000000)
+#define in_vmlist_region(x) (((x) >= KCORE_BASE && (x) < PAGE_OFFSET) || ((x) >= VMALLOC_START && (x) < VMALLOC_END))
+
+#ifndef KCORE_BASE
 #define	KCORE_BASE	PAGE_OFFSET
+#define in_vmlist_region(x) ((x) >= VMALLOC_START && (x) < VMALLOC_END)
+#endif
 
 #define roundup(x, y)  ((((x)+((y)-1))/(y))*(y))
 
@@ -394,7 +400,7 @@
 		tsz = buflen;
 		
 	while (buflen) {
-		if ((start >= VMALLOC_START) && (start < VMALLOC_END)) {
+		if (in_vmlist_region(start)) {
 			char * elf_buf;
 			struct vm_struct *m;
 			unsigned long curstart = start;


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

