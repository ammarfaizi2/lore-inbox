Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWEWF6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWEWF6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 01:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWEWF6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 01:58:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:28614 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932082AbWEWF6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 01:58:52 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Neil Brown <neilb@suse.de>
cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4 md lock held at task exit 
In-reply-to: Your message of "Fri, 12 May 2006 17:11:11 +1000."
             <17508.13583.730399.209905@cse.unsw.edu.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 May 2006 15:56:47 +1000
Message-ID: <9193.1148363807@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown (on Fri, 12 May 2006 17:11:11 +1000) wrote:
>On Friday May 12, kaos@ocs.com.au wrote:
>> Doing poweroff on 2.6.17-rc4 i386, SMP
>> 
>> BUG halt/4781, lock held at task exit time!
>>  [f7001b34] {mddev_find}
>> .. held by: halt: 4781 [f7cd4030, 118]
>> ... acquired at: md_notify_reboot+0x3a/0xa9 [md_mod}
>> 
>
>I suspect this will fix it.
>Is it repeatable?  Can you test?
>
>Thanks,
>NeilBrown
>
>
>Signed-off-by: Neil Brown <neilb@suse.de>
>
>### Diffstat output
> ./drivers/md/md.c |    4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff ./drivers/md/md.c~current~ ./drivers/md/md.c
>--- ./drivers/md/md.c~current~	2006-05-12 16:00:03.000000000 +1000
>+++ ./drivers/md/md.c	2006-05-12 17:10:16.000000000 +1000
>@@ -5171,8 +5171,10 @@ static int md_notify_reboot(struct notif
> 		printk(KERN_INFO "md: stopping all md devices.\n");
> 
> 		ITERATE_MDDEV(mddev,tmp)
>-			if (mddev_trylock(mddev))
>+			if (mddev_trylock(mddev)) {
> 				do_md_stop (mddev, 1);
>+				mddev_unlock(mddev);
>+			}
> 		/*
> 		 * certain more exotic SCSI devices are known to be
> 		 * volatile wrt too early system reboots. While the

Finally got some time to test this.  The problem was reproducable and
the patch fixed it.

Acked-by: Keith Owens <kaos@ocs.com.au>

