Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276445AbRJURwL>; Sun, 21 Oct 2001 13:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276448AbRJURwB>; Sun, 21 Oct 2001 13:52:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32262 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276445AbRJURvu>; Sun, 21 Oct 2001 13:51:50 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
Date: Sun, 21 Oct 2001 17:50:48 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9qv1to$ase$1@penguin.transmeta.com>
In-Reply-To: <016a01c15831$ef51c5c0$5c044589@legato.com> <20011020171730.A28057@parallab.uib.no> <3BD28673.1060302@sap.com> <20011021093547.A24227@work.bitmover.com>
X-Trace: palladium.transmeta.com 1003686715 10611 127.0.0.1 (21 Oct 2001 17:51:55 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 21 Oct 2001 17:51:55 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011021093547.A24227@work.bitmover.com>,
Larry McVoy  <lm@bitmover.com> wrote:
>
>One of the engineers here has also seen this.  The root cause is that
>readdir() is returning a file multiple times.  We've seen it on tmpfs.

Yes.  "tmpfs" will consider the position in the dentry lists to be the
"offset" in the file, and if you remove files from the directory as you
do a readdir(), you can get the same file twice (or you can fail to see
files).

If somebody has a good suggestion for what could be used as a reasonably
efficient "cookie" for virtual filesystems like tmpfs, speak up.  In the
meantime, one way to _mostly_ avoid this should be to give a big buffer
to readdir(), so that you end up getting all entries in one go (which
will be protected by the semaphore inside the kernel), rather than
having to do multiple readdir() calls. 

(But we don't have an EOF cookie either, so..)

The logic, in case people care is just "dcache_readdir()" in
fs/readdir.c, and that logic is used for all virtual filesystems, so
fixing that will fix not just tmpfs..

Now, that said it might be worthwhile to be more robust on an
application layer by simply just sorting the directory.  As you point
out, NFS to some servers can have the same issues, for very similar
reasons - on many filesystems a directory "position" is not a stable
thing if you remove or add files at the same time.

So I would consider the current tmpfs behaviour a beauty wart and
something to be fixed, but at the same time I also think you're
depending on behaviour that is not in any way guaranteed, and I would
argue that the tmpfs behaviour (while bad) is not actually strictly a
bug but more a quality-of-implementation issue. 

			Linus
