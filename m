Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266495AbUGKElS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266495AbUGKElS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 00:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266496AbUGKElS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 00:41:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:47307 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266495AbUGKEk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 00:40:58 -0400
Date: Sat, 10 Jul 2004 21:40:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexandre Oliva <aoliva@redhat.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, jmorris@redhat.com,
       mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
In-Reply-To: <orhdsfo75w.fsf@livre.redhat.lsd.ic.unicamp.br>
Message-ID: <Pine.LNX.4.58.0407102128490.1764@ppc970.osdl.org>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
 <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org> <m1fz80c406.fsf@ebiederm.dsl.xmission.com>
 <Pine.LNX.4.58.0407092313410.1764@ppc970.osdl.org>
 <orhdsfo75w.fsf@livre.redhat.lsd.ic.unicamp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Jul 2004, Alexandre Oliva wrote:
> 
> > Why should they be?
> 
> Err...  Because the conditional expression is implicitly compared with
> 0 [6.8.4.1]/#2.  If 0 is not to be used explicitly in pointer
> contexts, why should it be ok to use it implicitly?

Exactly BECAUSE it's not an explicitly WRONG type of 0.

"0" is a number token. It is totally illogical from a conceptual 
standpoint to use it as a pointer. It makes no sense from any syntactic 
standpoint, and it's very much an ugly special case because K&R didn't 
want to add a keyword for NULL.

But the fact is, even early on, exactly _because_ "0" is illogical as a 
pointer, K&R added a

	#define NULL 0

to make it make _syntactic_ sense to use "NULL" as a pointer, even though 
the language lacked the specific keyword. So from a _syntactic_ 
standpoint, NULL is a pointer, even if from an implementation standpoint 
NULL ended up being this totally illogical integer 0.

In contrast, there is nothing syntactically strange about comparing a 
non-boolean (even though Pascal and other languages make it illegal). So 
here again, the "compare against 0" is an _implementation_ issue, not a 
conceptual syntactic confusion.

What I object to in using "0" as a pointer is that it changes the meaning 
of the token "0" depending on semantic information that may not even be 
very local. In contrast

	if (ptr)
		..

has no such confusion.

> [6.5.3.3]/#5 defines the result of the logical negation operator
> based on the result of comparing the expression with 0.

And you're totally confusing the "this is defined to be equivalent" as an 
implementation standpoint with "it's the same thing".

For example, the code

	5[ptr]

is _defined_ to be exactly the same as

	ptr[5]

since they both really mean

	*(ptr + 5)

and nothing else. HOWEVER, despite the fact that the C language _defines_ 
that they are exactly equivalent, I claim that anybody who writes "5[ptr]" 
is an ass.

For that same reason, your argument is totally irrelevant. Yes, 

	if (ptr)

is _defined_ to be exactly the same as

	if (ptr != 0)

but I claim that anybody who writes the latter is an ass, because it makes 
no syntactic sense. The same way "5[ptr]" doesn't make syntactic sense, 
even though the compiler will silently accept it.

Got it?

		Linus
