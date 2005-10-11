Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVJKOyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVJKOyE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 10:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbVJKOyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 10:54:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24762 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932110AbVJKOyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 10:54:02 -0400
Date: Tue, 11 Oct 2005 07:44:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux@horizon.com,
       Kirill Korotaev <dev@sw.ru>
Subject: Re: i386 spinlock fairness: bizarre test results
In-Reply-To: <1129035658.23677.46.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0510110740050.14597@g5.osdl.org>
References: <200510110007_MC3-1-AC4C-97EA@compuserve.com>
 <1129035658.23677.46.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Oct 2005, Alan Cox wrote:

> On Maw, 2005-10-11 at 00:04 -0400, Chuck Ebbert wrote:
> >   That test machine was a dual 350MHz Pentium II Xeon; on a dual 333MHz Pentium II
> > Overdrive (with very slow Socket 8 bus) I could not reproduce those results.
> > However, on that machine the 'xchg' instruction made the test run almost 20%
> > _faster_ than using 'mov'.
> > 
> >   So I think the i386 spinlock code should be changed to always use 'xchg' to do
> > spin_unlock.
> 
> 
> Using xchg on the spin unlock path is expensive. Really expensive on P4
> compared to movb. It also doesn't guarantee anything either way around
> especially as you go to four cores or change CPU (or in some cases quite
> likely even chipset).

Indeed.

I suspect that the behaviour Chuck saw is (a) only present under 
contention and (b) very much dependent on other timing issues.

(a) is the wrong thing to optimize for, and (b) means that Chuck's numbers 
aren't reliable anyway (as shown by the fact that things like instruction 
alignment matters, and by Eric's numbers on other machines).

We want the spinlocks to behave well when they are _not_ under heavy 
contention. If a spinlock gets so much contention that it starts having 
these kinds of issues, then there's something wrong at higher levels, and 
the fix is to use a different algorithm, or use a different kind of lock.

Spinlocks by definition are the _simplest_ locks there are. Not the 
smartest or most fair. Trying to make them anything else is kind of 
missing the whole point of them.

			Linus
