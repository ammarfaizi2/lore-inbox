Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbQKFAfX>; Sun, 5 Nov 2000 19:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129838AbQKFAfN>; Sun, 5 Nov 2000 19:35:13 -0500
Received: from gateway-490.mvista.com ([63.192.220.206]:60155 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S129836AbQKFAfC>; Sun, 5 Nov 2000 19:35:02 -0500
Date: Sun, 5 Nov 2000 16:34:56 -0800 (PST)
From: Nigel Gamble <nigel@mvista.com>
Reply-To: nigel@mvista.com
To: jeremy@goop.org
cc: linux-kernel@vger.kernel.org, autofs@linux.kernel.org
Subject: Re: Locking problem in autofs4_expire(), 2.4.0-test10
In-Reply-To: <Pine.LNX.4.21.0011031752150.14843-100000@pegasus.mvista.com>
Message-ID: <Pine.LNX.4.21.0011051630000.20731-100000@pegasus.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2000, Nigel Gamble wrote:
>
> dput() is called with dcache_lock already held, resulting in deadlock.
> 
> Here is a suggested fix:
> 
> ===== expire.c 1.3 vs edited =====
> --- 1.3/linux/fs/autofs4/expire.c       Tue Oct 31 15:14:06 2000
> +++ edited/expire.c     Fri Nov  3 17:47:47 2000
> @@ -223,8 +223,10 @@
>                         mntput(p);
>                         return dentry;
>                 }
> +               spin_unlock(&dcache_lock);
>                 dput(d);
>                 mntput(p);
> +               spin_lock(&dcache_lock);
>         }
>         spin_unlock(&dcache_lock);

On looking at this code more closely, I don't think it's safe just
to drop the lock, because it looks like the lock is supposed to
protect the loop variable, tmp, and the data structure which
is being traversed.  However, I'm not familiar with this code,
so I'm hoping someone who is can come up with a correct solution
to this deadlock problem.

Nigel

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
