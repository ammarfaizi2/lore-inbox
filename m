Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbSJJLWo>; Thu, 10 Oct 2002 07:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261866AbSJJLWn>; Thu, 10 Oct 2002 07:22:43 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:56234 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261836AbSJJLWm>; Thu, 10 Oct 2002 07:22:42 -0400
Subject: O_STREAMING has insufficient info - how about fadvise() ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: andersen@codepoet.org
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Mark Mielke <mark@mark.mielke.cc>,
       Giuliano Pochini <pochini@denise.shiny.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021010032950.GA11683@codepoet.org>
References: <1034104637.29468.1483.camel@phantasy>
	<XFMail.20021009103325.pochini@shiny.it>
	<20021009170517.GA5608@mark.mielke.cc> <3DA4852B.7CC89C09@denise.shiny.it>
	<20021009222438.GD5608@mark.mielke.cc>
	<20021009232002.GC2654@bjl1.asuk.net>  <20021010032950.GA11683@codepoet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Oct 2002 12:38:52 +0100
Message-Id: <1034249932.2044.128.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-10 at 04:29, Erik Andersen wrote:
> I don't think grep is a very good candidate for O_STREAMING.  I
> usually want the stuff I grep to stay in cache.  O_STREAMING is
> much better suited to applications like ogle, vlc, xine, xmovie,
> xmms etc since there is little reason for the OS to cache things
> like songs and movies you aren't likely to hear/see again any
> time soon.

Im not sure O_STREAMING is what you actually want here, its proper
working drop behind. That -shouldnt- need a magic flag if the kernel is
doing the VM things right.

For streaming media writes you want a thread (we lack aio_fsync it
seems), you do a regular asynchronous fsync to keep the buffering
smooth.

For streaming media read the kernel ought to be able to get it right,
and if not then I'd much rather the kernel gave _me_ total control 

Instead of O_STREAMING therefore I'd much prefer to have

	fadvise(filehandle, offset, length, FADV_DONTNEED);

Its quite possible that most of the rest of the madvise notions aren't
worth implementing, but we have the flexibility to do. The fadvise
interface also lets you pick which ranges you evict, so now I can do
streaming media but not fadvise out of cache key frames so that my
chapter starts just happen to generally be in cache as do a few I frames
behind the read pointer - (for rewind).

Do that with O_STREAMING ?

Alan

