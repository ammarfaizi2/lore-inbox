Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319142AbSHMSyj>; Tue, 13 Aug 2002 14:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319143AbSHMSyj>; Tue, 13 Aug 2002 14:54:39 -0400
Received: from inmail.compaq.com ([161.114.64.102]:52490 "EHLO
	zmamail02.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S319142AbSHMSyh>; Tue, 13 Aug 2002 14:54:37 -0400
Date: Tue, 13 Aug 2002 13:55:56 -0500
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.30 breaks cciss driver?
Message-ID: <20020813135556.A1438@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmmm, It appears that now we need a gendisk per disk, rather 
than per controller, as this snippet from patch-2.5.30 implies?
And we need to set the gendisk's first_minor to be the minor 
number of the first partition for each disk, is that about right?

-       hd_gendisk.nr_real = NR_HD;
-
-       for(drive=0; drive < NR_HD; drive++)
-               register_disk(&hd_gendisk, mk_kdev(MAJOR_NR,drive<<6), 1<<6,
+       for(drive=0; drive < NR_HD; drive++) {
+               hd_gendisk[i].nr_real = 1;
+               add_gendisk(hd_gendisk + drive);
+               register_disk(hd_gendisk + drive,
+                       mk_kdev(MAJOR_NR,drive<<6), 1<<6,
                        &hd_fops, hd_info[drive].head * hd_info[drive].sect *
                        hd_info[drive].cyl)

I think this is why cciss is broken, we have just one gendisk
per controller.  (please pardon my ignorance, I haven't ever 
had to look at this partition related code before.)

-- steve

