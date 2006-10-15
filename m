Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbWJOVMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWJOVMH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 17:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbWJOVMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 17:12:06 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:11857 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030289AbWJOVME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 17:12:04 -0400
Message-ID: <df1ef2450610151412m3ed1570pffc0e26ebab0b874@mail.gmail.com>
Date: Sun, 15 Oct 2006 17:12:03 -0400
From: "Andrew Moise" <chops@demiurgestudios.com>
To: linux-kernel@vger.kernel.org
Subject: Frequent RESETs with 2.6.16 megaraid_sas
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I'm running a 2.6.16 kernel (Debian 2.6.16-18) on a Dell PE 2950,
and I used to get frequent warnings like this under heavy write load:

Oct  2 14:36:01 localhost kernel: sd 0:2:1:0: megasas: RESET -55455 cmd=2a
Oct  2 14:36:01 localhost kernel: megasas: reset successful
Oct  2 14:36:31 localhost kernel: sd 0:2:1:0: megasas: RESET -70369 cmd=2a
Oct  2 14:36:31 localhost kernel: megasas: reset successful
Oct  2 14:37:02 localhost kernel: sd 0:2:1:0: megasas: RESET -83487 cmd=2a
Oct  2 14:37:02 localhost kernel: megasas: reset successful
Oct  2 14:37:32 localhost kernel: sd 0:2:1:0: megasas: RESET -95079 cmd=2a
Oct  2 14:37:32 localhost kernel: megasas: reset successful
Oct  2 14:38:02 localhost kernel: sd 0:2:1:0: megasas: RESET -105361 cmd=2a
Oct  2 14:38:02 localhost kernel: megasas: reset successful
Oct  2 14:38:33 localhost kernel: sd 0:2:1:0: megasas: RESET -115613 cmd=2a
Oct  2 14:38:33 localhost kernel: megasas: reset successful
Oct  2 14:38:33 localhost kernel: sd 0:2:1:0: SCSI error: return code= 0x6000000
Oct  2 14:38:33 localhost kernel: end_request: I/O error, dev sdb,
sector 2927091007
Oct  2 14:38:33 localhost kernel: Buffer I/O error on device sdb1,
logical block 731772736
Oct  2 14:38:33 localhost kernel: lost page write due to I/O error on sdb1
Oct  2 14:39:03 localhost kernel: sd 0:2:1:0: megasas: RESET -125667 cmd=2a
Oct  2 14:39:03 localhost kernel: megasas: reset successful
Oct  2 14:39:33 localhost kernel: sd 0:2:1:0: megasas: RESET -135588 cmd=2a
Oct  2 14:39:33 localhost kernel: megasas: [ 0]waiting for 1 commands
to complete
Oct  2 14:39:34 localhost kernel: megasas: reset successful

  I saw in some posting that someone with this problem had worked
around it by reducing BLKDEV_MAX_RQ to 8.  I did that, and it's been
working well for me for some weeks, but I happened to notice the
following in a recent megaraid patch:

--- linux-2.6.16-2.6.16/drivers/scsi/megaraid/megaraid_sas.c
2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.19-rc2drivers/scsi/megaraid/megaraid_sas.c
2006-10-13 12:25:04.000000000 -0400

@@ -1716,6 +1823,12 @@
         * Get various operational parameters from status register
         */
        instance->max_fw_cmds =
instance->instancet->read_fw_status_reg(reg_set) & 0x00FFFF;
+       /*
+        * Reduce the max supported cmds by 1. This is to ensure that the
+        * reply_q_sz (1 more than the max cmd that driver may send)
+        * does not exceed max cmds that the FW can support
+        */
+       instance->max_fw_cmds = instance->max_fw_cmds-1;
        instance->max_num_sge =
(instance->instancet->read_fw_status_reg(reg_set) & 0xFF0000) >>
                                        0x10;
        /*

  I'd prefer to stick with an older, distro-supported kernel, and I'd
also like to avoid importing big recent changes to the megaraid driver
into my production server :-).  However, it looks to me like this one
line might be the right fix for the problem that the BLKDEV_MAX_RQ
hack is a workaround for.  I'm considering applying it during downtime
in the near future and seeing how it works out.
  Would anyone knowledgeable care to comment on the wisdom of this
approach?  I won't hold you responsible if my filesystem explodes :-).
 I'm just not familiar enough with storage drivers to know if what I'm
considering doing makes sense.
  Cheers.  Please CC any replies to me, as I'm not on the list.  Thanks.
