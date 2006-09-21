Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWIUW4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWIUW4F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWIUW4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:56:05 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:25521
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932100AbWIUW4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:56:02 -0400
Date: Thu, 21 Sep 2006 15:56:15 -0700 (PDT)
Message-Id: <20060921.155615.11378692.davem@davemloft.net>
To: w@1wt.eu
Cc: DJurzitza@harmanbecker.com, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Subject: Re: Patch 2.4 kernel / allow to read more than 2048 (1821) Symbols
 from /boot/System.map
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060919182638.GD3467@1wt.eu>
References: <DA6197CAE190A847B662079EF7631C06015692C9@OEKAW2EXVS03.hbi.ad.harman.com>
	<20060917.223512.25476592.davem@davemloft.net>
	<20060919182638.GD3467@1wt.eu>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>
Date: Tue, 19 Sep 2006 20:26:38 +0200

> On Sun, Sep 17, 2006 at 10:35:12PM -0700, David Miller wrote:
> > From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
> > Date: Mon, 18 Sep 2006 07:23:58 +0200
> > 
> > > The 2.4 kernel series uses sys32_get_kernel_syms(struct kernel_sym32
> > > *table) for reading the kernel symbols (on sparc64). The size of
> > > struct kernel_sym is 64 byte on "normal" arches, but 72 byte on
> > > sparc64.
> > 
> > Jurzita, you do not need to post this patch multiple times.
> > I was simply on vacation for 2 weeks right after your first
> > posting so I had no chance to review the patch.
> 
> BTW, did you finally review it (no emergency at all on my side) ?

There are two problems:

1) If this goes in, similar fixes for sys_ia32.c, mips64, et al.
   should go in at the same time.

2) I dislike this fix because it means that users can lock down
   a significant amount of non-swappable kernel memory.  There are
   no privilege checks in the get_kernel_syms() system call, so
   anyone can invoke it.  Imagine a fork bomb invoking this, and it
   could also potentially eat up nearly all of the vmalloc() space.

It may be, in the end, simply better to have a
"compat_sys_get_kernel_syms" written that can be called
so a temporary kernel copy is not needed.

I'm not offering to implement this :-)  But it does seem to be the
only reasonable solution.
