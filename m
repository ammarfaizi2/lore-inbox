Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266562AbUA3DgJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 22:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266569AbUA3DgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 22:36:09 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:6622 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S266562AbUA3DgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 22:36:01 -0500
Message-ID: <4019D11C.7020706@backtobasicsmgmt.com>
Date: Thu, 29 Jan 2004 20:35:56 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: tmpfs sparse file failure in glibc "make check"
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been tracking down a problem in CVS glibc "make check" and it 
appears that either it's a bug in tmpfs or an undocumented limitation of 
tmpfs.

My system is running 2.6.2-rc2, with 1G of physical RAM (4G highmem mode 
is enabled in the kernel). The glibc test does the following (snipped 
from the source because it's a simple test):

int fd;
#define TWO_GB 2147483648LL

...

   fd = mkstemp64 (name);
   ret = lseek64 (fd, TWO_GB+100, SEEK_SET);
   ret = write (fd, "Hello", 5);


On my system the temp file is created in /tmp, and tmpfs is mounted on 
/tmp (with no mount options limiting maximum size or anything of that 
type). With no swap space turned on, this write() returns ENOMEM.

With 512MB or 1GB of swap space, it still returns ENOMEM. With 1.5GB of 
swap space, the write() succeeds. However, this is a sparse file with a 
total of 6 bytes of content :-)

I could understand if tmpfs was limiting the file size to half of 
physical RAM+swap, but the test succeeds at 2.5GB total even though the 
sparse file is created at 2GB size.

For now I work around the test failure by pointing glibc to a different 
filesystem for this test, but I'm wondering why the tmpfs filesystem 
can't pass this test like a "normal" filesystem does...

