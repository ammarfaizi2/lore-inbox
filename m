Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTKRN1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTKRN1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:27:20 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:23746
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262610AbTKRN1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:27:15 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: shoxx@web.de, linux-kernel@vger.kernel.org
Subject: Re: problem with suspend to disk on linux2.6-t9
Date: Tue, 18 Nov 2003 07:18:00 -0600
User-Agent: KMail/1.5
References: <200311172327.24418.shoxx@web.de>
In-Reply-To: <200311172327.24418.shoxx@web.de>
Cc: mochel@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311180718.00059.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 November 2003 16:27, dodger wrote:
> hi
> i am using linux2.6-t9 and i am trying to use suspend to disk
> when doing a
> < echo -n "disk" > /sys/power/state >
>
> it is suspending real fine.
> but it is not resuming at all.
> i tried to boot up normally and with resume=/dev/hdb5 ( swap partition )
> but nothing happens...
>
> it just boots up normally...
> i have set /dev/hdb5 as DEFAULT RESUME PARTITION during kernel config...
>
> any ideas?
> thanks

Did you specify a default resume partition (CONFIG_PM_DISK_PARTITION) in your 
.config?  (Or provide it with the kernel parameter pmdisk=/dev/blah)...

On suspend, it saves to the first mounted swap file.  On resume, it hasn't 
looked at /etc/fstab yet to see where the swap files are by the time it gets 
to resuming, and nobody's bothered to code up any heuristic for what to do 
with no default partition, so you have to point it at a partition or it won't 
attempt to resume.

Personally, I think that 99% of the time you can just iterate through the 
partitions of whatever drive your root device lives on and find the first one 
that's got a valid suspend signature on it, and resume from that.  (And if 
you don't find one, don't resume.)  The few cases where this isn't 
appropriate can configure another default or supply a kernel command line 
paramenter, but having to bake your swap partition location into the kernel 
config is a bit klunky at best...

Of course with lilo, there's a user space alternative, you know.  Your suspend 
script could call lilo -R with a command line that points to the partition 
you're about to suspend to.  But there are a number of problems with that 
(ideally you want to do it right AFTER suspending...)  And I dunno if grub's 
got an equivalent...

One thing that might be nice is if there was a way to trigger a resume from 
the initramfs.  "Blow away the current process list and load this binary 
image of what userspace should look like."  That way figuring out where the 
sucker lives is a problem you could punt on. :)

Rob

