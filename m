Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbTFJO5J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 10:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTFJO5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 10:57:09 -0400
Received: from chaos.analogic.com ([204.178.40.224]:897 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262930AbTFJO5H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 10:57:07 -0400
Date: Tue, 10 Jun 2003 11:12:55 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Large files
In-Reply-To: <20030610141759.GU28900@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.53.0306101057020.4326@chaos>
References: <Pine.LNX.4.53.0306100952560.4080@chaos> <20030610141759.GU28900@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jun 2003, Matti Aarnio wrote:

> On Tue, Jun 10, 2003 at 09:57:57AM -0400, Richard B. Johnson wrote:
> > With 32 bit return values, ix86 Linux has a file-size limitation
> > which is currently about 0x7fffffff. Unfortunately, instead of
> > returning from a write() with a -1 and errno being set, so that
> > a program can do something about it, write() executes a signal(25)
> > which kills the task even if trapped. Is this one of those <expletive
> > deleted> POSIX requirements or is somebody going to fix it?
>
>   http://www.sas.com/standards/large.file/
>
> #define SIGXFSZ    25    /* File size limit exceeded (4.2 BSD). */
>
> from  fs/buffer.c:
>
>         err = -EFBIG;
>         limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
>         if (limit != RLIM_INFINITY && size > (loff_t)limit) {
>                 send_sig(SIGXFSZ, current, 0);
>                 goto out;
>         }
>         if (size > inode->i_sb->s_maxbytes)
>                 goto out;
>
>

On the system that fails, there are no ulimits and it's the root
account, therefore I don't know how to set the above limit to
RLIM_INFINITY (~0LU).  It's also version  2.4.20. I don't think
it has anything to do with 'rlim' shown above. In any event
sending a signal when the file-size exceeds some level is preposterous.
The write should return -1 and errno should have been set to EFBIG
(in user space). That allows the user's database to create another
file and keep on trucking instead of blowing up and destroying the
user's inventory or whatever else was in process.

FYI, this caused the failure of a samba server for M$ stuff. It
gives the impression of Linux being defective. This is not good.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

