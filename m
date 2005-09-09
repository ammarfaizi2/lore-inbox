Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbVIIKRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbVIIKRL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 06:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbVIIKRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 06:17:11 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:51483
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030216AbVIIKRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 06:17:10 -0400
Message-Id: <43217D8C02000078000248DF@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 09 Sep 2005 12:18:20 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new kallsyms approach
References: <43206DBB0200007800024447@emea1-mh.id2.novell.com> <p733boe52c0.fsf@verdi.suse.de>
In-Reply-To: <p733boe52c0.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I don't think it's a good idea to have two different ways
>to do kallsyms. Either we should always use your new
>way in standard KALLSYMS or not do it at all.

I agree, but I wanted to retain the old mechanism not the least because
of the space constraints you mention.

>The major decision factor is how much bloat it adds.
>Can you post before/after numbers of binary size? 

i386 vmlinux KALLSYMS_ALL=n: old=5782934 new=6106675 (5.60% increase)
i386 vmlinux KALLSYMS_ALL=y: old=6049118 new=6524411 (7.85% increase)
x86-64 vmlinux KALLSYMS_ALL=n: old=8593125 new=8962128 (4.30%
increase)
x86-64 vmlinux KALLSYMS_ALL=y: old=8797853 new=9117704 (3.64%
increase)

I shall note additionally that not using KALLSYMS_ALL with the new
approach increases the build time somewhat because the stripping of the
data symbols in this scheme is rather inefficient (a binutils limitation
as I would call it). KALLSYMS_ALL=y, however, is mostly suited for
kernel debugging, while KALLSYMS_ALL=n seems the best choice if just
caring about symbolic stack traces, which seems to be another argument
for keeping both mechanisms.

>If the difference is >5% or so - are there ways to recover
>the difference? 

There are certainly ways, but I'm not sure how much they would cost.
One thing would be to teach the linker to not only optimize the section
string table, but also the (normal) symbol string one. Decreasing the
symbol table size might be more difficult - only st_size and only on
64-bit archs seems to lend itself to reduction (as any symbol's size can
clearly be expected to be less than 4G). But that would result in
alignment problems, so I don't think that'd be a good idea either.

Jan
