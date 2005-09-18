Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVIRVxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVIRVxD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 17:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbVIRVxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 17:53:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48004 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932219AbVIRVxB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 17:53:01 -0400
Date: Sun, 18 Sep 2005 22:52:57 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Willy Tarreau <willy@w.ods.org>,
       Robert Love <rml@novell.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: p = kmalloc(sizeof(*p), )
Message-ID: <20050918215257.GA29417@ftp.linux.org.uk>
References: <20050918100627.GA16007@flint.arm.linux.org.uk> <1127061146.6939.6.camel@phantasy> <20050918165219.GA595@alpha.home.local> <20050918171845.GL19626@ftp.linux.org.uk> <Pine.LNX.4.58.0509181028140.26803@g5.osdl.org> <20050918174549.GN19626@ftp.linux.org.uk> <Pine.LNX.4.61.0509182222030.3743@scrub.home> <20050918211225.GP19626@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050918211225.GP19626@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 10:12:25PM +0100, Al Viro wrote:
 
> Compound literal _is_ an object, all right.  However, decision to allocate
> storage for given object is up to compiler and it's hardly something unusual.
> "Value of right-hand side is not needed to finish calculating left-hand side,
> so its storage is fair game from that point on" is absolutely normal.

BTW, for some idea of how hard does it actually blow, with
struct foo {
	int a, b[100];
};
we get
void f(struct foo *p)
{
	*p = (struct foo){.b[1] = 2};
}
compiled essentially to
void f(struct foo *p)
{
	static struct foo hidden_const = {.b[1] = 2};
	auto struct foo hidden_var;
	memcpy(&hidden_var, &hidden_const, sizeof(struct foo));
	memcpy(p, &hidden_var, sizeof(struct foo));
}

That's right - two memcpy back-to-back, both inserted by gcc, intermediate
object lost immediately after the second one, both source and intermediate
introduced by gcc, so it knows that there is no aliasing problems to be
dealt with.  And yes, that's with optimizations turned on - -O2 and -Os
generate the same.
