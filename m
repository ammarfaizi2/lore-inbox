Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268323AbTAMUTt>; Mon, 13 Jan 2003 15:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268325AbTAMUTs>; Mon, 13 Jan 2003 15:19:48 -0500
Received: from mail2.scram.de ([195.226.127.112]:48139 "EHLO mail2.scram.de")
	by vger.kernel.org with ESMTP id <S268323AbTAMUTp>;
	Mon, 13 Jan 2003 15:19:45 -0500
Date: Mon, 13 Jan 2003 21:27:23 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [BUG 2.5.57] NFSv2 READDIR broken
Message-ID: <Pine.LNX.4.44.0301132103130.4148-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

if mounting a Linux partition with NFSv2, READDIR fills in the last cookie
byte-swapped. The following READDIR will fail, so the NFS client sees a
truncated directory:

Frame 43 (1074 bytes on wire, 1074 bytes captured)
Ethernet II, Src: 00:00:e8:d4:01:61, Dst: 00:60:b3:1f:52:7c
Internet Protocol, Src Addr: 192.168.94.2 (192.168.94.2), Dst Addr: 192.168.95.4 (192.168.95.4)
User Datagram Protocol, Src Port: 2049 (2049), Dst Port: 800 (800)
Remote Procedure Call
Network File System
    Program Version: 2
    V2 Procedure: READDIR (16)
    Status: OK (0)
    Value Follows: Yes
    Entry: file ID 1274231, name .
        File ID: 1274231
        Name: .
            length: 1
            contents: .
            fill bytes: opaque data
        Cookie: 12
    Value Follows: Yes
[...]
    Entry: file ID 1274709, name LICENSE.SRC
        File ID: 1274709
        Name: LICENSE.SRC
            length: 11
            contents: LICENSE.SRC
            fill bytes: opaque data
        Cookie: 644
    Value Follows: Yes
    Entry: file ID 1275342, name Makefile
        File ID: 1275342
        Name: Makefile
            length: 8
            contents: Makefile
        Cookie: 2483159040              <<<<<<<<<<< should be 678
    Value Follows: No
    EOF: 0

This patch corrects the problem:

===== nfsproc.c 1.23 vs edited =====
--- 1.23/fs/nfsd/nfsproc.c  Sat Jan 11 02:00:12 2003
+++ edited/nfsproc.c Mon Jan 13 21:03:28 2003
@@ -482,7 +482,7 @@

  resp->count = resp->buffer - argp->buffer;
  if (resp->offset)
-  *resp->offset = (u32)offset;
+  *resp->offset = htonl(offset);

  fh_put(&argp->fh);
  return nfserr;

--jochen


