Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbVCDPsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbVCDPsF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 10:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbVCDPsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 10:48:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55512 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262897AbVCDPrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 10:47:53 -0500
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="QP67Nc5ul6"
Content-Transfer-Encoding: 7bit
Message-ID: <16936.33587.974061.237160@segfault.boston.redhat.com>
Date: Fri, 4 Mar 2005 10:48:03 -0500
To: autofs@linux.kernel.org
CC: raven@themaw.net, linux-kernel@vger.kernel.org
Subject: autofs4 patch: autofs4_wait can leak memory
X-Mailer: VM 7.19 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QP67Nc5ul6
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

Hi,

There is a memory in the autofs4_wait function, if multiple processes are
waiting on the same queue:

	name = kmalloc(NAME_MAX + 1, GFP_KERNEL);
	if (!name)
		return -ENOMEM;
	...

	if ( !wq ) {
		/* Create a new wait queue */
		wq = kmalloc(sizeof(struct autofs_wait_queue), GFP_KERNEL);
		if ( !wq ) {
			kfree(name);
			up(&sbi->wq_sem);
			return -ENOMEM;
		}
		...
		wq->name = name;

		...
	} else {
		atomic_inc(&wq->wait_ctr);
		up(&sbi->wq_sem);
		...
       }

In the else clause, we forget to free the name we kmalloc'd above.  This is
pretty easy to trigger with the following reproducer:

setup an automount map as follows:
for n in `seq 1 48`; do echo "$n server:/export/$n" >> /etc/auto.test; done
setup a master map entry to point at this:
echo "/test /etc/auto.test --timeout=1" >> /etc/auto.master

Now, assuming the nfs server was setup to export said directories, run the
following shell script in two xterms:

#!/bin/sh
while true; do
        for n in `seq 1 48`; do
                ls /test/$n
        done
        sleep 2
done

and watch the size-256 slab cache grow

Within 4 minutes, I had the size-256 cache grow to 384k.  On a kernel with
the below patch applied, the size-256 remained constant during an over-night
run.

The patch is against linux-2.6.9, but it applies to 2.6.11, as well.

-Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>


--QP67Nc5ul6
Content-Type: text/plain
Content-Disposition: inline;
	filename="linux-2.6.9-autofs-mem-leak.patch"
Content-Transfer-Encoding: 7bit

--- linux-2.6.9/fs/autofs4/waitq.c.orig	2005-03-03 17:09:11.534047192 -0500
+++ linux-2.6.9/fs/autofs4/waitq.c	2005-03-03 17:09:21.777489952 -0500
@@ -224,6 +224,7 @@ int autofs4_wait(struct autofs_sb_info *
 	} else {
 		atomic_inc(&wq->wait_ctr);
 		up(&sbi->wq_sem);
+		kfree(name);
 		DPRINTK("existing wait id = 0x%08lx, name = %.*s, nfy=%d",
 			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify);
 	}

--QP67Nc5ul6--
