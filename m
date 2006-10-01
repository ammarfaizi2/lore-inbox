Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751742AbWJAAv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbWJAAv1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 20:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbWJAAv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 20:51:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21697 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751742AbWJAAv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 20:51:26 -0400
Date: Sat, 30 Sep 2006 17:51:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Eric Rannaud <eric.rannaud@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, Chandra Seetharaman <sekharan@us.ibm.com>,
       Jan Beulich <jbeulich@novell.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
In-Reply-To: <Pine.LNX.4.64.0609301713460.3952@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0609301748340.3952@g5.osdl.org>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
 <200610010002.46634.ak@suse.de> <Pine.LNX.4.64.0609301554310.3952@g5.osdl.org>
 <200610010156.52675.ak@suse.de> <Pine.LNX.4.64.0609301713460.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Sep 2006, Linus Torvalds wrote:
> 
>  - you have an outer loop that loops around the pages (since the _kernel_ 
>    controls the stack nesting at that level). This is the loop I quoted at 
>    you.
> 
>  - you have a _separate_ "unwinder()" for each page. It only unwinds 
>    within that one page, and if the frame moves away from the page, it 
>    immediately just returns that address, but it knows that it cannot be a 
>    "valid" unwind address within that page.

Side note: it's entirely possible that the "unwinder" code shouldn't even 
try to return the address outside the page, since the first/last frame on 
a page is likely to be special (ie it's an exception/interrupt kind of 
thing), and it's entirely possible that the "page-level" loop is better at 
handling that part too.

That way you wouldn't even need to make the exception frames haev the 
dwarf info etc, because you could choose to just depend on knowing what 
the format of such a page was. But that's obviously just an implementation 
choice..

Doesn't that sound like it should be both fairly straightforward and 
reasonable?

		Linus
