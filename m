Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314228AbSEFGtk>; Mon, 6 May 2002 02:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314231AbSEFGtj>; Mon, 6 May 2002 02:49:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59922 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314228AbSEFGti>;
	Mon, 6 May 2002 02:49:38 -0400
Message-ID: <3CD62808.DC3CF135@zip.com.au>
Date: Sun, 05 May 2002 23:51:52 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Pittman <daniel@rimspace.net>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Linux-2.5.14..
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com> <87g015bxff.fsf@enki.rimspace.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Pittman wrote:
> 
> On Sun, 5 May 2002, Linus Torvalds wrote:
> > There's a lot of stuff that has happened in the 2.5.x series lately,
> > and you can see the gory details in the ChangeLog files that accompany
> > releases these days, but I thought I'd point out 2.5.14, since it has
> > some interesting fundamental changes to how dirty state is maintained
> > in the VM.
> >
> > (The big changes were actually in 2.5.12, but 2.5.13 contained various
> > minor fixes and tweaks, and 2.5.14 contains a number of fixes
> > especially wrt truncate, so hopefully it's fairly _stable_ as of
> > 2.5.14.)
> 
> >From the look of the changelog at least a few of the file corruption
> bugs with ext3, 2k block file systems and 2.5 have been fixed. Should I
> expect this release to address the problems I was seeing?
> 

I don't have an explanation for the ext3 problem which you saw.
It's conceivable that 2.5.13 was leaving dirty buffers around after
they were "deleted", and that fsync grabbed them via the i_dirty_buffers
back door, and wrote them where they shouldn't have been written.

But they wouldn't have been mapped anywhere...

So I still need to try to reproduce that one.  If you could have
another shot, it would be appreciated.  But if it _does_ work OK,
I can't say it's fixed until I know what caused the 2.4.13 failure.

ext3 is very sensitive to what is going on in buffer.c.  There's
a lot of tension in there between the desire to share code and
the desire to not be damaged by changes in the code which we share.

Generally, ext3 with data=journal is not happy at present.

Partly because it contains assertions of things which aren't true
any more.

Partly because of a known problem in ext3: assertion failure at
transaction.c:606.  Stephen has a fix for this which we need to
wiggle into 2.4.  For some reason, the 2.5 changes are triggering
it much more easily.

I'll spend a few hours this week trying to resurrect data=journal,
but if that doesn't work out I think I'll just turn it off for the
while, make it emit a warning and use data=ordered.

-
