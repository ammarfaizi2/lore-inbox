Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316161AbSEJW71>; Fri, 10 May 2002 18:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316163AbSEJW70>; Fri, 10 May 2002 18:59:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36108 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316161AbSEJW7Z>;
	Fri, 10 May 2002 18:59:25 -0400
Message-ID: <3CDC5088.C723E5AA@zip.com.au>
Date: Fri, 10 May 2002 15:58:16 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG() disassembly tweak
In-Reply-To: <Pine.LNX.4.21.0205102216160.3747-100000@localhost.localdomain> <Pine.LNX.4.33.0205101457120.22516-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 10 May 2002, Hugh Dickins wrote:
> >
> > Could we change the i386 BUG() macro slightly again?

Hugh's patch looks just dandy to me, even though I
don't understand the problem ;)
 
> If it wants to be changed, I'd actually personally prefer it to be changed
> to take an explicit string instead of using the filename/linenr at all.

There seem to be two classes of bug report(er)s: the good ones
who do a bit of up-front analysis and the less good ones....

I believe that the BUG() macro should be tuned to the less-good
ones.  Generally, these are folk who take their kernels
straight from kernel.org and the line number is not a problem.
People who have applied other patches have the experience and
knowledge to go digging in the source tree and find which
line it was, and to include this in the report.

So..  dunno about others, but I find file-n-line works
not too badly.

> The filename/linenr one has the size problem (those absolute file names
> are _long_), and sucks when you have slight kernel version skew and
> suddenly the information isn't obviously unambiguous at all.

Well given that kbuild-2.5 has a single makefile running
out of $(TOPDIR), it _should_ be chopping the absolute
pathname out of the include path and the .c path:

	gcc -I include drivers/net/foo.c

There will be no starting-with-slash __FILE__s in the output of
this command.

> It also sucks for inline functions or other users of BUG that would
> potentially want to have different output.
> 
> In short, I suspect it would be nicer with
> 
>         kernel BUG: release_task(current)
> 
> instead of
> 
>         kernel BUG at /home/torvalds/v2.5/linux/exit.c:59
> 
> (the exact point where the BUG happens _is_ given by the EIP, so in that
> sense file and linenr are not actually all that useful. A descriptive
> string would be more readable, and equally useful at pinpointing at a
> source level).

Isn't this the traditional assert(), which includes
that-which-was-asserted in the message?

	kernel assertion of "!PageLocked(page)" failed at foo.c:42.

That's easy to do in the context of BUG_ON(), and greatly
increases our chances of pinpointing the failing line...

-
