Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbTETS5h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 14:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263877AbTETS5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 14:57:37 -0400
Received: from zero.aec.at ([193.170.194.10]:20490 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263876AbTETS5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 14:57:32 -0400
To: Terence Ripperda <tripperda@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pat support in the kernel
From: Andi Kleen <ak@muc.de>
Date: Tue, 20 May 2003 21:10:18 +0200
In-Reply-To: <20030520190017$773c@gated-at.bofh.it> (Terence Ripperda's
 message of "Tue, 20 May 2003 21:00:17 +0200")
Message-ID: <m38yt1igdh.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <20030520190017$773c@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terence Ripperda <tripperda@nvidia.com> writes:

> Hello all,
>
> I've discussed adding Page Attribute Table (PAT) support to the kernel w/ a few developers offline. They were very supportive and suggested I bring the discussion to lkml so others could get involved.

change_page_attr() will already do it for the kernel mappings. Just
define a PAGE_KERNEL_WC. Drawback is that it will convert the mapping
to 4K pages (from 2/4MB), but there is probably no alternative unless
all your mappings are 2MB aligned.

But the tricky part of it is that you need to make sure all mappings
to that memory have the same caching attribute, otherwise you invoke
undefined x86 behaviour and risk cache corruptions on some CPUs. 

For the special case of AGP it's quite simple - when an user process maps
the aperture it can just set the correct bits in its own mmap method 
like it already does for uncachable mappings. But for other mappings
it is more difficult. 

For normal memory you would need to find a way to synchronize the
attributes in all mappers (e.g. setting a flag in struct page or
similar). For frame buffer you also need to handle it in all mmap'ers
(like fbcon or /dev/mem). I think handling these generic cases will
need a few VM changes.

[actually even the agp aperture can be accessed using /dev/mem, 
but thats probably unlikely to happen because there is a better interface 
and could be ignored]

-Andi
