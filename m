Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317458AbSIMDLL>; Thu, 12 Sep 2002 23:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318016AbSIMDLL>; Thu, 12 Sep 2002 23:11:11 -0400
Received: from packet.digeo.com ([12.110.80.53]:60111 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S317458AbSIMDLJ>;
	Thu, 12 Sep 2002 23:11:09 -0400
Message-ID: <3D815C04.A08CB5D9@digeo.com>
Date: Thu, 12 Sep 2002 20:31:16 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hirokazu Takahashi <taka@valinux.co.jp>
CC: linux-kernel@vger.kernel.org, janetmor@us.ibm.com
Subject: Re: [patch] readv/writev rework
References: <3D80E139.ACC1719D@digeo.com> <20020913.101826.32726068.taka@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2002 03:15:46.0846 (UTC) FILETIME=[DA6533E0:01C25AD3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takahashi wrote:
> 
> Hello,
> 
> > > Your readv/writev patch interested me and I checked it.
> > > I found we also have a chance to improve normal writev.
> > >
> > > a_ops->prepare_write() and a_ops->commit_write will have a
> > > penalty when I/O size isn't PAGE_SIZE.
> > > With following patch generic_file_write_nolock() will try to
> > > make each I/O size become PAGE_SIZE.
> > >
> >
> > Certainly makes a lot of sense.  If an application has a large
> > number of small objects which are to be appended to a file, and
> > they are not contiguous in user memory then this patch makes
> > writev() a very attractive way of doing that.  Tons faster.

I wrote a little app which simulates a text editor writing out
its buffer.  Just:

struct line {
	char *data;
	int length;
	struct line *next;
};

walk this linked list, writing the lines out.  The input was
`cat linux/kernel/*.c > inputfile' and the output was written
1000 times (300 megs).  Benched four different ways of writing the
output:

                    2.5.34         2.5.34-mm2         2.5.34-mm2-taka

write                 54s             54s                   55s
fwrite                12.8s          12.8s                 12.7s
fwrite_unlocked       11.6s          11.6s                 11.5s
writev                39s            33.4s                 15.8s

So Janet's patch made a 15% improvement with this test.  Yours
dropped it 50% again.

> Yeah, I realized syslogd is using writev against logfiles which are
> opened with O_SYNC flag! I think heavy loaded mail-servers or
> web-servers may get good performance with the new writev
> as they are logging too much.

O_SYNC writev?  Ooh, oww, that hurts...

With 2.5.34, writing the 300k file once (1000x less data than above)
with 1024-vector writev's, opened O_SYNC:  68 seconds.

With 2.5.34-mm2-taka the same write takes 0.23 seconds.  (I had to write
100x as much data just to get a measurement).

A 300x speedup is nice, but based on these numbers syslogd should be
using fwrite_unlocked() and fflush().

O_SYNC should be eradicated.  It's basically always the wrong thing
to do.  Applications should write as much stuff as they can and then
run fsync.

> 
> It sounds nice.
> I'll rewrite it soon.
>

Great.  The test app is at http://www.zip.com.au/~akpm/writev-speed.c
