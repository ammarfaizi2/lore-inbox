Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265608AbUAGTG5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 14:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265611AbUAGTG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 14:06:57 -0500
Received: from pop.gmx.de ([213.165.64.20]:6347 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265608AbUAGTGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 14:06:51 -0500
X-Authenticated: #20450766
Date: Wed, 7 Jan 2004 20:06:07 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
In-Reply-To: <20040107181920.GN1882@matchmail.com>
Message-ID: <Pine.LNX.4.44.0401071947270.2922-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jan 2004, Mike Fedyk wrote:

> On Wed, Jan 07, 2004 at 07:13:46PM +0100, Guennadi Liakhovetski wrote:
> > noticed is that 2.6 is trying to read bigger blocks (32K instead of 8K),
>
> You mean it's trying to do 32K nfs block size on the wire?

Emn, no, if I understand it correctly. NFS-client requests 32K of data at
a time, but that is sent in several fragments. Actually, client is the
same (2.6 kernel), and it requests 32 or 8K depending on the
kernel-version of the server...

> Just post a few samples of the lines that differ.  Any files should be sent
> off-list.

Well, I am afraid, I won't be able to identify the important  differring
packets. I did
tcpdump -l -i eth0 -exX -vvv -s0
, so, the log contains complete packet dumps. Ok, I'll try just to quote
headers. poirot is the server (PC1, 2.4 / 2.6), fast is the client (PC2,
2.6). Following the first request for data (diff only in length)

2.6:

18:42:28.374430 0:80:5f:d2:53:f0 0:50:bf:a4:59:71 ip 162:
fast.grange.462443716 > poirot.grange.nfs: 120 read fh Unknown/1 32768
bytes @ 0x000008000 (DF) (ttl 64, id 15, len 148)

2.4:

18:48:57.794687 0:80:5f:d2:53:f0 0:50:bf:a4:59:71 ip 162:
fast.grange.1972393156 > poirot.grange.nfs: 120 read fh Unknown/1 8192
bytes @ 0x000002000 (DF) (ttl 64, id 6, len 148)

the server (PC1) sends the following packets:

2.6:

18:42:28.374554 0:50:bf:a4:59:71 0:80:5f:d2:53:f0 ip 1514:
poirot.grange.nfs > fast.grange.445666500: reply ok 1472 read REG 100644
ids 0/0 sz 0x00007a120 nlink 1 rdev 0/0 fsid 0x000000000 nodeid
0x000000000 a/m/ctime 1073497348.374212040 2477.000000 1064093242.000000
32768 bytes (frag 40553:1480@0+) (ttl 64, len 1500)

18:42:28.374560 0:50:bf:a4:59:71 0:80:5f:d2:53:f0 ip 1514: poirot.grange >
fast.grange: (frag 40553:1480@1480+) (ttl 64, len 1500)

2.4:

18:48:57.806270 0:50:bf:a4:59:71 0:80:5f:d2:53:f0 ip 962: poirot.grange >
fast.grange: (frag 39126:928@7400) (ttl 64, len 948)

18:48:57.806291 0:50:bf:a4:59:71 0:80:5f:d2:53:f0 ip 1514: poirot.grange >
fast.grange: (frag 39126:1480@5920+) (ttl 64, len 1500)

Well, maybe important is this place in 2.6 log - when it got the first
(2.5s) delay:

18:42:28.414903 1:80:c2:0:0:1 1:80:c2:0:0:1 8808 60:

18:42:31.033837 0:80:5f:d2:53:f0 0:50:bf:a4:59:71 ip 162:
fast.grange.479220932 > poirot.grange.nfs: 120 read fh Unknown/1 32768
bytes @ 0x000010000 (DF) (ttl 64, id 18, len 148)

18:42:31.034244 0:50:bf:a4:59:71 0:80:5f:d2:53:f0 ip 1514:
poirot.grange.nfs > fast.grange.479220932: reply ok 1472 read REG 100644
ids 0/0 sz 0x00007a120 nlink 1 rdev 0/0 fsid 0x000000000 nodeid
0x000000000 a/m/ctime 1073497351.33807720 2477.000000 1064093242.000000
32768 bytes (frag 40557:1480@0+) (ttl 64, len 1500)

So, does it say anything?

Thanks
Guennadi
---
Guennadi Liakhovetski



