Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272690AbTG1HB3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 03:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272689AbTG1HAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 03:00:07 -0400
Received: from f12.mail.ru ([194.67.57.42]:37638 "EHLO f12.mail.ru")
	by vger.kernel.org with ESMTP id S272687AbTG1G6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 02:58:24 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Andrew Morton=?koi8-r?Q?=22=20?= <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       =?koi8-r?Q?=22?=Daniele Venzano=?koi8-r?Q?=22=20?= 
	<webvenza@libero.it>
Subject: Re: 2.6.0-test1 devfs question
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Mon, 28 Jul 2003 11:13:38 +0400
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19h2CQ-0009YQ-00.arvidjaar-mail-ru@f12.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> The patch is broken - 2.4 does /dev/md/2 as well.
> 
> So what is the bug?  Why are people suddenly having problems with this?
> 

Daniele did some debugging, result is:

=================
Buggy config
------------
GRUB command line: kernel (hd0,1)/testing root=/dev/md2
video=radeonfb:1024x768-32@60
As output there is only (copied by hand):

[...]

raid1: raid set md2 active with 2 out of 2 mirrors
md: ... autorun DONE.
create_dev: name=/dev/root dev=902 dname=md2
VFS: cannot open root device "md2" or md2
please append a correct "root=" boot option
Kernel panic: VFS: unable to mount root fs on md2
<STOP>
==================

the bug is almost for sure in init/do_mount_devfs.c:read_dir; it
allocates static buffer of size at most 2**MAX_ORDER and tries to
read the whole dir at once. md driver creates all minors in md_init
i.e. 256 (2**MINORBITS). MAX_ORDER default is 11 so we have at most
2K which is enough for appr. 200 entries; 256 do not fit :)

Daniel, please, could you change read_dir to just allocate bigger
buffer - 4K should do - and test once more?

I'll see what can be done. Anyone sees reason why normal directory
scan won't work here?

-andrey 

