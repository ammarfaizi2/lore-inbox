Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUHGNSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUHGNSf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 09:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUHGNSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 09:18:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3589 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262062AbUHGNSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 09:18:33 -0400
Date: Sat, 7 Aug 2004 14:18:29 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org
Subject: [BUG] 2.6.8-rc3 jffs2 unable to read filesystems
Message-ID: <20040807141829.D2805@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-mtd@lists.infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following two messages sum up the problem:

JFFS2 compression type 0x5a06 not avaiable.
Error: jffs2_decompress returned -5

It appears that a jffs2 change committed on July 15th has caused recent
2.6.8-rc kernels to be incompatible with jffs2 filesystems modified by
previous kernel versions.

The "new format" jffs2 filesystem uses both "compr" and "usercompr"
of the jffs2_raw_inode structure, whereas previous implementations
left "usercompr" uninitialised and thus contains random data.

This can be seen by tracing through the code from jffs2_alloc_raw_inode()
and noticing that previous implementations do not initialise this field -
AFAICS kmem_cache_alloc() does not guarantee that memory returned by
this function will be initialised.

Therefore, recent 2.6.8-rc kernels must _NOT_ use this field if they
wish to remain compatible with existing jffs2 filesystems.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
