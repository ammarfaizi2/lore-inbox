Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261837AbREVPIO>; Tue, 22 May 2001 11:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbREVPIE>; Tue, 22 May 2001 11:08:04 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49936 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261851AbREVPHw>; Tue, 22 May 2001 11:07:52 -0400
Subject: Re: [patch] s_maxbytes handling
To: andrewm@uow.edu.au (Andrew Morton)
Date: Tue, 22 May 2001 16:05:14 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3B0A7C0F.C824FDB5@uow.edu.au> from "Andrew Morton" at May 23, 2001 12:47:43 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152Dik-00021y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > verification tests. So unless you can cite page and paragraph from SuS and
> > the LFS spec I think the 0 might in fact be correct..
> 
> I don't know the standards Alan, but returning zero
> from write() when f_pos is at s_maxbytes will make
> a lot of apps hang up.  dd, bash and zsh certainly do.

> Are they buggy?  Should they be testing the return value
> of write() and assuming that zero is file-full?

0 is an EOF.

> The s_maxbytes logic is different from the
> MAX_NON_LFS logic:
> 
>         /*
>          *      LFS rule 
>          */
>         if ( pos + count > MAX_NON_LFS && !(file->f_flags&O_LARGEFILE)) {
>                 if (pos >= MAX_NON_LFS) {
>                         send_sig(SIGXFSZ, current, 0);
>                         goto out;
>                 }
> 
> This makes more sense.  If the file is full, and
> you're trying to grow it, you fail.

The spec says of write

DESCRIPTION

     For regular files, no data transfer will occur past the offset
     maximum established in the open file description associated with
     fildes.

     [EFBIG]
          The file is a regular file, nbyte is greater than 0 and the
          starting position is greater than or equal to the offset
          maximum established in the open file description associated
          with fildes.

Which seems to say to me that if we write > 0 bytes and we start at or
on the boundary we should error - which would agree with your change.

Alan

