Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751157AbWFEOm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWFEOm4 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 10:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWFEOm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 10:42:56 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:64444 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751157AbWFEOm4 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 10:42:56 -0400
Message-Id: <200606051442.k55EghgI004703@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc5-mm3 - crash in cfq_queue_empty() after iosched change
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1149518563_2861P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Jun 2006 10:42:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1149518563_2861P
Content-Type: text/plain; charset=us-ascii

I've been hitting this about once every two weeks for a while now, probably
back to a 2.6.16-rc or so.  It always bites at the same time while my laptop
was at a point very late in bootup. I finally caught one when I had pen, paper,
*and* time to chase it a bit rather than reboot.  Sorry for the very partial
traceback, it's not a good CTS day and I didn't have a digital camera handy.

BUG: Unable to handle kernel NULL pointer dereference at 0x0000005c
EIP at cfq_queue_empty+0x9/0x15
call trace:
	elv_queue_empty+0x20/0x22
	ide_do_request+0xa4/0x788
	ide_intr+0x1ec/0x236
	handle_IRQ_eent+0x27/0x52
	handle_level_IRQ+0xb6
	do_IRQ+0x5d/0x78
	common_interrupt+0x1a/0x20

In my .config:

CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_IOSCHED="anticipatory"

This happened very soon (within a few milliseconds or two) after my /etc/rc.local did:

echo cfq >| /sys/block/hda/queue/scheduler

(The next executable statement in /etc/rc.local is this:
echo noop >| /sys/block/hdb/queue/scheduler  and 'last sysfs file' still
pointed at /dev/hda).

It *looks* like the problem is in elevator_switch() in block/elevator.c:

       while (q->rq.elvpriv) {
                blk_remove_plug(q);
                q->request_fn(q);
                spin_unlock_irq(q->queue_lock);
                msleep(10);
                spin_lock_irq(q->queue_lock);
                elv_drain_elevator(q);
        }

this--> spin_unlock_irq(q->queue_lock);

        /*
         * unregister old elevator data
         */
        elv_unregister_queue(q);
        old_elevator = q->elevator;

        /*
         * attach and start new elevator
         */
        if (elevator_attach(q, e))
                goto fail;

should be down here someplace, after elevator_attach(), I suspect?
Looks like the disk popped an IRQ after we had installed the iosched_cfq.ops[]
but q->elevator->elevator_data hadn't been initialized yet...

(I'd attach a patch, except I'm not positive I have the diagnosis right?)


--==_Exmh_1149518563_2861P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEhELjcC3lWbTT17ARApxLAKCojOY0xLrG6IN/muHUlhH4wCuOqgCgvbz+
E7jUg+f10dM3L+52vDFoDn4=
=QGwB
-----END PGP SIGNATURE-----

--==_Exmh_1149518563_2861P--
