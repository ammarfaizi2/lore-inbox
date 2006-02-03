Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWBCR2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWBCR2N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 12:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWBCR2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 12:28:13 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:15295 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751269AbWBCR2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 12:28:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=kkm6roakEwf6uP27RxTef66uvlTn9Pv7bJ6JRZpTFITMRdbitrS4mIDfAUt+h1s8kbRcNsXwo1NrA9DbyHOj4NOznslmGoJqtxLwaZpZs8sRWiSkoHC+c1HgQUCi9dOTyypTWgldvSeR9xaML/lxMOAHxT2odKNGIFdElOmi4bA=
Date: Fri, 3 Feb 2006 20:46:13 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Evgeniy Dushistov <dushistov@mail.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: Re [2]: [PATCH] Mark CONFIG_UFS_FS_WRITE as BROKEN
Message-ID: <20060203174613.GA7823@mipter.zuzino.mipt.ru>
References: <20060131234634.GA13773@mipter.zuzino.mipt.ru> <20060201200410.GA11747@rain.homenetwork>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201200410.GA11747@rain.homenetwork>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, these two patches makes things better but not much better.

1.

        inode->i_blocks = sb->s_blocksize / UFS_SECTOR_SIZE;
+       inode->i_size = sb->s_blocksize;
        de = (struct ufs_dir_entry *) dir_block->b_data;

This creates directories which are 2048 bytes in size. Native ones are
512 bytes.

	inode->i_size = 512;

makes mkdir and rm reliable for me both on linux and OpenBSD.

2. Second patch indeed makes hangs disaapear. However, data corruption
   is still in place:

Try

	for i in $(seq 1 10000); do echo $i; done >10000-linux.txt
	cp 10000-linux.txt >/mnt/openbsd/10000-openbsd.txt

Now corruption structure is following:

00000000  39 0a 33 30 39 30 0a 33  30 39 31 0a 33 30 39 32  |9.3090.3091.3092|
	[snip]
000007f0  33 34 39 36 0a 33 34 39  37 0a 33 34 39 38 0a 33  |3496.3497.3498.3|
00000800  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00004000  36 36 0a 36 33 36 37 0a  36 33 36 38 0a 36 33 36  |66.6367.6368.636|
	[snip]
000047f0  0a 36 37 37 33 0a 36 37  37 34 0a 36 37 37 35 0a  |.6773.6774.6775.|
00004800  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00008000  36 34 33 0a 39 36 34 34  0a 39 36 34 35 0a 39 36  |643.9644.9645.96|
	[snip]
000086f0  39 38 0a 39 39 39 39 0a  31 30 30 30 30 0a 00 00  |98.9999.10000...|
00008700  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
0000bef0  00 00 00 00 00 00 00 00  00 00 00 00 00 00        |..............|
0000befe

There are all zeros in 0800-4000 and 4800-8000 range. 0000-3800 from
original file is dropped (that 9 it's from 3089).

