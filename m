Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbUBYSee (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbUBYSee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:34:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29323 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261534AbUBYSd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:33:59 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Early memory patch, revised
References: <403ADCDD.8080206@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Feb 2004 11:26:03 -0700
In-Reply-To: <403ADCDD.8080206@zytor.com>
Message-ID: <m1r7wjf22s.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Hi all,
> 
> This is the latest version of the i386 early memory cleanup patch.  It has the
> additional advantage that it removes some of the special casing for VISWS --
> this is still untested; if you have access to a VISWS *please* test this out.
> 
> The main difference other than the VISWS code is that it always sets up the GDT.
> 
> I agree with Eric this is a lot cleaner.

Thanks.  :)

Two little tweaks I can think of.
1) Can we reserve space between __bss_stop and _end for the page
   tables and the bitmap of memory?   
   
   This should make it obvious that the early boot code is touching
   that memory.

2) Can we export _end in setup.S so a bootloader can verify the
   kernel + bss will fit in memory?

Roughly the additions needed to vmlinux.lds.S look like:
+++ arch/i386/kernel/vmlinux.lds.S
@@ -105,6 +105,18 @@
 	
   __bss_start = .;		/* BSS */
   .bss : { *(.bss) }
+  . = ALIGN(4);
   __bss_stop = .; 
+ 
+  /* Reserve space for the initial page tables.
+   * A 1GB kernel needs 1MB of page tables.
+   * We must cover the first 1M ourselves and the initial memory bitmap.
+   * In the worst (1G kernel + 36G of ram) case this increases our
+   * page table size by 3K.
+   */
+  . += (((__bss_stop - _text + 4095) / 4096) + ((4*1024*1024) / 4096)) * 4 ;
+  
+  /* Reserve space for the initial memory bitmap 2^36/4096/8 = 2MB */
+  . += 2*1024*1024;
 
   _end = . ;

Eric
