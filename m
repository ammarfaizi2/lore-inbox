Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132513AbQK0EM3>; Sun, 26 Nov 2000 23:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S135448AbQK0EMU>; Sun, 26 Nov 2000 23:12:20 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:26889 "HELO
        note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
        id <S132513AbQK0EMJ>; Sun, 26 Nov 2000 23:12:09 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 27 Nov 2000 14:41:53 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14881.55297.478630.85219@notabene.cse.unsw.edu.au>
cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] (test11-ac4)  unbelievably silly (fatal) typo in raid5.c
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
        LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
        8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,
 raid5 rebuild has been fatally flawed ever since it got into 2.4, and
 my recent testing has been looking at speed more than correctness, so
 I didn't notice until now.

 raid5_sync_request is handed a block number in 1K units and needs to 
 convert to 512byte sector units.
 I could have used   (block_nr*2)
 I could have used   (block_nr<<1)
 but instead I used  (block_nr<<2)  !!!!  :-(

Please apply the following patch.

Thanks, 
NeilBrown

--- ./drivers/md/raid5.c	2000/11/27 02:46:45	1.1
+++ ./drivers/md/raid5.c	2000/11/27 02:47:37	1.2
@@ -1516,8 +1516,8 @@
 	raid5_conf_t *conf = (raid5_conf_t *) mddev->private;
 	struct stripe_head *sh;
 	int sectors_per_chunk = conf->chunk_size >> 9;
-	unsigned long stripe = (block_nr<<2)/sectors_per_chunk;
-	int chunk_offset = (block_nr<<2) % sectors_per_chunk;
+	unsigned long stripe = (block_nr<<1)/sectors_per_chunk;
+	int chunk_offset = (block_nr<<1) % sectors_per_chunk;
 	int dd_idx, pd_idx;
 	unsigned long first_sector;
 	int raid_disks = conf->raid_disks;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
