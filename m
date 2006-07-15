Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161140AbWGOHF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbWGOHF2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 03:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWGOHF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 03:05:28 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:1469 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1161140AbWGOHF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 03:05:27 -0400
Subject: [patch] lockdep: annotate pktcdvd natural device hierarchy
From: Arjan van de Ven <arjan@linux.intel.com>
To: Peter Osterlund <petero2@telia.com>
Cc: mingo@elte.hu, akpm@osdl.org, Laurent Riffard <laurent.riffard@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>, axboe@suse.de
In-Reply-To: <m3odvrc2vo.fsf@telia.com>
References: <448875D1.5080905@free.fr> <448D84C0.1070400@linux.intel.com>
	 <m3sllxtfbf.fsf@telia.com> <1151000451.3120.56.camel@laptopd505.fenrus.org>
	 <m3u05kqvla.fsf@telia.com> <1152884770.3159.37.camel@laptopd505.fenrus.org>
	 <m3odvrc2vo.fsf@telia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 15 Jul 2006 09:04:58 +0200
Message-Id: <1152947098.3114.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So the claim from the lockdep code, "BUG: possible circular locking
> deadlock detected!", is a false alarm.

ok this patch ought to kill the false positive:


the pkt_*_dev functions operate on not-this-blockdevice, and that is
sufficiently checked at setup time. As a result there is a natural
hierarchy, which needs nesting annotations

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Index: linux-2.6.18-rc1/drivers/block/pktcdvd.c
===================================================================
--- linux-2.6.18-rc1.orig/drivers/block/pktcdvd.c
+++ linux-2.6.18-rc1/drivers/block/pktcdvd.c
@@ -2577,19 +2577,19 @@ static int pkt_ctl_ioctl(struct inode *i
 	case PKT_CTRL_CMD_SETUP:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		mutex_lock(&ctl_mutex);
+		mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
 		ret = pkt_setup_dev(&ctrl_cmd);
 		mutex_unlock(&ctl_mutex);
 		break;
 	case PKT_CTRL_CMD_TEARDOWN:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		mutex_lock(&ctl_mutex);
+		mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
 		ret = pkt_remove_dev(&ctrl_cmd);
 		mutex_unlock(&ctl_mutex);
 		break;
 	case PKT_CTRL_CMD_STATUS:
-		mutex_lock(&ctl_mutex);
+		mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
 		pkt_get_status(&ctrl_cmd);
 		mutex_unlock(&ctl_mutex);
 		break;

