Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265320AbUAPIZj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 03:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbUAPIZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 03:25:39 -0500
Received: from p50821B7E.dip.t-dialin.net ([80.130.27.126]:6272 "EHLO
	averell.firstfloor.org") by vger.kernel.org with ESMTP
	id S265320AbUAPIZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 03:25:37 -0500
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
References: <1bpdu-5jP-35@gated-at.bofh.it> <1brIi-Y0-57@gated-at.bofh.it>
	<1bIf6-fh-21@gated-at.bofh.it> <1bRiA-4PD-19@gated-at.bofh.it>
	<1bRrZ-58C-9@gated-at.bofh.it> <1bSHD-Xz-21@gated-at.bofh.it>
	<1e2sZ-rG-19@gated-at.bofh.it> <1e3Ih-1V0-1@gated-at.bofh.it>
	<1e7Cd-4qD-5@gated-at.bofh.it> <1einZ-64E-11@gated-at.bofh.it>
	<1ekpM-87C-1@gated-at.bofh.it> <1euyS-Eb-19@gated-at.bofh.it>
	<1euSb-U8-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 16 Jan 2004 09:25:30 +0100
In-Reply-To: <1euSb-U8-3@gated-at.bofh.it> (Andrew Morton's message of "Fri,
 16 Jan 2004 06:40:07 +0100")
Message-ID: <m3n08o1erp.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> +void bitmap_complement(unsigned long *bitmap, int bits)
> +{
> +	int k;
> +
> +	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
> +		bitmap[k] = ~bitmap[k];
> +}
> +EXPORT_SYMBOL(bitmap_complement);

I actually had to change that one in my NUMA API patchkit (which uses
bitmap functions for its node maps), because gcc 3.2 miscompiled the
loop.

Please add something like that (looks silly, but makes a big 
difference):

 static inline void bitmap_complement(unsigned long *bitmap, int bits)
 {
        int k;
+       int max = BITS_TO_LONGS(bits);
 
-       for (k = 0; k < BITS_TO_LONGS(bits); ++k)
+       for (k = 0; k < max; ++k)
                bitmap[k] = ~bitmap[k];

-Andi
