Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264886AbUGGFYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264886AbUGGFYQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 01:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264895AbUGGFYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 01:24:15 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:25823 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S264886AbUGGFYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 01:24:13 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Georgi Georgiev <chutz@gg3.net>
Date: Wed, 7 Jul 2004 15:24:04 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16619.35060.821865.570842@cse.unsw.edu.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: partitionable md devices and partition detection
In-Reply-To: message from Georgi Georgiev on Wednesday July 7
References: <20040707045939.GA20516@ols-dell.iic.hokudai.ac.jp>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday July 7, chutz@gg3.net wrote:
> What is the proper way to detect the partitions on a md device during kernel
> initialization?

Hmm... I guess there isn't.
I remember having a lot of trouble getting partitions to be recognised
when an array is first assembled, and deciding it was just easier to
leave it to user-space.  However that isn't an option when booting
without an initrd.

The following patch should make it work for the
  md=d0,....
case.  The "raid=part" case is a bit harder....

NeilBrown


diff ./init/do_mounts_md.c~current~ ./init/do_mounts_md.c
--- ./init/do_mounts_md.c~current~	2004-07-07 15:20:05.000000000 +1000
+++ ./init/do_mounts_md.c	2004-07-07 15:20:57.000000000 +1000
@@ -232,6 +232,8 @@ static void __init md_setup_drive(void)
 			err = sys_ioctl(fd, RUN_ARRAY, 0);
 		if (err)
 			printk(KERN_WARNING "md: starting md%d failed\n", minor);
+		else
+			sys_ioctl(fd, BLKRRPART, 0);
 		sys_close(fd);
 	}
 }
