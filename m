Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290422AbSBKUvB>; Mon, 11 Feb 2002 15:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290386AbSBKUuw>; Mon, 11 Feb 2002 15:50:52 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:43958 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S290417AbSBKUul>; Mon, 11 Feb 2002 15:50:41 -0500
Date: Mon, 11 Feb 2002 20:52:21 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <3C68200C.90F7807F@zip.com.au>
Message-ID: <Pine.LNX.4.21.0202112012170.6409-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2002, Andrew Morton wrote:
> Hugh Dickins wrote:
> > 
> > 1. I'd be sorry to see it go in as is: you haven't noticed how this
> >    looks to a disassembler: not pretty!  I don't see an alternative
> >    to wasting some more bytes: putting "push"es in front of line and
> >    file? or is there one instruction (some "mov"?) to encompass both
> >    line and file together?
> 
> This will also confound ksymoops when it parses the opcode
> dump.  But we know the file-and-line, so that doesn't seem
> very important.

Well, it's not very important if it's immediately obvious why the
BUG() on that source line should fire.  But in general, BUG()s are
catching problems that are not immediately obvious.

Very often we want to peer at the registers, work out exactly what's
happening.  That is precisely why you're making these changes.  Maybe
your in-head disassembler is better than objdump, but I need objdump
or ksymoops or kdb to make sense of what's there.

Of course, the nonsense comes _after_ the BUG(): but once you have
several BUG()s in succession, it can be hard even to find subsequent
"ud2a"s - in __free_pages_ok, I see "08 0f  or %cl,(%edi)
0b 4c 00 7c  or 0x7c(%eax,%eax,1),%ecx" and suspect that
there's really a "0f 0b  ud2a" hidden in there.

The BUG() info is there to help debugging, it should not be obscuring
the code.  I guess it would be easy to (mis)teach ksymoops and kdb
that "ud2a" is actually a seven-byte instruction, but not objdump.

> If the unpretty disassembler output is a problem, we could go
> back to your do_BUG code if CONFIG_DEBUG_BUGVERBOSE=y?

I don't care for that, I really like that the option should go (or be
sidelined to mean something else, which only affects a few places,
as you have it), given your triumph in cutting down its overhead.

Hugh

