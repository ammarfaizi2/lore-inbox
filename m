Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314052AbSDVFt0>; Mon, 22 Apr 2002 01:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314058AbSDVFtZ>; Mon, 22 Apr 2002 01:49:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29456 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314052AbSDVFtZ>;
	Mon, 22 Apr 2002 01:49:25 -0400
Message-ID: <3CC3A467.AC73A469@zip.com.au>
Date: Sun, 21 Apr 2002 22:49:27 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Ph. Marek" <marek@bmlv.gv.at>
CC: sct@redhat.com, adilger@turbolinux.com, linux-kernel@vger.kernel.org,
        ext3-users@redhat.com
Subject: Re: [PATCH] open files in kjounald (2)
In-Reply-To: <3.0.6.32.20020422072320.009347f0@pop3.bmlv.gv.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ph. Marek" wrote:
> 
> ...
> --- linux.ori/fs/jbd/journal.c  Mon Apr 22 06:28:54 2002
> +++ linux/fs/jbd/journal.c      Mon Apr 22 06:29:16 2002
> @@ -204,7 +204,6 @@
> 
>         lock_kernel();
>         daemonize();
> +       exit_files(current);
>         spin_lock_irq(&current->sigmask_lock);
>         sigfillset(&current->blocked);
>         recalc_sigpending(current);

Confused.  The daemonize() call makes kjournald use init's
files:

quad:/home/akpm# uname -a
Linux quad 2.4.19-pre7 #18 SMP Sun Apr 21 22:42:31 PDT 2002 i686 unknown
quad:/home/akpm# mount /dev/sdb6 /mnt/sdb6 -t ext3 < /etc/services
quad:/home/akpm# ps aux|tail -3
root       903  0.0  0.0     0    0 ?        SW   22:45   0:00 [kjournald]
root       904  0.0  0.0  2640  728 pts/0    R    22:45   0:00 ps aux
root       905  0.0  0.0  1680  528 pts/0    S    22:45   0:00 tail -3
quad:/home/akpm# ls -l /proc/903/fd
total 0
lrwx------    1 root     root           64 Apr 21 22:46 0 -> socket:[479]
lrwx------    1 root     root           64 Apr 21 22:46 10 -> /dev/initctl

That all looks good - every /proc/$(pidof kjournald)/fd
shows that the kjournald instances are using init's files.

Which kernel are you using?  Have you any theories as to why you're
seeing different behaviour?

-
