Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbUJXV00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbUJXV00 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 17:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbUJXV00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 17:26:26 -0400
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:21975 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S261553AbUJXV0U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 17:26:20 -0400
Date: Mon, 25 Oct 2004 00:26:18 +0300
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.9 latencies: 253ms in ip_tables.c:copy_entries_to_user(), 200ms in reiserfs/bitmap.c:scan_bitmap_block(), 4ms in i2c-algo-bit.c:bit_xfer()
Message-ID: <20041024212618.GA19377@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

there's a script which does
grep -Fh "^[0-9]" $BLOCKLISTS | aggregate | \
while read blocked; do
  iptables -A DROP_evil_in  -s $blocked -j LDROPEVILIN
  iptables -A DROP_evil_out -d $blocked -j LDROPEVILOUT
done

while that's running, "rtc_latencytest 1024" has max latencies of 253ms.
$BLOCKLIST has around two thousand lines.
http://safari.iki.fi/ip_tables_original_maxlat_253ms.png
from pressing sysrq+p while it was running, I guesstimated one evil spot
and added cond_resched() in there :)
http://safari.iki.fi/ip_tables_cond_resched.png
at 5s I started the script.

then there's this 200ms latency when doing "cp /dev/zero ." on reiserfs.
http://safari.iki.fi/2.6.9-no_reiserfs_cond_resched.png
sysrq+p pointed to scan_bitmap_block ... :) (I also used profile=2)
after adding cond_resched in there, max latency 2.4ms
http://safari.iki.fi/2.6.9-with_reiserfs_cond_resched.png

"cp /dev/zero ." consumes 90% CPU time in system...
reading the same file from disk needs 8% CPU.
is my partition just so fragmented or full?

EIP is at reiserfs_in_journal+0x82/0x168
EFLAGS: 00000206    Not tainted  (2.6.9-exec-shield)
EAX: 00008000 EBX: 00408000 ECX: 000011b3 EDX: cf202e00
ESI: 00000005 EDI: 0000011c EBP: c73a7c2c DS: 007b ES: 007b
CR0: 8005003b CR2: b7fda000 CR3: 091cb000 CR4: 000002d0
 [<c010425d>] show_regs+0x115/0x120
 [<c02768b8>] sysrq_handle_showregs+0x10/0x14
 [<c0276a3b>] __handle_sysrq+0x5f/0xe8
 [<c0276ae1>] handle_sysrq+0x1d/0x21
 [<c02709ee>] kbd_keycode+0x12e/0x2d8
 [<c0270c1c>] kbd_event+0x84/0xbc
 [<c02d883c>] input_event+0x3ac/0x3d0
 [<c02db9da>] atkbd_report_key+0x3a/0x5c
 [<c02dbf3b>] atkbd_interrupt+0x53f/0x5b8
 [<c0282fb0>] serio_interrupt+0x30/0x65
 [<c028357b>] i8042_interrupt+0x14b/0x15c
 [<c0108230>] handle_IRQ_event+0x28/0x5c
 [<c010852e>] do_IRQ+0xa2/0x114
 [<c010679c>] common_interrupt+0x18/0x20
 [<c01816c8>] scan_bitmap_block+0xb8/0x28c
 [<c0181ac0>] scan_bitmap+0x15c/0x1ac
 [<c0182ce5>] reiserfs_allocate_blocknrs+0x415/0x4f8
 [<c018cf17>] reiserfs_allocate_blocks_for_region+0x187/0x1314
 [<c018f356>] reiserfs_file_write+0x482/0x630
 [<c014e659>] vfs_write+0xb5/0xec
 [<c014e734>] sys_write+0x3c/0x68
 [<c0105e2f>] syscall_call+0x7/0xb

also, there's 4ms latency every five seconds, when I am running xawtv
in stereo mode.  I have BT878 and MSP3400.
http://safari.iki.fi/3.7ms-with-xawtv.png
http://safari.iki.fi/1.6ms-without-xawtv.png
turned out the culprit is msp3400 -- it checks every five secs
audio state (stereo/mono/...) which calls i2c_master_send.
http://safari.iki.fi/i2c-msp3400-cond_resched.png
http://safari.iki.fi/i2c-msp3400-cond_resched-switching_channels.png

WARNING: I don't know are those cond_rescheds safe to call,
but I haven't gotten panics because of them yet.
Someone who actually has a clue might want to tell are they safe
or where would be a better place to do cond_resched.

...uhhh, and I have low-end Celeron system running UP non-preempt kernel.



--- linux/net/ipv4/netfilter/ip_tables.c.bak	2004-10-19 23:40:28.000000000 +0300
+++ linux/net/ipv4/netfilter/ip_tables.c	2004-10-24 19:15:54.000000000 +0300
@@ -976,6 +976,7 @@ copy_entries_to_user(unsigned int total_
 		struct ipt_entry_match *m;
 		struct ipt_entry_target *t;
 
+		cond_resched();
 		e = (struct ipt_entry *)(table->private->entries + off);
 		if (copy_to_user(userptr + off
 				 + offsetof(struct ipt_entry, counters),



--- linux/fs/reiserfs/bitmap.c.condresched	2004-08-14 08:37:25.000000000 +0300
+++ linux/fs/reiserfs/bitmap.c	2004-10-20 18:12:31.000000000 +0300
@@ -155,6 +155,7 @@ static int scan_bitmap_block (struct rei
 
     while (1) {
 	cont:
+	cond_resched();
 	if (bi->free_count < min)
 		return 0; // No free blocks in this bitmap

 
--- linux/drivers/i2c/algos/i2c-algo-bit.c.bak	2004-10-19 23:38:52.000000000 +0300
+++ linux/drivers/i2c/algos/i2c-algo-bit.c	2004-10-24 23:29:12.000000000 +0300
@@ -153,6 +153,7 @@ static int i2c_outb(struct i2c_adapter *
 	int ack;
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
 
+	cond_resched();
 	/* assert: scl is low */
 	for ( i=7 ; i>=0 ; i-- ) {
 		sb = c & ( 1 << i );
@@ -195,6 +196,7 @@ static int i2c_inb(struct i2c_adapter *i
 	unsigned char indata=0;
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
 
+	cond_resched();
 	/* assert: scl is low */
 	sdahi(adap);
 	for (i=0;i<8;i++) {

-- 

