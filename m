Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317488AbSGEQoO>; Fri, 5 Jul 2002 12:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317500AbSGEQoN>; Fri, 5 Jul 2002 12:44:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4106 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317488AbSGEQoM>;
	Fri, 5 Jul 2002 12:44:12 -0400
Date: Fri, 5 Jul 2002 17:46:43 +0100
From: Matthew Wilcox <willy@debian.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ->i_dev switched to dev_t
Message-ID: <20020705174643.D27706@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[apologies for the mangling; this is what happens when you have to
copy and paste from a web archive]

you wrote:
>         * ->i_dev followed the example of ->s_dev - it's dev_t now. All
> remaining uses of ->i_dev either outright want dev_t (stat()) or couldn't
> care less (printing major:minor in /proc/<pid>/maps, etc.)

[...]

> diff -urN C24-0/fs/locks.c C24-current/fs/locks.c
> --- C24-0/fs/locks.c Thu Jun 20 13:37:25 2002
> +++ C24-current/fs/locks.c Wed Jul 3 04:26:31 2002
> @@ -1751,9 +1751,12 @@
>                                 ? (fl->fl_type & F_UNLCK) ? "UNLCK" : "READ "
>                                 : (fl->fl_type & F_WRLCK) ? "WRITE" : "READ ");
>          }
> + /*
> + * NOTE: it should be inode->i_sb->s_id, not kdevname(...).
> + */
>          out += sprintf(out, "%d %s:%ld ",
>                       fl->fl_pid,
> - inode ? kdevname(inode->i_dev) : "<none>",
> + inode ? kdevname(to_kdev_t(inode->i_dev)) : "<none>",
>                       inode ? inode->i_ino : 0);
>          out += sprintf(out, "%Ld ", fl->fl_start);
>          if (fl->fl_end == OFFSET_MAX)

why not:

> -        out += sprintf(out, "%d %s:%ld ",
> +        out += sprintf(out, "%d %02x:%02x:%ld ",
>                       fl->fl_pid,
> - inode ? kdevname(inode->i_dev) : "<none>",
> + inode ? MAJOR(inode->i_dev), MINOR(inode->i_dev) : "<none>",

you've done things like this elsewhere where you didn't want to change
the format of a file in /proc yet.

-- 
Revolutions do not require corporate support.
