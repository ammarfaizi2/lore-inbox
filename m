Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWINSY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWINSY1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 14:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWINSY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 14:24:27 -0400
Received: from 1-1-5-8a.ehn.lk.bostream.se ([82.183.137.225]:34039 "EHLO
	1-1-5-8a.ehn.lk.bostream.se") by vger.kernel.org with ESMTP
	id S1750893AbWINSY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 14:24:26 -0400
Date: Thu, 14 Sep 2006 20:24:23 +0200
From: Henrik Carlqvist <hc8@uthyres.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ocfs2 problem with nfs v2
Message-Id: <20060914202423.56314cf5.hc8@uthyres.com>
In-Reply-To: <20060913223320.008bdcf7.hc8@uthyres.com>
References: <20060913223320.008bdcf7.hc8@uthyres.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henrik Carlqvist <hc8@uthyres.com> wrote:
> As the old 2.2.6 kernel does not have support for NFS v3 but only NFS v2
> my guess is that this might trigger the bug.

Today I used a Slackware 9.1 machine to mount the NFS share with NFS v2.
Using NFS v3 in Slackware 9.1 the server works fine, but with NFS v2 I was
able to repeat the bug.

This is what it looks like on the NFS client:

# uname -sr
Linux 2.4.22
# mount -o nfsvers=2 ekorrapa:/san/old /mnt/hd/ 
# cat /proc/mounts | grep mnt/hd
ekorrapa:/san/old /mnt/hd nfs
rw,v2,rsize=8192,wsize=8192,hard,udp,lock,addr=ekorrapa 0 0 
# ls /mnt/hd/
1   11  13  15  17  19  20  3  5  7  9           mail 
10  12  14  16  18  2   21  4  6  8  lost+found
# ls -al /mnt/hd/ 
ls:/mnt/hd/lost+found: Input/output error 
ls: /mnt/hd/1: Input/output error
ls: /mnt/hd/2: Input/output error
ls: /mnt/hd/3: Input/output error
ls: /mnt/hd/4: Input/output error
ls: /mnt/hd/5: Input/output error
ls: /mnt/hd/6: Input/output error
ls: /mnt/hd/7: Input/output error
ls: /mnt/hd/8: Input/output error
ls: /mnt/hd/9: Input/output error
ls: /mnt/hd/10: Input/output error
ls: /mnt/hd/11: Input/output error
ls: /mnt/hd/12: Input/output error
ls: /mnt/hd/13: Input/output error
ls: /mnt/hd/14: Input/output error
ls: /mnt/hd/15: Input/output error
ls: /mnt/hd/16: Input/output error
ls: /mnt/hd/17: Input/output error
ls: /mnt/hd/18: Input/output error
ls: /mnt/hd/19: Input/output error
ls: /mnt/hd/20: Input/output error
ls: /mnt/hd/21: Input/output error
ls: /mnt/hd/mail: Input/output error
total 3
drwxr-xr-x   25 root     root         2048 Sep 13 10:21 . 
drwxr-xr-x    5 root     root          120 Mar 16  2002 ..
 
>From the clients point of view it looks a little bit different compared
with a 2.2.6 kernel. "ls" works, but "ls -l" does not work. With kernel
2.2.6 not even "ls" did work. I also get a slightly different error with
kernel 2.4.22 on the client, "Input/output error" instead of "Operation
not supported on transport endpoint".

However, on the NFS server things look exactly the same as before:

# uname -sr
Linux 2.6.9-42.ELsmp
# cat /proc/mounts | grep old
/dev/emcpowerb1 /san/old ocfs2 rw,noatime 0 0 
# fgrep ocfs2 /var/log/messages
Sep 14 10:53:23 kattapa kernel: (5380,0):ocfs2_encode_fh:155 ERROR: fh
buffer is too small for encoding 
Sep 14 10:53:31 kattapa kernel: (5390,2):ocfs2_encode_fh:155 ERROR: fh
buffer is too small for encoding 
Sep 14 10:53:45 kattapa kernel: (5390,1):ocfs2_encode_fh:155 ERROR: fh
buffer is too small for encoding 
Sep 14 10:53:47 kattapa kernel: (5390,1):ocfs2_encode_fh:155 ERROR: fh
buffer is too small for encoding 
Sep 14 10:53:59 kattapa kernel: (5390,1):ocfs2_encode_fh:155 ERROR: fh
buffer is too small for encoding 
Sep 14 10:54:02 kattapa kernel: (5390,3):ocfs2_encode_fh:155 ERROR: fh
buffer is too small for encoding 
Sep 14 13:21:41 kattapa kernel: (5383,0):ocfs2_encode_fh:155 ERROR: fh
buffer is too small for encoding 
Sep 14 13:35:17 kattapa kernel: (5380,3):ocfs2_encode_fh:155 ERROR: fh
buffer is too small for encoding 
Sep 14 13:35:17 kattapa kernel: (5380,0):ocfs2_encode_fh:155 ERROR: fh
buffer is too small for encoding
Sep 14 13:35:17 kattapa kernel: (5380,0):ocfs2_encode_fh:155 ERROR: fh
buffer is too small for encoding 
Sep 14 13:35:17 kattapa kernel: (5380,3):ocfs2_encode_fh:155 ERROR: fh
buffer is too small for encoding 
Sep 14 13:35:19 kattapa kernel: (5380,0):ocfs2_encode_fh:155 ERROR: fh
buffer is too small for encoding 
Sep 14 13:35:19 kattapa kernel: (5380,1):ocfs2_encode_fh:155 ERROR: fh
buffer is too small for encoding 
Sep 14 13:35:19 kattapa kernel: (5381,0):ocfs2_encode_fh:155 ERROR: fh
buffer is too small for encoding 
Sep 14 13:37:24 kattapa kernel: (5380,0):ocfs2_encode_fh:155 ERROR: fh
buffer is too small for encoding
Sep 14 13:40:38 kattapa kernel: (5380,2):ocfs2_encode_fh:155 ERROR: fh
buffer is too small for encoding

The good thing with this is that the bug is possible to reproduce without
having access to an NFS client running an ancient Linux distribution.
By doing:
mount -o nfsvers=2 server:/nfs/export /mount/point
It is possible to repeat this bug.

regards Henrik
