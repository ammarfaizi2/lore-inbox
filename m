Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUD2LAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUD2LAt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 07:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbUD2LAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 07:00:49 -0400
Received: from usergc137.dsl.pipex.com ([62.190.170.137]:25609 "EHLO
	gateway.office.e-tv-interactive.com") by vger.kernel.org with ESMTP
	id S264098AbUD2LAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 07:00:45 -0400
Subject: Possible permissions bug on NFSv3 kernel client
From: Colin Paton <colin.paton@etvinteractive.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: eTV Interactive Ltd
Message-Id: <1083236543.4541.293.camel@colinp>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 29 Apr 2004 12:02:24 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have found what I think might be a bug with the kernel NFS v3 client
code. It is however more likely that I am doing something wrong -
perhaps someone might verify my attempted fix!

Google suggests that other people might be having the same problem - but
I couldn't find a fix so had a go myself.

I am trying to export a filesystem as read-only from a server. On my
client machine I boot into an initial filesystem, mount the 'real' root
filesystem over NFS, then pivot_root to it. 

If I mount the root filesystem as NFSv2 (using mount -o nfsvers=2) then
everything works correctly. If I mount as NFSv3 then I run into problems
when trying to write to block/character device files.

Both the client and the server are using kernel 2.4.25, with knfsd on
the server. I case it matters, I am using busybox 1.00-pre8 mount, but
the same thing happens with mount version 2.11n on a Debian system.

Essentially, it does not appear to be possible to write to device files
which are mounted on a read-only NFSv3 filesystem. The problem only
occurs with NFS v3 - Mounting the filesystem as NFSv2 (using mount -o
nfsvers=2) is fine.

To reproduce:

- On a server machine create a character device file on a read-only NFS
exported directory (called 'tty3' in this example)
- Mount the NFS volume on a client machine.
- From the client machine, run 'cat > /mnt/tty3'

The kernel returns EACCES when trying to open the 'tty3' device.

The 'cat > /mnt/tty3' command works properly if the directory is
exported read-write.

Reading from the device file (cat < /mnt/tty3) is fine in all cases.

Doing a trace with ethereal shows that an NFS 'access' RPC is sent to
the server, with the access bitmask set to 'allow MODIFY+EXTEND'. The
server returns that these are not allowed, as the filesystem is mounted
read-only. This causes the EACCES error.

I modified the client kernel code as follows, to make the NFS client
behave differently:

In file: fs/nfs/nfs3proc.c modify nfs3_proc_access(). This calls the
access RPC on the server. I added the following to the code:

            if (S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode))
                {
                    // Leave arg.access untouched.
 
                }

...so that the the MODIFY and EXTEND bits aren't set when writing to a
block or character device.

This fix works, yet I believe it might introduce a security problem. I
am not sure where permissions should be properly checked.

The access RPC appears specific to NFS v3. I am not sure how NFS v2 does
permissions checking.

In addition, I am not 100% sure if the problem is at the client end or
the server end - have I just masked the problem rather than actually
fixing it?

Alternatively, of course, there may be some specific reason why NFSv3 is
not recommended for root filesystems - in which case it might be better
to fall back to NFSv2.

Thanks,

Colin


