Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSIIHN6>; Mon, 9 Sep 2002 03:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSIIHN6>; Mon, 9 Sep 2002 03:13:58 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:39441 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S316574AbSIIHN5>;
	Mon, 9 Sep 2002 03:13:57 -0400
Date: Mon, 09 Sep 2002 16:11:23 +0900 (JST)
Message-Id: <20020909.161123.74745039.taka@valinux.co.jp>
To: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] zerocopy NFS for 2.5.33
From: Hirokazu Takahashi <taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I updated the patches for zerocopy NFS. You can apply them against
linux-2.5.33 and zerocopy NFS over UDP/TCP works very fine.

1)
ftp://ftp.valinux.co.jp/pub/people/taka/tune/2.5.33/va10-hwchecksum-2.5.33.patch
This patch enables HW-checksum against outgoing packets including UDP frames.

2)
ftp://ftp.valinux.co.jp/pub/people/taka/tune/2.5.33/va11-udpsendfile-2.5.33.patch
This patch makes sendfile systemcall over UDP work. It also supports
UDP_CORK interface which is very similar to TCP_CORK. And you can call
sendmsg/senfile with MSG_MORE flags over UDP sockets too.

Using TSO code is commented out at this moment as TSO for UDP isn't
implemented yet. I'm waiting for it so that we would remove "#ifdef NotYet"
to send jumbo UDP frames without any fragmentation and any checksumming.
Then I hope we will get great performance.

3)
ftp://ftp.valinux.co.jp/pub/people/taka/tune/2.5.33/va-csumpartial-fix-2.5.33.patch
This patch fixes the problem of x86 csum_partilal() routines which
can't handle odd addressed buffers.

4)
ftp://ftp.valinux.co.jp/pub/people/taka/tune/2.5.33/va01-zerocopy-rpc-2.5.33.patch
This patch makes RPC be able to send some pieces of data and pages
without any copies.

5)
ftp://ftp.valinux.co.jp/pub/people/taka/tune/2.5.33/va02-zerocopy-nfsdread-2.5.33.patch
This patch makes NFSD pass pages in pagecache to RPC layer directly
when NFS clinets request file-read.

6)
ftp://ftp.valinux.co.jp/pub/people/taka/tune/2.5.33/va03-zerocopy-nfsdreaddir-2.5.33.patch
nfsd_readdir can also send pages without copy.

7)
ftp://ftp.valinux.co.jp/pub/people/taka/tune/2.5.33/va04-zerocopy-shadowsock-2.5.33.patch
This patch makes per-cpu UDP sockets so that NFSD can send UDP frames on
each prosessor simultaneously.
Without the patch we can send only one UDP frame at the time as a UDP socket
have to be locked during sending some pages to serialize them.

8)
ftp://ftp.valinux.co.jp/pub/people/taka/tune/2.5.33/va05-zerocopy-tempsendto-2.5.33.patch
If you don't want to use sendfile over UDP yet, you can apply it instead
of 1) and 2) .


If you have any requests or comments, could you let me know.


Thank you,
Hirokazu Takahashi.
