Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbULAFvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbULAFvN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 00:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbULAFvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 00:51:12 -0500
Received: from hera.kernel.org ([63.209.29.2]:17590 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261187AbULAFvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 00:51:10 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Wed, 1 Dec 2004 05:50:58 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cojm42$sf1$1@terminus.zytor.com>
References: <19865.1101395592@redhat.com> <Pine.LNX.4.58.0411301020160.22796@ppc970.osdl.org> <200411302128.53583.mmazur@kernel.pl> <Pine.LNX.4.58.0411301243000.22796@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1101880258 29154 127.0.0.1 (1 Dec 2004 05:50:58 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 1 Dec 2004 05:50:58 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.58.0411301243000.22796@ppc970.osdl.org>
By author:    Linus Torvalds <torvalds@osdl.org>
In newsgroup: linux.dev.kernel
> 
> But claiming that __KERNEL__ doesn't work is clearly a bunch of crapola. 
> As is the notion that you can somehow do it all. We do it in small pieces.
> 

IMNSHO, based on my experience with klibc, the problem is not #ifdef
__KERNEL__, the *specific* problems are:

- The kernel exporting libc4/5 internals, which are neither what the
  kernel nor any kind of modern userspace wants.  This should be
  possible to get rid of easily enough.

- The kernel exporting things into the userspace namespace.  The
  kernel's definition of "struct stat" isn't usable -- the one that is
  useful is called "struct stat64" on most, but not all,
  architectures, but because it's a structure tag it can't be pulled
  from the exported kernel ABI in such a way that what userspace calls
  "struct stat" is what the kernel currently calls "struct stat64" if
  that exists.

  This one is a bit uglier, since it probably needs something like:

  #ifdef __KERNEL__
  #define __kabi_stat64 stat64
  #endif

  struct __kabi_stat64 { ... };

	-hpa
