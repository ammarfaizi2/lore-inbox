Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbUCBJVi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 04:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbUCBJVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 04:21:37 -0500
Received: from hera.kernel.org ([63.209.29.2]:40075 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261571AbUCBJVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 04:21:36 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [CFT][PATCH] 2.6.4-rc1 remove x86 boot page tables
Date: Tue, 2 Mar 2004 09:21:15 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c21jmb$9g9$1@terminus.zytor.com>
References: <m1vflp81kq.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1078219275 9738 63.209.29.3 (2 Mar 2004 09:21:15 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 2 Mar 2004 09:21:15 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m1vflp81kq.fsf@ebiederm.dsl.xmission.com>
By author:    ebiederm@xmission.com (Eric W. Biederman)
In newsgroup: linux.dev.kernel
> 
> -	.quad 0x0000000000000000	/* 0x20 unused */
> -	.quad 0x0000000000000000	/* 0x28 unused */
> +	.quad 0x40cf9a000000ffff	/* 0x20 kernel 4G code at 0-__PAGE_OFFSET */
> +	.quad 0x40cf92000000ffff	/* 0x28 kernel 4G data at 0-__PAGE_OFFSET */
> 

This needs to actually be derived from __PAGE_OFFSET (it may or may
not be 0xc0000000.)

I'd suggest:

/* Create a descriptor from (base,limit,flags) */
/* Limit is in 20-bit form! */
#define DESC(b,l,f)     .long (((l) & 0x0ffff)) |\
                              (((b) & 0x0000ffff) << 16), \
			      (((b) & 0x00ff0000) >> 16) | \
                              (((l) & 0xf0000)) | \
                              (((f) & 0xf0ff) << 8) | \
			      (((b) & 0xff000000))

        DESC(-__PAGE_OFFSET,0xfffff,0xc09a)       /* 0x20 kernel 4G code at -__PAGE_OFFSET */
        DESC(-__PAGE_OFFSET,0xfffff,0xc092)       /* 0x28 kernel 4G code at -__PAGE_OFFSET */

[It broken up into .longs like that, because gas doesn't seem to
handle 64-bit arithmetric.]

Writing all the descriptors in that form may be a good thing :)

	-hpa
