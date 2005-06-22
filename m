Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbVFVVDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVFVVDF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 17:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbVFVVC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 17:02:58 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:59017
	"EHLO pinky.shadowen.org") by vger.kernel.org with ESMTP
	id S262279AbVFVVAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 17:00:06 -0400
Date: Wed, 22 Jun 2005 21:59:34 +0100
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: ahc_target_state check starget valid
Message-ID: <20050622205934.GA29435@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Justin I believe that you are the maintainer for the aic7xxx 
driver, could you look this over and if you concur with this
change push it up.]

Since 2.6.12-git1 we have been seeing the Oops below when accessing
/proc files for the aix7xxx driver.  This seems to be as a result of
a new abstraction for scsi targets.  Looking at other uses of the
aic7xxx 'starget[]' seems to indicate that it is possible for this 
to be NULL.  The patch below adds a check to ahc_dump_target_state
before we attempt to map it to a scsi target.

Unable to handle kernel NULL pointer dereference at virtual address 00000124
 printing eip:
c02482dc
*pde = 1b971001
*pte = 00000000
Oops: 0000 [#1]
SMP
CPU:    2
EIP:    0060:[<c02482dc>]    Not tainted VLI
EFLAGS: 00010296   (2.6.12-git4-autokern1)
EIP is at scsi_is_host_device+0x4/0x18
eax: 00000014   ebx: 00000014   ecx: 00000000   edx: e017fb80
esi: 00000000   edi: ddc0b100   ebp: dffe3ef4   esp: dffe3dac
ds: 007b   es: 007b   ss: 0068
Process cp (pid: 6942, threadinfo=dffe2000 task=dcc27a60)
Stack: c026825b 00000014 00000000 dffe3ef4 dfc55600 0000000f 41268703 c02687c9
       dfc55600 dffe3ef4 00000007 00000041 00000000 00000000 dffe3f68 00000c00
       db6aa000 dffe3f64 37636961 3a393938 746c5520 36316172 69572030 43206564
Call Trace:
 [<c026825b>] ahc_dump_target_state+0xa3/0x10c
 [<c02687c9>] ahc_linux_proc_info+0x199/0x1ca
 [<c0141af6>] do_anonymous_page+0x1ee/0x21c
 [<c0141b0e>] do_anonymous_page+0x206/0x21c
 [<c0141b79>] do_no_page+0x55/0x3d8
 [<c0135f15>] prep_new_page+0x49/0x50
 [<c01365a3>] buffered_rmqueue+0x153/0x1b4
 [<c0136a4b>] __alloc_pages+0x3bb/0x3c8
 [<c024ff3b>] proc_scsi_read+0x2b/0x44
 [<c017d5d8>] proc_file_read+0xec/0x200
 [<c01506b5>] vfs_read+0x8d/0xec
 [<c0150924>] sys_read+0x40/0x6c
 [<c0102df9>] syscall_call+0x7/0xb
Code: fd ff 83 c4 04 c3 90 68 20 ce 3a c0 e8 ca 31 fd ff 83 c4 04 c3 89 f6 68 20 ce 3a c0 e8 46 32 fd ff 83 c4 04 c3 89 f6 8b 44 24 04 <81> b8 10 01 00 00 80 7d 24 c0 0f 94 c0 0f b6 c0 c3 8d 76 00 8b
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000124 printing eip:
c02482dc
*pde = 1ff59001
*pte = 00000000

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 aic7xxx_proc.c |    2 ++
 1 files changed, 2 insertions(+)
diff -upN reference/drivers/scsi/aic7xxx/aic7xxx_proc.c current/drivers/scsi/aic7xxx/aic7xxx_proc.c
--- reference/drivers/scsi/aic7xxx/aic7xxx_proc.c
+++ current/drivers/scsi/aic7xxx/aic7xxx_proc.c
@@ -155,6 +155,8 @@ ahc_dump_target_state(struct ahc_softc *
 	copy_info(info, "\tUser: ");
 	ahc_format_transinfo(info, &tinfo->user);
 	starget = ahc->platform_data->starget[target_offset];
+	if (starget == NULL)
+		return;
 	targ = scsi_transport_target_data(starget);
 	if (targ == NULL)
 		return;
