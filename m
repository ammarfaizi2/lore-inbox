Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264976AbRGIVrw>; Mon, 9 Jul 2001 17:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbRGIVrm>; Mon, 9 Jul 2001 17:47:42 -0400
Received: from gateway.foliage.com ([63.117.36.2]:13609 "EHLO
	gateway.foliage.com") by vger.kernel.org with ESMTP
	id <S264976AbRGIVrc>; Mon, 9 Jul 2001 17:47:32 -0400
From: "J. Richard Sladkey" <jrs@foliage.com>
To: "Craig Soules" <soules@happyplace.pdl.cmu.edu>,
        "Trond Myklebust" <trond.myklebust@fys.uio.no>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: NFS Client patch
Date: Mon, 9 Jul 2001 17:46:31 -0400
Message-ID: <MOBBLAGBDIJIPKLCBNCNGELFEBAA.jrs@foliage.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
In-Reply-To: <Pine.LNX.3.96L.1010709153516.16113R-100000@happyplace.pdl.cmu.edu>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by gateway.foliage.com id f69LlEa27717
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, perhaps I mis-spoke slightly.  What the spec does state is that the
> cookie is opaque.  This has generally been interpreted to mean that you
> should not trust it to be stable after a change to that directory.

This interpretation isn't useful.  If a second client modifies the
directory while the first client is reading a directory, the first
client has no way of knowing that its cookie is now invalid, yet it
clearly will be invalid if the server's cookies are invalid after
any directory modifying operation.

The solution is that the server must cope with directory modifying
operations and still keep its cookies valid.  It can do this by
cooperating with the filesystem to update the "true" index associated
with the "opaque" index stored in any outstanding cookies.  Or it can
simply have a more sophisticated cookie, such as passing the inode number
of the first unread directory entry in the cookie and the offset of the
entry.  If they are the same continue as usual.  If they are different,
re-read the directory from the beginning, searching for that specific
inode.  Or any other scheme.  Note that this information is still
completely opaque to the client.

Other operating systems may not show the problem if they pre-read
much larger blocks of directory entries.  However, you should be able
to provoke the problem out of any OS by creating a sufficiently
large directory.  In any case, the two-client argument clearly shows
that cookies should be so fragile that any directory operation
makes them invalid.  This makes your server more complicated, but it
seems like the correct behavior.

