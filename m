Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316965AbSGNRbz>; Sun, 14 Jul 2002 13:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316961AbSGNRby>; Sun, 14 Jul 2002 13:31:54 -0400
Received: from goliath.siemens.de ([192.35.17.28]:11224 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP
	id <S316965AbSGNRbx>; Sun, 14 Jul 2002 13:31:53 -0400
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: linux-kernel list <linux-kernel@vger.kernel.org>
Cc: Juan Quintela <quintela@mandrakesoft.com>,
       Cooker list <cooker@linux-mandrake.com>
Subject: BUG: pdcraid OOPS due to uninitialized variable access
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-1mdk 
Date: 14 Jul 2002 21:34:40 +0400
Message-Id: <1026668086.3181.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On both 2.4.18-6mdk (from 8.2) and in current cooker pdcraid oopses
immediately after insertion. The reason is usage of uninitialized
variable in drivers/ide/pdcraid.c:


static void __init probedisk(int devindex,int device, int raidlevel)
{
        int i;
        int major, minor;
        struct promise_raid_conf *prom;
        static unsigned char block[4096];
        struct block_device *bdev;

        if (devlist[devindex].device!=-1) /* already assigned to another
array
*/
                return;
        if (strcmp("Promise Technology, Inc.",prom->promise_id))
                return; /* magic number must match */
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

here it bails out. prom is initialized later:

       major = devlist[devindex].major;
        minor = devlist[devindex].minor;

        if (read_disk_sb(major,minor,(unsigned
char*)&block,sizeof(block)))
                return;


        prom = (struct promise_raid_conf*)&block[512];

I am sorry, I do not have vanilla kernel so I cannot check if bug is in
general kernel or Mandrake-specific.

-andrej

