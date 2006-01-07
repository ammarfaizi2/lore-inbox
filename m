Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWAGMXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWAGMXL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 07:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWAGMXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 07:23:11 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:24990 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932346AbWAGMXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 07:23:10 -0500
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Zan Lynx <zlynx@acm.org>, Jens Axboe <axboe@suse.de>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Khushil Dep <khushil.dep@help.basilica.co.uk>,
       Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bio: gcc warning fix.
References: <8941BE5F6A42CC429DA3BC4189F9D442014FAE@bashdad01.hd.basilica.co.uk>
	<9a8748490601061041y532cb797u6d106f03625d3daa@mail.gmail.com>
	<20060106184810.GR3389@suse.de> <1136576037.10342.6.camel@localhost>
	<20060106195631.GW27946@ftp.linux.org.uk>
From: Peter Osterlund <petero2@telia.com>
Date: 07 Jan 2006 13:22:48 +0100
In-Reply-To: <20060106195631.GW27946@ftp.linux.org.uk>
Message-ID: <m3y81sw7l3.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> writes:

> On Fri, Jan 06, 2006 at 12:33:56PM -0700, Zan Lynx wrote:
> > On Fri, 2006-01-06 at 19:48 +0100, Jens Axboe wrote:
> > > On Fri, Jan 06 2006, Jesper Juhl wrote:
> > > > gcc is right to warn in the sense that it doesn't know if
> > > > bvec_alloc_bs() will read or write into idx when its address is passed
> > > 
> > > The function is right there, on top of bio_alloc_bioset(). It's even
> > > inlined. gcc has absolutely no reason to complain.

> And yes, if you inline it manually gcc _will_ see that everything's OK.
> Path that confuses it is
> 	default in switch -> exit from bio_alloc_bs() -> l1 -> use of idx
> and 
> 		return value will be NULL	=>	  we will go to l2
> is what it doesn't notice when it inlines itself.

With my compiler (gcc 4.0.2 from FC4), it's the "unlikely" construct
that confuses the gcc warning logic, not the inlining. I get the
warning if I compile the following code with "gcc -Wall -O2 -S
test.c":

	int f(int x)
	{
		int a;
		int b = 0;
		if (x) {
			a = 1;
			b = 1;
		}
		if (__builtin_expect(!b, 0))
			return 0;
		return a;
	}

However, removing the __builtin_expect makes the warning go away.

Interestingly, changing the source so that a is initialized to some
value will make the warning go away without changing the compiled
code. Apparently, the compiler eventually realizes that the initial
value of a is never used, but it realizes it after deciding if the
warning should be generated.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
