Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264661AbSJTXWe>; Sun, 20 Oct 2002 19:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264664AbSJTXWd>; Sun, 20 Oct 2002 19:22:33 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:57100 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S264661AbSJTXWc>;
	Sun, 20 Oct 2002 19:22:32 -0400
Date: Mon, 21 Oct 2002 08:21:08 +0900 (JST)
Message-Id: <20021021.082108.74745582.taka@valinux.co.jp>
To: ahu@ds9a.nl
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: nfsd/sunrpc boot on reboot in 2.5.44
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20021020173142.GA26384@outpost.ds9a.nl>
References: <20021020173142.GA26384@outpost.ds9a.nl>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Mon_Oct_21_08:21:08_2002_586)--"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Next_Part(Mon_Oct_21_08:21:08_2002_586)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

I think auth_domain_drop() may call NULL function.
I believe the followin patch will fix your problem.
Can you try it with my patch?

ahu> My Debian sid machine oopses when I run 'sudo reboot'.
ahu> 
ahu> $ mount
ahu> /dev/hdb2 on / type ext3 (rw,errors=remount-ro)
ahu> proc on /proc type proc (rw)
ahu> devpts on /dev/pts type devpts (rw,gid=5,mode=620)
ahu> /dev/hdb4 on /mnt type ext2 (rw,errors=remount-ro)
ahu> nodev on /dev/oprofile type oprofilefs (rw)
ahu> /dev/hda1 on /images type ext2 (rw)
ahu> 
ahu> No NFS activity involved.
ahu> 
ahu> By the way, can anybody tell me how to convert this:
ahu> Oct 20 19:21:32 hubert kernel:  [<c8831060>] auth_domain_drop+0x50/0x60 [sunrpc]
ahu> 
ahu> To a line in auth_domain_drop()?
ahu> 
ahu> I'm looking if I can reproduce this.

----Next_Part(Mon_Oct_21_08:21:08_2002_586)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="rpcdomain-fix2.5.43.patch"

--- linux/net/sunrpc/svcauth.c.ORG	Sun Oct 20 15:47:26 2030
+++ linux/net/sunrpc/svcauth.c	Sun Oct 20 15:50:37 2030
@@ -143,8 +143,9 @@ static struct cache_head	*auth_domain_ta
 void auth_domain_drop(struct cache_head *item, struct cache_detail *cd)
 {
 	struct auth_domain *dom = container_of(item, struct auth_domain, h);
-	if (cache_put(item,cd))
-		authtab[dom->flavour]->domain_release(dom);
+	void (*fn)(struct auth_domain *) = authtab[dom->flavour]->domain_release;
+	if (cache_put(item,cd) && fn != NULL)
+		fn(dom);
 }
 
 

----Next_Part(Mon_Oct_21_08:21:08_2002_586)----
