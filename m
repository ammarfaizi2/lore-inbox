Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUHGOFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUHGOFL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 10:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUHGOFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 10:05:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31493 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262450AbUHGOFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 10:05:01 -0400
Date: Sat, 7 Aug 2004 15:04:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org
Subject: [BUG] 2.6.8-rc3 slab corruption (jffs2?)
Message-ID: <20040807150458.E2805@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-mtd@lists.infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure exactly what caused this, but it happened while logging in
(after fixing the previous two reported problems - the first by backing
out the last change to redboot.c and the second by commenting out
ri->usercompr in fs/jffs2/read.c.)

Slab corruption: start=c1e39474, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c032ca10>](cfi_intelext_erase_varsize+0x58/0x64)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 4f 6b
Prev obj: start=c1e39428, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02c767c>](jffs2_garbage_collect_deletion_dirent+0x80/0x8c)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=c1e394c0, len=64
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c03514f8>](neigh_hh_init+0x64/0x11c)
000: 00 00 00 00 03 00 00 00 08 00 00 00 0e 00 00 00
010: 00 b0 34 c0 00 00 08 00 2b 95 1d 7b 00 c0 1b 00

Due to tail call optimisation, its difficult to work out exactly what's
going on, but the first seems to be a kfree call from the erase callback
(possibly jffs2_erase_callback).  The second function is the call to
jffs2_free_full_dirent() in jffs2_garbage_collect_deletion_dirent().

Any ideas?  I haven't been able to reproduce (presumably because the
erase succeeded, and we didn't need to re-erase again.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
