Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319253AbSIKRzZ>; Wed, 11 Sep 2002 13:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319254AbSIKRzZ>; Wed, 11 Sep 2002 13:55:25 -0400
Received: from pC19F9AAB.dip.t-dialin.net ([193.159.154.171]:17156 "EHLO
	router.abc") by vger.kernel.org with ESMTP id <S319253AbSIKRzY> convert rfc822-to-8bit;
	Wed, 11 Sep 2002 13:55:24 -0400
Message-ID: <3D7F83BC.5DF306A@baldauf.org>
Date: Wed, 11 Sep 2002 19:56:12 +0200
From: Xuan Baldauf <xuan--reiserfs@baldauf.org>
X-Mailer: Mozilla 4.79 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Xuan Baldauf <xuan--lkml@baldauf.org>, linux-kernel@vger.kernel.org,
       Reiserfs List <reiserfs-list@namesys.com>
Subject: Re: Heuristic readahead for filesystems
References: <Pine.LNX.4.44L.0209111340060.1857-100000@imladris.surriel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rik van Riel wrote:

> On Wed, 11 Sep 2002, Xuan Baldauf wrote:
>
> > I wonder wether Linux implements a kind of heuristic
> > readahead for filesystems:
>
> > If an application did a stat()..open()..read() sequence on a
> > file, it is likely that, after the next stat(), it will open
> > and read the mentioned file. Thus, one could readahead the
> > start of a file on stat() of that file.
>
> > Example: See this diff strace:
>
> Your observation is right, but I'm not sure how much it will
> matter if we start reading the file at stat() time or at
> read() time.
>
> This is because one disk seek takes about 10 million CPU
> cycles on modern systems and we'll have completed the stat(),
> open() and started the read() before the disk arm has started
> moving ;)
>
> regards,
>
> Rik

The point here is not to optimize latency but to optimize throughput: If the
filesystem is able to recognize that a whole tree is being read, it may issue
read requests for all the blocks of that tree, which are (with a high
probability) in such a close location to each other that all the read requests
can result in a single, large, megabyte-big disk-read-burst, taking few
seconds instead of minutes.

In theory, this also could be implemented explicitly if the application could
tell the kernel "I'm going to read these 100 files in the very near future,
please make them ready for me". But wait, maybe the application can do this
(for regular files, not for directory entries and stat() data): Could it be
efficient if the application used open(file,O_NONBLOCK) for the next 100 files
and subsequent read()s on each of the returned filedescriptors?

Xuân.


