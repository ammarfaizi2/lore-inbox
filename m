Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbUKNWQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbUKNWQA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 17:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbUKNWQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 17:16:00 -0500
Received: from danga.com ([66.150.15.140]:8934 "EHLO danga.com")
	by vger.kernel.org with ESMTP id S261355AbUKNWPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 17:15:52 -0500
Date: Sun, 14 Nov 2004 14:15:49 -0800 (PST)
From: Brad Fitzpatrick <brad@danga.com>
X-X-Sender: bradfitz@danga.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.9: unkillable processes during heavy IO
Message-ID: <Pine.LNX.4.58.0411141403040.22805@danga.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have two database servers which freeze up during heavy IO load.  The
machines themselves are responsible, but the mysqld processes are forever
locked, unkillable with even kill -9.  I can't restart with MySQL without
rebooting the machines.

I can reasonable rule out hardware, since this is happening in the
same way on two identical machines.

I'd like to know how I can debug this, to file a proper bug report.

The hardware/software stack is:

  - Dual Opteron 246, SMP kernel, w/ NUMA
  - 9 GB of memory (4GB in one zone, 5GB in the other)
  - MySQL, running mostly InnoDB, but some MyISAM
  - MegaRAID raid-10
  - device mapper
  - XFS (used as both O_DIRECT from InnoDB and regularly from MyISAM)

At this point I'm going to try changing different variables on
different machines in order to try and isolate it, but it's a slow
process.

  - on raw partions, instead of device mapper
  - ext3 instead of XFS
  - not using O_DIRECT

"Screenshot":

roast:~# killall -9 mysqld
roast:~# killall -9 mysqld
roast:~# ps afx | grep mysqld
31495 ?        D      0:08 /usr/local/mysql/bin/mysqld --defaults-extra-file=/usr/local/mysql/data/my.cnf --basedir=/usr/local/mysql/ --datadir=/data/mydb --user=root
--pid-file=/var/run/mysqld/mysqld.pid --skip-locking --port=3306 --socket=/var/run/mysqld/mysqld.sock
32391 ?        D      0:01 /usr/local/mysql/bin/mysqld --defaults-extra-file=/usr/local/mysql/data/my.cnf --basedir=/usr/local/mysql/ --datadir=/data/mydb --user=root
--pid-file=/var/run/mysqld/mysqld.pid --skip-locking --port=3306 --socket=/var/run/mysqld/mysqld.sock
  515 ?        D      0:00 /usr/local/mysql/bin/mysqld --defaults-extra-file=/usr/local/mysql/data/my.cnf --basedir=/usr/local/mysql/ --datadir=/data/mydb --user=root
--pid-file=/var/run/mysqld/mysqld.pid --skip-locking --port=3306 --socket=/var/run/mysqld/mysqld.sock
  517 ?        Z      0:00  \_ [mysqld] <defunct>

Next time it hangs like this, how can I get a kernel backtrace or other useful information
for a certain process?

Thanks!

- Brad

