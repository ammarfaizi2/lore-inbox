Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbSIXHQG>; Tue, 24 Sep 2002 03:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbSIXHQG>; Tue, 24 Sep 2002 03:16:06 -0400
Received: from unthought.net ([212.97.129.24]:48874 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S261593AbSIXHQE>;
	Tue, 24 Sep 2002 03:16:04 -0400
Date: Tue, 24 Sep 2002 09:21:17 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@zip.com.au>
Subject: jbd bug(s) (?)
Message-ID: <20020924072117.GD2442@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First:

In Linux-2.4.19, I was wondering about the following:

In fs/jbd/commit.c:583, we find the following:
 /* AKPM: buglet - add `i' to tmp! */
 for (i = 0; i < jh2bh(descriptor)->b_size; i += 512) {
         journal_header_t *tmp =
                 (journal_header_t*)jh2bh(descriptor)->b_data;
         tmp->h_magic = htonl(JFS_MAGIC_NUMBER);
         tmp->h_blocktype = htonl(JFS_COMMIT_BLOCK);
         tmp->h_sequence = htonl(commit_transaction->t_tid);
 }


As I see it, this means that jbd using filesystems (ext3) will only
remember writing *ONE* entry from the journal.

Isn't this a problem ?

Second:

The jbd superblocks contains an index into the journal for the first
transaction - but there is only *one* copy of the index, and there is no
reasonable way to detect if it got written correctly to disk.

If the system loses power while updating the superblock, and only *half*
of this index is written correctly, we have a journal which we cannot
reach.

Sort of removes the point of having the journal in the first place. (If
my above assertion is true).

As far as I know, Tux2 solves this problem by keeping multiple indexes
(yes it uses phase trees and not a journal, but Tux2 root nodes and the
journal index are identical wrt. this problem).

If one keeps two blocks holding:
  index
  timestamp
  CRC
one can consider the two blocks and disregard the ones with invalid CRC.
This leaves us with one or two blocks left - we then pick the one with
the highest timestamp - and we are then guaranteed to *always* have a
valid index.

(The above works when the timestamp is incremented for every write,
index updates are written alternating between the two blocks, and the
complete block is sync()ed before the other is written to)

Wouldn't something like this be required for a journalling fs to be
worth anything ?

I know the window is rather small for half an index to be written - but
that doesn't mean it can't happen.


-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
