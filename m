Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKDB6I>; Fri, 3 Nov 2000 20:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129617AbQKDB56>; Fri, 3 Nov 2000 20:57:58 -0500
Received: from gateway-490.mvista.com ([63.192.220.206]:6134 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S129066AbQKDB5s>; Fri, 3 Nov 2000 20:57:48 -0500
Date: Fri, 3 Nov 2000 17:57:45 -0800 (PST)
From: Nigel Gamble <nigel@mvista.com>
Reply-To: nigel@mvista.com
To: jeremy@goop.org
cc: linux-kernel@vger.kernel.org
Subject: Locking problem in autofs4_expire(), 2.4.0-test10
Message-ID: <Pine.LNX.4.21.0011031752150.14843-100000@pegasus.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dput() is called with dcache_lock already held, resulting in deadlock.

Here is a suggested fix:

===== expire.c 1.3 vs edited =====
--- 1.3/linux/fs/autofs4/expire.c       Tue Oct 31 15:14:06 2000
+++ edited/expire.c     Fri Nov  3 17:47:47 2000
@@ -223,8 +223,10 @@
                        mntput(p);
                        return dentry;
                }
+               spin_unlock(&dcache_lock);
                dput(d);
                mntput(p);
+               spin_lock(&dcache_lock);
        }
        spin_unlock(&dcache_lock);

Nigel Gamble
MontaVista Software

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
