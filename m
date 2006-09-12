Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWILVCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWILVCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 17:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWILVCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 17:02:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36480 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030222AbWILVCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 17:02:52 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060912202826.GC19707@waste.org> 
References: <20060912202826.GC19707@waste.org>  <20060912174339.GA19707@waste.org> <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com> <17162.1157365295@warthog.cambridge.redhat.com> <6d6a94c50609042052n4c1803eey4f4412f6153c4a2b@mail.gmail.com> <3551.1157448903@warthog.cambridge.redhat.com> <6d6a94c50609051935m607f976j942263dd1ac9c4fb@mail.gmail.com> <44FE4222.3080106@yahoo.com.au> <6d6a94c50609120107w1942a8d8j368dd57a271d0250@mail.gmail.com> <24525.1158089104@warthog.cambridge.redhat.com> 
To: Matt Mackall <mpm@selenic.com>
Cc: David Howells <dhowells@redhat.com>, Aubrey <aubreylee@gmail.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       davidm@snapgear.com, gerg@snapgear.com
Subject: Re: kernel BUGs when removing largish files with the SLOB allocator 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 12 Sep 2006 22:02:44 +0100
Message-ID: <6626.1158094964@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:

> Not sure yet. There's only one user in nommu.c that shouldn't just be
> changed to ksize() that I can see, and that's the one in
> show_process_blocks(). That could test for VM_MAPPED_COPY and keep its
> hands off otherwise. 

Hmmm...  You're right.  However, note binfmt_elf_fdpic().  This calls ksize()
but should really call kobjsize().  It should not assume that the allocation
it's been given is of any particular type.  IIRC ksize() changed purpose at
some point.

> I can imagine situations where ->mmap returns pointers to something
> that's statically allocated anyway (XIP?), where kobjsize doesn't
> really make sense.

ramfs for example.  See get_unmapped_area() hooks, not mmap() hooks.

> Also, looks like the WARN_ON_SLACK code has rotten, result isn't
> defined in that function. Change it to base, perhaps?

Yeah.  It might be worth ditching it entirely too.

David
