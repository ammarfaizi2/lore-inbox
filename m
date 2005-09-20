Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbVITMUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbVITMUY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 08:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbVITMUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 08:20:23 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:16582 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964985AbVITMUX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 08:20:23 -0400
Date: Tue, 20 Sep 2005 15:20:18 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: p = kmalloc(sizeof(*p), )
In-Reply-To: <20050920114003.GA31025@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0509201501440.9304@sbz-30.cs.Helsinki.FI>
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
 <84144f0205092004187f86840c@mail.gmail.com> <20050920114003.GA31025@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Tue, 20 Sep 2005, Russell King wrote:
> Think about it some more.  You've added a new member to struct foo.
> You want to fix up all the places which allocate struct foo to
> initialise this new member.  Grepping for 'struct foo' returns 100
> files.  Grepping for kmalloc in those 100 files returns 100 files.
> 
> Do you open all 100 in an editor and manually try and locate the five
> kmalloc instances of this structure, and end up missing some.

Nope. I grep for assignments to other members of that struct.

On Tue, 20 Sep 2005, Russell King wrote:
> Or do you do the sane thing and use kmalloc(sizeof(struct foo), ...)
> and grep for "kmalloc[[:space:]]*(sizeof[[:space:]]*(struct foo)"
> which returns only the five files and fix those up with knowledge
> that you've found all the instances?

There are still statically allocated structs left. So neither heuristic 
for figuring out initialization points is perfect.

On 9/18/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> Such shuffling around should be done in easy to review stages so that
> bugs can be found, and not a mega patch.  This inherently means that
> for a structure name change, you don't end up with a new structure
> named the same as an old structure.  And if you compile-test the
> stages, you find out if you missed the problem.

No disagreement here.

On 9/18/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> Your solution is better if the only thing you're concerned about is
> "are we allocating enough memory for this fixed size structure".
> It completely breaks if you are also concerned about "are we doing
> correct initialisation" or "are we allocating enough memory for this
> variable sized structure" both of which are far more important
> questions.
> 
> *especially* when you consider that kmalloc is redzoned and therefore
> will catch the kinds of bugs you're suggesting.

Well, yes, but for initialization, I would prefer something like what Al 
Viro suggested. To me, initialization is a separate issue from kmalloc. I 
do get your point but I just don't think sizeof(struct foo) is the answer.

In all completeness, I would personally prefer the following form for 
allocation and initialization which is readable, easy to get right, and 
highly greppable:

	struct foo *p = kmalloc(sizeof *p, ...);

	*p = (struct foo) {
		.bar = ...;
	};

Unfortunately it doesn't seem like gcc is doing such a good job with it.

			Pekka
