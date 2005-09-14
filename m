Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbVINUBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbVINUBO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbVINUBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:01:14 -0400
Received: from cramus.icglink.com ([66.179.92.18]:41189 "EHLO mx03.icglink.com")
	by vger.kernel.org with ESMTP id S932512AbVINUBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:01:12 -0400
Date: Wed, 14 Sep 2005 15:01:09 -0500
From: Phil Dier <phil@icglink.com>
To: linux-kernel@vger.kernel.org
Cc: ziggy <ziggy@icglink.com>, Jack Massari <jack@icglink.com>,
       Scott Holdren <scott@icglink.com>
Subject: Slow I/O with SMP, Fusion-MPT and u160 SCSI JBOD
Message-Id: <20050914150109.232c6765.phil@icglink.com>
Organization: ICGLink
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.4.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just tried the 2.6.14-rc1 kernel to see if it exhibits the behaviour
I have described before[0]. It still does. Briefly, I have a dual Xeon
2.8 with 4GB ram, 1 adaptec and 1 fusion-mpt scsi device, each connected
to 1 SCSI JBOD with 5 disks apiece[1]. I/O on scsi ids 0 and 1 both
work flawlessly. I built an md device across ids 2 and 3, and the disks
connected to the fusion-mpt are unbearably slow. This behaviour was not
present in 2.6.12.3.  When I partition the devices in question and mount
a filesystem on them, they exhibit the same behaviour individually.

[0]: http://www.ussg.iu.edu/hypermail/linux/kernel/0508.3/1233.html
[1]: http://www.icglink.com/debug-2.6.14-rc1.html


Here is what iostat looks like during what should be heavy I/O (my
tesh.sh script described in [1] is running), showing only the relevant
devices:


$ iostat 1 -k | awk '/(Device|md5|md6|md7)/{print $0;}'
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.62         0.00         2.46        244     198312
md6               0.62         0.00         2.46        228     198312
md7               0.61         0.01         2.45        440     197856
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5              25.74         0.00       102.97          0        104
md6              25.74         0.00       102.97          0        104
md7               9.90         0.00        39.60          0         40
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5              59.41         0.00       237.62          0        240
md6              60.40         3.96       237.62          4        240
md7              20.79         3.96        79.21          4         80
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5             100.99         0.00       403.96          0        408
md6             100.99         0.00       403.96          0        408
md7              72.28         0.00       289.11          0        292
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5           16242.57         0.00     64970.30          0      65620
md6           16242.57         0.00     64970.30          0      65620
md7           16230.69         0.00     64922.77          0      65572
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5            1014.85         0.00      4059.41          0       4100
md6            1014.85         0.00      4059.41          0       4100
md7            1014.85         0.00      4059.41          0       4100
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5            3298.02         0.00     13192.08          0      13324
md6            3298.02         0.00     13192.08          0      13324
md7            3298.02         0.00     13192.08          0      13324
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5            2789.11         0.00     11156.44          0      11268
md6            2789.11         0.00     11156.44          0      11268
md7            2789.11         0.00     11156.44          0      11268
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
md5               0.00         0.00         0.00          0          0
md6               0.00         0.00         0.00          0          0
md7               0.00         0.00         0.00          0          0


Thanks for looking. Please cc me on replies.

-- 

Phil Dier (ICGLink.com -- 615 370-1530 x733)

/* vim:set noai nocindent ts=8 sw=8: */
