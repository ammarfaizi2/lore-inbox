Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTH1SAU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 14:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264109AbTH1SAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 14:00:19 -0400
Received: from hank-fep6-0.inet.fi ([194.251.242.201]:45004 "EHLO
	fep06.tmt.tele.fi") by vger.kernel.org with ESMTP id S262273AbTH1SAH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 14:00:07 -0400
Message-ID: <046201c36d8e$34669eb0$322bde50@koticompaq>
From: "Heikki Tuuri" <Heikki.Tuuri@innodb.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2-mm3 and mysql
Date: Thu, 28 Aug 2003 20:59:50 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey,

does it always crash when you start mysqld?

It is page number 0 in the InnoDB tablespace. That is, the header page of
the whole tablespace!

The checksums in the page are ok. That shows the page was not corrupted in
the Linux file system.

InnoDB is trying to do an index search, but that of course crashes, because
the header page is not any index page.

The reason for the crash is probably that a page number in a pointer record
in the father node of the B-tree has been reset to zero. The corruption has
happened in the mysqld process memory, not in the file system of Linux.
Otherwise, InnoDB would have complained about page checksum errors.

No one else has reported this error. I have now added a check to a future
version of InnoDB which will catch this particular error earlier and will
hex dump the father page.

By the way, I noticed that a website http://www.linuxtestproject.org has
made an extensive regression test suite for Linux. They have also
successfully run big MySQL and DB2 stress tests on their computers, on
2.5.xx kernels. If there is something wrong with 2.5.xx or 2.6.0, it
apparently does not concern all computers.

"
The Linux Test Project test suite, ltp-20030807, has been released. The
latest version of the testsuite contains 2000+ tests for the Linux OS.
"

The general picture about InnoDB corruption is that reports have almost
stopped after I advised people on the mailing list to upgrade to
Linux-2.4.20 kernels.

With apologies,

Heikki
Innobase Oy
http://www.innodb.com

"
030827 15:34:10  InnoDB: Page checksum 1165918361, prior-to-4.0.14-form
checksum 4088416325
InnoDB: stored checksum 1165918361, prior-to-4.0.14-form stored checksum
4088416325
InnoDB: Page lsn 0 4080819655, low 4 bytes of lsn at page end 4080819655
InnoDB: Page directory corruption: supremum not pointed to
030827 15:34:10  InnoDB: Page dump in ascii and hex (16384 bytes):
 len 16384; hex 457e8099000000000000000000000000000000
00f33c5dc7000000000000f356ce970000000100000000000000
0000040f0000040240000000000000006c00000002000400000
1b60004000001de0000000400028000144e00040000009e0000
00360000000001160002800015de0000000000000b410000000
20000000200260002b5e500260000000200027d300026000119
3a0026000000000000000000014000207e00018000009e00000
003aaaaaaaaaaaaaaaa

...

000000000000000f3b04845f33c5dc7
"

From: Sergey S. Kostyliov (rathamahata@php4.ru)
Subject: Re: 2.6.0-test2-mm3 and mysql
View: Complete Thread (22 articles)
Original Format
Newsgroups: linux.kernel
Date: 2003-08-27 09:00:19 PST


On Monday 04 August 2003 04:05, Matt Mackall wrote:
> On Sun, Aug 03, 2003 at 10:58:17PM +0400, Sergey S. Kostyliov wrote:
> > Hello Andrew,
> >
> > On Sunday 03 August 2003 05:04, Andrew Morton wrote:
> > > Shane Shrybman <shrybman@sympatico.ca> wrote:
> > > > One last thing, I have started seeing mysql database corruption
> > > > recently. I am not sure it is a kernel problem. And I don't know the
> > > > exact steps to reproduce it, but I think I started seeing it with
> > > > -test2-mm2. I haven't ever seen db corruption in the 8-12 months I
> > > > have being playing with mysql/php.
> > >
> > > hm, that's a worry.  No additional info available?
> >
> > I also suffer from this problem (I'm speaking about heavy InnoDB
> > corruption here), but with vanilla 2.6.0-test2. I can't blame
> > MySQL/InnoDB because there are a lot of MySQL boxes around of me with
the
> > same (in fact the box wich failed is replication slave) or allmost the
> > same database setup. All other boxes (2.4 kernel) works fine up to now.
>
> All Linux kernels prior to 2.6.0-test2-mm3-1 would silently fail to
> complete fsync() and msync() operations if they encountered an I/O
> error, resulting in corruption. If a particular disk subsystem was
> producing these errors, the symptoms would likely be:
>
> - no error reported
> - no messages in logs
> - independent of kernel version, etc.
> - suddenly appear at some point in drive life
> - works flawlessly on other machines
>
> If you can reproduce this corruption, please try running against mm3-1
> and seeing if it reports problems (both to fsync and in logs).

I've just got another one InnoDB crash with 2.6.0-test4.
As in previous case there was no messages in kernel log.
You can find mysql error log here.
http://sysadminday.org.ru/linux-2.6.0-test4_InnoDB_crash

It's a development server, so this isn't a big problem.
I do understand that this can easily be a hardware problem,
but the kernel silence is really sad in such case.
Memory is fine (at least according to memtest 3.0).

Any hints will be appreciated.

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc


