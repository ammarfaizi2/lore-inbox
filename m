Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282706AbRLQUBd>; Mon, 17 Dec 2001 15:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282691AbRLQUBY>; Mon, 17 Dec 2001 15:01:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63492 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282706AbRLQUBN>; Mon, 17 Dec 2001 15:01:13 -0500
Date: Mon, 17 Dec 2001 11:59:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Joel Becker <jlbec@evilplan.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT wierd behavior..
In-Reply-To: <20011217195312.K31706@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.33.0112171156380.1380-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Dec 2001, Joel Becker wrote:
> 	IIRC, SUS states that if a fatal error occurred causing the
> partial write, that error will be returned on the next write or upon
> close().  Thus:
>
> 	/* Smart program handles partial writes */
> 	write(100k); = 50k
> 	write(remaining 50k); = -1/ENOSPC|EIO|etc

We do this, if the error is "hard". And "fatal" implies hardness, so we're
ok here.

> 	/* Dumb program doesn't handle partial write */
> 	write(100k); = 50k
> 	close(fd); = -1/EIO

But we're not doing this.

We'd have to save the error into the "struct file" to do the close thing.

Which is what NFS actually already does for other reasons (ie the
asynchronous nature of writes and thus IO errors), so generalizing it
might actually clean some stuff up (sockets have some of the same issues,
but socket semantics may be different enough that we do not want to have
common "error on next access" handling).

		Linus

