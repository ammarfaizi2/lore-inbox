Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbUAKUUq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 15:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265972AbUAKUUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 15:20:46 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:53955 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S265083AbUAKUUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 15:20:42 -0500
Date: Sun, 11 Jan 2004 12:20:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: mark@borgerding.net
Subject: [Bug 1837] New: tmpfs readdir does not update dir access time
Message-ID: <28710000.1073852440@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1837

           Summary: tmpfs readdir does not update dir access time
    Kernel Version: 2.6.0
            Status: NEW
          Severity: normal
             Owner: fs_other@kernel-bugs.osdl.org
         Submitter: mark@borgerding.net


Distribution: various
Hardware Environment: i386 (Athlons & various intel 32bit)
Software Environment: kernel 2.4.18 to 2.6.0 (at least)
Problem Description:  access times of tmpfs dirs do not get updated on readdir
Impact: This can cause empty dirs to get tmpwatch'd too early, b/c atime never
changes even though the dir is in use.
Steps to reproduce:
    cd /dev/shm
    mkdir mydir
    ls -u --full-time mydir
    ls mydir; sleep 1
    ls -u --full-time mydir
  Access time should be changed by 2nd ls.


FIX: add update_atime call to dcache_readdir function in fs/libfs.c

--- fs/libfs.c.orig     Wed Dec 17 21:58:04 2003
+++ fs/libfs.c  Sun Jan 11 13:22:37 2004
@@ -155,6 +155,7 @@
                        }
                        spin_unlock(&dcache_lock);
        }
+       update_atime(dentry->d_inode);
        return 0;
 }


Note that other fs use dcache_readdir as well. Hopefully none rely on this
(broken?) behavior.  I found direct or indirect use of dcache_readdir ,
simple_dir_operations, or simple_fill_super in various places.  I was not
familiar enough with most fs to evaluate the impact.

