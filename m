Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbVLUS7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVLUS7o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVLUS7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:59:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52958 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751187AbVLUS7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:59:44 -0500
Date: Wed, 21 Dec 2005 10:57:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 3/8] mutex subsystem, add atomic_*_call_if_*() to i386
In-Reply-To: <Pine.LNX.4.64.0512211044240.4827@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0512211054450.4827@g5.osdl.org>
References: <20051221155442.GD7243@elte.hu> <Pine.LNX.4.64.0512211044240.4827@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Dec 2005, Linus Torvalds wrote:

> Umm. This asm is broken. It doesn't mark %eax as changed, so this is only 
> reliable if the function you call is
> 
>  - a "fastcall" one
>  - always returns as its return value the pointer to the atomic count
> 
> which is not true (you verify that it's a fastcall, but it's of type 
> "void").

Actually (and re-reading the email I sent that wasn't obvious at all), my 
_preferred_ fix is to literally force the use of the above kind of 
function: not save/restore %eax at all, but just say that any function 
that is called by the magic "atomic_*_call_if()" needs to always return 
the argument it gets as its return value too.

That allows the caller to not even have to care. And the callee obviously 
already _has_ that value, so it might as well return it (and in the best 
case it's not going to add any cost at all, either to the caller or the 
callee).

So you might opt to keep the asm the same, just change the calling 
conventions.

		Linus
