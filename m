Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262673AbVCDIny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbVCDIny (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 03:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbVCDIny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 03:43:54 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.138]:18055 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S262659AbVCDInh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 03:43:37 -0500
Date: Fri, 4 Mar 2005 00:43:26 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>,
       <jfs-discussion@www-124.southbury.usf.ibm.com>, <reiser@namesys.com>
cc: mc@cs.stanford.edu
Subject: Re: [MC] [CHECKER] Do ext2, jfs and reiserfs respect mount -o
 sync/dirsync option?
In-Reply-To: <Pine.GSO.4.44.0503032211570.7754-100000@elaine24.Stanford.EDU>
Message-ID: <Pine.GSO.4.44.0503040025380.9443-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005, Junfeng Yang wrote:

>
> Hi,
>
> FiSC (our file system checker) emits several warnings on ext2, jfs and
> reiserfs, complaining that diretories or files are lost while FiSC
> believes they should already be persistent on disk. (ext3 behaves
> correctly.)

I forget to mention, we are mainly looking for crash-recovery bugs.  The
warnings can trigger this way:
1. do several file system operations
2. "crash" the test machine
3. get the crashed disk image, run fsck to recover
4. mount the recovered disk image

I'm able to reproduce the same warnings on ext2 using the following
program:

main()
{
        system("sudo umount /dev/hda9");
        system("/sbin/mke2fs /dev/hda9");
        system("sudo mount -t ext2 /dev/hda9 /mnt/sbd1 -o sync,dirsync");
        creat("/mnt/sbd1/0002", 0777);
        mkdir("/mnt/sbd1/0003", 0777);
	// unplug your power cord here :)  then use e2fsck to recover
}

uname -a shows
Linux notus 2.6.8-1-686 #1 Thu Nov 25 04:34:30 UTC 2004 i686 GNU/Linux

