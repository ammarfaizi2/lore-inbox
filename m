Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWELHLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWELHLj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 03:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWELHLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 03:11:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:14798 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750990AbWELHLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 03:11:38 -0400
From: Neil Brown <neilb@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Date: Fri, 12 May 2006 17:11:11 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17508.13583.730399.209905@cse.unsw.edu.au>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4 md lock held at task exit
In-Reply-To: message from Keith Owens on Friday May 12
References: <7819.1147416227@kao2.melbourne.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday May 12, kaos@ocs.com.au wrote:
> Doing poweroff on 2.6.17-rc4 i386, SMP
> 
> BUG halt/4781, lock held at task exit time!
>  [f7001b34] {mddev_find}
> .. held by: halt: 4781 [f7cd4030, 118]
> ... acquired at: md_notify_reboot+0x3a/0xa9 [md_mod}
> 

I suspect this will fix it.
Is it repeatable?  Can you test?

Thanks,
NeilBrown


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-05-12 16:00:03.000000000 +1000
+++ ./drivers/md/md.c	2006-05-12 17:10:16.000000000 +1000
@@ -5171,8 +5171,10 @@ static int md_notify_reboot(struct notif
 		printk(KERN_INFO "md: stopping all md devices.\n");
 
 		ITERATE_MDDEV(mddev,tmp)
-			if (mddev_trylock(mddev))
+			if (mddev_trylock(mddev)) {
 				do_md_stop (mddev, 1);
+				mddev_unlock(mddev);
+			}
 		/*
 		 * certain more exotic SCSI devices are known to be
 		 * volatile wrt too early system reboots. While the
