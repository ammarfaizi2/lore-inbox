Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTJDJcM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 05:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbTJDJcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 05:32:12 -0400
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:23751 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S261965AbTJDJcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 05:32:11 -0400
From: Ingo Oeser <ioe-lists@rameria.de>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: mlockall and mmap of IO devices don't mix
Date: Sat, 4 Oct 2003 11:29:25 +0200
User-Agent: KMail/1.5.4
Cc: joe.korty@ccur.com, linux-kernel@vger.kernel.org, riel@redhat.com,
       andrea@suse.de, Andrew Morton <akpm@osdl.org>
References: <20031003214411.GA25802@rudolph.ccur.com> <20031003172727.3d2b6cb2.akpm@osdl.org> <20031003224727.2f6956b5.davem@redhat.com>
In-Reply-To: <20031003224727.2f6956b5.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310041129.25813.ioe-lists@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 04 October 2003 07:47, David S. Miller wrote:
> On Fri, 3 Oct 2003 17:27:27 -0700
>
> Andrew Morton <akpm@osdl.org> wrote:
> > Maybe it's best to not overload VM_RESERVED in this manner, but to always
> > mark /dev/mem as VM_IO.
>
> Just in cast is isn't clear, it should be defined that anything
> that sets VM_IO on an mmap() area should prefill the page tables
> as a side effect of such a mmap() request.
>
> Then things like mlockall() have simple semantics on VM_IO area, they
> end up being a nop.

It should be already, but the check in get_user_pages() looks wrong and
will only disallow VM_IO if you provide space for an page array.
It should be unconditional and we are done, because follow_pages will
never be called with such vmas.

Putting this check for "forbidden VMAs" into follow_pages is also a good
decision, if follow_pages() is called by strange callers not knowing the
limitations. kernel/futex.c is such an user, which don't check these in
the fast path (does it like wait on hardware triggered futexes there?).

It might be good to add VM_RESERVED check to get_user_pages(), too.
These pages are available anyway, so never need to be considered from
its users.

Regards

Ingo Oeser


