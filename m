Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWGCEFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWGCEFI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 00:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWGCEFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 00:05:08 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:5418 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751181AbWGCEFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 00:05:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fY2o6OnajkQf60UAexVZ87OgSG5cXr4X7IDlI965/h027nIK3qFPo1F703GlDkwJawRjRH0V35zNMjilMW4tcicpgBOL6baR6Mg0tBN5jVvHjU3MU7cRxPvmvIlEgSCwmLWvAo5Df/5Ek7bOmMbPnAh4yIGx3+jggFn0DQFuLAY=
Message-ID: <4ae3c140607022105t30570e1an2549d8ea07388388@mail.gmail.com>
Date: Mon, 3 Jul 2006 00:05:05 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: How to explain a strange NFS behavior
Cc: linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, folks,

I benchmarked NFS V3 and found a strange thing. I benchmarked with
command "tar xvf linux-2.6.12.tar" and record the total time as well
as the time used on several important system calls. NFS directory is
exported in async mode. The result is listed below:

		number of        NFS3           NFS3
                being called	1st run		 2nd run	     Ext3
                                       (ms)             (ms)
      (ms)

stat64 		23		   1249		  64484		       35
fstat64		11		   2078		  5399		        4
utime  		18436		1290737	     1266746		169427
open   		17371		2747423	     3160002		913427
read   		20802		 7269517      11566103		10036876
write  		54784		 611536		723411		   1594104
close  		17386		26698315     12052766		61096
mmap2  		5		17		  21		        15
munmap 		8	       122		136		       82
---------------------------------------------------------------------------------------------------
Total time:			  37s		    25s		          22s

Note that I added some fast communication mechanisms to make NFS
client and server communicate very fast.

Now the problem is: the second run of NFS was much faster than the
first run. Because I didn't flush the disk cache at the server side,
intuitively I think the performance difference should come from the
sys_read() as the tar file data should be already in disk cache for
the second run. However, the results showed that sys_read in the
second run was even slower than the first run. BUT, sys_close of the
second run was much faster!  Why? I am really confused.

Please help!

Also, I ran the same benchmark on ext3, it spent more time on sys_read
and sys_write, but sys_close was much faster. I guess that's because
NFS and Ext3 use different running model. NFS always tried to cache
data at client side and flush data  until file is closed. This can
send a lot of data to the server in a bursty manner. On the contrary,
the ext3 file system periodically flush data to disk and amotizes the
data write cost and make disk write executed with untar
simultaneously.  Is this the real reason? If not, how to explain these
interesting running patterns of NFS and Ext3?

Again, many thanks for kind help!

xin
