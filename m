Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132800AbRDOVd0>; Sun, 15 Apr 2001 17:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132731AbRDOVdP>; Sun, 15 Apr 2001 17:33:15 -0400
Received: from quechua.inka.de ([212.227.14.2]:27404 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S132800AbRDOVdM>;
	Sun, 15 Apr 2001 17:33:12 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: CML1 cleanup patch
In-Reply-To: <E14hVd6-0007eK-00@mercury.ccil.org> <Pine.LNX.4.21.0103261153510.1863-100000@imladris.rielhome.conectiva> <7zuzLtMHw-B@khms.westfalen.de>
Date: Sun, 15 Apr 2001 22:52:40 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E14otVh-0000TW-00@hunte.bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And the problem is that this hits a fast path in the classical news spool
> layout article create path. The code for this assumes that you have
> articles in the range X to Y, and you just got a new article, so you write
> a file called /var/spool/news/group/name/Y+1. You really do not want to
> cope with the possibility of a directory Y+1 existing in that place.

C News did this, actually: if creat(.../name/Y+1) fails, it tries
creat(.../name/Y+2), etc. (IIRC up to 1000 times). This does not really
hurt a fast path: either you do
  sprintf(a, "...", artno);
  if (creat(a, ...)<0) {
    syslog(...);
    return FAILED;
  }
or
  while (sprintf(a, "...", artno),
         creat(a, ...)<0) {
    ++artno;
    if (++count>MAX) {
      syslog(...);
      return FAILED;
    }
  }

it's just one compare in the fast path which you need anyway.
(Initializing the counter does not _have_ to happen for each article.)

What would hurt is a stat() here, but that is not necessary. It could
be necessary in expire and/or maintenance tools, but these are not as
time-critical. The all-numerics mess up things like "find the lowest
article number" (makeactive/renumber/however it is called), in these
cases a stat is really necessary.

However I think the point is moot because the traditional spool layout
has been proven by experience to be inadequate for the job, even in
the face of more sophisticated filesystems - modern news systems need
other storage mechanisms to cope with the load anyway.

> And then, it's an ugly user interface: the classical spool layout does
> assume that you look at that scpool with Unix tools (like find and grep),
> not only via NNTP and the server.

INN needs a "storage manager grep", but that's even more off topic
here :-)

Olaf

