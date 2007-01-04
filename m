Return-Path: <linux-kernel-owner+w=401wt.eu-S1030286AbXADXwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbXADXwa (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 18:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbXADXwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 18:52:30 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:53128 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030286AbXADXwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 18:52:30 -0500
Date: Thu, 4 Jan 2007 23:52:26 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Eric Sandeen <sandeen@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted bad_inode_ops return values
Message-ID: <20070104235226.GA17561@ftp.linux.org.uk>
References: <20070104105430.1de994a7.akpm@osdl.org> <Pine.LNX.4.64.0701041104021.3661@woody.osdl.org> <20070104191451.GW17561@ftp.linux.org.uk> <Pine.LNX.4.64.0701041127350.3661@woody.osdl.org> <20070104202412.GY17561@ftp.linux.org.uk> <20070104215206.GZ17561@ftp.linux.org.uk> <20070104223856.GA79126@gaz.sfgoth.com> <Pine.LNX.4.64.0701041428510.3661@woody.osdl.org> <20070104232106.GK35756@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104232106.GK35756@gaz.sfgoth.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 03:21:06PM -0800, Mitchell Blank Jr wrote:
> Linus Torvalds wrote:
> > Well, that probably would work, but it's also true that returning a 64-bit 
> > value on a 32-bit platform really _does_ depend on more than the size.
> 
> Yeah, obviously this is restricted to the signed-integer case.  My point
> was just that you could have the compiler figure out which variant to pick
> for loff_t automatically.
> 
> > "let's not play tricks with function types at all".
> 
> I think I agree.  The real (but harder) fix for the wasted space issue
> would be to get the toolchain to automatically combine functions that
> end up compiling into identical assembly.

Can't do.

int f(void)
{
	return 0;
}

int g(void)
{
	return 0;
}

int is_f(int (*p)(void))
{
	return p == f;
}

main()
{
	printf("%d %d\n", is_f(f), is_f(g));
}

would better produce
1 0
for anything resembling a sane C compiler.  Comparing pointers to
functions for equality is a well-defined operation and it's not
to be messed with.

You _can_ compile g into jump to f, but that's it.  And that, AFAICS,
is what gcc does.
