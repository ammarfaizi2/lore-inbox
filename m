Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422676AbWGJQZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422676AbWGJQZU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 12:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422680AbWGJQZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 12:25:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:41348 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422676AbWGJQZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 12:25:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hg47Pr1/lh3ksVNnfIWlbLCTBDzLSh/iJnk38ZC4UziD2eukrnL6ftzTpCa5241z1cv6jJSEdJnh6zTF9XgO/PM8GJLtpZkqN5kBcdzyCWnvMNRSKhGxH/8w/RUwpOJf380pPd0edG/XpXClWjJ4TVP5Jlg5Qonbwglmp9I+7iI=
Message-ID: <9f7850090607100925k297fdb47v92a8fbbefef4bd96@mail.gmail.com>
Date: Mon, 10 Jul 2006 09:25:15 -0700
From: "marty fouts" <mf.danger@gmail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: [patch] spinlocks: remove 'volatile'
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Albert Cahalan" <acahalan@gmail.com>, tglx@linutronix.de,
       joe.korty@ccur.com, linux-kernel@vger.kernel.org, linux-os@analogic.com,
       khc@pm.waw.pl, mingo@elte.hu, akpm@osdl.org, arjan@infradead.org
In-Reply-To: <20060709211023.GC5759@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607072054i237eebf5g8109a100623a1070@mail.gmail.com>
	 <20060708094556.GA13254@tsunami.ccur.com>
	 <1152354244.24611.312.camel@localhost.localdomain>
	 <787b0d920607080849p322a6349g7a5fd98f78aa9f32@mail.gmail.com>
	 <1152383487.24611.337.camel@localhost.localdomain>
	 <787b0d920607081233w3e0e99a9n706ff510c3de458b@mail.gmail.com>
	 <Pine.LNX.4.64.0607081256170.3869@g5.osdl.org>
	 <20060709211023.GC5759@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/06, Pavel Machek <pavel@suse.cz> wrote:
> Hi!
>
> > Btw, I think that the whole standard definition of "volatile" is pretty
> > weak and useless. The standard could be improved, and a way to improve the
> > definition of volatile would actually be to say something like
> >
> >       "volatile" implies that the access to that entity can alias with
> >       any other access.
> >
> > That's actually a lot simpler for a compiler writer (a C compiler already
> > has to know about the notion of data aliasing), and gives a lot more
> > useful (and strict) semantics to the whole concept.
> >
> > So to look at the previous example of
> >
> >       extern int a;
> >       extern int volatile b;
> >
> >       void testfn(void)
> >       {
> >               a++;
> >               b++;
> >       }
> >
> > _my_ definition of "volatile" is actually totally unambiguous, and not
> > just simpler than the current standard, it is also stronger. It would make
> > it clearly invalid to read the value of "b" until the value of "a" has
> > been written, because (by my definition), "b" may actually alias the value
> > of "a", so you clearly cannot read "b" until "a" has been updated.
> ...
> > In contrast, the current C standard definition of "volatile" is not only
> > cumbersome and inconvenient, it's also badly defined when it comes to
> > accesses to _other_ data, making it clearly less useful.
> >
> > I personally think that my simpler definition of volatile is actually a
> > perfectly valid implementation of the current definition of volatile, and
> > I suggested it to some gcc people as a better way to handle "volatile"
> > inside gcc while still being standards-conforming (ie the "can alias
> > anything" thing is not just clearer and simpler, it's strictly a subset of
> > what the C standard allows, meaning that I think you can adopt my
> > definition _without_ breaking any old programs or standards).
>
> Are you sure?
>
> volatile int a; a=1; a=2;
>
> ...under old definition, there's nothing to optimize but AFAICT, your
> definition allows optimizing out a=1.
>
>                                                Pavel
> --

You don't have to go that far.  "Alias with anything" is too vague,
because it basically means that all external variables are volatile if
any are.  In the original example, b shouldn't be allowed as an alias
for a, because a is not "volatile". Otherwise, once you've added any
volatile variables you've effectively said "all variables are
volatile".

Anyway, this approach is the opposite of the original intent of
volatile.  Originally, the idea was that volatile meant "anything
might have changed b since the last time you referenced it".  Here,
you're saying "changing b could change anything".
