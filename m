Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSFLWS5>; Wed, 12 Jun 2002 18:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316530AbSFLWS5>; Wed, 12 Jun 2002 18:18:57 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:36485 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S314277AbSFLWS4>; Wed, 12 Jun 2002 18:18:56 -0400
Message-ID: <3D07C8D0.60B49C6D@austin.ibm.com>
Date: Wed, 12 Jun 2002 17:18:56 -0500
From: Saurabh Desai <sdesai@austin.ibm.com>
Organization: IBM Corporation
X-Mailer: Mozilla 4.7 [en] (X11; U; AIX 4.3)
X-Accept-Language: en-US,en-GB
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/locks.c: Fix posix locking for threaded tasks
In-Reply-To: <20020610034843.W27186@parcelfarce.linux.theplanet.co.uk> <E17I4bn-0007Rn-00@the-village.bc.nu> <20020612124536.T27449@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> 
> On Wed, Jun 12, 2002 at 10:40:07AM +0100, Alan Cox wrote:
> > > SUS v3 does not offer any enlightenment.  But it seems reasonable that
> > > processes which share a files_struct should share locks.  After all,
> > > if one process closes the fd, they'll remove locks belonging to the
> > > other process.
> > >
> > > Here's a patch generated against 2.4; it also applies to 2.5.
> > > Please apply.
> >
> > This seems horribly inappropriate for 2.4 as it may break apps
> 
> I have no problem with withdrawing the request for 2.4.  It does mean that
> it's almost impossible to write an M:N threading library implementation.
> This doesn't concern me too much; I just want you to be aware this is
> the tradeoff you're making.
> 
> I would still like to see it in 2.5.

Yes, it's needed for M:N threading library. Here is scenario: Task A
holds a lock and waiting for some event in library, now task B tries
to acquire that lock and waits in kernel and this can create a deadlock.
These tasks are created with CLONE_THREAD (for M:N) flag. 
This change (removing pid check) may cause problem for 1:1 (linuxthreads),
where each task has unique pid and tgid. Again, whether that's a right 
behavior or not is questionable. 
However, with CLONE_THREAD flag, all tasks shares "tgid" value with unique
pid and that's why I suggested earlier to change the "fl_pid" from "pid" 
to "tgid" and it works for both the cases (M:N and 1:1).
