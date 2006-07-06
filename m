Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbWGFAAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbWGFAAO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 20:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbWGFAAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 20:00:14 -0400
Received: from xenotime.net ([66.160.160.81]:53724 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965076AbWGFAAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 20:00:12 -0400
Date: Wed, 5 Jul 2006 17:02:52 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: arjan@infradead.org, akpm@osdl.org, tglx@linutronix.de, mingo@elte.hu,
       rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq: ARM dyntick cleanup
Message-Id: <20060705170252.4dc73eb8.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.64.0607051626380.12404@g5.osdl.org>
References: <1151885928.24611.24.camel@localhost.localdomain>
	<20060702173527.cbdbf0e1.akpm@osdl.org>
	<Pine.LNX.4.64.0607031007421.12404@g5.osdl.org>
	<1151947627.3108.39.camel@laptopd505.fenrus.org>
	<20060705162425.547f3d3f.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0607051626380.12404@g5.osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006 16:53:22 -0700 (PDT) Linus Torvalds wrote:

> 
> 
> On Wed, 5 Jul 2006, Randy.Dunlap wrote:
> > 
> > OK, I'll bite.  What part of Linus's macro doesn't work.
> 
> Heh. This is "C language 101".

Yes, I got most of that.  :)
more below.

> The reason we always write
> 
> 	#define empty_statement do { } while (0)
> 
> instead of
> 
> 	#define empty_statement /* empty */
> 
> is not that
> 
> 	if (x)
> 		empty_statement;
> 
> wouldn't work like Arjan claimed, but because otherwise the empty 
> statement won't parse perfectly as a real C statement.
> 
> In particular, you tend to get much better error messages if you have 
> syntax errors _around_ the empty statement if it's done as that 
> "do { } while (0)" thing. You also avoid compiler warnings about 
> empty statements or statements without effects, that you'd get if you were 
> to use
> 
> 	#define empty_statement /* empty */
> 
> or
> 
> 	#define empty_statement 0
> 
> for example (a expression statement is a perfectly valid statement, as is 
> an empty one, but many compilers will warn on them).
> 
> It's also simply good practice - if you _always_ do the "do { } while (0)" 
> thing, you'll never get bitten by having a macro that has several 
> statements inside of it, and you'll also never get bitten by a macro that 
> is _meant_ to be used as a statement being used as part of an expression 
> instead.
> 
> It basically boils down to the fact that the "do { } while (0)" format is 
> always syntactically correct, /regardless/ of what is inside of the 
> braces, and should always give you meaningful error messages regardless of 
> what is _around_ the macro usage.

Yes, I already understood that.  I was interested in Arjan's
specific example, which was:

if (foo())
	zyzzy();

in which he supplied the terminating semi-colon, and which Andrew
explained with the -W warning...

> For example:
> 
> 	if (a)
> 		empty_statement
> 	b;
> 
> will give the _correct_ syntax error message ("expected ';'"), instead of 
> silently turning into
> 
> 	if (a)
> 		b;
> 
> or other nonsense.

OK, good practice, yes.

> But in the end, the real aim is to just teach your fingers to _always_ put 
> the do/while(0) there, so that you never EVER write something like
> 
> 	#define MACRO one; two;
> 
> which really breaks down.
> 
> This is, btw, the same reason a lot of people (including me, most of the 
> time) will write
> 
> 	#define VALUE (12)
> 
> instead of writing the simpler
> 
> 	#define VALUE 12
> 
> just because it's good practice to _always_ have the parentheses around 
> a macro that ends up being used as an expression.
> 
> So we always also write
> 
> 	#define ADD(a,b) ((a)+(b))
> 
> because otherwise you eventually _will_ get bitten (we've had that 
> particular bug bite us in the *ss lots of times, even though people should 
> know better)

Yes, I have the () macro practice down.  I was just looking for the
problem with that one specific example, which you and Andrew have now
explained.  Thanks.

---
~Randy
