Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316502AbSEUD7K>; Mon, 20 May 2002 23:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316504AbSEUD7I>; Mon, 20 May 2002 23:59:08 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:24054 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316502AbSEUD7E>; Mon, 20 May 2002 23:59:04 -0400
Date: Mon, 20 May 2002 21:57:02 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Frank Krauss <fmfkrauss@mindspring.com>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Possible EXT2 File System Corruption in Kernel 2.4
Message-ID: <20020521035702.GA9901@turbolinux.com>
Mail-Followup-To: Juan Quintela <quintela@mandrakesoft.com>,
	Frank Krauss <fmfkrauss@mindspring.com>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <E16vKwg-00056q-00@barry.mail.mindspring.net> <02041112492500.01786@sevencardstud.cable.nu> <20020417075637.GJ20464@turbolinux.com> <m2661jxioj.fsf@demo.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 20, 2002  11:38 +0200, Juan Quintela wrote:
> >>>>> "andreas" == Andreas Dilger <adilger@clusterfs.com> writes:
> andreas> diff -ru linux-2.4.18.orig/fs/ext2/balloc.c linux-2.4.18-aed/fs/ext2/balloc.c
> andreas> --- linux-2.4.18.orig/fs/ext2/balloc.c	Wed Feb 27 10:31:58 2002
> andreas> +++ linux-2.4.18-aed/fs/ext2/balloc.c	Mon Mar 18 17:07:55 2002
> andreas> @@ -269,7 +269,8 @@
> andreas> }
> andreas> lock_super (sb);
> andreas> es = sb->u.ext2_sb.s_es;
> andreas> -	if (block < le32_to_cpu(es->s_first_data_block) || 
> andreas> +	if (block < le32_to_cpu(es->s_first_data_block) ||
> andreas> +	    block + count < block ||
> 
> It is just me, or this will allways be false?  A fast grep shows that
> count is always bigger than 1. Same for the ext3 part.

Well, under normal operation this test will never be true (same as the
other tests there), but it appears that in some cases there _are_ values
of "block + count" which pass this test but fail later on.  I don't know
the exact source of the problem, but it appears to happen when "block"
is -1, and "block + count" is then 0, which does not trigger the
existing tests (s_first_data_block is 0 for 4kB filesystems).

It is likely that block is being set as -EPERM or something like that,
but I'm not sure.  In any case, you can check l-k archives for the
original emails on this thread where the users report trying to access
group 131071, which is 2^32 / 32768 (i.e. -1 / number of blocks per
group for a 4kB block ext2 filesystem).

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

