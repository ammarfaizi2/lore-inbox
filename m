Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263564AbUJ2VEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbUJ2VEx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbUJ2VEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:04:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:17851 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263573AbUJ2VDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:03:24 -0400
Date: Fri, 29 Oct 2004 14:03:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: linux-os@analogic.com
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.58.0410291217460.28839@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0410291355460.28839@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410291316470.3945@chaos.analogic.com>
 <Pine.LNX.4.58.0410291217460.28839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Oct 2004, Linus Torvalds wrote:
> 
> Here's a totally untested patch to make the semaphores use "fastcall" 
> instead of "asmlinkage"

Ok, I tested it, looked through the assembly code, and did a general size 
comparison. Everything looks good, and it should fix the problem that 
caused this discussion. Checked in.

The patch actually improves code generation by moving the failure case
argument generation _into_ the failure case: this makes the inline asm one
instruction longer, but it means that the fastpath is often one
instruction shorter. In fact, the fastpath is usually improved even _more_
than that, because gcc does sucketh at generating code that uses fixed
registers (ie the old code often caused gcc to first generate the value
into another register, and then _move_ it into %eax, rather than just
generating it into %eax in the first place).

My test-kernel shrunk by a whopping 2kB in size from this change.

		Linus
