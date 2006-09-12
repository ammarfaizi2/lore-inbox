Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbWILWAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWILWAJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 18:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030310AbWILWAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 18:00:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38562 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030304AbWILWAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 18:00:08 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060912210425.GG19707@waste.org> 
References: <20060912210425.GG19707@waste.org>  <20060912174339.GA19707@waste.org> <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com> <17162.1157365295@warthog.cambridge.redhat.com> <6d6a94c50609042052n4c1803eey4f4412f6153c4a2b@mail.gmail.com> <3551.1157448903@warthog.cambridge.redhat.com> <6d6a94c50609051935m607f976j942263dd1ac9c4fb@mail.gmail.com> <44FE4222.3080106@yahoo.com.au> <6d6a94c50609120107w1942a8d8j368dd57a271d0250@mail.gmail.com> <15193.1158088232@warthog.cambridge.redhat.com> <6495.1158094606@warthog.cambridge.redhat.com> 
To: Matt Mackall <mpm@selenic.com>
Cc: David Howells <dhowells@redhat.com>, Aubrey <aubreylee@gmail.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       davidm@snapgear.com, gerg@snapgear.com
Subject: Re: kernel BUGs when removing largish files with the SLOB allocator 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 12 Sep 2006 22:59:45 +0100
Message-ID: <31224.1158098385@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:

> The only tricky part is the timer points back to _this very function_.

OIC.  Brrr.  That _definitely_ needs commenting - as has been demonstrated.
SLOB is using the theoretically one-shot initiator to do garbage collection.

The:

			if (size == PAGE_SIZE) /* trying to shrink arena? */
				return 0;

In slob_alloc() definitely looks very dodgy, now that I see it.  What happens
if some normal user asks to allocate exactly a page?  Oh... I suppose it never
gets into slob_alloc() to allocate the main piece of storage.

David
