Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266656AbRGHGDD>; Sun, 8 Jul 2001 02:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266668AbRGHGCy>; Sun, 8 Jul 2001 02:02:54 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:16520 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S266656AbRGHGCk>; Sun, 8 Jul 2001 02:02:40 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: ext3-users@redhat.com
Date: Sun, 8 Jul 2001 16:02:23 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15175.63343.920493.735551@notabene.cse.unsw.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>, "Stephen C. Tweedie" <sct@redhat.com>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Peter J. Braam" <braam@clusterfilesystem.com>
Subject: Re: ext3-2.4-0.9.0
In-Reply-To: message from Andrew Morton on Sunday July 8
In-Reply-To: <3B45D6DB.70B9D754@uow.edu.au>
	<15175.35317.985921.670835@notabene.cse.unsw.edu.au>
	<3B47B1DC.3B7C387C@uow.edu.au>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday July 8, andrewm@uow.edu.au wrote:
> 
> Could well be.  ext3 will happily feed 2,000 buffers into submit_bh()
> prior to running tq_disk.  Everything else is happy with this, so I blame
> nfsd and raid5 :)  Rapid fsyncs will break this up, however.
> 

raid5 is definately happy with large sequences of requests between
tq_disk (infact, that is best), but I think I have found a situation
where lots of small requests can confuse it.  It seems that your
intuation about the direction of blame is better than mine :-)

Then a write request happens to raid5, the queue is (potentially)
plugged, and then the request is (potentially) queued, and there is a
window between the two where the queue can be unplugged by another
process.   If this happens, then the tq_disk run the follows the write
request will not wake-up the raid5d, so the raid5 queue will not be
run, and the request will just sit there until something else causes
raid5d to run.
I'm guessing that ext3 imposes more sequencing on requests than ext2
does, and so it is easier for one request being stalled to stall the
whole filesystem.

In any case, the follow patch against raid5 seems to have relieved the
situation, but more testing is underway.

So ThankYou to ext3 for helping to find a bug in raid5 :-)

NeilBrown

--- drivers/md/raid5.c	2001/07/07 06:23:02	1.1
+++ drivers/md/raid5.c	2001/07/08 00:22:52
@@ -66,9 +66,10 @@
 			BUG();
 		if (atomic_read(&conf->active_stripes)==0)
 			BUG();
-		if (test_bit(STRIPE_DELAYED, &sh->state))
+		if (test_bit(STRIPE_DELAYED, &sh->state)) {
 			list_add_tail(&sh->lru, &conf->delayed_list);
-		else if (test_bit(STRIPE_HANDLE, &sh->state)) {
+			md_wakeup_thread(conf->thread);
+		} else if (test_bit(STRIPE_HANDLE, &sh->state)) {
 			list_add_tail(&sh->lru, &conf->handle_list);
 			md_wakeup_thread(conf->thread);
 		} else {
@@ -1167,10 +1168,9 @@
 
 	raid5_activate_delayed(conf);
 	
-	if (conf->plugged) {
+	if (conf->plugged)
 		conf->plugged = 0;
-		md_wakeup_thread(conf->thread);
-	}	
+	md_wakeup_thread(conf->thread);
 	spin_unlock_irqrestore(&conf->device_lock, flags);
 }
 

