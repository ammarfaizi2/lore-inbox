Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314290AbSESJuw>; Sun, 19 May 2002 05:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314291AbSESJuv>; Sun, 19 May 2002 05:50:51 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:64494 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S314290AbSESJuu>; Sun, 19 May 2002 05:50:50 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Rusty Russell <rusty@rustcorp.com.au>
Cc: <linux-kernel@vger.kernel.org>, <alan@lxorguk.ukuu.org.uk>
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
Date: Sat, 18 May 2002 22:47:17 +0100
Message-Id: <20020518214717.3526@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.44.0205182210330.878-100000@home.transmeta.com>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>But read (and particularly write) are _not_ re-startable without the
>knowledge of how much was written, because they change f_pos and other
>things ("write()" in particular changes a _lot_ of "other things", namely
>the data in the file itself, of course).

Looking at generic_file_write(), it ignore the count returned by
copy_from_user and always commit a write for the whole requested
count, regardless of how much could actually be read from userland.
The result of copy_from_user is only used as an error condition.

generic_file_read() on the other hand seems to be ok.

>There are other system calls that aren't re-startable, but basically
>read/write are the "big ones", and thus Linux should try its best to make
>them work in an environment that requires restartability. Most programs
>can live without various random ioctl's and special system calls, but very
>very few programs/environments can live without read/write.
>
>("restartable" here doesn't mean that the _kernel_ would re-start them,
>but that a "gc-aware library" can make wrappers around them and correctly
>restart them internally, if you see my point - kind of like how stdio
>already handles the issue of EINTR returns for read/write, which is
>actually very similar in nature).


