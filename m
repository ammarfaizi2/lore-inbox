Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314422AbSF2Xty>; Sat, 29 Jun 2002 19:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314433AbSF2Xtx>; Sat, 29 Jun 2002 19:49:53 -0400
Received: from go-gw.beeline3G.net ([217.118.66.254]:34399 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S314422AbSF2Xtx>; Sat, 29 Jun 2002 19:49:53 -0400
Date: Sun, 30 Jun 2002 03:50:58 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-rc1 broke OSF binaries on alpha
Message-ID: <20020630035058.A884@localhost.park.msu.ru>
References: <Pine.LNX.4.44.0206281730160.12542-100000@freak.distro.conectiva> <E17O7yk-0007w5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E17O7yk-0007w5-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Jun 29, 2002 at 03:28:50AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 29, 2002 at 03:28:50AM +0100, Alan Cox wrote:
> Please back it back in. The bug is the Alpha port. Alpha needs its own OSF
> readv/writev entry point which masks the top bits.

Ouch. The new entry point just because of this?!
Marcelo, if you're going to back in that patch, please apply
the following on the top of it.

Ivan.

--- linux/fs/read_write.c.ac	Fri Jun 28 11:52:59 2002
+++ linux/fs/read_write.c	Sun Jun 30 03:21:52 2002
@@ -260,7 +260,15 @@ static ssize_t do_readv_writev(int type,
 	ret = -EINVAL;
 	for (i = 0 ; i < count ; i++) {
 		ssize_t tmp = tot_len;
+#ifdef	__alpha__
+		/* Current versions of Tru64 unix are SuS compliant.
+		   Unfortunately, we have to use the binaries (namely
+		   Netscape and Acrobat Reader) compiled vs. older
+		   versions of OSF/1, where iov_len was a 32 bit integer. */
+		ssize_t len = (int) iov[i].iov_len;
+#else
 		ssize_t len = (ssize_t) iov[i].iov_len;
+#endif
 		if (len < 0)	/* size_t not fitting an ssize_t .. */
 			goto out;
 		tot_len += len;
