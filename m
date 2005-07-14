Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVGNBMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVGNBMQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 21:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVGNBMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 21:12:16 -0400
Received: from science.horizon.com ([192.35.100.1]:48709 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261588AbVGNBMM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 21:12:12 -0400
Date: 14 Jul 2005 01:12:08 -0000
Message-ID: <20050714011208.22598.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: kernel guide to space
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I don't think there's a strict 80 column rule anymore.  It's 2005...

> Think again.  There are a lot of people who use 80 column windows so
> that we can see two code windows side-by-side.

Agreed.  If you're having trouble with width, it's a sign that the code
needs to be refactored.

Also, my personal rule is if that a source file exceeds 1000 lines, start
looking for a way to split it.  It can go longer (indeed, there is little
reason to split the fs/nls/nls_cp9??.c files), but 
(I will refrain from discussing drivers/scsi/advansys.c)



Comments on the rest of the thread:

> 3a. Binary operators
>	+ - / * %
>	== !=  > < >= <= && || 
>	& | ^ << >> 
>	= *= /= %= += -= <<= >>= &= ^= |=
>
>	spaces around the operator
>	a + b

Generally, yes, and if you violate this, take the spaces out around the
tightest-binding operators first!


>> I like this style because I can grep for ^function_style_for_easy_grep
>> and quickly find function def.

> That's a pretty bad argument, since most functions aren't declared
> that way, and there are much better source code navigational tools,
> like cscope and ctags.

Well, I use that style for everything I write, for exactly that reason,
so it's fairly popular.  Yes, there are lots of tools, but it's convenient
not to need them.

Also, definition argument lists can be a little longer than declaration
argument lists (due to the presence of argument names and possible
const qualifiers), so an extra place to break the line helps.

And it provides a place to put the handy GCC __attribute__(()) extensions...

static unsigned __attribute__((nonnull, pure))
is_condition_true(struct hairy *p, unsigned priority)
{
...
}

Finally, if you are burdened with long argument names, a shorter fixed prefix
makes it easier to align the arguments.  To pick a real-world example:

static sctp_disposition_t sctp_sf_do_5_2_6_stale(const struct sctp_endpoint *ep,
                                                 const struct sctp_association *
asoc,
                                                 const sctp_subtype_t type,
                                                 void *arg,
                                                 sctp_cmd_seq_t *commands)
I prefer to write

static sctp_disposition_t
sctp_sf_do_5_2_6_stale(const struct sctp_endpoint *ep,
                       const struct sctp_association *asoc,
                       const sctp_subtype_t type,
                       void *arg,
                       sctp_cmd_seq_t *commands)
Although in extreme cases, it's usually best to just to:
static sctp_disposition_t
sctp_sf_do_5_2_6_stale_bug_workaround(
	const struct sctp_endpoint *ep,
	const struct sctp_association *asoc,
	const sctp_subtype_t type,
	void *arg,
	sctp_cmd_seq_t *commands)


>> 3e. sizeof
>> 	space after the operator
>> 	sizeof a

> I use sizeof(a) always (both for sizeof(type) and sizeof(expr)).

You can, but I prefer not to.  Still, it behaves a lot "like a function",
so it's not too wrong.  In fact, I'll usually avoid the sizeof(type)
version entirely.  It's often clearer to replace, e.g.
	char buffer[sizeof(struct sctp_errhdr)+sizeof(union sctp_addr_param)];
with
	char buffer[sizeof *errhdr + sizeof *addrparm];
which (if you look at the code in sctp_sf_send_restart_abort), actually
reflects what's going on better.


What really gets my goat is
	return(0);

return *is not a function*.  Stop making it look syntactically like one!
That should be written
	return 0;

>> 3i. if/else/do/while/for/switch
>> 	space between if/else/do/while and following/preceeding
>> 	statements/expressions, if any:
>> 
>> 	if (a) {
>> 	} else {
>> 	}
>> 
>> 	do {
>> 	} while (b);

> What's wrong with if(expr) ? Rationale?

- It's less visually distinct from a function call.
- The space makes the keyword (important things, keywords) stand out more
  and makes it easier to pick out of a mass of code.
- (Subjective) it balances the space in the trailing ") {" better.

This matches my personal style.

>> 6. One-line statement does not need a {} block, so dont put it into one
>> 	if (foo)
>> 		bar;

> Disagree. Common case of hard-to-notice bug:
>
>	if(foo)
>		bar()
>...after some time code evolves into:
>	if(foo)
>		/*
>		 * We need to barify it, or else pagecache gets FUBAR'ed
>		 */
>		bar();

The braces should have been added then.  They are okay to omit when the
body contains one physical line of text, but my rule is that a comment or
broken expression requires braces:

	if (foo) {
		/* We need to barify it, or else pagecache gets FUBAR'ed */
		bar();
	}

	if (foo) {
		bar(p->foo[hash(garply) % LARGEPRIME]->head,
		    flags & ~(FLAG_FOO | FLAG_BAR | FLAG_BAZ | FLAG_QUUX));
	}

> Thus we may be better to slighty encourage use of {}s even if they are
> not needed:
>
>	if(foo) {
>		bar();
>	}

It's not horrible to include them, but it reduces clutter sometimes to
leave them out.


>>	if (foobar(.................................) + barbar * foobar(bar +
>>	                                                                foo *
>>	                                                                oof)) {
>>	}
> 
> Ugh, that's as ugly as it can get... Something like below is much
> easier to read...
> 
>	if (foobar(.................................) +
>	    barbar * foobar(bar + foo * oof)) {
>	}

Strongly agreed!  If you have to break an expression, do it at the lowest
precedence point possible!
 
> Even easier is
>	if (foobar(.................................)
>	    + barbar * foobar(bar + foo * oof)) {
>	}
>
> Since a statement cannot start with binary operators
> and as such we are SURE that there must have been something before.

I don't tend to do this, but I see the merit.  However, C uses a number
of operators (+ - * &) in both unary and binary forms, so it's
not always unambiguous.

In such cases, I'll usually move the brace onto its own line to make the
end of the condition clearer:

	if (foobar(.................................) +
	    barbar * foobar(bar + foo * oof))
	{
	}

Of course, better yet is to use a temporary or something to shrink
the condition down to a sane size, but sometimes you just need

	if (messy_condition_one &&
	    messy_condition_two &&
	    messy_condition_three)
	{
	}
