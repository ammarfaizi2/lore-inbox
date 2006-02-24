Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbWBXWHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbWBXWHW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 17:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbWBXWHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 17:07:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:19673 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932603AbWBXWHW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 17:07:22 -0500
Date: Fri, 24 Feb 2006 17:07:21 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/7] inflate pt1: refactor boot-time inflate code
In-reply-to: <1.399206195@selenic.com>
X-X-Sender: nico@localhost.localdomain
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0602241654480.31162@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <1.399206195@selenic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006, Matt Mackall wrote:

> This is a refactored version of the lib/inflate.c:
> 
> - clean up some really ugly code
> - clean up atrocities like '#include "../../../lib/inflate.c"'
> - drop a ton of cut and paste code from the kernel boot
> - move towards making the boot decompressor pluggable
> - move towards unifying the multiple inflate implementations
> - save space

Could you also make sure that there is no non-const global variables 
whatsoever in there?  The idea is that on ARM the decompressor was once 
made to be executable directly from flash so the deflated kernel image 
would be stored at its final location in ram directly without first 
copying zImage nor any .data to ram in order to execute it.  This is a 
significant boot time saving (which I think CE Linux is interested in) 
while still preserving a compressed kernel in flash.

Currently:

$ size lib/zlib_inflate/zlib_inflate.o
   text    data     bss     dec     hex filename
  11868      68       0   11936    2ea0 lib/zlib_inflate/zlib_inflate.o

Since this code is probably reentrant already, global variables are most 
probably read-only and declaring them const will store their content 
into .rodata which should be accounted as text above.

Having an empty .data section is the easiest way to be sure the kernel 
decompressor can actually execute from flash without subtle bugs due to 
the enforced read-only nature of global variables.


Nicolas
