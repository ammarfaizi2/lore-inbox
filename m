Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbUBVUMc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 15:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUBVUMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 15:12:31 -0500
Received: from hera.kernel.org ([63.209.29.2]:52130 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261741AbUBVUM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 15:12:29 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: kernel/microcode.c error from new 64bit code
Date: Sun, 22 Feb 2004 20:12:25 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c1b2f9$sfj$1@terminus.zytor.com>
References: <20040218145218.6bae77b5@dell_ss3.pdx.osdl.net> <Pine.LNX.4.58.0402181502260.18038@home.osdl.org> <20040221141608.GB310@elf.ucw.cz> <Pine.LNX.4.58.0402210914530.3301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1077480745 29172 63.209.29.3 (22 Feb 2004 20:12:25 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sun, 22 Feb 2004 20:12:25 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.58.0402210914530.3301@ppc970.osdl.org>
By author:    Linus Torvalds <torvalds@osdl.org>
In newsgroup: linux.dev.kernel
>
> 
> 
> On Sat, 21 Feb 2004, Pavel Machek wrote:
> >
> > > +	wrmsr(MSR_IA32_UCODE_WRITE,
> > > +		(unsigned long) uci->mc->bits, 
> > > +		(unsigned long) uci->mc->bits >> 16 >> 16);
> > 				             ~~~~~~~~~~~~
> > 
> > I see what you are doing, but this is evil. At least comment /* ">> 32"
> > is undefined on i386 */ ?
> 
> Sorry, but you're wrong.
> 
> ">> 32" is underfined PERIOD! It has nothing to do with x86, it's a C
> standards issue. It's undefined on any 32-bit architecture. (shifting by
> the wordsize or bigger is simply not a defined C operation).
> 
> The above is not evil. The above is the standard way of doing this in C if 
> you know the word-size is 32-bits or bigger.
> 

Actually, what is undefined is shifting with the size of the data type or higher.

If the cast of uci->mc->bits had been an uint64_t (unsigned long
long), >> 32 would have been perfectly well-defined.

The above code is just plain wrong: the cast to (unsigned long) has
higher precedence than the shift, so on i386 (which I presume this is)
it will become an unsigned long, and the shifts will bring it down to
zero.

You might as well write zero if that's what you mean.

	-hpa
