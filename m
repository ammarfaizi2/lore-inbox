Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318242AbSHUUAh>; Wed, 21 Aug 2002 16:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318237AbSHUUAh>; Wed, 21 Aug 2002 16:00:37 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:37360 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318242AbSHUT7E>; Wed, 21 Aug 2002 15:59:04 -0400
Subject: Re: More on EFS bug
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: peter.hicks@poggs.co.uk
Cc: cc@poggs.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208212031530.21363-100000@tufnell.london1.poggs.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Aug 2002 21:04:11 +0100
Message-Id: <1029960251.26411.175.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem isn't the freshly burnt CD, as I tried with the original SGI CD,
> which shows the same problem using ide-scsi, but is fine when I access things
> natively over IDE.

That confirms my suspicion. Patch below. The bug cases should now error
politely


--- fs/efs/super.c~	2002-08-21 20:40:27.000000000 +0100
+++ fs/efs/super.c	2002-08-21 20:40:27.000000000 +0100
@@ -141,7 +141,13 @@
 	s->s_magic		= EFS_SUPER_MAGIC;
 	s->s_blocksize		= EFS_BLOCKSIZE;
 	s->s_blocksize_bits	= EFS_BLOCKSIZE_BITS;
-	set_blocksize(dev, EFS_BLOCKSIZE);
+	
+	if( set_blocksize(dev, EFS_BLOCKSIZE) < 0)
+	{
+		printk(KERN_ERR "EFS: device does not support %d byte blocks\n",
+			EFS_BLOCKSIZE);
+		goto out_no_fs_ul;
+	}
   
 	/* read the vh (volume header) block */
 	bh = sb_bread(s, 0);
