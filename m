Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265155AbTLROVw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 09:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265176AbTLROVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 09:21:52 -0500
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:5818 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP id S265155AbTLROVs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 09:21:48 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Trivial hard lockup, SCSI, 2.4.23
References: <Pine.LNX.4.44.0312181153080.4547-100000@logos.cnet>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Thu, 18 Dec 2003 09:21:42 -0500
In-Reply-To: <Pine.LNX.4.44.0312181153080.4547-100000@logos.cnet> (Marcelo
 Tosatti's message of "Thu, 18 Dec 2003 11:53:20 -0200 (BRST)")
Message-ID: <9cf65gei4uh.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:

> On Tue, 16 Dec 2003, Ian Soboroff wrote:
>
>> 
>> I've found that I can lock a machine running 2.4.23aa1 by trying to
>> access a nonexistent SCSI device.  In other words, if a userspace
>> program tries to access /dev/sdd, but no device is attached on any
>> SCSI bus using that device node, the machine locks hard.
>> 
>> We found this when we disconnected a SCSI hardware RAID from a server,
>> but forgot to remove the cron job which checked its status.
>> 
>> The lockup leaves no errors whatsoever in the logs.  I finally tracked
>> it down with the NMI watchdog.
>
> What did the NMI oopser report ? 

It didn't get logged, so I don't have the full trace, but I remember
that it indicated a program we run called raidm, which checks the
status of our RAIDs periodically.  We'd forgotten to gun the instance
which was watching the RAID we disconnected.

Running raidm on a connected RAID, I can see that it opens the device
and sends some ioctls:

...
stat64("/dev/sda1", {st_mode=S_IFBLK|0660, st_rdev=makedev(8, 1), ...}) = 0
open("/dev/sda1", O_RDONLY)             = 3
ioctl(3, FIBMAP, 0xbfff4840)            = 0
ioctl(3, FIBMAP, 0xbfff4840)            = 0
ioctl(3, FIBMAP, 0xbfff4910)            = 134217730
ioctl(3, FIBMAP, 0xbfff4910)            = 134217730
ioctl(3, FIBMAP, 0xbfff4910)            = 134217730
ioctl(3, FIBMAP, 0xbfff4910)            = 134217730
ioctl(3, FIBMAP, 0xbfff4910)            = 134217730
ioctl(3, FIBMAP, 0xbfff4910)            = 134217730
time(NULL)                              = 1071757056
open("/var/log/raidm.log", O_WRONLY|O_APPEND|O_CREAT, 0666) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=5049303, ...}) = 0
...

I can't afford to kill the machine again, otherwise I'd trigger the
oops again.  Shouldn't scsi or aic7xxx not let me open(2) the device
if nothing's attached?

Ian

