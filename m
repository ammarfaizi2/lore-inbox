Return-Path: <linux-kernel-owner+w=401wt.eu-S932746AbWLZSCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746AbWLZSCm (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 13:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932749AbWLZSCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 13:02:42 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:54633 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932746AbWLZSCl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 13:02:41 -0500
Date: Tue, 26 Dec 2006 18:56:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, dwmw2@infradead.org,
       Joy Latten <latten@austin.ibm.com>, Jamal Hadi Salim <hadi@cyberus.ca>
Subject: [patch] net/xfrm: fix crash in ipsec audit logging
Message-ID: <20061226175619.GA27982@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] net/xfrm: fix crash in ipsec audit logging
From: Ingo Molnar <mingo@elte.hu>

i got the following crash when restarting a (timed out) ipsec session on 
2.6.20-rc1-rt4:

BUG: unable to handle kernel NULL pointer dereference at virtual address 000000a2
 printing eip:
c0320f67
*pde = 00000000
stopped custom tracer.
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in: xfrm4_mode_tunnel deflate zlib_deflate twofish twofish_common serpent blowfish cbc ecb xcbc sha256 crypto_null aes des blkcipher xfrm4_tunnel tunnel4 ipcomp esp4 ah4 af_key radeon drm hidp l2cap bluetooth sunrpc ipv6 n_hdlc ppp_synctty ppp_async crc_ccitt ppp_generic slhc nf_conntrack_netbios_ns ipt_REJECT nf_conntrack_ipv4 xt_state xt_tcpudp iptable_filter ip_tables x_tables dm_mirror dm_multipath dm_mod raid1 video sbs i2c_ec button battery asus_acpi ac parport_pc lp parport floppy snd_via82xx_modem snd_seq_dummy snd_via82xx snd_ac97_codec snd_seq_oss snd_seq_midi_event ac97_bus bt878 tuner snd_seq bttv video_buf ir_common snd_pcm_oss snd_mixer_oss videodev v4l1_compat v4l2_common i2c_algo_bit snd_pcm btcx_risc tveeprom compat_ioctl32 pcspkr e100 skge mii i2c_viapro snd_timer gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd_page_alloc snd i2c_core soundcore k8temp hwmon ide_cd serio_raw cdrom sata_via pata_via ata_generic libata sd_mod scsi_mod ext3 jbd ehci_hcd ohci_hcd uhci_hcd
CPU:    0
EIP:    0060:[<c0320f67>]    Not tainted VLI
EFLAGS: 00010246   (2.6.20-rc1.1.rt4.0006 #1)
EIP is at xfrm_audit_log+0x116/0x423
eax: 00000000   ebx: 00000586   ecx: 00000000   edx: c03dfc79
esi: 000001f4   edi: 00000000   ebp: f5229a48   esp: f522999c
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process pluto (pid: 12885, ti=f5229000 task=f7c06af0 task.ti=f5229000)
Stack: f7c5be00 c03f6e49 000001f4 f3860a80 00000000 f52299bc c02ca13f 00000000 
       f52299dc c02ca247 00000006 f52299e4 c01254ba 00000001 e86fd000 00000000 
       f52299e4 c02ca27d f7c5be00 f8d928b9 f5229a10 c0155d14 f3860a80 fffffffd 
Call Trace:
 [<c0329c69>] xfrm_get_policy+0x108/0x24f
 [<c03274a9>] xfrm_user_rcv_msg+0x132/0x155
 [<c02e3f23>] netlink_run_queue+0x61/0xcd
 [<c0326eeb>] xfrm_netlink_rcv+0x27/0x3b
 [<c02e3fa2>] netlink_data_ready+0x13/0x54
 [<c02e1fcf>] netlink_sendskb+0x1f/0x37
 [<c02e3a55>] netlink_unicast+0x1aa/0x1b2
 [<c02e3cce>] netlink_sendmsg+0x271/0x27d
 [<c02c47b8>] sock_aio_write+0x104/0x110
 [<c017d703>] do_sync_write+0xb2/0xef
 [<c017dd46>] vfs_write+0xc5/0x165
 [<c017e51a>] sys_write+0x3d/0x61
 [<c0103ffd>] syscall_call+0x7/0xb
 [<457d78b2>] 0x457d78b2
 =======================
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c0334075>] .... __spin_lock_irqsave+0x25/0x5e
.....[<c01057db>] ..   ( <= die+0x42/0x201)

skipping trace printing on CPU#0 != -1
Code: 24 e8 3e 5b e3 ff eb 08 8b 45 9c e8 43 9f e3 ff 83 7d 0c 00 74 12 8b 4d 0c 0f b7 99 9c 00 00 00 8b 91 18 01 00 00 eb 10 8b 45 10 <0f> b7 98 a2 00 00 00 8b 90 d8 01 00 00 85 d2 74 29 8d 42 08 89 
EIP: [<c0320f67>] xfrm_audit_log+0x116/0x423 SS:ESP 0068:f522999c

the reason for the crash is that we pass both 'xp' and 'x' as NULL into 
xfrm_audit_log(), which thus has no other option but to crash.

The fix i think is to check for the presence of xp sooner and return 
with -ENOENT, and to pass in the 'delete' flag as the result to the 
audit subsystem, not the 'xp != NULL' boolen value.

(this is a new v2.6.19->v2.6.20-rc1 regression, i never had problems 
with this functionality of the kernel.)

Hopefully i got the fix right :-)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 net/xfrm/xfrm_user.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

Index: linux/net/xfrm/xfrm_user.c
===================================================================
--- linux.orig/net/xfrm/xfrm_user.c
+++ linux/net/xfrm/xfrm_user.c
@@ -1268,13 +1268,12 @@ static int xfrm_get_policy(struct sk_buf
 		xp = xfrm_policy_bysel_ctx(type, p->dir, &p->sel, tmp.security, delete);
 		security_xfrm_policy_free(&tmp);
 	}
-	if (delete)
-		xfrm_audit_log(NETLINK_CB(skb).loginuid, NETLINK_CB(skb).sid,
-			       AUDIT_MAC_IPSEC_DELSPD, (xp) ? 1 : 0, xp, NULL);
-
 	if (xp == NULL)
 		return -ENOENT;
 
+	xfrm_audit_log(NETLINK_CB(skb).loginuid, NETLINK_CB(skb).sid,
+		       AUDIT_MAC_IPSEC_DELSPD, delete, xp, NULL);
+
 	if (!delete) {
 		struct sk_buff *resp_skb;
 
