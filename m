Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265581AbUADObh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 09:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265604AbUADObf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 09:31:35 -0500
Received: from lmdeliver01.st1.spray.net ([212.78.202.210]:33195 "EHLO
	lmdeliver01.st1.spray.net") by vger.kernel.org with ESMTP
	id S265581AbUADOba convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 09:31:30 -0500
From: Paolo Ornati <ornati@lycos.it>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
Date: Sun, 4 Jan 2004 15:30:24 +0100
User-Agent: KMail/1.5.2
Cc: gandalf@wlug.westbo.se, linuxram@us.ibm.com, linux-kernel@vger.kernel.org
References: <200401021658.41384.ornati@lycos.it> <200401031213.01353.ornati@lycos.it> <20040103144003.07cc10d9.akpm@osdl.org>
In-Reply-To: <20040103144003.07cc10d9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200401041530.24395.ornati@lycos.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 January 2004 23:40, Andrew Morton wrote:
> Paolo Ornati <ornati@lycos.it> wrote:
> > I know these are only performance in sequential data reads... and real
> > life is another thing... but I think the author of the patch should be
> > informed (Ram Pai).
>
> There does seem to be something whacky going on with readahead against
> blockdevices.  Perhaps it is related to the soft blocksize.  I've never
> been able to reproduce any of this.
>
> Be aware that buffered reads for blockdevs are treated fairly differently
> from buffered reads for regular files: they only use lowmem and we always
> attach buffer_heads and perform I/O against them.
>
> No effort was made to optimise buffered blockdev reads because it is not
> very important and my main interest was in data coherency and filesystem
> metadata consistency.
>
> If you observe the same things reading from regular files then that is
> more important.

I have done some tests with this stupid script and it seems that you are 
right:
_____________________________________________________________________
#!/bin/sh

DEV=/dev/hda7
MOUNT_DIR=mnt
BIG_FILE=$MOUNT_DIR/big_file

mount $DEV $MOUNT_DIR
if [ ! -f $BIG_FILE ]; then
    echo "[DD] $BIG_FILE"
    dd if=/dev/zero of=$BIG_FILE bs=1M count=1024
    umount $MOUNT_DIR
    mount $DEV $MOUNT_DIR
fi

killall5
sleep 2
sync
sleep 2

time cat $BIG_FILE > /dev/null
umount $MOUNT_DIR
_____________________________________________________________________


Results for plain 2.6.1-rc1 (A) and 2.6.1-rc1 without Ram Pai's patch (B):

o readahead = 256 (default setting)

(A)
real	0m43.596s
user	0m0.153s
sys	0m5.602s

real	0m42.971s
user	0m0.136s
sys	0m5.571s

real	0m42.888s
user	0m0.137s
sys	0m5.648s

(B)
real    0m43.520s
user    0m0.130s
sys     0m5.615s

real	0m42.930s
user	0m0.154s
sys	0m5.745s

real	0m42.937s
user	0m0.120s
sys	0m5.751s


o readahead = 128

(A)
real	0m35.932s
user	0m0.133s
sys	0m5.926s

real	0m35.925s
user	0m0.146s
sys	0m5.930s

real	0m35.892s
user	0m0.145s
sys	0m5.946s

(B)
real	0m35.957s
user	0m0.136s
sys	0m6.041s

real	0m35.958s
user	0m0.136s
sys	0m5.957s

real	0m35.924s
user	0m0.146s
sys	0m6.069s


o readahead = 64
(A)
real	0m35.284s
user	0m0.137s
sys	0m6.182s

real	0m35.267s
user	0m0.134s
sys	0m6.110s

real	0m35.260s
user	0m0.149s
sys	0m6.003s


(B)
real	0m35.210s
user	0m0.149s
sys	0m6.009s

real	0m35.341s
user	0m0.151s
sys	0m6.119s

real	0m35.151s
user	0m0.144s
sys	0m6.195s


I don't notice any big difference between kernel A and kernel B....

>From these tests the best readahead value for my HD seems to be 64... and 
the default setting (256) just wrong.

With 2.4.23 kernel and readahead = 8 I get results like these:

real	0m40.085s
user	0m0.130s
sys	0m4.560s

real	0m40.058s
user	0m0.090s
sys	0m4.630s

Bye.

-- 
	Paolo Ornati
	Linux v2.4.23


