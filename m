Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264097AbUGXGI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbUGXGI1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 02:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268310AbUGXGI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 02:08:27 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:50146 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264097AbUGXGIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 02:08:17 -0400
Date: Fri, 23 Jul 2004 23:08:02 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ppc64 max_pfn issue
Message-ID: <20040724060802.GA31385@taniwha.stupidest.org>
References: <20040724044720.GF4556@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040724044720.GF4556@krispykreme>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2004 at 02:47:20PM +1000, Anton Blanchard wrote:

> I noticed excessive time in the pid hash functions on a ppc64
> box. It turns out the pid hash is being sized way too small, eg on a
> 16GB box:

This reminds me (that someone pointed out to me, I forget who) that in
pid.c we have:

 void __init pidhash_init(void)
 {
         int i, j, pidhash_size;
         unsigned long megabytes = max_pfn >> (20 - PAGE_SHIFT);

         pidhash_shift = max(4, fls(megabytes * 4));
         pidhash_shift = min(12, pidhash_shift);
         pidhash_size = 1 << pidhash_shift;

which isn't strictly correct for machines with sparse/discontiguous
memory as max_pfn may have very little bearing on the overall memory
size.

Since we cap it at 1<<12 I guess the platform affected might be ARM
where you would otherwise get a smaller hash size.  That said, I
wonder if a shift of 12 suffices for really large machines with many
many processes.


  --cw
