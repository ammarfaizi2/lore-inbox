Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbUBEHBv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 02:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbUBEHBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 02:01:51 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:30136 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263711AbUBEHBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 02:01:47 -0500
Date: Wed, 04 Feb 2004 23:01:41 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: yusufg@outblaze.com
Subject: [Bug 2020] New: mysql multi-user performance half that	of Fedora 2.4.22-2149.nptl kernel
Message-ID: <56730000.1075964501@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=2020

           Summary: mysql multi-user performance half that of Fedora 2.4.22-
                    2149.nptl kernel
    Kernel Version: 2.6.2
            Status: NEW
          Severity: normal
             Owner: axboe@suse.de
         Submitter: yusufg@outblaze.com


Distribution:

Fedora Core 1 (all updates applied)

Hardware Environment:

Dual P3-450 with 1GB RAM. 4x9GB SCSI disks attached to onboard Adaptec
aic7896/97 Ultra2 SCSI adapter (2 disks per channel) on a 440GX motherboard

Software Environment:

mysql 4.0.16 compiled from source
2.6.2 booted with elevator=deadline

Problem Description:

I received a benchmark program from Peter Zaitsev of Mysql. unlike the sql-bench
program in the mysql distribution which is single-threaded, this benchmark is
multi-threaded

I made some minor modifications to the source of sysbench.c (diff+original to be
attached) and ran it.

Comparing the number of transactions shown on 2.6.2 versus Fedora
2.4.22-2149.nptl kernel. 2.6.2 shows half the performance

Steps to reproduce:

compile insert.c and sysbench.c (to be attached)

The compile script for sysbench.c is

INC=/usr/local/site/mysql/include/mysql
LIB=/usr/local/site/mysql/lib/mysql

gcc -g -Wall -O6 -funroll-loops -fomit-frame-pointer sysbench.c  $LIB/libmysqlcl
ient.a  -lz -lm -lrt -o sysbench -I${INC} -L${LIB}

Replace INC,LIB as appropiate

Create a database 'bench'. Create table as per the following SQL command

CREATE TABLE `sbtest` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `k` int(10) unsigned NOT NULL default '0',
  `c` char(120) NOT NULL default '',
  `pad` char(60) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `k` (`k`)
);

Create values to be inserted by running insert and saving the output in a file
./insert > insert.sql
insert the values into the mysql database

mysql -uroot bench < insert.sql

Run sysbench (my diff uses the mysql advanced test, the simple test is just a
trivial select which shows peak number of trivial queries you can get on that box)

./sysbench qt 

Observe the results (to be attached) 
vmstat 1 output during the tests is also attached


