Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267685AbTGLFZA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 01:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267705AbTGLFZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 01:25:00 -0400
Received: from imf21aec.mail.bellsouth.net ([205.152.59.69]:31174 "EHLO
	imf21aec.bellsouth.net") by vger.kernel.org with ESMTP
	id S267685AbTGLFY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 01:24:58 -0400
From: "J.C. Wren" <jcwren@jcwren.com>
Reply-To: jcwren@jcwren.com
To: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>
Subject: Re: Bug in open() function (?)
Date: Sat, 12 Jul 2003 01:39:40 -0400
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <20030712011716.GB4694@bouh.unh.edu> <20030711203809.3c320823.akpm@osdl.org> <200307120511.h6C5BCSe017963@turing-police.cc.vt.edu>
In-Reply-To: <200307120511.h6C5BCSe017963@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307120139.40179.jcwren@jcwren.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	While I'm sure I don't have a grasp of "the big picture", I would have 
imagines these would have acted like a mask against the file system 
attributes.  In effect setting O_RDONLY would clear the write permission bits 
read by stat(), and O_WRONLY would clear the read permission bits.  O_RDONLY 
+ O_WRONLY (O_RDWR) would leave the permissions alone.  These would be 
applied somewhere around the may_open() call in fs/open_namei.c

	A poor mans umaks(), I guess.

	--John

On Saturday 12 July 2003 01:11 am, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 11 Jul 2003 20:38:09 PDT, Andrew Morton said:
> > "J.C. Wren" <jcwren@jcwren.com> wrote:
> > > I was playing around today and found that if an existing file is opened
> > > wit
>
> h
>
> > >  O_TRUNC | O_RDONLY, the existing file is truncated.
> >
> > Well that's fairly idiotic, isn't it?
>
> Not idiotic at all, and even if it was, it's still contrary to specific
> language in the manpage.
>
> I could *easily* see some program having a line of code:
>
> 	if (do_ro_testing) openflags |= O_RDONLY;
>
> I'd not be surprised if J.C. was playing around because a file unexpectedly
> shrank to zero size because of code like this.  There's a LOT of programs
> that implement some sort of "don't really do it" option, from "/bin/bash
> -n" to "cdrecord -dummy".  So you do something like the above to make your
> file R/O - and O_TRUNC *STILL* zaps the file, in *direct violation* of the
> language in the manpage.
>
> Whoops.  Ouch. Where's the backup tapes?
>
> > The Open Group go on to say "The result of using O_TRUNC with O_RDONLY is
> > undefined" which is also rather silly.
> >
> > I'd be inclined to leave it as-is, really.
>
> I hate to think how many programmers are relying on the *documented*
> behavior to prevent data loss during debugging/test runs....
>
> /Valdis

