Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVEVV1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVEVV1s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 17:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVEVV1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 17:27:48 -0400
Received: from holomorphy.com ([66.93.40.71]:4836 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261735AbVEVV1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 17:27:42 -0400
Date: Sun, 22 May 2005 14:27:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: [bugfix] try_to_unmap_cluster() passes out-of-bounds pte to pte_unmap()
Message-ID: <20050522212734.GF2057@holomorphy.com>
References: <20050516021302.13bd285a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2Z2K0IlrPCVsbNpk"
Content-Disposition: inline
In-Reply-To: <20050516021302.13bd285a.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 16, 2005 at 02:13:02AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc4/2.6.12-rc4-mm2/
> - davem has set up a mm-commits mailing list so people can review things
>   which are added to or removed from the -mm tree.  Do
> 	echo subscribe mm-commits | mail majordomo@vger.kernel.org
> - x86_64 architecture update from Andi.
> - Everything up to and including `spurious-interrupt-fix.patch' is planned
>   for 2.6.12 merging.  Plus a few other things in there.
> - Another DVB subsystem update

try_to_unmap_cluster() does:
        for (pte = pte_offset_map(pmd, address);
                        address < end; pte++, address += PAGE_SIZE) {
		...
	}

	pte_unmap(pte);

It may take a little staring to notice, but pte can actually fall off
the end of the pte page in this iteration, which makes life difficult
for kmap_atomic() and the users not expecting it to BUG(). Of course,
we're somewhat lucky in that arithmetic elsewhere in the function
guarantees that at least one iteration is made, lest this force larger
rearrangements to be made. This issue and patch also apply to non-mm
mainline and with trivial adjustments, at least two related kernels.

Discovered during internal testing at Oracle. Sample BUG() message
included along with patch as a MIME attachment.

Signed-off-by: William Irwin <wli@holomorphy.com>


-- wli

--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Description: vlm-kunmap-atomic-fix.patch
Content-Disposition: attachment; filename="vlm-kunmap-atomic-fix.patch"

--- ./mm/rmap.c.orig	2005-05-20 01:29:14.066467151 -0700
+++ ./mm/rmap.c	2005-05-20 01:30:06.620649901 -0700
@@ -694,7 +694,7 @@
 		(*mapcount)--;
 	}
 
-	pte_unmap(pte);
+	pte_unmap(pte-1);
 out_unlock:
 	spin_unlock(&mm->page_table_lock);
 }

--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Description: vlm.oops
Content-Disposition: attachment; filename="vlm.oops"

May 18 23:50:30 palnx1 kernel: ------------[ cut here ]------------
May 18 23:50:30 palnx1 kernel: kernel BUG at arch/i386/mm/highmem.c:96!
May 18 23:50:30 palnx1 kernel: invalid operand: 0000 [#1]
May 18 23:50:30 palnx1 kernel: SMP
May 18 23:50:30 palnx1 kernel: Modules linked in: nfsd exportfs md5 ipv6 parport_pc lp parport autofs4 i2c_dev i2c_core nfs lockd sunrpc dm_mod button battery ac uhci_hcd e1000 e100 mii floppy ext3 jbd qla2300 qla2xxx scsi_transport_fc aic79xx sd_mod scsi_mod
May 18 23:50:30 palnx1 kernel: CPU:    2
May 18 23:50:30 palnx1 kernel: EIP:    0060:[<c011bfc4>]    Not tainted VLI
May 18 23:50:30 palnx1 kernel: EFLAGS: 00010206   (2.6.9-9.ELsmp)
May 18 23:50:30 palnx1 kernel: EIP is at kunmap_atomic+0x2e/0x58
May 18 23:50:30 palnx1 kernel: eax: 00074000   ebx: 00000001   ecx: fff8b000  edx: 0000005e
May 18 23:50:30 palnx1 kernel: esi: fff8c000   edi: d5dac000   ebp: fff8c000  esp: d5daccd0
May 18 23:50:30 palnx1 kernel: ds: 007b   es: 007b   ss: 0068
May 18 23:50:30 palnx1 kernel: Process oracle (pid: 23771, threadinfo=d5dac000 task=f4df4bb0)
May 18 23:50:30 palnx1 kernel: Stack: 00000001 97800000 c402e480 c014e1fa 81724007 00000001 97800000 d6d59c80
May 18 23:50:30 palnx1 kernel:        e3a41c24 d5dacd18 00100000 e3a41c24 f73012fc c1198580 c014e3e4 20000000
May 18 23:50:30 palnx1 kernel:        00100000 00000001 ffffffe1 00000000 00000000 00000000 00000000 f7301318
May 18 23:50:30 palnx1 kernel: Call Trace:
May 18 23:50:30 palnx1 kernel:  [<c014e1fa>] try_to_unmap_cluster+0x1b1/0x1c4
May 18 23:50:30 palnx1 kernel:  [<c014e3e4>] try_to_unmap_file+0x16d/0x21c
May 18 23:50:30 palnx1 kernel:  [<c014e4c9>] try_to_unmap+0x36/0x49
May 18 23:50:30 palnx1 kernel:  [<c01451d6>] shrink_list+0x1ba/0x3ed
May 18 23:50:30 palnx1 kernel:  [<c02c7d6a>] invalidate_interrupt+0x1a/0x20
May 18 23:50:30 palnx1 kernel:  [<c01455e6>] shrink_cache+0x1dd/0x34d

--2Z2K0IlrPCVsbNpk--
