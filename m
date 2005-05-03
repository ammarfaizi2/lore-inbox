Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVECKAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVECKAa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 06:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVECKAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 06:00:30 -0400
Received: from pop.gmx.de ([213.165.64.20]:42712 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261442AbVECKAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 06:00:19 -0400
Date: Tue, 3 May 2005 12:00:18 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
       andros@citi.umich.edu, matthew@wil.cx, schwidefsky@de.ibm.com,
       michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <20050502210411.06226103.sfr@canb.auug.org.au>
Subject: Re: fcntl: F_SETLEASE/F_RDLCK question
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <2606.1115114418@www14.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

> On Mon, 2 May 2005 11:15:24 +0200 Heiko Carstens
> <heiko.carstens@de.ibm.com> wrote:
> >
> > the semantics of fnctl used together with F_SETLEASE and
> > argument F_RDLCK have been changed with bk changeset
> > 1.1938.185.141 (sometime between 2.6.9 and 2.6.10).
> > Since then it's only possible to get a read lease when the
> > file in question does not have _any_ writers.
> > This is at least inconsistent with the man page of fcntl
> > and looks pretty much like this is a bug in the kernel.
> > 
> > Any comments?
> 
> The previous behaviour was a bug that occurred because at the time the
> original lease code was written, it was not possible to tell if there 
> were
> writers when the read lease was being taken. Further improvements in the
> kernel have since made this possible.
> 
> The intention of a read lease is to let the holder know is anyone tries 
> to modify the file.
> 
> The current behaviour does not conflict with the man pages on Debian
> (although the previous behaviour did not either :-))

Indeed the problem referred to is fixed, but it looks like another 
one may have been introduced.

It now appears (I tested on 2.6.11.6) that if a process opens 
a file O_RDWR and then tries to place a read lease via that
file descriptor, then the F_SETLEASE fails with EAGAIN, 
even though no other process has the file open for writing.  
(On the other hand, if the process opens the file 
O_WRONLY, then it can place either a read or a write lease.  
This is how I think things always worked, but it seems 
inconsistent with the aforementioned behaviour.)  

Some further testing showed the following (both open() 
and fcntl(F_SETLEASE) from same process):

 open()  |  lease requested
  flag   | F_RDLCK  | F_WRLCK
---------+----------+----------
O_RDONLY | okay     |  okay
O_WRONLY | EAGAIN   |  okay
O_RDWR   | EAGAIN   |  okay

This seems strange (I imagine the caller should be excluded 
from the list of processes being checked to see if the file 
is opened for writing), and differs from earlier kernel
versions.  What is the intended behaviour here?

Cheers,

Michael

-- 
+++ Lassen Sie Ihren Gedanken freien Lauf... z.B. per FreeSMS +++
GMX bietet bis zu 100 FreeSMS/Monat: http://www.gmx.net/de/go/mail
