Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270942AbRICBYk>; Sun, 2 Sep 2001 21:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271005AbRICBYa>; Sun, 2 Sep 2001 21:24:30 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:37847 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S270942AbRICBYV>; Sun, 2 Sep 2001 21:24:21 -0400
Date: Mon, 3 Sep 2001 03:24:39 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: linux-kernel@vger.kernel.org
Cc: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
Subject: Re: Editing-in-place of a large file
Message-ID: <20010903032439.A802@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010902152137.L23180@draal.physics.wisc.edu> <20010902233008.Q9870@nightmaster.csn.tu-chemnitz.de> <20010902175938.D21576@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010902175938.D21576@work.bitmover.com>; from lm@bitmover.com on Sun, Sep 02, 2001 at 05:59:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2001 at 05:59:38PM -0700, Larry McVoy wrote:
> > What's needed is a generalisation of sparse files and truncate().
> > They both handle similar problems.
> 
> how about 
> 
> 	fzero(int fd, off_t off, size_t len)
> 	fdelete(int fd, off_t off, size_t len)
 
and 

   finsert(int fd, off_t off, size_t len, void *buf, size_t buflen)

> The main problem with this is if the off/len are not block aligned.  If they
> are, then this is just block twiddling, if they aren't, then this is a file
> rewrite anyway.

Yes, that's why I solved this in user space by implementing a C++
stream consisting of multiple mmaps() of files and anonymous
memory. I needed this for someone editing audio streams.

It's basically creating a binary diff ;-)

Another solution for the original problem is to rewrite the file
in-place by coping from the end of the gap to the beginning of
the gap until the gap is shifted to the end of the file and thus
can be left to ftruncate().

This will at least not require more space on disk, but will take
quite a while and risk data corruption for this file in case of
abortion.

But fzero, fdelete and finsert might be worth considering, since
some file systems, which pack tails could also pack these kind of
partial used blocks and handle them properly. 

We already handle partial pages, so why not handle them with
offset/size pairs and enable this mechanisms? Multi media streams
would love these kind of APIs ;-)


Regards

Ingo Oeser
