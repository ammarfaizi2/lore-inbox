Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268095AbTBMRW0>; Thu, 13 Feb 2003 12:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268096AbTBMRW0>; Thu, 13 Feb 2003 12:22:26 -0500
Received: from packet.digeo.com ([12.110.80.53]:17816 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268095AbTBMRWZ>;
	Thu, 13 Feb 2003 12:22:25 -0500
Date: Thu, 13 Feb 2003 09:31:44 -0800
From: Andrew Morton <akpm@digeo.com>
To: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
Cc: cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT foolish question
Message-Id: <20030213093144.23ff268e.akpm@digeo.com>
In-Reply-To: <1045149719.4766.126.camel@urca.rutgers.edu>
References: <20030212140338.6027fd94.akpm@digeo.com>
	<1045088991.4767.85.camel@urca.rutgers.edu>
	<20030212224226.GA13129@f00f.org>
	<1045090977.21195.87.camel@urca.rutgers.edu>
	<20030212232443.GA13339@f00f.org>
	<1045092802.4766.96.camel@urca.rutgers.edu>
	<20030212233846.GA13540@f00f.org>
	<1045093775.21195.99.camel@urca.rutgers.edu>
	<20030212235130.GA13629@f00f.org>
	<1045094589.4767.106.camel@urca.rutgers.edu>
	<20030213001302.GA13833@f00f.org>
	<1045096579.21195.121.camel@urca.rutgers.edu>
	<20030212211221.3f73ba45.akpm@digeo.com>
	<1045149719.4766.126.camel@urca.rutgers.edu>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2003 17:31:28.0026 (UTC) FILETIME=[BD534FA0:01C2D385]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruno Diniz de Paula <diniz@cs.rutgers.edu> wrote:
>
> Thanks, Andrew. So, no chances of getting this working correctly on 2.4
> kernel for now (I mean, reading files with size != n*block_size), and
> I'd better give up on this... Is it the case, or you think there is
> still something to do to get this working on ext2 and 2.4 kernel?
> 

Oh I think we can probably fix this up.  Can you test this diff?


diff -puN fs/buffer.c~o_direct-length-fix fs/buffer.c
--- 24/fs/buffer.c~o_direct-length-fix	2003-02-13 09:23:34.000000000 -0800
+++ 24-akpm/fs/buffer.c	2003-02-13 09:24:39.000000000 -0800
@@ -2107,7 +2107,7 @@ int generic_direct_IO(int rw, struct ino
 	int length;
 
 	length = iobuf->length;
-	nr_blocks = length / blocksize;
+	nr_blocks = (length + blocksize - 1) / blocksize;
 	/* build the blocklist */
 	for (i = 0; i < nr_blocks; i++, blocknr++) {
 		struct buffer_head bh;
@@ -2148,6 +2148,10 @@ int generic_direct_IO(int rw, struct ino
 	retval = brw_kiovec(rw, 1, &iobuf, inode->i_dev, iobuf->blocks, blocksize);
 	/* restore orig length */
 	iobuf->length = length;
+
+	/* Return correct value for reads at eof */
+	if (retval > 0 && retval > length)
+		retval = length;
  out:
 
 	return retval;

_

