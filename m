Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262476AbREULBd>; Mon, 21 May 2001 07:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262473AbREULBX>; Mon, 21 May 2001 07:01:23 -0400
Received: from p3EE0E2C2.dip.t-dialin.net ([62.224.226.194]:42245 "EHLO
	router.abc") by vger.kernel.org with ESMTP id <S262472AbREULBG> convert rfc822-to-8bit;
	Mon, 21 May 2001 07:01:06 -0400
Message-ID: <3B08F54D.F1C75D14@baldauf.org>
Date: Mon, 21 May 2001 13:00:29 +0200
From: Xuan Baldauf <xuan--lkml@baldauf.org>
X-Mailer: Mozilla 4.77 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: Urban Widmark <urban@teststation.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Xuan Baldauf <xuan--lkml@baldauf.org>,
        "James H. Puttick" <james.puttick@kvs.com>
Subject: Re: [PATCH][RFT] smbfs bugfixes for 2.4.4
In-Reply-To: <Pine.LNX.4.30.0105082131350.4308-100000@cola.teststation.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Urban Widmark wrote:

> On 7 May 2001, Linus Torvalds wrote:
>
> > It has code to do that in smb_revalidate_inode(), but it may be that
> > something else refreshes the inode size _without_ doing the proper
> > invalidation checks. Or maybe Urban broke that logic by mistake while
> > fixing the other one ;)
>
> No, I broke it when copying the ncpfs dircache code.
>
> That code will reuse an old inode if it already exists (and thus also any
> pages attached to it), which is what I wanted and should be fine except
> that it needs to invalidate_inode_pages() if something changed.
>
> Xuan and James, you have both seen this bug with smbfs not properly
> handling changes made on the server. Could you please test this patch vs
> 2.4.4 and let me know if it helps or not.
>
> http://www.hojdpunkten.ac.se/054/samba/smbfs-2.4.4-truncate+retry-4.patch
> (Apply with 'patch -p1' in the linux/ source dir)
>
> /Urban

Hello Urban,

I've been playing around a while with that patch and so far could not find any
problems anymore. But I've noticed some other annoying behaviour, which might
be caused by trying to work around the initially reported bug where the
win98se server does not update something (the new file contents after writing
to a file or the file size?) when something is written by the client: Every
little SMBwrite is followed by an SMBflush, which is translated by win98se
into a "commit" of the file, which seems to be an fsync(2) equivalent.

That is annoying, because it heavily slows down bulk transfers of small
writes, like automatically unzipping a new mozilla build from the linux box to
the windows box. Every write of say 100 bytes is implemented as

send write req
recv write ack
send flush req
sync to disk (on the windows machine)
recv flush ack

This creates heaviest disk load (on the windows machine) for minimal
throughput. Is the SMBflush needed anymore, after you seem to have found
another, better workaround?

Xuân.


