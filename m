Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUHaRLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUHaRLt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUHaRJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:09:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:55972 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264937AbUHaRFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:05:24 -0400
Date: Tue, 31 Aug 2004 10:05:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Tim Fairchild <tim@bcs4me.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: K3b and 2.6.9?
In-Reply-To: <200408312037.00994.tim@bcs4me.com>
Message-ID: <Pine.LNX.4.58.0408310959340.2295@ppc970.osdl.org>
References: <200408301047.06780.tim@bcs4me.com> <200408311151.25854.tim@bcs4me.com>
 <Pine.LNX.4.58.0408301917360.2295@ppc970.osdl.org> <200408312037.00994.tim@bcs4me.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Aug 2004, Tim Fairchild wrote:
> 
> On starting k3b seems to use 'safe for reading' commands and 'safe for 
> writing' command 0x55 (mode_select?) to test the drive function.

Yes. MODE_SELECT is write-only, because that command can do some bad 
things.

> file->f_mode is returning with 0x0d during 'safe for writing' command.

Yes, that's FMODE_READ | FMODE_LSEEK | FMODE_PREAD (ie the device not only 
accepts reading, it can do seeks and "pread()" too). Which is what a block 
device that was opened with O_RDONLY would have.

> I believe FMODE_WRITE is 0x02  tho don't know where that is defined...

Correct. It's a kernel-internal "readability" thing, defined in 
<linux/fs.h> - it's invisible to user space (user space uses the O_RDONLY, 
O_WRONLY and O_RDWR defines, which are in a different numbering space)

> If this bit not set does it mean the device is opened for reading?

Yes, it means that the user used O_RDONLY to open the device.

> during a burn? 

I agree, it doesn't make much sense, does it? But the fact is, it used to 
work, and as a result programs can do it that way because they were tested 
that wat.

Linus' law: programs don't do things because they make sense. Programs do 
things that happened to work for the programmer.

But exactly _because_ it makes so much sense to just change K3b to use
O_RDWR in its open, I'm hoping that the K3b developers won't complain too
much about the kernel changing to require more strict checking (obviously,
I can understand that _users_ will complain - they only see the "it
stopped working" part).

		Linus
