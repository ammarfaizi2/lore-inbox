Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBHBPJ>; Wed, 7 Feb 2001 20:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129027AbRBHBOu>; Wed, 7 Feb 2001 20:14:50 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:63989 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S129026AbRBHBOk>; Wed, 7 Feb 2001 20:14:40 -0500
Message-ID: <3A81F2A6.DC5AB40B@mvista.com>
Date: Wed, 07 Feb 2001 17:13:10 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: nfs_refresh_inode: inode number mismatch
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a weird problem that I am looking at right.  It seems to indicate a
bug in the nfs server.

I have a MIPS machine that boots from a NFS root fs hosted on a redhat 6.2
workstation.  Everything works fine except that after a few reboots I start to
see the error messages like the following:

Freeing unused kernel memory: 24k freed
INIT: version 2.77 booting
nfs_refresh_inode: inode number mismatch
expected (0x308/0x28b3d2), got (0x308/0x12b91b)
INIT: Entering runlevel: 3
sh-2.03# 

Restarting the nfs server on the host does not get rid of the messages. 
Things will get better if I reboot the host.

I traced the network packets, and it seems obvious that the server is
returning wrong fileid in the "write reply" message.  Below is a segment of
the extracted packet trace.  It is obvious that the nfs server returns a wrong
fileid for the same handle it returned earlier to the client.  The confusing
part is the nfs server actually serves the first write request, and a couple
of other requests, correctly but failed for the second time, returning a wrong
fileid.

In my particular setup, it seems only certain files (inodes) tend to get
screwed up.

Does anybody have an idea as to what is wrong here?

Please cc your reply to my email address.  TIA.


Jun

------------------
round 3:

case 1:

2177 lookup:
        ioctl.save

2178 lookup reply:
        fileid: 2667474
        handle:
cabaebfed2b32800e6ab2800080300000803000054c21100b2302b0c00000000

2181 write:
        offset:0
        total count: 60
        handle:
cabaebfed2b32800e6ab2800080300000803000054c21100b2302b0c00000000

2182 write reply:
        fileid: 2667474
        size: 60

2183 setattr:
        handle:
cabaebfed2b32800e6ab2800080300000803000054c21100b2302b0c00000000

2184 setattr reply:
        fileid: 2667474

2185 write:
        handle:
cabaebfed2b32800e6ab2800080300000803000054c21100b2302b0c00000000

2186 write reply:
        fileid 1227035
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
