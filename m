Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264269AbUEIEZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbUEIEZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 00:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264268AbUEIEZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 00:25:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:51333 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264269AbUEIEZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 00:25:56 -0400
Date: Sat, 8 May 2004 21:25:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: dipankar@in.ibm.com, manfred@colorfullife.com, davej@redhat.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org, maneesh@in.ibm.com
Subject: Re: dentry bloat.
In-Reply-To: <20040508211236.10481447.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0405082120290.1592@ppc970.osdl.org>
References: <409B1511.6010500@colorfullife.com> <20040508012357.3559fb6e.akpm@osdl.org>
 <20040508022304.17779635.akpm@osdl.org> <20040508031159.782d6a46.akpm@osdl.org>
 <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org>
 <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
 <Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org> <20040508204239.GB6383@in.ibm.com>
 <20040508135512.15f2bfec.akpm@osdl.org> <20040508211920.GD4007@in.ibm.com>
 <20040508171027.6e469f70.akpm@osdl.org> <Pine.LNX.4.58.0405081947290.1592@ppc970.osdl.org>
 <20040508211236.10481447.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 May 2004, Andrew Morton wrote:
> 
> I think that'll crash.  DNAME_INLINE_LEN_MIN is the *minimum* storage in
> the dentry.  The actual storage is assumed to be DNAME_INLINE_LEN and the
> patch doesn't change that value.

It doesn't need to, the value is correct.

> The calculation of DNAME_INLINE_LEN assumes that slab padded the dentry out
> to the next cacheline.

No it doesn't. It's just:

	#define DNAME_INLINE_LEN (sizeof(struct dentry)-offsetof(struct dentry,d_iname))

which is always right. 

It used to assume the padding because of the "____cacheline_aligned" on 
the struct dentry, which obviously also padded out the "sizeof()". But 
since I removed that, DNAME_INLINE_LEN is still correct.

NOTE! It's absolutely true that DNAME_INLINE_LEN may still be different 
from DNAME_INLINE_LEN_MIN. In particular, if something inside the struct 
makes the alignment of "struct dentry" be bigger than the offset of the 
last field, then DNAME_INLINE_LEN will be different from (bigger than) 
DNAME_INLINE_LEN.

It's just that with current architectures, I don't believe that will 
happen in practice. But I left it as-is, because at least in theory it 
could happen.

		Linus
