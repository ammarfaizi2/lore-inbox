Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265417AbSIRIRv>; Wed, 18 Sep 2002 04:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265831AbSIRIRv>; Wed, 18 Sep 2002 04:17:51 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:29203 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S265417AbSIRIRu>;
	Wed, 18 Sep 2002 04:17:50 -0400
Date: Wed, 18 Sep 2002 17:14:31 +0900 (JST)
Message-Id: <20020918.171431.24608688.taka@valinux.co.jp>
To: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: [PATCH] zerocopy NFS for 2.5.36
From: Hirokazu Takahashi <taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I ported the zerocopy NFS patches against linux-2.5.36.

I made va05-zerocopy-nfsdwrite-2.5.36.patch more generic,
so that it would be easy to merge with NFSv4. Each procedure can
chose whether it can accept splitted buffers or not.
And I fixed a probelem that nfsd couldn't handle NFS-symlink
requests which were very large.


1)
ftp://ftp.valinux.co.jp/pub/people/taka/2.5.36/va10-hwchecksum-2.5.36.patch
This patch enables HW-checksum against outgoing packets including UDP frames.

2)
ftp://ftp.valinux.co.jp/pub/people/taka/2.5.36/va11-udpsendfile-2.5.36.patch
This patch makes sendfile systemcall over UDP work. It also supports
UDP_CORK interface which is very similar to TCP_CORK. And you can call
sendmsg/senfile with MSG_MORE flags over UDP sockets.

3)
ftp://ftp.valinux.co.jp/pub/people/taka/2.5.36/va-csumpartial-fix-2.5.36.patch
This patch fixes the problem of x86 csum_partilal() routines which
can't handle odd addressed buffers.

4)
ftp://ftp.valinux.co.jp/pub/people/taka/2.5.36/va01-zerocopy-rpc-2.5.36.patch
This patch makes RPC can send some pieces of data and pages without copy.

5)
ftp://ftp.valinux.co.jp/pub/people/taka/2.5.36/va02-zerocopy-nfsdread-2.5.36.patch
This patch makes NFSD send pages in pagecache directly when NFS clinets request
file-read.

6)
ftp://ftp.valinux.co.jp/pub/people/taka/2.5.36/va03-zerocopy-nfsdreaddir-2.5.36.patch
nfsd_readdir can also send pages without copy.

7)
ftp://ftp.valinux.co.jp/pub/people/taka/2.5.36/va04-zerocopy-shadowsock-2.5.36.patch
This patch makes per-cpu UDP sockets so that NFSD can send UDP frames on
each prosessor simultaneously.
Without the patch we can send only one UDP frame at the time as a UDP socket
have to be locked during sending some pages to serialize them.

8)
ftp://ftp.valinux.co.jp/pub/people/taka/2.5.36/va05-zerocopy-nfsdwrite-2.5.36.patch
This patch enables NFS-write uses writev interface. NFSd can handle NFS
requests without reassembling IP fragments into one UDP frame.

9)
ftp://ftp.valinux.co.jp/pub/people/taka/2.5.36/taka-writev-2.5.36.patch
This patch makes writev for regular file work faster.
It also can be found at
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.35/2.5.35-mm1/broken-out/

Caution:
       XFS doesn't support writev interface yet. NFS write on XFS might
       slow down with No.8 patch. I wish SGI guys will implement it.

10)
ftp://ftp.valinux.co.jp/pub/people/taka/2.5.36/va07-nfsbigbuf-2.5.36.patch
This makes NFS buffer much bigger (60KB).
60KB buffer is the same to 32KB buffer for linux-kernel as both of them
require 64KB chunk.


11)
ftp://ftp.valinux.co.jp/pub/people/taka/2.5.36/va09-zerocopy-tempsendto-2.5.36.patch
If you don't want to use sendfile over UDP yet, you can apply it instead of No.1 and No.2 patches.



Regards,
Hirokazu Takahashi
