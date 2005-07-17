Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVGQGl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVGQGl4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 02:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVGQGl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 02:41:56 -0400
Received: from NS6.Sony.CO.JP ([137.153.0.32]:60570 "EHLO ns6.sony.co.jp")
	by vger.kernel.org with ESMTP id S261947AbVGQGlz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 02:41:55 -0400
Message-ID: <42D9FDAC.3010109@sm.sony.co.jp>
Date: Sun, 17 Jul 2005 15:41:48 +0900
From: Hiroyuki Machida <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFD] FAT robustness
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Folks,

I'd like to have a discussion about FAT robustness.
Please give your thought, comments and related issues.

About few years ago, we added some features to FAT, called xvfat,
so that System and FAT have robustness against unexpected media hot
unplug and ability to let applications correctly be aware the event.

Just for your reference, I put a patch to 2.4.20 kernel at
http://www.celinuxforum.org/CelfPubWiki/XvFatDiscussion?action=AttachFile&do=get&target=20050715-xvfat-2.4.20.patch
This includes following features;

	Handle media removed during “mount”
		Notification of media removal to application
		Cancellation of I/O Elevator for Block device
		Block system calls until a completion of writing
		Control order of meta-data updates, using transaction	
			control implemented in fs/xvfat/fwrq.c
		File syscall return “error”, except umount
	Japanese file name support
		possible 1-N mapping issues SJIS <-> UNICODE
	Dirty Flag support
	TIME ZONE support

On moving to 2.6, we consider and categorize issues, again.
And we are planing to have open source project for these features
to add 2.6 kernel.  I'd like to open discussion about these features
and how to implement on 2.6 kernel.

1. Issues to be addressed

- Issues around FAT with CE devices
  - Hot unplug issues
	- File System corruption on unplug  media/storage device
		Almost same as power down without umount

	- Notification of the event
		Application need to know the event precisely
		Need to more investigation

	- System stability after unplug
		Almost same as I/O error recovery issues discussed
		at LKLM
http://developer.osdl.jp/projects/doubt/fs-consistency-and-coherency/index.html

http://groups.google.co.jp/group/linux.kernel/browse_thread/thread/b9c11bccd59e0513/4a4dd84b411c6d32?q=[RFD]+FS+behavior+(I%2FO+failure)+in+kernel+summit++lkml&rnum=1&hl=ja#4a4dd84b411c6d32


  - Other issues
	- Time stamp issues
		using always local time
		time resolution is 2sec unit

	- Issues around mapping with UNICODE and local char code
		1-N mapping SJIS<-> UNICODE
		Potential directory cache problem due to 1 –N mapping
		Possible inconsistency problems with application side

	- Support file size over 2GB

	- Support dirty flag

  Q1 : First issue for discussion is "Do you have any other issues
	about this?" and "Do you have any other idea to categorize
	the issues?"


2.  FAT corruption on unplug  media/storage device

On starting the open source project, we focus to the following issue,
 first.
	- File System corruption on unplug  media/storage device
		Almost same as power down without umount

And, we are planing to focus on HDD device and treat system power down
instead of unplug media, because
  A. Damages and it's counter methods may depend on property of lower
     layer
	E.g.
	  - Memory Card
		Some controller can guaranty atomicity of certain
		operations
	  - Flush Memory (NAND, NOR)
		I/O operations may be constrained by Block Size
		(e,g, 128KB) or Page Size (e.g. 2KB)
	 - HDD
		- Cache memory my resident inside in
		- Sector which is under writing 
		on power down may be corrupted(can't read anymore)

  B.  It may make the problem easier
	- Sector size is 512 Byte
	- Many developers may check with PC

  Q2 : Do you know any other storage devices and it's property, to 
	be address later?

3. Features to be developed for FAT corruption.

We currently plan to add following features to address FAT corruption.

    - Utilize standard 2.6 features as much as possible
	- Implement as options of fat, vfat and uvfat
	- Utilize existent journal block device (JBD) for transaction control
	- Utilize noop elevator to cancel unexpected operation
	 reordering
    - Coordinate order of operations so that update data first, meta
	 data later with transaction control
    - With O_SYNC, close() make flush all related data and
	 meta-data, then wait completion of I/O

 
  Q3 : I'm not sure JBD can be used for FAT improvements. 
       Do you have any comments ?


Thanks,
Hiroyuki Machida



