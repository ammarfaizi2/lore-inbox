Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266955AbUBMMgI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 07:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266959AbUBMMgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 07:36:08 -0500
Received: from columba.eur.3com.com ([161.71.171.238]:53965 "EHLO
	columba.eur.3com.com") by vger.kernel.org with ESMTP
	id S266955AbUBMMgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 07:36:05 -0500
Message-ID: <402CC4AE.7050904@jburgess.uklinux.net>
Date: Fri, 13 Feb 2004 12:35:58 +0000
From: Jon Burgess <lkml@jburgess.uklinux.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jon Burgess <lkml@jburgess.uklinux.net>, linux-kernel@vger.kernel.org
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interleaved
 writes
References: <402A7CA0.9040409@jburgess.uklinux.net> <20040212015626.48631555.akpm@osdl.org>
In-Reply-To: <20040212015626.48631555.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>What filesytem was that with?
>  
>
I re-ran the tests again last night and founfd that I had made one 
mistake in my description.

The really poor results occured with the *ext3* filesystem, not ext2.

"mount" was telling me that the contents of /etc/fstab which was ext2 - 
but the kernel actually had it mounted it as ext3.

I think I might be able to give a little insight to the "0.34MB/s" and 
"0.48MB/s" numbers. I think these numbers closely match the theoretical 
performance rate when a single 4kB write occurs per disk rotation.

4kB * 5400RPM / 60 seconds = 360 kB/s
4kB * 7200RPM / 60 seconds = 480 kB/s

Perhaps the drives that I am running the test on do not have 
write-caching enabled.
By the time the first 4kB write has completed the drive may need to wait 
a complete rotation before it can do the next write. I don't think it 
quite explains the difference between ext2 and ext3. Any ideas?

Below are the resuls of ext2/ext3 tests on a new Seagate 80Gb SATA, 8MB 
Cache, model ST380023AS.
The ext3 results are a lot better, perhaps this drive has write caching 
enabled.

Num streams    |1      1      |2      2      |4       4
Filesystem     |Write  Read   |Write  Read   |Write   Read
------------------------------|--------------|--------------
Ext2           |40.17  43.07  |10.88  21.49  |10.13   11.41
ext3-journal   |16.06  42.24  | 7.56  16.28  | 7.17   11.25
ext3-ordered   |37.31  43.12  | 4.64  15.33  | 5.25   11.28
ext3-writeback |37.33  42.93  | 4.00  14.88  | 2.97   11.26


    Jon

