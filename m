Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUDNTa7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 15:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUDNTa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 15:30:59 -0400
Received: from mail.shareable.org ([81.29.64.88]:45729 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261405AbUDNTaz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 15:30:55 -0400
Date: Wed, 14 Apr 2004 20:28:44 +0100
From: Jamie Lokier <jamie@shareable.org>
To: davidm@hpl.hp.com
Cc: linux-ia64@linuxia64.org, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Kurt Garloff <garloff@suse.de>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] (IA64) Fix ugly __[PS]* macros in <asm-ia64/pgtable.h>
Message-ID: <20040414192844.GD12105@mail.shareable.org>
References: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com> <20040414082355.GA8303@mail.shareable.org> <20040414113753.GA9413@mail.shareable.org> <16509.25006.96933.584153@napali.hpl.hp.com> <20040414184603.GA12105@mail.shareable.org> <16509.35554.807689.904871@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16509.35554.807689.904871@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
>   Jamie> Yes I have.  Quite thoroughly.
> 
> Then you should have noticed that drivers/char/mem.c is using PAGE_COPY.

That's an interesting bug in drivers/char/mem.c.  PAGE_COPY is wrong,
for archs with separate execute permission or write-only mappings.

The correct argument in drivers/char/mem.c should be vma->vm_page_prot.

>   Jamie> In theory the Alpha can do exec-only pages, but it's __[PS]*
>   Jamie> map always gives read permission when there's execute
>   Jamie> permission.  I'm not sure if there's a reason for that, or if
>   Jamie> it just historically copied the i386 behaviour (Alpha was the
>   Jamie> first port).
> 
> I know why: back in those days, GCC emitted code for nested C
> functions that assumed an executable stack.  Also, Linus wasn't
> terribly eager to turn off execute-permission on data/stacks.  Even on
> ia64 we started out that way, until I saw the error in my ways.

We're both wrong.  I misread the Alpha code: it does have exec-only
pages.  What it doesn't have is write-only.  And exec-only pages
aren't relevant to GCC's requirements, which used to be
read-implies-exec (exec-only breaks exec-implies-read).

-- Jamie
