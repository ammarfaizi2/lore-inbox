Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVAATjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVAATjv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 14:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVAATjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 14:39:51 -0500
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:18602 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261167AbVAATjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 14:39:49 -0500
Message-ID: <41D6FCB2.5070507@myrealbox.com>
Date: Sat, 01 Jan 2005 11:40:34 -0800
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: the umount() saga for regular linux desktop users
References: <200412311741.02864.wh@designed4u.net> <20041231175051.GD2818@pclin040.win.tue.nl>
In-Reply-To: <20041231175051.GD2818@pclin040.win.tue.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> On Fri, Dec 31, 2004 at 05:41:02PM +0000, William wrote:
> 
> 
>>Regularly, when attempting to umount() a filesystem I receive 'device is busy' 
>>errors. The only way (that I have found) to solve these problems is to go on 
>>a journey into processland and kill all the guilty ones that have tied 
>>themselves to the filesystem concerned.
> 
> 
> Do you know about the existence of the MNT_DETACH flag of umount(2),
> or the -l option of umount(8)?
> 
> It seems that does at least some of the things you are asking for.


I have this complaint too, and MNT_DETACH doesn't really do it. 
Sometimes I want to "unmount cleanly, damnit, and I don't care if 
applications that are currently accessing it lose data."  Windows can do 
this, and it's _useful_.

<rant>
I think part of the nastiness is that mount now means too things:
1) Read the superblock, fire up the fs, etc.
2) Shove the thing into the namespace.

The fact that the current mount/umount interface papers over the 
distinction is at least confusing.  It made sense before there were bind 
mounts.  Now, for example, mount /dev/hda2 /mnt/whatever does something 
_different_ depending on whether hda2 is already mounted.  And the mount 
options will be silently ignored sometimes.  Then, I can MNT_DETACH 
something to separate it from the namespace, but I can't force it to 
actually shut down the fs.  There is no interface for it.

Shouldn't these be separate syscalls with separate parameters?  For 
example, ro applied to the fs should mean "don't touch the device" and 
ro applied to the view in the namespace should mean "don't write to this 
view."
</rant>
