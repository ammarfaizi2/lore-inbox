Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267208AbTAAImu>; Wed, 1 Jan 2003 03:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267211AbTAAImu>; Wed, 1 Jan 2003 03:42:50 -0500
Received: from eriador.apana.org.au ([203.14.152.116]:275 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S267208AbTAAImt>; Wed, 1 Jan 2003 03:42:49 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: marekm@amelek.gda.pl (Marek Michalkiewicz), linux-kernel@vger.kernel.org
Subject: Re: Recent 2.4.x PPP bug? (PPPIOCDETACH file->f_count=3)
In-Reply-To: <E18TOnK-0007Tp-00@alf.amelek.gda.pl>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.14-20020917 ("Chop Suey!") (UNIX) (Linux/2.4.20-686-smp (i686))
Message-Id: <E18TeaM-0006MC-00@gondolin.me.apana.org.au>
Date: Wed, 01 Jan 2003 19:50:46 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marek Michalkiewicz <marekm@amelek.gda.pl> wrote:
> 
> Starting with recent 2.4.19 and 2.4.20 kernels, when any
> one (or both) of my two permanent PPP connections goes
> down (usually due to the ISP rebooting their equipment),
> quite often something bad happens.
> 
> Dec 31 16:31:52 alf kernel: PPPIOCDETACH file->f_count=3
> Dec 31 16:31:52 alf kernel: PPPIOCDETACH file->f_count=3

I don't know the cause of this, but this patch should let
pppd continue to work:
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
Index: sys-linux.c
===================================================================
RCS file: /var/cvs/snwb/packages/ppp/pppd/sys-linux.c,v
retrieving revision 1.1.1.1
retrieving revision 1.6
diff -u -r1.1.1.1 -r1.6
--- sys-linux.c	2002/07/25 03:42:01	1.1.1.1
+++ sys-linux.c	2002/10/14 01:53:01	1.6
@@ -531,10 +531,21 @@
     if (new_style_driver) {
 	close(ppp_fd);
 	ppp_fd = -1;
-	if (!looped && ifunit >= 0 && ioctl(ppp_dev_fd, PPPIOCDETACH) < 0)
-	    error("Couldn't release PPP unit: %m");
 	if (!multilink)
 	    remove_fd(ppp_dev_fd);
+	if (!looped && ifunit >= 0 && ioctl(ppp_dev_fd, PPPIOCDETACH) < 0) {
+	    int flags;
+
+	    error("Couldn't release PPP unit: %m");
+	    close(ppp_dev_fd);
+	    ppp_dev_fd = open("/dev/ppp", O_RDWR);
+	    if (ppp_dev_fd < 0)
+		fatal("Couldn't open /dev/ppp: %m");
+	    flags = fcntl(ppp_dev_fd, F_GETFL);
+	    if (flags == -1
+		|| fcntl(ppp_dev_fd, F_SETFL, flags | O_NONBLOCK) == -1)
+		warn("Couldn't set /dev/ppp to nonblock: %m");
+	}
     }
 }
 
