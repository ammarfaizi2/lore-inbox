Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270600AbRH3AkY>; Wed, 29 Aug 2001 20:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269817AbRH3AkP>; Wed, 29 Aug 2001 20:40:15 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:64004 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S269238AbRH3Aj4>; Wed, 29 Aug 2001 20:39:56 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: David Rees <dbr@greenhydrant.com>
Date: Thu, 30 Aug 2001 10:39:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15245.35636.82680.966567@notabene.cse.unsw.edu.au>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        ext3-users@redhat.com
Subject: Re: kupdated, bdflush and kjournald stuck in D state on RAID1 device (deadlock?)
In-Reply-To: message from David Rees on Wednesday August 29
In-Reply-To: <3B8D54F3.46DC2ABB@zip.com.au>
	<20010829141451.A20968@greenhydrant.com>
	<3B8D60CF.A1400171@zip.com.au>
	<20010829144016.C20968@greenhydrant.com>
	<3B8D6BF9.BFFC4505@zip.com.au>
	<20010829153818.B21590@greenhydrant.com>
	<3B8D712C.1441BC5A@zip.com.au>
	<20010829155633.D21590@greenhydrant.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday August 29, dbr@greenhydrant.com wrote:
> On Wed, Aug 29, 2001 at 03:48:12PM -0700, Andrew Morton wrote:
> > David Rees wrote:
> >
> > Are you able to access all the underlying devices on the array?
> > For example, if /dev/md0 consists of /dev/hda1 and /dev/hdb2,
> > can you run 'cp /dev/hda1 /dev/null' and 'cp /dev/hdb1 /dev/null'?
> > 
> > If so, then I'm all out of ideas.  Your raid1 buffers have disappeared
> > into thin air :(
> 
> Copying as I write this (actually, `cat /dev/hde1 > /dev/null` and `cat
> /dev/hdg1 >/dev/null`.
> 
> Well, if no-one knows, I'll reboot and cross my fingers that it doesn't
> happen again.

Thanks David and Andrew for providing all the helpful details.
I know what happened.  As Andrew said, the raid1 buffers have simply
disappeared into thin air.
The line that makes them invisible is
			r1_bh->state = 0;
at line 165 in drivers/md/raid1.c.  This should be more like
			r1_bh->state = (1 << R1BH_PreAlloc);
We need to clear the Uptodate bit and the Phase bit, but not
the prealloc bit.  

Linus:  Please consider applying this patch.

NeilBrown



--- drivers/md/raid1.c	2001/08/30 00:36:54	1.1
+++ drivers/md/raid1.c	2001/08/30 00:37:03
@@ -162,7 +162,7 @@
 			conf->freer1 = r1_bh->next_r1;
 			conf->freer1_cnt--;
 			r1_bh->next_r1 = NULL;
-			r1_bh->state = 0;
+			r1_bh->state = (1 << R1BH_PreAlloc);
 			r1_bh->bh_req.b_state = 0;
 		}
 		md_spin_unlock_irq(&conf->device_lock);
