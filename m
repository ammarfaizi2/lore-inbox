Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWHIV3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWHIV3u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 17:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWHIV3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 17:29:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:25475 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751384AbWHIV3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 17:29:48 -0400
X-Authenticated: #271361
Date: Wed, 9 Aug 2006 23:29:39 +0200
From: Edgar Toernig <froese@gmx.de>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Chase Venters" <chase.venters@clientec.com>,
       "Pavel Machek" <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       tytso@mit.edu, tigran@veritas.com
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Message-Id: <20060809232939.13f1f8e9.froese@gmx.de>
In-Reply-To: <84144f020608091213u4bbb1d07xe8486a4549208016@mail.gmail.com>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	<20060807101745.61f21826.froese@gmx.de>
	<84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com>
	<20060807224144.3bb64ac4.froese@gmx.de>
	<Pine.LNX.4.64.0608071720510.29055@turbotaz.ourhouse>
	<1155039338.5729.21.camel@localhost.localdomain>
	<20060809104159.1f1737d3.froese@gmx.de>
	<1155119999.5729.141.camel@localhost.localdomain>
	<20060809200010.2404895a.froese@gmx.de>
	<1155148605.5729.251.camel@localhost.localdomain>
	<84144f020608091213u4bbb1d07xe8486a4549208016@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
>
> I'll put them on my todo and in the meanwhile, you can find the latest
> patches here:
>   http://www.kernel.org/pub/linux/kernel/people/penberg/patches/revoke/
> 
> Thanks for taking the time to review the patch!

+		err = close_files(this);
+
+		put_task_struct(this->owner);
+		if (err)
+			break;
+	}
+	if (err)
+		restore_files(&to_cleanup[i], nr_fds-i);

I think, the error path is wrong as it tries to restore "this"
which means the now invalid filp (close always closes, even in
case of errors) is put back into the fd-table; and, the task
struct is put twice.  I think, you should ignore errors on close.
(But I guess, this part of revoke gets rewritten anyway to match
BSD behaviour.)  I wonder, if revoke should really abort when
there's an error from one fd or better continue and try its best.

restore_files:
+			spin_lock(&files->file_lock);
+			fdt = files_fdtable(files);
+			rcu_assign_pointer(fdt->fd[this->fd], this->file);
+			FD_SET(this->fd, fdt->close_on_exec);
+			spin_unlock(&files->file_lock);
+			put_files_struct(files);
+		}
+
+		put_task_struct(this->owner);

This sets close_on_exec unconditionally, even if it wasn't set
before.  Hm..., if a cloned thread is able to exec, it seems a
little bit dangerous to restore the fd-table with filps that
were valid some time ago - the fd-table may have changed in the
meantime...  But maybe I simply missed something...

Ciao, ET.
