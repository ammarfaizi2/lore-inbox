Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289272AbSAOLu6>; Tue, 15 Jan 2002 06:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289317AbSAOLuk>; Tue, 15 Jan 2002 06:50:40 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:17933 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S289272AbSAOLub>; Tue, 15 Jan 2002 06:50:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: Neil Brown <neilb@cse.unsw.edu.au>
Subject: [BUG] symlink problem with knfsd and reiserfs 
Date: Tue, 15 Jan 2002 12:50:08 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020115115019.89B55143B@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil et al.,

during the last days, Trond and me was able to hunt a problem down
to $subject, which happens as follows:

It occurs with all 2.4 kernels, I've tested so far, but for reference:

Server: 2.4.18-pre3 on Dual P3/500 exports reiserfs partitions
Client: Diskless 2.4.18-pre3 on Athlon 1.2 GHz

When building lm_sensors-2.6.2 on the client, I could easily reproduce
this:

gcc -shared -Wl,-soname,libsensors.so.1 -o lib/libsensors.so.1.2.0 
lib/data.lo lib/general.lo lib/error.lo lib/chips.lo lib/proc.lo 
lib/access.lo lib/init.lo lib/conf-parse.lo lib/conf-lex.lo -lc
rm -f lib/libsensors.so.1
ln -sfn libsensors.so.1.2.0 lib/libsensors.so.1
make: stat:lib/libsensors.so.1: Eingabe-/Ausgabefehler
rm -f lib/libsensors.so 
ln -sfn libsensors.so.1.2.0 lib/libsensors.so

In syslog, this message appears:
Jan 15 00:21:03 elfe kernel: nfs_refresh_inode: inode 50066 mode changed, 
0100664 to 0120777

In this case, ln managed to create an invalid link in the above sequence.
Really bad is, you cannot get around this within the client. Within the
server, the link is ok, but on the client, ls -l lib throws a 
ls: lib/libsensors.so.1: Eingabe-/Ausgabefehler

A comment from Trond << EOC
It is telling you that the server has a blatant bug: it is first
telling the client that the inode 50066 is a regular file, then
it changes it to a link.

When this happens, the RFCs state that the server is supposed to
change the NFS filehandle. The client *does* check the filehandle, so
if the server had updated it correctly, you would not have had a
problem.
EOC

A least, Trond was able to get me around it with this patch, but
I would be nice to fix the real problem instead (b/c the build 
feels noticable slower with it):

--- linux-2.4.18-up/fs/nfs/dir.c.orig   Fri Jan 11 23:06:38 2002
+++ linux-2.4.18-up/fs/nfs/dir.c        Mon Jan 14 23:52:17 2002
@@ -619,6 +619,8 @@
                nfs_complete_unlink(dentry);
                unlock_kernel();
        }
+       if (is_bad_inode(inode))
+               force_delete(inode);
        iput(inode);
 }
 
--- linux-2.4.18-up/fs/nfs/inode.c.orig Fri Jan 11 23:08:00 2002
+++ linux-2.4.18-up/fs/nfs/inode.c      Mon Jan 14 23:53:10 2002
@@ -699,6 +699,8 @@
                return 0;
        if (memcmp(&inode->u.nfs_i.fh, fh, sizeof(inode->u.nfs_i.fh)) != 0)
                return 0;
+       if (is_bad_inode(inode))
+               return 0;
        /* Force an attribute cache update if inode->i_count == 0 */
        if (!atomic_read(&inode->i_count))
                NFS_CACHEINV(inode);

An noted, this is a longer standing problem here, but with libsensors build,
I could easily reproduce this. Do yoou?

Any chance to get this fixed soon?

Cheers,
  Hans-Peter
