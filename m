Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130130AbQKFDNV>; Sun, 5 Nov 2000 22:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129906AbQKFDNM>; Sun, 5 Nov 2000 22:13:12 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:21770 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129745AbQKFDNC>; Sun, 5 Nov 2000 22:13:02 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: ryan <ryan@netidea.com>
Date: Mon, 6 Nov 2000 14:12:41 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14854.8617.282831.205647@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: Kernel 2.4.0test10 crash (RAID+SMP)
In-Reply-To: message from ryan on Sunday November 5
In-Reply-To: <1459.973469046@kao2.melbourne.sgi.com>
	<3A060BE5.8877F477@netidea.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday November 5, ryan@netidea.com wrote:
> > Which tells us precisely nothing.  Saying "a message like" is no good.
> > You need to follow the procedure in linux/REPORTING-BUGS, including the
> > _exact_ message, run through ksymoops if necessary.
> 
> Ok, for your enlightenment:
...

> 
> And a final note, I applied the alpha raid patches to kernel 2.2.16 to
> produce this raid array (just a simple mirror for /home), so the
> question is, could it be the array data itself? perhaps mkraid under
> 2.4.0test10 would be good? Either way I dont think a hardcrash is a
> reasonable response ;-)

The data format is the same.  This isn't data related..

....
> 
> >>EIP; c0223186 <stext_lock+451e/9408>   <=====
> Trace; c010be41 <handle_IRQ_event+4d/78>
> Trace; c010c026 <do_IRQ+a6/f4>
> Trace; c010a764 <ret_from_intr+0/20>
> Trace; c88577c3 <END_OF_CODE+8524/????>
> Trace; c8857861 <END_OF_CODE+85c2/????>
> Trace; c018bb11 <end_that_request_first+61/b8>
> Trace; c01b10aa <ide_end_request+32/84>
> Trace; c01b9594 <ide_dma_intr+64/9c>
> Trace; c01b2953 <ide_intr+12f/198>
> Trace; c01b9530 <ide_dma_intr+0/9c>
> Trace; c010be41 <handle_IRQ_event+4d/78>
> Trace; c010c026 <do_IRQ+a6/f4>
> Trace; c0108900 <default_idle+0/34>
> Trace; c0108900 <default_idle+0/34>
> Trace; c010a764 <ret_from_intr+0/20>
> Trace; c0108900 <default_idle+0/34>
> Trace; c0108900 <default_idle+0/34>
> Trace; c0100018 <startup_32+18/cc>
> Trace; c0108920 <default_idle+20/34>
> Trace; c0108992 <cpu_idle+3e/54>
> Trace; 0c01e687 Before first symbol
> Trace; c019c13f <unblank_screen+7b/c4>
> Code;  c0223186 <stext_lock+451e/9408>

It looks like an interupt is happening while another interrupt is
happening, which should be impossible... but it isn't.

raid1.c:end_sync_write calls raid1_free_buff which calls
spin_lock_irq()/spin_unlock_irq(), which unmasks interrupts.  but
end_sync_write is called from interupt context.  This is bad.

Try:
--- drivers/md/raid1.c	2000/11/01 23:32:36	1.4
+++ drivers/md/raid1.c	2000/11/06 03:11:00
@@ -91,7 +91,8 @@
 
 static inline void raid1_free_bh(raid1_conf_t *conf, struct buffer_head *bh)
 {
-	md_spin_lock_irq(&conf->device_lock);
+	unsigned long flags;
+	spin_lock_irqsave(&conf->device_lock, flags);
 	while (bh) {
 		struct buffer_head *t = bh;
 		bh=bh->b_next;
@@ -103,7 +104,7 @@
 			conf->freebh_cnt++;
 		}
 	}
-	md_spin_unlock_irq(&conf->device_lock);
+	spin_unlock_irqrestore(&conf->device_lock, flags);
 	wake_up(&conf->wait_buffer);
 }
 
@@ -182,10 +183,11 @@
 	r1_bh->mirror_bh_list = NULL;
 
 	if (test_bit(R1BH_PreAlloc, &r1_bh->state)) {
-		md_spin_lock_irq(&conf->device_lock);
+		unsigned long flags;
+		spin_lock_irqsave(&conf->device_lock, flags);
 		r1_bh->next_r1 = conf->freer1;
 		conf->freer1 = r1_bh;
-		md_spin_unlock_irq(&conf->device_lock);
+		spin_unlock_irqrestore(&conf->device_lock, flags);
 	} else {
 		kfree(r1_bh);
 	}
@@ -229,14 +231,15 @@
 
 static inline void raid1_free_buf(struct raid1_bh *r1_bh)
 {
+	unsigned long flags;
 	struct buffer_head *bh = r1_bh->mirror_bh_list;
 	raid1_conf_t *conf = mddev_to_conf(r1_bh->mddev);
 	r1_bh->mirror_bh_list = NULL;
 	
-	md_spin_lock_irq(&conf->device_lock);
+	spin_lock_irqsave(&conf->device_lock, flags);
 	r1_bh->next_r1 = conf->freebuf;
 	conf->freebuf = r1_bh;
-	md_spin_unlock_irq(&conf->device_lock);
+	spin_unlock_irqrestore(&conf->device_lock, flags);
 	raid1_free_bh(conf, bh);
 }
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
