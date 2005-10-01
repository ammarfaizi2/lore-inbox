Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVJADAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVJADAe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 23:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVJADAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 23:00:34 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:31879 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S1750721AbVJADAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 23:00:34 -0400
Date: Sat, 1 Oct 2005 05:00:27 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc2-almost-rc3, ext3 and memory corruption
Message-ID: <20051001030027.GA8784@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  I was so happy that 2.6.13-rc3 was released that I tried to grab it,
and while I was doing that, box said:

Slab corruption: start=ffff8100005e5bf8, len=96
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff801ec42d>](journal_remove_journal_head+0x6d/0xb0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 01 00 00 00 6b 6b 6b 6b
Prev obj: start=ffff8100005e5b80, len=96
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff801ec42d>](journal_remove_journal_head+0x6d/0xb0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=ffff8100005e5c70, len=96
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff801ec42d>](journal_remove_journal_head+0x6d/0xb0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

It looks like that journal head's b_jcount was set to 1 after
journal head was already released.  It looks like that I must
have been extremelly unlucky, as all b_jcount operations I
can find are either jh->b_jcount++ or --jh->b_jcount, so
schedule() (and free()) must have happened after b_jcount was 
read from memory, but before incremented value was written
back (or I have missed some direct assignment, but I see none).
On other side all these b_jcount manipulations should be under
jbd_lock_bh_journal_head, which both disables preemption and
acquires some bitlock.  So I'm again missing something fundamental,
as this use-after-free should never happen, and if it could
happen I should get 6c 6b 6b 6b and not 01 00 00 00...

Box has two ext3 filesystems, and when these oopses occured I
was running one apt-get install in /, apt-get update in the /pure64
chroot, apt-get source apt in /usr/src/debian (but maybe this one
was already finished at that time) and cg-export /tmp/linux-2.6.13-rc3
on fourth console.  git's kernel repository is on second disk, everything
else on first one.  So disks and ext3 were quite busy when problem
occured.

I'll try to reproduce it with 2.6.13-rc3 (running kernel was from
wednesday git, as of commit 95001ee...), but I have no idea how 
reproducible it is, and as I see no ext3 or jbd changes since wednesday
I believe it is not fixed yet.

Box in question has single Athlon64 processor, runs SMP PREEMPT kernel
with almost all debugging options set (but not CONFIG_JBD_DEBUG).  Box 
has 2GB of ECC RAM.  Root filesystem is on pata disk connected to the 
pata port on Promise's 20378 (using sata_promise).  Disk with git repository 
is plugged to pata port on Via's VT8237.  Kernel's configuration is 
at http://platan.vc.cvut.cz/vana_at_home_config.txt, dmesg at 
http://platan.vc.cvut.cz/vana_at_home_dmesg.txt.

					Thanks,
						Petr Vandrovec
