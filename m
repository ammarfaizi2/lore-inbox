Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVCNMaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVCNMaW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 07:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVCNMaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 07:30:22 -0500
Received: from port-212-202-144-146.static.qsc.de ([212.202.144.146]:8643 "EHLO
	mail.hennerich.de") by vger.kernel.org with ESMTP id S261390AbVCNMaH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 07:30:07 -0500
Message-ID: <026101c52891$2a618410$0404010a@hennerich.de>
From: "Timo Hennerich" <Timo@Hennerich.de>
To: "Alexander Nyberg" <alexn@dsv.su.se>
Cc: "Tobias Hennerich" <Tobias@Hennerich.de>, <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
References: <20050308133735.A13586@bart.hennerich.de> <20050308173811.0cd767c3.akpm@osdl.org> <20050309102740.D3382@bart.hennerich.de> <20050311183207.A22397@bart.hennerich.de> <1110565420.2501.12.camel@boxen> <20050312133241.A11469@bart.hennerich.de> <1110640085.2376.22.camel@boxen> <20050312214216.A24046@bart.hennerich.de> <1110661479.3360.11.camel@boxen>
Subject: Re: Strange memory leak in 2.6.x
Date: Mon, 14 Mar 2005 13:27:18 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

my brother got ill this weekend, so I'll continue this task:

> > See http://download.hennerich.de/kallsyms_20050312_1630.gz
> 
> Great, just so that there is no confusion, I still need a new run
> of /proc/page_owner, the shorter time before the lockup the better.

The machine locked up this morning again. See

    http://download.hennerich.de/page_owner_sorted_20050314_0740.bz2

for one of the last results of /proc/page_owner. It seems to be
obvious that the memory-leak seems to be the first entry:

    $ less page_owner_sorted_20050314_0740.bz2
    881397 times:
    Page allocated via order 0
    [0xc013962b] find_or_create_page+91
    [0xf8aa9955] +613
    [0xf8aaa606] +1366
    [0xc015765c] vfs_write+172
    [0xc015776c] sys_write+60
    [0xc0103879] sysenter_past_esp+82
     
    13358 times:
    Page allocated via order 0
    [0xc014817a] do_wp_page+282
    [0xc014914e] handle_mm_fault+302
    [0xc0113625] do_page_fault+501
    [0xc0104a7b] error_code+43

The sorted table of /proc/kallsyms looks like this:

    ...
    f8aa90e0 t reiserfs_commit_page [reiserfs]
    f8aa92e0 t reiserfs_submit_file_region_for_write        [reiserfs]
    f8aa9550 t reiserfs_check_for_tail_and_convert  [reiserfs]
    f8aa96f0 t reiserfs_prepare_file_region_for_write       [reiserfs]
    f8aaa0b0 t reiserfs_file_write  [reiserfs]
    f8aaa770 t reiserfs_aio_write   [reiserfs]
    f8aaa779 t .text.lock.file      [reiserfs]
    f8aaa7c0 t reiserfs_dir_fsync   [reiserfs]
    f8aaa7f0 t reiserfs_readdir     [reiserfs]
    f8aaad70 t make_empty_dir_item_v1       [reiserfs]
    f8aaae50 t make_empty_dir_item  [reiserfs]
    f8aaafc0 t create_virtual_node  [reiserfs]
    f8aab520 t check_left   [reiserfs]
    f8aab670 t check_right  [reiserfs]
    f8aab7c0 t get_num_ver  [reiserfs]
    ...

So I guess that we have a problem with the reiser filesystem??
We are using reiserfs 3.6...

Perhaps it's important to notice that the operating system

- is no fresh installation of SuSE 9.2, but was updated from SuSE 8.2
- is installed on that special hardware via a restore with the software
  Mondo-Rescue v2.03

Unfortunately we were not able up to now to reproduce the bug with
identical hardware and simulated disk-io. Only the production environment
triggers the bug.


0xf8aa9955 -  613 = 0xf8aa96f0: reiserfs_prepare_file_region_for_write
0xf8aaa606 - 1366 = 0xf8aaa0b0: reiserfs_file_write  

Wild guessing: Is "reiserfs_prepare_file_region_for_write" used
to append new output to existent files only - and do we have a memory
leak inside of this function? The production machine is used as loghost 
and syslog is writing several 100MB logfiles each day - which would be
a difference to the test hardware.



Best regards         Timo
-- 
T+T Hennerich GmbH --- Zettachring 12a --- 70567 Stuttgart
Fon:+49(711)720714-0  Fax:+49(711)720714-44  Vanity:+49(700)HENNERICH
UNIX - Linux - Java - C  Entwicklung/Beratung/Betreuung/Schulung
http://www.hennerich.de/

