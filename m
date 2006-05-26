Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWEZTgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWEZTgE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 15:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWEZTgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 15:36:04 -0400
Received: from cpe-70-113-23-186.austin.res.rr.com ([70.113.23.186]:63442 "EHLO
	kinison.puremagic.com") by vger.kernel.org with ESMTP
	id S1751315AbWEZTgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 15:36:02 -0400
Date: Fri, 26 May 2006 14:35:48 -0500 (CDT)
From: Evan Harris <eharris@puremagic.com>
To: Alasdair G Kergon <agk@redhat.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ext3-fs transient corruption with devmapper over md raid, kernel
 2.6.16.14
In-Reply-To: <20060523221547.GA1002@agk.surrey.redhat.com>
Message-ID: <Pine.LNX.4.62.0605261425160.19083@kinison.puremagic.com>
References: <Pine.LNX.4.62.0605231225450.11814@kinison.puremagic.com>
 <20060523221547.GA1002@agk.surrey.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Luckily the filesystem had no important data on it yet, so I have been 
testing various changes.

First I changed the mount from ext3 to plain ext2, and that eventually 
produced a series of errors like this:

May 24 03:15:18 localhost kernel: init_special_inode: bogus i_mode (2640)
May 24 03:15:29 localhost kernel: init_special_inode: bogus i_mode (175015)
May 24 03:15:29 localhost kernel: init_special_inode: bogus i_mode (11)
May 24 03:15:29 localhost kernel: init_special_inode: bogus i_mode (161265)
May 24 03:15:29 localhost kernel: init_special_inode: bogus i_mode (0)
May 24 03:15:29 localhost kernel: attempt to access beyond end of device
May 24 03:15:29 localhost kernel: dm-0: rw=0, want=8341843240, limit=2930302464
May 24 03:15:30 localhost kernel: attempt to access beyond end of device
May 24 03:15:30 localhost kernel: dm-0: rw=0, want=9187258480, limit=2930302464
May 24 03:15:30 localhost kernel: attempt to access beyond end of device
May 24 03:15:30 localhost kernel: dm-0: rw=0, want=9184366040, limit=2930302464
May 24 03:15:30 localhost kernel: attempt to access beyond end of device
May 24 03:15:30 localhost kernel: dm-0: rw=0, want=9182932112, limit=2930302464
May 24 03:15:30 localhost kernel: attempt to access beyond end of device
May 24 03:15:30 localhost kernel: dm-0: rw=0, want=8994978168, limit=2930302464
May 24 03:15:30 localhost kernel: attempt to access beyond end of device
May 24 03:15:30 localhost kernel: dm-0: rw=0, want=9187258480, limit=2930302464
May 24 03:15:30 localhost kernel: attempt to access beyond end of device

Then I tried changing from dm-crypt to dm-linear and have not been able to 
reproduce the problem using dm-linear.  Unfortunately, the test conditions 
are not exactly the same because using the dm-crypt module completely pegs 
the cpu, while using the linear module is disk-bound not io-bound and the 
cpu utilization is MUCH lower.

However, this leads me to suspect that the problem is either in dm-crypt, or 
a data corruption problem resulting from a decrypt error from the aes_x86_64 
module that dm-crypt is using.

One thing I forgot to mention before is this is on a dual-core box.  Just in 
case the problem may be related to SMP, I'm planning to try recompiling for 
a non-SMP kernel and go back to using dm-crypt and see if I can still 
produce the error that way.

If anyone has variations that would be more useful, I can try to test those 
first.

Evan


On Tue, 23 May 2006, Alasdair G Kergon wrote:

> On Tue, May 23, 2006 at 01:26:32PM -0500, Evan Harris wrote:
>> I just recently upgraded a machine to use devmapper for an encrypted
>> filesystem on top of a software raid5 array.  System is running a
>> stock 2.6.16.14 kernel with no additional patches.
>
>> Happy to provide any further info that may be useful.
>
> This might not be practical for you, but what we're looking for
> is people who can reproduce this on a test system where they can
> try varying things one-at-a-time.  For example, replace dm-crypt
> with dm-linear (e.g. a standard unencrypted LVM2 logical volume);
> replace raid5 with (md) linear.  Also test with the latest
> development kernels to see if recent md patches fixed the problem.
>
> Alasdair
> -- 
> agk@redhat.com
