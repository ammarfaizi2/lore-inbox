Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317006AbSG1SZe>; Sun, 28 Jul 2002 14:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317012AbSG1SZe>; Sun, 28 Jul 2002 14:25:34 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:17318 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S317006AbSG1SZd>; Sun, 28 Jul 2002 14:25:33 -0400
Date: Sun, 28 Jul 2002 11:28:52 -0700
From: niraj gupta <nirajgupta@yahoo.com>
Subject: max scri drive size limit supported in linux
To: linux-kernel@vger.kernel.org
Message-id: <0GZZ00FQB205JM@mta7.pltn13.pbi.net>
MIME-version: 1.0
X-Mailer: KMail [version 1.3.2]
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i was looking at the sd driver code to see how linux does drive capacity 
recognition, it looks like linux can only support a maximum single drive 
capacity of 2TB, how would that affect using raids which are larger than 2TB.
here is how i reached the 2TB conclusion. and please do correct me if i am 
wrong.

kernel revision 2.4.18, sd.c

line 927

	 rscsi_disks[i].capacity = 1 + ((buffer[0] << 24) |
                                               (buffer[1] << 16) |
                                               (buffer[2] << 8) |
                                               buffer[3]);

which is max number of sectors = 2^32

line 940

	if (sector_size != 512 &&
                    sector_size != 1024 &&
                    sector_size != 2048 &&
                    sector_size != 4096 &&
                    sector_size != 256) {
                        printk("%s : unsupported sector size %d.\n",
                               nbuff, sector_size);
                        /*
                         * The user might want to re-format the drive with
                         * a supported sectorsize.  Once this happens, it
                         * would be relatively trivial to set the thing up.
                         * For this reason, we leave the thing in the table.
                         */
                        rscsi_disks[i].capacity = 0;
                }

which limits sector size to a max of 2^12, which may lead us to think that 
the max drive capacity would be 2^44 - 16TB, but later on

line 999
                /* Rescale capacity to 512-byte units */
                if (sector_size == 4096)
                        rscsi_disks[i].capacity <<= 3;
                if (sector_size == 2048)
                        rscsi_disks[i].capacity <<= 2;
                if (sector_size == 1024)
                        rscsi_disks[i].capacity <<= 1;
                if (sector_size == 256)
                        rscsi_disks[i].capacity >>= 1;

which would result in a max drive capacity supported to be 2TB
although this is not a issue to me personally, it just raised questions in my 
mind as to how does it do it for raids larger than 2tb

thanks for reading the rambling
niraj gupta
nirajgupta@yahoo.com
