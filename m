Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129582AbQLETFK>; Tue, 5 Dec 2000 14:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129543AbQLETFA>; Tue, 5 Dec 2000 14:05:00 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:59145 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129518AbQLETEr>; Tue, 5 Dec 2000 14:04:47 -0500
Date: Tue, 5 Dec 2000 10:33:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        Alan Cox <alan@redhat.com>, Christoph Rohland <cr@sap.com>,
        Rik van Riel <riel@conectiva.com.br>,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: test12-pre5
In-Reply-To: <Pine.GSO.4.21.0012051256470.12284-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10012051030060.1902-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Dec 2000, Alexander Viro wrote:
> 
> Sigh. OK, let me put it that way:
> 
> 	* we _can_ have dirty blocks on the list when inode gets freed.

Agreed.

> 	* no, CAN_UNUSE will not see them.

CAN_UNUSE() is not used at all for the final forcible removal of an inode
that has no users.

> 	* no, we do not give a damn about forgetting them.

Indeed. We'd be better off marking them clean, to make sure they never hit
the disk.

> So Stephen is right wrt fsync() (it will not get that stuff on disk).
> However, it's not a bug - if that crap will not end up on disk we
> will only win.

Stephen is _wrong_ wrt fsync().

Why?

Think about it for a second. How the hell could you even _call_ fsync() on
a file that no longer exists, and has no file handles open to it?

By the time we call clear_inode(), fsync() had better not be an issue any
more. The only reason fscyn() could be an issue is if somebody starts
calling clear_inode() left and right, but hey, if that happens your
filesystem would be so FUBAR'ed that you really wouldn't care any more.
Data integrity of "fsync()" is the least of your worries.

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
