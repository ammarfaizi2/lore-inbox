Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTGASmF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 14:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTGASmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 14:42:04 -0400
Received: from justchat.medium.net ([62.53.205.52]:15005 "EHLO
	plato.servers.medium.net") by vger.kernel.org with ESMTP
	id S263315AbTGASlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 14:41:55 -0400
Message-ID: <3F01D956.7060600@baldauf.org>
Date: Tue, 01 Jul 2003 20:56:22 +0200
From: =?ISO-8859-1?Q?Xu=E2n_Baldauf?= 
	<xuan--lkml--2003.07.01@baldauf.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5a) Gecko/20030531
X-Accept-Language: de-de, en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: chaffee@cs.berkeley.edu
Subject: [BUG] VFAT eats directory entries on read errors?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I accidently mounted the wrong partition (which was a VFAT32 partition) 
of a 2.5" IDE hard drive which was attached to the IDE bus of a desktop 
box for diagnostics.

  ls -la /mount/point

showed only parts of the root directory of the filesystem, some error 
messages were printed onto the console indicating read errors. For some 
seconds, there was some calm but strange sound created by the computer. 
It seemed that (due to the lousy adapter between IDE bus cable and the 
HD) there was a cable error and thus some blocks could not be read. Some 
seconds later (when there was no strange sound to be listened anymore) I 
tried to verify that communication between HD and host worked fine using 
dd. There were no read erros.

Because I did not want to access that partition, I unmounted the FAT32 
partition and continued to work on another partition.


Unfortunately, booting Windows from this FAT32 partition did not work 
anymore. There were files missing which belong to the root directory. 
Repair tools like "dosfsck" or "chkdsk" did not report any problem or 
possibility to save the contents of the root directory. (Maybe "dosfsck" 
is too destructive...) The only directory entries which were not missing 
were the directory entries which were displayed by the former "ls -la".

The Linux vfat code (2.4.21-pre5) actually cut the directory! (And 
destroyed data.) The partition had been mounted with no special options 
(thus, it was mounted read-write). But there was no write access by some 
user. It seems that the vfat module interpreted non-readable blocks 
belonging to the root directory as non-existent blocks and that the vfat 
module rewrited that cut directory to disk.

Maybe someone enlightened could try to reproduce such a scenario where 
some blocks of the root directory cannot be read. (Error simulation is 
does not seems to be possible without a specially modified kernel.)

Xuân.


