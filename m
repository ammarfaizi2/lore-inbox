Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269586AbUKASxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269586AbUKASxG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 13:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S287887AbUKASxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 13:53:05 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:5248 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S287422AbUKASgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 13:36:37 -0500
Date: Mon, 1 Nov 2004 19:36:31 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: x86-64 numa: accessing memnodemap[] beyond its end
Message-ID: <20041101183631.GA24023@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   what prevents function below (arch/x86_64/mm/numa.c) from accessing
memnodemap[] beyond its end?  NODEMAPSIZE is 0xFF, so for first attempted
bit shift 24 it attempts to access field 0x100000000 >> 24 = 0x100.
Fortunately it survives as memnodemap[256] fortunately contains zero and
not 0xFF or 0x01, but still it seems to me that some test for index
overflow is missing here. 
						Thanks,
							Petr Vandrovec


u8  memnodemap[NODEMAPSIZE];

int __init compute_hash_shift(struct node *nodes)
{
        int i;
        int shift = 24;
        u64 addr;

        /* When in doubt use brute force. */
        while (shift < 48) {
                memset(memnodemap,0xff,sizeof(*memnodemap) * NODEMAPSIZE);
                for (i = 0; i < numnodes; i++) {
                        if (nodes[i].start == nodes[i].end)
                                continue;
                        for (addr = nodes[i].start;
                             addr < nodes[i].end;
                             addr += (1UL << shift)) {
                                if (memnodemap[addr >> shift] != 0xff &&
                                    memnodemap[addr >> shift] != i) {
                                        printk(KERN_INFO
                                            "node %d shift %d addr %Lx conflict %d\n",
                                               i, shift, addr, memnodemap[addr>>shift]);
                                        goto next;
                                }
                                memnodemap[addr >> shift] = i;
                        }
                }
                return shift;
        next:
                shift++;
        }
        memset(memnodemap,0,sizeof(*memnodemap) * NODEMAPSIZE);
        return -1;
}

Bootdata ok (command line is BOOT_IMAGE=2.6.10-1-424-64 ro root=801 ramdisk=0 video=matroxfb:vesa:0x11E,left:16,right:8,hslen:48,xres:1920,upper:2,vslen:4,lowe)
Linux version 2.6.10-rc1-c2424 (root@vana) (gcc version 3.3.3 (Debian 20040401)) #2 SMP Mon Nov 1 15:43:42 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 0000000000100000 - 0000000040000000 (usable)
 BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
Scanning NUMA topology in Northbridge 24
Number of nodes 2 (10010)
Node 0 MemBase 0000000000000000 Limit 000000003fffffff
Node 1 MemBase 0000000100000000 Limit 000000013fffffff
node 1 shift 24 addr 100000000 conflict 0
Using node hash shift of 25
Bootmem setup node 0 0000000000000000-000000003fffffff
Bootmem setup node 1 0000000100000000-000000013fffffff

P.S.:  No, this setup does not come from standard BIOS.
