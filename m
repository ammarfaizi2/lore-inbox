Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261802AbREVOwx>; Tue, 22 May 2001 10:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261813AbREVOwd>; Tue, 22 May 2001 10:52:33 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:9702 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S261802AbREVOw1>; Tue, 22 May 2001 10:52:27 -0400
Message-ID: <3B0A7C0F.C824FDB5@uow.edu.au>
Date: Wed, 23 May 2001 00:47:43 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] s_maxbytes handling
In-Reply-To: <3B0A6124.E90717E7@uow.edu.au> from "Andrew Morton" at May 22, 2001 10:52:52 PM <E152CCP-0001rM-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > If ->f_pos is positioned exactly at sb->s_maxbytes, a non-zero-length
> > write to the file doesn't write anything, and write() returns zero.
> 
> Are you absolutely sure here. Because I ran that code through a set of standards
> verification tests. So unless you can cite page and paragraph from SuS and
> the LFS spec I think the 0 might in fact be correct..

I don't know the standards Alan, but returning zero
from write() when f_pos is at s_maxbytes will make
a lot of apps hang up.  dd, bash and zsh certainly do.

Are they buggy?  Should they be testing the return value
of write() and assuming that zero is file-full?

The s_maxbytes logic is different from the
MAX_NON_LFS logic:

        /*
         *      LFS rule 
         */
        if ( pos + count > MAX_NON_LFS && !(file->f_flags&O_LARGEFILE)) {
                if (pos >= MAX_NON_LFS) {
                        send_sig(SIGXFSZ, current, 0);
                        goto out;
                }

This makes more sense.  If the file is full, and
you're trying to grow it, you fail.
