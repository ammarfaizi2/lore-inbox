Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262600AbTCIUdT>; Sun, 9 Mar 2003 15:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262603AbTCIUdT>; Sun, 9 Mar 2003 15:33:19 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:1417 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S262600AbTCIUdR>;
	Sun, 9 Mar 2003 15:33:17 -0500
Date: Sun, 9 Mar 2003 21:43:27 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com, marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk
Cc: Oleg Drokin <green@linuxhacker.ru>, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: NCPFS memleak/crazyness?
Message-ID: <20030309204327.GB16578@vana.vc.cvut.cz>
References: <20030309203048.GA31393@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309203048.GA31393@linuxhacker.ru>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 11:30:48PM +0300, Oleg Drokin wrote:
> Hello!
> 
>    Looking at fs/ncpfs/ioctl.c (latest 2.4 bk tree), I seem to see a place
>    where we use userspace-pointers directly (And eventually doing kfree on
>    these). In NCP_IOC_SETOBJECTNAME handler, we allocated space (newname
>    pointer), copy stuff from userspace to there and then assign userspace
>    pointer to our internal structure, whoops! Or am I missing something?
> 
>    Seems that following patch is needed. (Same problem is present in 2.5
>    and same patch should apply)

Definitely. Alan, Linus, Marcelo (alphabetically) please apply...
2.2.x should not be affected as it does not support this ioctl.
						Petr Vandrovec

    From Oleg Drokin:

    In NCP_IOC_SETOBJECTNAME handler, we allocated space (newname pointer), 
    copy stuff from userspace to there and then assign userspace
    pointer to our internal structure, whoops!

===== fs/ncpfs/ioctl.c 1.3 vs edited =====
--- 1.3/fs/ncpfs/ioctl.c	Mon Sep  9 22:36:07 2002
+++ edited/fs/ncpfs/ioctl.c	Sun Mar  9 23:23:12 2003
@@ -434,7 +434,7 @@
 			oldprivatelen = server->priv.len;
 			server->auth.auth_type = user.auth_type;
 			server->auth.object_name_len = user.object_name_len;
-			server->auth.object_name = user.object_name;
+			server->auth.object_name = newname;
 			server->priv.len = 0;
 			server->priv.data = NULL;
 			/* leave critical section */
