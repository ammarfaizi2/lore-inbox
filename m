Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264064AbTKSNUV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 08:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbTKSNUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 08:20:21 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:58895 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264064AbTKSNUL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 08:20:11 -0500
Message-ID: <3FBB7075.7060406@aitel.hist.no>
Date: Wed, 19 Nov 2003 14:30:29 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031010 Debian/1.4-6
X-Accept-Language: no, en
MIME-Version: 1.0
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Missing /dev/pts?
References: <20031119125533.GN3351@rdlg.net>
In-Reply-To: <20031119125533.GN3351@rdlg.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert L. Harris wrote:
> 
>   Had to rebuild a machine due to a dead deathstar.  It's 99% there at
> this point I think except I can't log in via xterm, eterm or ssh.
> Poking around, the most obvious factor is that /dev/pts is empty.
> 
> I can see that /dev and /dev/pts mounted by using "df -k /dev /dev/pts"
> which returns:
> 
> Filesystem	1K-blocks	Used	Available	Use%	Mounted on
> -		0		0	0		-	/dev
> devpts		0		0	0		-	/dev/pts
> 
> whish is identicle to the machine I'm currently logged into and is
> working fine.  /dev and /dev/pts are both compiled into the kernel and
> are reported by "cat /proc/filesystms".  Devfsd is up and running with a
> command line of "/sbin/devfsd /dev".
> 
> Anyone have any idea why this is malfunctioning?

Both devfs and devpts can be troublesome in several ways.
First, the obvious: Make sure you didn't mount devpts on
/dev/pts first and then devfs on /dev later.  That will hide
the devpts mount completely.  (Assuming there is a pts
directory in /dev before devfs gets mounted.  Many people
haven't actually removed anything from the oldfashioned /dev
after installing devfs because it isn't necessary.)

You don't say what kernel version you're using.  In 2.6, this
problem exists when using devfs+devpts:

Devfs documentation claims there is a problem using devpts
with devfs.  The same docs also claim that you don't need devpts
because devfs does the same job and does it without those problems.
This used to be true.  Devfs is becoming obsolete though,
and someone did a "cleanup" patch that removed the pts support from
devfs, forcing everybody to use devpts wether they use devfs or not.
Unfortunately, the bad devfs/devpts interactions remained.  I recently
got rid of devfs for this reason, I got tired of xterms that
1. didn't appear, often crashing the x server instead
2. appeared after 20 -60 seconds or so.  And then I got lots because
   I clicked the xterm menu over and over. :-(

This doesn't work, and won't likely be fixed ever now that
devfs is being obsoleted.  I recommend going back to
oldfashioned /dev with plain device nodes while waiting
for the udev stuff to become useable.

Udev will probably achieve many of the same goals as devfs, such as:
1. showing device nodes only for those devices that actually have a driver
   in the running kernel, avoiding clutter and wondering which cdrom driver
   is the "right" one.
2. showing a device node for every driver in the kernel, no need to 
   remember to use MAKEDEV or even mknod just because you got some
   experimental hardware that your distro vendor hasn't heard about yet.

Udev will probably not get rid of the silly major/minor numbers though.
The devfs approach didn't really need them, now they are being extended
instead.  At least we won't ever have to look them up and type them in if
udev gets going. :-/

Helge Hafting

