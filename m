Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWGLVD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWGLVD7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWGLVD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:03:59 -0400
Received: from ns2.g-housing.de ([81.169.133.75]:1973 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S932230AbWGLVD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:03:58 -0400
Date: Wed, 12 Jul 2006 22:01:23 +0100 (BST)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: evil@vaio.testbed.de
To: kay.sievers@suse.de
cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [x86_64] strange delays since 2.6.15 (was: Re: ohci1394: aborting
 transmission)
In-Reply-To: <Pine.NEB.4.64.0607121247410.2796@vaio.testbed.de>
Message-ID: <Pine.NEB.4.64.0607122134150.3497@vaio.testbed.de>
References: <Pine.LNX.4.64.0607100527200.10447@sheep.housecafe.de>
 <44B203F4.1030903@s5r6.in-berlin.de> <Pine.LNX.4.64.0607100852390.13858@sheep.housecafe.de>
 <44B253CE.3030308@s5r6.in-berlin.de> <Pine.NEB.4.64.0607121247410.2796@vaio.testbed.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I am still having these strange boot-delays which I reported in [0] when 
I was under the assumption that ohci1394 was to blame, simply because 
"ohci1394: aborting transmission" was the last message before the 
3minute delay during bootup happened. I've found out that the actual 
problem started way earlier (2.6.14->2.6.15) and I have bisected my way 
down to this patchset:

a7fd67062efc5b0fc9a61368c607fa92d1d57f9e is first bad commit
diff-tree a7fd67062efc5b0fc9a61368c607fa92d1d57f9e (from 
d8539d81aeee4dbdc0624a798321e822fb2df7ae)
Author: Kay Sievers <kay.sievers@suse.de>
Date:   Sat Oct 1 14:49:43 2005 +0200

     [PATCH] add sysfs attr to re-emit device hotplug event

     A "coldplug + udevstart" can be simple like this:
       for i in /sys/block/*/*/uevent; do echo 1 > $i; done
       for i in /sys/class/*/*/uevent; do echo 1 > $i; done
       for i in /sys/bus/*/devices/*/uevent; do echo 1 > $i; done

     Signed-off-by: Kay Sievers <kay.sievers@suse.de>
     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

:040000 040000 7edb92ad6f55113bac2e1919e6b2364e17dfaa0b 43b3108675db828a2ce7df87f08a26aa7d7ac0fc M      drivers
:040000 040000 382f692398a9fe4bea4ab5333dea67f8151b0b82 58bb09d0051236695e6987f12e389ce75387ddf7 M      fs
:040000 040000 72bcc7fddd5087cadf70b9d2582c7faea7ebb364 2ec812818920645cb58f1694818019516ea6e3b6 M      include

Wtihout this patch, booting is fine, no delays. With this patchset, I 
notice a 3 minute delay.

However, as the patch-description tells me, it only introduces something 
in /sys/..../*/uevent and the delay is in fact triggered by userspace!
My distribution of choice (Ubuntu/6.06 LTS) does "something" in /sys 
during execution of /etc/init.d/udev (from: udev-079-0ubuntu34). Please 
see this url for details, logs, .config and more:

http://nerdbynature.de/bits/2.6.15/

Many thanks for hints on what to do here. This issue is 100% 
reproducible and is kinda annoying now that I happen to be on-site when 
the machine boots up. As mentioned earlier I had no access to the box 
for a few months and did not pay attention to the boot-process and did 
not track -current too, that's why I'm whining about 2.6.15-problems 
when we're actually at 2.6.18-* already....

Thanks,
Christian.

[0] http://www.ussg.iu.edu/hypermail/linux/kernel/0607.1/1708.html
-- 
BOFH excuse #156:

Zombie processes haunting the computer
