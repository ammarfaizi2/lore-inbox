Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965219AbWEZAjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965219AbWEZAjj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 20:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbWEZAjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 20:39:39 -0400
Received: from cantor2.suse.de ([195.135.220.15]:13188 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965219AbWEZAji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 20:39:38 -0400
From: Neil Brown <neilb@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Date: Fri, 26 May 2006 10:39:25 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17526.20029.475148.370873@cse.unsw.edu.au>
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.17-rc5
In-Reply-To: message from Linus Torvalds on Thursday May 25
References: <Pine.LNX.4.64.0605241902520.5623@g5.osdl.org>
	<20060525132336.7f6ca8af@doriath.conectiva>
	<Pine.LNX.4.64.0605250934220.5623@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday May 25, torvalds@osdl.org wrote:
> 
> 
> On Thu, 25 May 2006, Luiz Fernando N. Capitulino wrote:
> > 
> >  I'm getting this after running 'halt':
> > 
> > Halting system...
> > md: stopping all md devices.
> > md: md0 switched to read-only mode.
> > Shutdown: hda
> > System halted.
> > BUG: halt/3367, lock held at task exit time!
> >  [dfe70494] {mddev_find}
> > .. held by:              halt: 3367 [decf4a90, 118]
> > ... acquired at:               md_notify_reboot+0x31/0x7f
> 
> Sounds like this is due to df5b89b323b922f56650b4b4d7c41899b937cf19, aka 
> "md: Convert reconfig_sem to reconfig_mutex" by NeilBrown.
> 
> Neil? It may well be (and likely is) an old thing, just exposed by the 
> lock debugging of the new mutexes.
> 
> Was it _meant_ to take the lock and hold it? Looks like it might be the
> 
> 	ITERATE_MDDEV(mddev,tmp)
> 		if (mddev_trylock(mddev))
> 			do_md_stop (mddev, 1);
> 
> (maybe it should release the lock after the md_stop?)
> 
> 		Linus

Yes.  Keith Owens hit this earlier and I have this patch in my
queue.  It has been confirmed to fix the problem.

NeilBrown

------------------------------------
Unlock md devices when stopping them on reboot.

otherwise we get nasty messages about locks not being released.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-05-21 08:46:09.000000000 +1000
+++ ./drivers/md/md.c	2006-05-21 08:46:08.000000000 +1000
@@ -5171,8 +5171,10 @@ static int md_notify_reboot(struct notif
 		printk(KERN_INFO "md: stopping all md devices.\n");
 
 		ITERATE_MDDEV(mddev,tmp)
-			if (mddev_trylock(mddev))
+			if (mddev_trylock(mddev)) {
 				do_md_stop (mddev, 1);
+				mddev_unlock(mddev);
+			}
 		/*
 		 * certain more exotic SCSI devices are known to be
 		 * volatile wrt too early system reboots. While the
