Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWJJSlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWJJSlF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWJJSlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:41:05 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:41911 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030213AbWJJSlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:41:03 -0400
Date: Tue, 10 Oct 2006 13:39:43 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       herbert@gondor.apana.org.au
Subject: Re: [PATCH] ecryptfs: reduce legacy API usage
Message-ID: <20061010183943.GA4673@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20061010064626.GA21155@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010064626.GA21155@havoc.gtf.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 02:46:26AM -0400, Jeff Garzik wrote:
> Use modern crypto APIs.
> 
> Signed-off-by: Jeff Garzik <jeff@garzik.org>

With this patch, I ran across a problem:

---
Oct 10 13:21:24 localhost mount.ecryptfs: Mount opts: [ecryptfs_sig=7fa06f4b66fcde02,ecryptfs_cipher=aes,ecryptfs_key_bytes=16] 
Oct 10 13:21:28 localhost kernel: ecryptfs_init_crypt_ctx: cryptfs: init_crypt_ctx(): Error initializing cipher [aes]
Oct 10 13:21:28 localhost kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 00000006
Oct 10 13:21:28 localhost kernel:  printing eip:
Oct 10 13:21:28 localhost kernel: f8a8ff10
Oct 10 13:21:28 localhost kernel: *pde = 00000000
Oct 10 13:21:28 localhost kernel: Oops: 0000 [#1]
Oct 10 13:21:28 localhost kernel: PREEMPT 
Oct 10 13:21:28 localhost kernel: Modules linked in: ecryptfs dummy l2cap bluetooth twofish twofish_common serpent aes blowfish ecb sha256 cry
pto_null cryptomgr joydev snd_intel8x0m wlan_scan_sta ath_pci ath_rate_sample wlan ath_hal(P) genrtc
Oct 10 13:21:28 localhost kernel: CPU:    0
Oct 10 13:21:28 localhost kernel: EIP:    0060:[<f8a8ff10>]    Tainted: P      VLI
Oct 10 13:21:28 localhost kernel: EFLAGS: 00010286   (2.6.19-rc1 #116)
Oct 10 13:21:28 localhost kernel: EIP is at decrypt_scatterlist+0x50/0x110 [ecryptfs]
Oct 10 13:21:28 localhost kernel: eax: 00000010   ebx: f2a44b84   ecx: fffffffe   edx: f2a44bd8
Oct 10 13:21:28 localhost kernel: esi: f2a44c48   edi: 00001000   ebp: e5f33bf4   esp: e5f33bb8
Oct 10 13:21:29 localhost kernel: ds: 007b   es: 007b   ss: 0068
Oct 10 13:21:29 localhost kernel: Process cat (pid: 5888, ti=e5f32000 task=ec246a70 task.ti=e5f32000)
Oct 10 13:21:29 localhost kernel: Stack: fffffffe f2a44bd8 00000010 00000bf4 fffffffe e5f33c78 00000200 e5f33c14 
Oct 10 13:21:29 localhost kernel:        fffffffe e5f33c78 00000200 e5f33c14 f2a44b84 00000000 c140d020 e5f33c30 
Oct 10 13:21:29 localhost kernel:        f8a9006b f2a44b84 e5f33c10 e5f33c20 00001000 e5f33c78 c13a7860 00000000 
Oct 10 13:21:29 localhost kernel: Call Trace:
Oct 10 13:21:29 localhost kernel:  [<f8a9006b>] ecryptfs_decrypt_page_offset+0x4b/0x50 [ecryptfs]
Oct 10 13:21:29 localhost kernel:  [<f8a8fd08>] ecryptfs_decrypt_page+0x168/0x320 [ecryptfs]
Oct 10 13:21:29 localhost kernel:  [<f8a8deef>] ecryptfs_readpage+0xaf/0x100 [ecryptfs]
Oct 10 13:21:29 localhost kernel:  [<c0149250>] read_pages+0x80/0xf0
Oct 10 13:21:29 localhost kernel:  [<c0149445>] __do_page_cache_readahead+0x185/0x1c0
Oct 10 13:21:29 localhost kernel:  [<c01495bf>] blockable_page_cache_readahead+0x4f/0xd0
Oct 10 13:21:29 localhost kernel:  [<c01497fc>] page_cache_readahead+0x10c/0x1d0
Oct 10 13:21:29 localhost kernel:  [<c0142a0c>] do_generic_mapping_read+0x40c/0x520
Oct 10 13:21:29 localhost kernel:  [<c0142d47>] generic_file_aio_read+0x147/0x220
Oct 10 13:21:29 localhost kernel:  [<f8a8a389>] ecryptfs_read_update_atime+0x39/0x80 [ecryptfs]
Oct 10 13:21:29 localhost kernel:  [<c016324f>] do_sync_read+0xdf/0x130
Oct 10 13:21:29 localhost kernel:  [<c0163468>] vfs_read+0x1c8/0x1d0
Oct 10 13:21:29 localhost kernel:  [<c01637bb>] sys_read+0x4b/0x80
Oct 10 13:21:29 localhost kernel:  [<c0103353>] syscall_call+0x7/0xb
Oct 10 13:21:29 localhost kernel:  [<b7f338de>] 0xb7f338de
Oct 10 13:21:29 localhost kernel:  =======================
Oct 10 13:21:29 localhost kernel: Code: 45 e4 89 f0 c7 45 dc 00 02 00 00 c7 45 ec 00 02 00 00 e8 74 04 9e c7 8b 4b 2c 8d 53 54 8b 43 1c 89 54 
24 04 89 0c 24 89 44 24 08 <ff> 51 08 85 c0 75 59 89 7c 24 08 b8 43 33 a9 f8 89 44 24 04 c7 
Oct 10 13:21:29 localhost kernel: EIP: [<f8a8ff10>] decrypt_scatterlist+0x50/0x110 [ecryptfs] SS:ESP 0068:e5f33bb8
---

parse_tag_3_packet() does not check the return code from
ecryptfs_init_crypt_ctx(). Here is a patch to fix that issue; this
prevents the oops. But reading an encrypted file still does not
work.

---

Check the return code from the cryptographic context initializer.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/keystore.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

dd04668dddad4efc44dcfa6fc392a6aeabf30256
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index ba45478..5ca3836 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -273,7 +273,12 @@ parse_tag_3_packet(struct ecryptfs_crypt
 		crypt_stat->key_size =
 			(*new_auth_tok)->session_key.encrypted_key_size;
 	}
-	ecryptfs_init_crypt_ctx(crypt_stat);
+	rc = ecryptfs_init_crypt_ctx(crypt_stat);
+	if (rc) {
+		printk(KERN_ERR "Error initializing the cryptographic context; "
+		       "rc = [%d]\n", rc);
+		goto out_free;
+	}
 	/* S2K identifier 3 (from RFC2440) */
 	if (unlikely(data[(*packet_size)++] != 0x03)) {
 		ecryptfs_printk(KERN_ERR, "Only S2K ID 3 is currently "
-- 
1.3.3

