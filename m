Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWDWMlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWDWMlZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 08:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWDWMlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 08:41:25 -0400
Received: from silver.veritas.com ([143.127.12.111]:2233 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751394AbWDWMlY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 08:41:24 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.04,149,1144047600"; 
   d="scan'208"; a="37489448:sNHT25510548"
Date: Sun, 23 Apr 2006 13:41:18 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: David Wilk <davidwilk@gmail.com>
cc: Chris Wright <chrisw@sous-sol.org>, Greg KH <greg@kroah.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, stable@kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [stable] 2.6.16.6 breaks java... sort of
In-Reply-To: <a4403ff60604211456j46a2f69fw39606ffec42ec95d@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0604231312450.2515@blonde.wat.veritas.com>
References: <a4403ff60604191152u5a71e70fr9f54c104a654fc99@mail.gmail.com> 
 <20060419192803.GA19852@kroah.com>  <Pine.LNX.4.64.0604192046590.17491@blonde.wat.veritas.com>
  <Pine.LNX.4.64.0604201706540.14395@blonde.wat.veritas.com> 
 <a4403ff60604211208gf64dfe2v7282a493f4853c@mail.gmail.com> 
 <20060421192743.GH3061@sorel.sous-sol.org> <a4403ff60604211456j46a2f69fw39606ffec42ec95d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Apr 2006 12:41:24.0272 (UTC) FILETIME=[3B1FF300:01C666D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2006, David Wilk wrote:
> I finally got strace into the tomcat startup scripts properly and
> grabbed the attached output.  I don't see any of the two lines you
> propose.  I hope you guys can find this useful.

Thanks for getting that, David.  As you observe, it doesn't involve
shm at all, and the only mprotect is PROT_NONE.  Do the abbreviated
messages in the final lines of the trace fit with the errors you
were originally reporting?  (I think so.)  Or is this particular
trace failing for some other reason, earlier than before, and we
need to try something else to identify the problem?

> mmap2(NULL, 872415232, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) = -1 ENOMEM (Cannot allocate memory)
> write(1, "Error occurred during initializa"..., 43) = 43
> write(1, "Could not reserve enough space f"..., 46) = 46
> write(1, "\n", 1)                       = 1
> unlink("/tmp/hsperfdata_tomcat/12273")  = 0
> write(2, "Could not create the Java virtua"..., 43) = 43

To judge by this trace, I'd have to say that your problem has
nothing whatever to do with the shm/mprotect fix in 2.6.16.6,
and we've no evidence yet to complicate that fix.  Interestingly,
nobody else has so far reported any problem with it.

Judging by the mmap addresses throughout the trace (top down, from
0x37f2e000), it looks like you've got CONFIG_VMSPLIT_1G (not a good
choice for a box with only 1G of RAM: whereas CONFIG_VMSPLIT_3G_OPT
would maximize your userspace while avoiding the need for HIGHMEM);
and with the above 832M mmap, the remaining hole in user address
space is just too small to hold it.

But that leaves me quite unable to explain why you should have
thought the shm/mprotect patch responsible, and why you should
find the more complicated version works.  Stack randomization
changes the numbers a little, but I think not enough to explain
how it sometimes could fit 832M in there, sometimes not.

Tell me I'm talking nonsense and we'll have another go:
I guess adding some printks on top of the "replacement"
patch, so it can tell us when it's having an effect.

Hugh
