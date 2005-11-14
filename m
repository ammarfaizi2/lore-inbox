Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbVKNFLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbVKNFLi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 00:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbVKNFLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 00:11:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:28574 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750924AbVKNFLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 00:11:37 -0500
From: Neil Brown <neilb@suse.de>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
       dtor_core@ameritech.net, vojtech@suse.cz
Date: Mon, 14 Nov 2005 16:11:27 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17272.7295.464735.805122@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: uinput broken in 2.6.15-rc1
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The 'uinput' driver doesn't work well in 2.6.15-rc1.  It
triggers this complaint:
		printk(KERN_WARNING "input: device %s is statically allocated, will not register\n"
			"Please convert to input_allocate_device() or contact dtor_core@ameritech.net\n",
			dev->name ? dev->name : "<Unknown>");

The following patch fixes it for me, but I'm not convinced it is
correct.  I would expect it to need a special 'free' routine to match
the special 'alloc' routine, but I couldn't easily find one.

NeilBrown

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/input/misc/uinput.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff ./drivers/input/misc/uinput.c~current~ ./drivers/input/misc/uinput.c
--- ./drivers/input/misc/uinput.c~current~	2005-11-14 14:34:56.000000000 +1100
+++ ./drivers/input/misc/uinput.c	2005-11-14 15:17:01.000000000 +1100
@@ -199,10 +199,9 @@ static int uinput_open(struct inode *ino
 	spin_lock_init(&newdev->requests_lock);
 	init_waitqueue_head(&newdev->requests_waitq);
 
-	newinput = kmalloc(sizeof(struct input_dev), GFP_KERNEL);
+	newinput = input_allocate_device();
 	if (!newinput)
 		goto cleanup;
-	memset(newinput, 0, sizeof(struct input_dev));
 
 	newdev->dev = newinput;
 
