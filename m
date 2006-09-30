Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751963AbWI3UoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbWI3UoD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 16:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbWI3UoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 16:44:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24966 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751963AbWI3UoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 16:44:00 -0400
Date: Sat, 30 Sep 2006 13:43:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>, Jan Beulich <jbeulich@novell.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, Chandra Seetharaman <sekharan@us.ibm.com>,
       Eric Rannaud <eric.rannaud@gmail.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
In-Reply-To: <Pine.LNX.4.64.0609301237460.3952@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0609301329230.3952@g5.osdl.org>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
 <Pine.LNX.4.64.0609301237460.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Sep 2006, Linus Torvalds wrote:
>
> It's not just unreadable and obviously buggy, it's so scarily that it's 
> hard to even talk about it. Lookie here:
> 
> 	#define HANDLE_STACK(cond) \
> 	        do while (cond) { \
> 	                unsigned long addr = *stack++; \
> 
> What the F*CK! "do while(cond) {" ???? 

Btw, it took me quite a while to realize how something like that can 
even compile. Seriously. Don't write code like that. Maybe some humans 
parse it as

	do {
		while (cond) {
			..
		}
	} while(0)

(which is the technically correct parsing and explains why it compiles 
and wors), but I suspect I'm not the only one who went "What the F*CK" 
when shown it without the "extraneous" braces.

For similar reasons, we write

	#define dummy(x) do { } while (0)

rather than the shorter

	#define dummy(x) do ; while (0)

(which some people _do_ seem to use. Aarggh!)

Or at least indent it. Or something.

I'll see if I can make git warn about "do <non-blockstatement> while ()", 
if only because I at least personally seem to have trouble parsing it.

		Linus
