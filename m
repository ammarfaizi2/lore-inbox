Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287882AbSA3BeO>; Tue, 29 Jan 2002 20:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287880AbSA3BeB>; Tue, 29 Jan 2002 20:34:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47115 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287872AbSA3Bdx>;
	Tue, 29 Jan 2002 20:33:53 -0500
Message-ID: <3C574BD1.E5343312@zip.com.au>
Date: Tue, 29 Jan 2002 17:26:41 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: push BKL out of llseek
In-Reply-To: <Pine.LNX.4.33.0201291602510.1747-100000@penguin.transmeta.com>,
		<Pine.LNX.4.33.0201291602510.1747-100000@penguin.transmeta.com> <1012351309.813.56.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> @@ -84,9 +84,9 @@
>         fn = default_llseek;
>         if (file->f_op && file->f_op->llseek)
>                 fn = file->f_op->llseek;
> -       lock_kernel();
> +       down(&file->f_dentry->d_inode->i_sem);
>         retval = fn(file, offset, origin);
> -       unlock_kernel();
> +       up(&file->f_dentry->d_inode->i_sem);
>         return retval;
>  }

Just a little word of caution here.  Remember the
apache-flock-synchronisation fiasco, where removal
of the BKL halved Apache throughput on 8-way x86.

This was because the BKL removal turned serialisation
on a quick codepath from a spinlock into a schedule().

So...  I'd suggest that changes such as this should be
benchmarked in isolation; otherwise we end up spending
quite some time hunting down mysterious reports of
performance regression, and having to rethink stuff.

And llseek is *fast*.  If we're seeing significant
lock contention in there then adding a schedule() is
likely to turn Anton into one unhappy dbencher.

-
