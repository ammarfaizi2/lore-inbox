Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWGLAjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWGLAjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 20:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWGLAjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 20:39:47 -0400
Received: from jg555.com ([64.30.195.78]:61143 "EHLO jg555.com")
	by vger.kernel.org with ESMTP id S932299AbWGLAjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 20:39:46 -0400
Message-ID: <44B443D2.4070600@jg555.com>
Date: Tue, 11 Jul 2006 17:35:30 -0700
From: Jim Gifford <maillist@jg555.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.18 Headers - Long
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was really glad to see that something was going to be done with the 
headers, but I don't think it's enough. I'm going to share my concerns 
and hopefully we can all figure what is the right thing to do.

First off, my research in this has been going on since LLH announced 
that it was not going to produce any more headers. I started a project 
to sanitize the headers myself. http://headers.cross-lfs.org.

I will only document one issue, but there are several more like this in 
the kernel.

I'm going to use the MIPS architecture in my example, along with the 
file page.h.

With the 2.6.18 headers, the file that gets created looks like this. If 
you notice on lines 17, 20, 23, 26, and 34 they all use CONFIG_{...}, 
these variables are called from linux/autoconf.h. Yes, the simple fix 
would be to include this file.

   1.
      /*
   2.
       * This file is subject to the terms and conditions of the GNU
      General Public
   3.
       * License.  See the file "COPYING" in the main directory of this
      archive
   4.
       * for more details.
   5.
       *
   6.
       * Copyright (C) 1994 - 1999, 2000, 03 Ralf Baechle
   7.
       * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
   8.
       */
   9.
      #ifndef _ASM_PAGE_H
  10.
      #define _ASM_PAGE_H
  11.
       
  12.
       
  13.
       
  14.
      /*
  15.
       * PAGE_SHIFT determines the page size
  16.
       */
  17.
      #ifdef CONFIG_PAGE_SIZE_4KB
  18.
      #define PAGE_SHIFT      12
  19.
      #endif
  20.
      #ifdef CONFIG_PAGE_SIZE_8KB
  21.
      #define PAGE_SHIFT      13
  22.
      #endif
  23.
      #ifdef CONFIG_PAGE_SIZE_16KB
  24.
      #define PAGE_SHIFT      14
  25.
      #endif
  26.
      #ifdef CONFIG_PAGE_SIZE_64KB
  27.
      #define PAGE_SHIFT      16
  28.
      #endif
  29.
      #define PAGE_SIZE       (1UL << PAGE_SHIFT)
  30.
      #define PAGE_MASK       (~((1 << PAGE_SHIFT) - 1))
  31.
       
  32.
       
  33.
       
  34.
      #ifdef CONFIG_LIMITED_DMA
  35.
      #define WANT_PAGE_VIRTUAL
  36.
      #endif
  37.
       
  38.
      #include <asm-generic/memory_model.h>
  39.
      #include <asm-generic/page.h>
  40.
       
  41.
      #endif /* _ASM_PAGE_H */

Here's the header I produce with my sanitize script, I use a glibc call 
to get the information, which would be more appropriate for the user 
space. This is very similar to what LLH provided. Even my example is not 
prefect due to line 14.

   1.
      #define _ASM_PAGE_H
   2.
       
   3.
      #include <unistd.h>
   4.
       
   5.
      #define PAGE_SIZE       (getpagesize())
   6.
      static __inline__ int getpageshift()
   7.
      {
   8.
          int pagesize = getpagesize();
   9.
          return (__builtin_clz(pagesize) ^ 31);
  10.
      }
  11.
      #define PAGE_SHIFT      (getpageshift())
  12.
      #define PAGE_MASK       (~(PAGE_SIZE-1))
  13.
       
  14.
      #ifdef CONFIG_LIMITED_DMA
  15.
      #define WANT_PAGE_VIRTUAL
  16.
      #endif
  17.
       
  18.
      #endif /* !(_ASM_PAGE_H) */


So even with the new headers_install, the headers still need to be 
sanitized to overcome the missing variables from linux/autoconf.h.

Just wanted to bring this up to everyone's attention and look forward to 
helping get things resolved.
