Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131988AbRBNM7V>; Wed, 14 Feb 2001 07:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132136AbRBNM7L>; Wed, 14 Feb 2001 07:59:11 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:35600 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id <S131988AbRBNM7D>; Wed, 14 Feb 2001 07:59:03 -0500
From: "" <simon@baydel.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 14 Feb 2001 12:47:52 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: File IO performance
Message-ID: <46C587D9403D@baydel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been performing some IO tests under Linux on SCSI disks.
I noticed gaps between the commands and decided to investigate.
I am new to the kernel and do not profess to underatand what 
actually happens. My observations suggest that the file 
structured part of the io consists of the following file phases 
which mainly reside in mm/filemap.c . The user read call ends up in
a generic file read routine. If the requested buffer is not in
the file cache then the data is requested from disk via the disk 
readahead routine. When this routine completes the data is copied 
to user space. I have been looking at these phases on an analyzer
and it seems that none of them overlap for a single user process. 

This creates gaps in the scsi commands which significantly reduce
bandwidth, particularly at todays disk speeds. 

I am interested in making changes to the readahead routine. In this 
routine there is a loop


 /* Try to read ahead pages.
  * We hope that ll_rw_blk() plug/unplug, coalescence, requests sort
  * and the scheduler, will work enough for us to avoid too bad 
  * actuals IO requests. 
  */ 

 while (ahead < max_ahead) {
  ahead ++;
  if ((raend + ahead) >= end_index)
   break;
  if (page_cache_read(filp, raend + ahead) < 0)
 }


this whole loop completes before the disk command starts. If the 
commands are large and it is for a maximum read ahead this loops 
takes some time and is followed by disk commands. 

It seems that the performance could be improved if the disk commands 
were overlapped in some way with the time taken in this loop. I have 
not traced page_cache_read so I have no idea what is happening but I 
guess this is some page location and entry onto the specific device 
buffer queues ?

I am really looking for some help in underatanding what is happening 
here and suggestions in ways which operations may be overlapped.
__________________________

Simon Haynes - Baydel 
Phone : 44 (0) 1372 378811
Email : simon@baydel.com
__________________________
