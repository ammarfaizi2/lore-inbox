Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319607AbSIMLpm>; Fri, 13 Sep 2002 07:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319608AbSIMLpm>; Fri, 13 Sep 2002 07:45:42 -0400
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:47292 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S319607AbSIMLpj>; Fri, 13 Sep 2002 07:45:39 -0400
Message-ID: <005a01c25b1b$ac7fb390$3083accf@tabasco>
From: "Bill Davenport" <dragonpt@rcn.com>
To: <linux-kernel@vger.kernel.org>
Subject: Can prune_icache safely discard inodes which have only clean pages? (2.4.18)
Date: Fri, 13 Sep 2002 07:49:53 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a system which has a fairly large amount of physical memory (2GB)
that experiences
performance problems after a large number of files have been accessed.

Looking into the slab_info I discovered that a very large number of inodes
are currently
present in the system (along with many buffer headers). Digging deeper I was
able to determine
that most of the inodes were on the inode_unused chain, but were being
skipped over during
the prunce_icache processing because they have a non-zero number of pages
(i_data.nrpages).
Looking a bit deeper I discovered that most of the inodes had only pages
that are on the
clean_pages list, with these pages also accounting for many of the buffer
heads.

The system wasn't attempting to free these pages (presumably since it still
had a fair
amount of physical memory available, so it didn't need to do this).

Is there any danger in changing prune_icache to also pick an inode for
pruning if it has
a non-zero page count where the dirty_list and locked_list are empty?

In particular, the existing code in fs/inode.c looks somewhat like:

 #define CAN_UNUSE(inode) \
  ((((inode)->i_state | (inode)->i_data.nrpages) == 0)  && \
   !inode_has_buffers(inode))
 void prune_icache(int goal)
 {
  ...
  while (entry != &inode_unused)
  {
   ...
   if (inode->i_state & (I_FREEING|I_CLEAR|I_LOCK))
    continue;
   if (!CAN_UNUSE(inode))
    continue;

   Remove inode from i_hash and add to freeable
  }
  ...
  dispose_list(freeable);
  ...
 }

and I'd like to change it to:

 void prune_icache(int goal)
 {
  ...
  while (entry != &inode_unused)
  {
   ...
   if (inode->i_state & (I_FREEING|I_CLEAR|I_LOCK))
    continue;
   if ((inode->i_state != 0) || inode_has_buffers(inode))
    continue;
   if (inode->i_data.nrpages != 0) {
    if ((!list_empty(&inode->i_data.dirty_pages)) ||
        (!list_empty(&inode->i_data.locked_pages))) {
     /* skip if any dirty or locked pages */
     continue;
    }
   }

   Remove inode from i_hash and add to freeable
  }
  ...
  dispose_list(freeable);
  ...
 }


