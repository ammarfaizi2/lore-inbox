Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316562AbSEPDIJ>; Wed, 15 May 2002 23:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316566AbSEPDII>; Wed, 15 May 2002 23:08:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42768 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316562AbSEPDII>;
	Wed, 15 May 2002 23:08:08 -0400
Message-ID: <3CE32384.65C70AA@zip.com.au>
Date: Wed, 15 May 2002 20:12:04 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa3
In-Reply-To: <20020515212733.GA1025@dualathlon.random> <Pine.LNX.4.44L.0205151929430.32261-100000@imladris.surriel.com> <20020516020134.GC1025@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> ...
> That's all, and that's an autodetection bug because ext3 must be always
> tried first, there's no point at all to try to mount with ext2 before
> ext3 (of course unless rootfstype= is specified).

It is *very* common problem for people to think that their root fs is ext3
when in fact it is being mounted as ext2.

It seems that /etc/mtab incorrectly reports ext3, which doesn't help.
The real truth is revealed in /proc/mounts.  (Which has this irritating
"/dev/root" thing in it, btw).

So anything we can do to simplify this problem for people would be
really good.  (It would be good if kernel.org came back, too, so we
can see the patch ;))

And Andreas' idea of "Warning: mounting ext3 as as ext2" will help,
too.

--- 2.4.19-pre8/fs/ext2/super.c~ext2-ext3-warning	Wed May 15 19:36:12 2002
+++ 2.4.19-pre8-akpm/fs/ext2/super.c	Wed May 15 20:11:41 2002
@@ -486,6 +486,9 @@ struct super_block * ext2_read_super (st
 		       bdevname(dev), i);
 		goto failed_mount;
 	}
+	if (EXT2_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_HAS_JOURNAL))
+		ext2_warning(sb, __FUNCTION__,
+			"mounting ext3 filesystem as ext2\n");
 	sb->s_blocksize_bits =
 		le32_to_cpu(EXT2_SB(sb)->s_es->s_log_block_size) + 10;
 	sb->s_blocksize = 1 << sb->s_blocksize_bits;


-
