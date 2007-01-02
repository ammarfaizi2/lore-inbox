Return-Path: <linux-kernel-owner+w=401wt.eu-S1755025AbXABQwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025AbXABQwi (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 11:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755287AbXABQwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 11:52:38 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:34056 "EHLO
	mail.holtmann.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025AbXABQwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 11:52:37 -0500
Subject: Re: [Bluez-devel] regression: bluetooth oopses because of multiple
	kobject_add()
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Cc: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       gregkh@elf.ucw.cz, maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
In-Reply-To: <20070102140419.GK2122@elf.ucw.cz>
References: <20070102140419.GK2122@elf.ucw.cz>
Content-Type: multipart/mixed; boundary="=-+iB0ZkNbk+8rlxhfElRx"
Date: Tue, 02 Jan 2007 17:51:54 +0100
Message-Id: <1167756714.30886.88.camel@violet>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+iB0ZkNbk+8rlxhfElRx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Pavel,

> On 2.6.20-rc2, I got:
> 
> This used to work before... certainly with 2.6.19.
> 
> Running this multiple times seems to trigger it:
> 
> #!/bin/bash
> #
> # Run tui on desktop machine, using t68i instead of a modem.
> #
> 
> hciconfig hci0 name billionton
> hciconfig hci0 up
> hcid
> rfcomm unbind 1
> # t68
>  rfcomm bind 1 00:80:37:??:??:??
> stty -echo < /dev/rfcomm1
> 
> cd ~pavel/misc/tui/microwindows-0.91/src
> ( while true; do ~pavel/sf/tui/input_sx1 | bin/phone; done ) &
> ./launcher.sh
> 
> 								Pavel
> 
> ....
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> kobject_add failed for rfcomm1 with -EEXIST, don't try to register things with the same name in the same directory.
>  [<c025121c>] kobject_add+0x1ac/0x1e0
>  [<c0328d40>] device_add+0xb0/0x500
>  [<c025156b>] kobject_init+0x2b/0x40
>  [<c0328510>] device_create_release+0x0/0x10
>  [<c0329229>] device_create+0x89/0xc0
>  [<c02d854b>] tty_register_device+0x5b/0xf0
>  [<c0612038>] _read_lock_bh+0x8/0x20
>  [<c05e4072>] hci_get_route+0x112/0x120
>  [<c05f04ed>] rfcomm_dev_ioctl+0x4cd/0x690
>  [<c05ee6b9>] rfcomm_sock_ioctl+0x29/0x50
>  [<c054409f>] sock_ioctl+0xaf/0x1d0
>  [<c0543ff0>] sock_ioctl+0x0/0x1d0
>  [<c017a23b>] do_ioctl+0x2b/0xa0
>  [<c017a30c>] vfs_ioctl+0x5c/0x2e0
>  [<c017a5cd>] sys_ioctl+0x3d/0x70
>  [<c010304c>] syscall_call+0x7/0xb
>  [<c0610033>] schedule+0x2c3/0x8f0
>  =======================

I have no idea why this one happens. You should check if the unbind
really succeeded.

> BUG: unable to handle kernel NULL pointer dereference at virtual address 0000003c
>  printing eip:
> c05ef978
> *pde = 00000000
> BUG: soft lockup detected on CPU#0!
>  [<c014d469>] softlockup_tick+0xa9/0xd0
>  [<c0131383>] update_process_times+0x33/0x80
>  [<c011ab7b>] smp_apic_timer_interrupt+0x6b/0x80
>  [<c0103aa4>] apic_timer_interrupt+0x28/0x30
>  [<c0255606>] delay_tsc+0x16/0x20
>  [<c0255646>] __delay+0x6/0x10
>  [<c011fbbb>] do_page_fault+0x35b/0x600
>  [<c011f860>] do_page_fault+0x0/0x600
>  [<c061237c>] error_code+0x7c/0x84
>  [<c02d007b>] read_fan+0x59/0x6f
>  [<c05ef978>] rfcomm_tty_chars_in_buffer+0x8/0x20
>  [<c02dcd64>] normal_poll+0xd4/0x140
>  [<c02dcc90>] normal_poll+0x0/0x140
>  [<c02d9f4b>] tty_poll+0x6b/0x90
>  [<c017b5c9>] do_select+0x219/0x4b0
>  [<c017ac00>] __pollwait+0x0/0x110
>  [<c0123c90>] default_wake_function+0x0/0x10
>  [<c0123c90>] default_wake_function+0x0/0x10
>  [<c0123c90>] default_wake_function+0x0/0x10
>  [<c018f0a0>] __find_get_block_slow+0xc0/0x140
>  [<c0169c39>] poison_obj+0x29/0x60
>  [<c016962e>] dbg_redzone1+0xe/0x20
>  [<c016a51e>] cache_alloc_debugcheck_after+0x3e/0x150
>  [<c016a364>] check_poison_obj+0x24/0x1a0
>  [<c019129f>] __find_get_block+0xcf/0x1c0
>  [<c0169c39>] poison_obj+0x29/0x60
>  [<c0169c39>] poison_obj+0x29/0x60
>  [<c016a220>] cache_free_debugcheck+0xb0/0x1d0
>  [<c01c0592>] journal_stop+0x162/0x1f0
>  [<c01c0592>] journal_stop+0x162/0x1f0
>  [<c01ba0e4>] __ext3_journal_stop+0x24/0x50
>  [<c01b29f1>] ext3_ordered_commit_write+0xa1/0xd0
>  [<c01b16a0>] ext3_journal_dirty_data+0x0/0x50
>  [<c015162b>] generic_file_buffered_write+0x39b/0x680
>  [<c01ba0e4>] __ext3_journal_stop+0x24/0x50
>  [<c018a824>] __mark_inode_dirty+0x34/0x1c0
>  [<c0152a43>] __generic_file_aio_write_nolock+0x283/0x590
>  [<c017ba26>] core_sys_select+0x1c6/0x2e0
>  [<c06112cf>] __mutex_lock_slowpath+0xef/0x230
>  [<c0152db2>] generic_file_aio_write+0x62/0xd0
>  [<c01b0570>] ext3_file_write+0x30/0xc0
>  [<c016ea77>] do_sync_write+0xc7/0x130
>  [<c015e392>] __handle_mm_fault+0x642/0x890
>  [<c013c680>] autoremove_wake_function+0x0/0x50
>  [<c02d82d5>] tty_ldisc_deref+0x15/0x70
>  [<c017bea1>] sys_select+0x51/0x1c0
>  [<c010304c>] syscall_call+0x7/0xb
>  =======================
> Oops: 0000 [#1]
> SMP 
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c05ef978>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.20-rc2 #384)
> EIP is at rfcomm_tty_chars_in_buffer+0x8/0x20
> eax: 00000000   ebx: db0e5704   ecx: 00000000   edx: f79858ac
> esi: 00000000   edi: f7599528   ebp: 00000000   esp: da73bb54
> ds: 007b   es: 007b   ss: 0068
> Process phone (pid: 3930, ti=da73a000 task=dc212a70 task.ti=da73a000)
> Stack: c02dcd64 00610a52 f7599528 db0e5704 c02dcc90 c02d9f4b 00000000 db0e5710 
>        00000010 f7599528 00000004 0000001c c017b5c9 00000000 da73bf9c da73bf54 
>        00000000 da73be60 da73be64 da73be68 da73be58 da73be5c da73be60 00000011 
> Call Trace:
>  [<c02dcd64>] normal_poll+0xd4/0x140
>  [<c02dcc90>] normal_poll+0x0/0x140
>  [<c02d9f4b>] tty_poll+0x6b/0x90
>  [<c017b5c9>] do_select+0x219/0x4b0
>  [<c017ac00>] __pollwait+0x0/0x110
>  [<c0123c90>] default_wake_function+0x0/0x10
>  [<c0123c90>] default_wake_function+0x0/0x10
>  [<c0123c90>] default_wake_function+0x0/0x10
>  [<c018f0a0>] __find_get_block_slow+0xc0/0x140
>  [<c0169c39>] poison_obj+0x29/0x60
>  [<c016962e>] dbg_redzone1+0xe/0x20
>  [<c016a51e>] cache_alloc_debugcheck_after+0x3e/0x150
>  [<c016a364>] check_poison_obj+0x24/0x1a0
>  [<c019129f>] __find_get_block+0xcf/0x1c0
>  [<c0169c39>] poison_obj+0x29/0x60
>  [<c0169c39>] poison_obj+0x29/0x60
>  [<c016a220>] cache_free_debugcheck+0xb0/0x1d0
>  [<c01c0592>] journal_stop+0x162/0x1f0
>  [<c01c0592>] journal_stop+0x162/0x1f0
>  [<c01ba0e4>] __ext3_journal_stop+0x24/0x50
>  [<c01b29f1>] ext3_ordered_commit_write+0xa1/0xd0
>  [<c01b16a0>] ext3_journal_dirty_data+0x0/0x50
>  [<c015162b>] generic_file_buffered_write+0x39b/0x680
>  [<c01ba0e4>] __ext3_journal_stop+0x24/0x50
>  [<c018a824>] __mark_inode_dirty+0x34/0x1c0
>  [<c0152a43>] __generic_file_aio_write_nolock+0x283/0x590
>  [<c017ba26>] core_sys_select+0x1c6/0x2e0
>  [<c06112cf>] __mutex_lock_slowpath+0xef/0x230
>  [<c0152db2>] generic_file_aio_write+0x62/0xd0
>  [<c01b0570>] ext3_file_write+0x30/0xc0
>  [<c016ea77>] do_sync_write+0xc7/0x130
>  [<c015e392>] __handle_mm_fault+0x642/0x890
>  [<c013c680>] autoremove_wake_function+0x0/0x50
>  [<c02d82d5>] tty_ldisc_deref+0x15/0x70
>  [<c017bea1>] sys_select+0x51/0x1c0
>  [<c010304c>] syscall_call+0x7/0xb
>  =======================
> Code: 8d 76 00 8b 80 60 01 00 00 8b 50 3c f0 0f ba 72 3c 00 19 c0 85 c0 75 01 c3 89 d0 e9 f3 cb ff ff 8d 76 00 8b 80 60 01 00 00 31 c9 <8b> 50 3c 8d 42 0c 39 42 0c 74 03 8b 4a 50 89 c8 c3 8d b4 26 00 
> EIP: [<c05ef978>] rfcomm_tty_chars_in_buffer+0x8/0x20 SS:ESP 0068:da73bb54

The attached patch is from my queue of pending fixes and should take
care of these oopses.

Regards

Marcel


--=-+iB0ZkNbk+8rlxhfElRx
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

[Bluetooth] More checks if DLC is still attached to the TTY

If the DLC device is no longer attached to the TTY device, then return
errors or default values for various callbacks of the TTY layer.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

---
commit 3d3eac49e9cafde6b66e677397d9b078a9582f46
tree f0d3fb5b7d753e233108a0361bc993bf567874d1
parent 8c31ee8311b0b3b76616efc017e0fb87e0263823
author Marcel Holtmann <marcel@holtmann.org> Tue, 02 Jan 2007 06:38:02 +0100
committer Marcel Holtmann <marcel@holtmann.org> Tue, 02 Jan 2007 06:38:02 +0100

 net/bluetooth/rfcomm/tty.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index e0e0d09..eb2b524 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -697,9 +697,13 @@ static int rfcomm_tty_write_room(struct tty_struct *tty)
 
 	BT_DBG("tty %p", tty);
 
+	if (!dev || !dev->dlc)
+		return 0;
+
 	room = rfcomm_room(dev->dlc) - atomic_read(&dev->wmem_alloc);
 	if (room < 0)
 		room = 0;
+
 	return room;
 }
 
@@ -915,12 +919,14 @@ static void rfcomm_tty_unthrottle(struct tty_struct *tty)
 static int rfcomm_tty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
-	struct rfcomm_dlc *dlc = dev->dlc;
 
 	BT_DBG("tty %p dev %p", tty, dev);
 
-	if (!skb_queue_empty(&dlc->tx_queue))
-		return dlc->mtu;
+	if (!dev || !dev->dlc)
+		return 0;
+
+	if (!skb_queue_empty(&dev->dlc->tx_queue))
+		return dev->dlc->mtu;
 
 	return 0;
 }
@@ -928,11 +934,12 @@ static int rfcomm_tty_chars_in_buffer(struct tty_struct *tty)
 static void rfcomm_tty_flush_buffer(struct tty_struct *tty)
 {
 	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
-	if (!dev)
-		return;
 
 	BT_DBG("tty %p dev %p", tty, dev);
 
+	if (!dev || !dev->dlc)
+		return;
+
 	skb_queue_purge(&dev->dlc->tx_queue);
 
 	if (test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags) && tty->ldisc.write_wakeup)
@@ -952,11 +959,12 @@ static void rfcomm_tty_wait_until_sent(struct tty_struct *tty, int timeout)
 static void rfcomm_tty_hangup(struct tty_struct *tty)
 {
 	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
-	if (!dev)
-		return;
 
 	BT_DBG("tty %p dev %p", tty, dev);
 
+	if (!dev)
+		return;
+
 	rfcomm_tty_flush_buffer(tty);
 
 	if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags))

--=-+iB0ZkNbk+8rlxhfElRx--

