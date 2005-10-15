Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbVJOV3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVJOV3L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 17:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVJOV3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 17:29:11 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:22752 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S1751222AbVJOV3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 17:29:10 -0400
Date: Sat, 15 Oct 2005 23:29:12 +0200
To: linux-kernel@vger.kernel.org
Subject: uinput crash and fix
Message-ID: <20051015212911.GA25752@tink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: emard@softhome.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI

During some begginer's fiddling with uinput it
wasn't too difficult to obtain a hard kernel freeze:

CPU:    1
EIP:    0060:[<f90310ff>]    Tainted: P      VLI
EFLAGS: 00210246   (2.6.13.4)
EIP is at uinput_request_done+0x14/0x3e [uinput]
eax: e2d72000   ebx: e2d73ea4   ecx: ea9e7020   edx: c17efa80
esi: dcbf8400   edi: 400c55cb   ebp: dcbf8400   esp: c47bdee0
ds: 007b   es: 007b   ss: 0068
Process ifeel (pid: 10855, threadinfo=c47bc000 task=dcb2e520)
Stack: c4b45980 b7f3c3b4 f9031db7 dcbf8400 e2d73ea4 0000000c 00000001 00000000
       00000000 00000003 00200002 da41e00c 00200202 00000021 00200002 c02ed08d
       00000000 d9bcabec 00200202 c02edf2f da41e00c 00000002 00000000 00000000
Call Trace:
 [<f9031db7>] uinput_ioctl+0x2fa/0x49b [uinput]
 [<c02ed08d>] tty_ldisc_deref+0x48/0x71
 [<c02edf2f>] tty_write+0x1cc/0x21e
 [<c0170688>] do_ioctl+0x78/0x81
 [<c0170813>] vfs_ioctl+0x5a/0x1f1
 [<c01709e6>] sys_ioctl+0x3c/0x5a
 [<c0102e39>] syscall_call+0x7/0xb
Code: 8b 54 24 08 31 c0 83 fa 0f 77 0b 8b 44 24 04 8b 84 90 1c 01 00 00 c3 56 53 8b 74 24 0c 8b 5c 24 10 8d 43 0c e8 26 a7 0e c7 8b 03 <c7> 84 86 1c 01 00 00 00 00 00 00 8d 86 5c 01 00 00 c7 44 24 0c

and I think this patch fixes this:

--- linux-2.6.13.4/drivers/input/misc/uinput.c.orig	2005-10-15 10:09:38.000000000 +0200
+++ linux-2.6.13.4/drivers/input/misc/uinput.c	2005-10-15 10:19:54.000000000 +0200
@@ -517,7 +517,11 @@ static int uinput_ioctl(struct inode *in
 				break;
 			}
 			req = uinput_request_find(udev, ff_up.request_id);
-			if (!(req && req->code == UI_FF_UPLOAD && req->u.effect)) {
+			if (!req) {
+				retval = -EINVAL;
+				break;
+			}
+			if (!(req->code == UI_FF_UPLOAD && req->u.effect)) {
 				retval = -EINVAL;
 				break;
 			}
@@ -535,7 +539,11 @@ static int uinput_ioctl(struct inode *in
 				break;
 			}
 			req = uinput_request_find(udev, ff_erase.request_id);
-			if (!(req && req->code == UI_FF_ERASE)) {
+			if (!req) {
+				retval = -EINVAL;
+				break;
+			}
+			if (!(req->code == UI_FF_ERASE)) {
 				retval = -EINVAL;
 				break;
 			}
@@ -553,7 +561,11 @@ static int uinput_ioctl(struct inode *in
 				break;
 			}
 			req = uinput_request_find(udev, ff_up.request_id);
-			if (!(req && req->code == UI_FF_UPLOAD && req->u.effect)) {
+			if (!req) {
+				retval = -EINVAL;
+				break;
+			}
+			if (!(req->code == UI_FF_UPLOAD && req->u.effect)) {
 				retval = -EINVAL;
 				break;
 			}
@@ -568,7 +580,11 @@ static int uinput_ioctl(struct inode *in
 				break;
 			}
 			req = uinput_request_find(udev, ff_erase.request_id);
-			if (!(req && req->code == UI_FF_ERASE)) {
+			if (!req) {
+				retval = -EINVAL;
+				break;
+			}
+			if (!(req->code == UI_FF_ERASE)) {
 				retval = -EINVAL;
 				break;
 			}
