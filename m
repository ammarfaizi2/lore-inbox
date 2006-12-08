Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164355AbWLHBbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164355AbWLHBbj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164373AbWLHBbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:31:39 -0500
Received: from ns2.suse.de ([195.135.220.15]:48148 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164355AbWLHBbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:31:38 -0500
From: Neil Brown <neilb@suse.de>
To: Jiri Kosina <jikos@jikos.cz>
Date: Fri, 8 Dec 2006 12:31:41 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17784.49277.120641.30296@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-mm2
In-Reply-To: message from Jiri Kosina on Tuesday December 5
References: <20061128020246.47e481eb.akpm@osdl.org>
	<Pine.LNX.4.64.0611290147400.28502@twin.jikos.cz>
	<17780.52337.767875.963882@cse.unsw.edu.au>
	<17780.61551.896455.157225@cse.unsw.edu.au>
	<Pine.LNX.4.64.0612050844110.28502@twin.jikos.cz>
	<Pine.LNX.4.64.0612052305490.28502@twin.jikos.cz>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday December 5, jikos@jikos.cz wrote:
> On Tue, 5 Dec 2006, Jiri Kosina wrote:
> 
> > It seemed to be 100% reproducible - happened on every boot of FC6 
> > system, so it was probably triggered by some raid/lvm command executed 
> > from init scripts after boot, but I didn't examine it further. As soon 
> > as I get to the machine where this happens, I will try to narrow it down 
> > to the exact userspace command that triggers it and will let you know 
> > (probably this evening).
> 
> OK, so more details follow (I am not sure how valuable they are, though). 

They do help a bit..

I've found a possible race that could possibly be related to this
BUG.  Can you try this patch and see if it helps?

Note: this isn't the final form I would use to fix the race, but if it
makes a difference, then it tells me I am on the right track.

Thanks,
NeilBrown


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-12-06 14:49:20.000000000 +1100
+++ ./drivers/md/md.c	2006-12-07 10:29:40.000000000 +1100
@@ -222,10 +222,14 @@ static inline mddev_t *mddev_get(mddev_t
 	return mddev;
 }
 
+static DEFINE_MUTEX(disks_mutex);
 static void mddev_put(mddev_t *mddev)
 {
-	if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
+	mutex_lock(&disks_mutex);
+	if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock)) {
+		mutex_unlock(&disks_mutex);
 		return;
+	}
 	list_del(&mddev->all_mddevs);
 	spin_unlock(&all_mddevs_lock);
 
@@ -234,6 +238,7 @@ static void mddev_put(mddev_t *mddev)
 	blk_cleanup_queue(mddev->queue);
 	mddev->queue = NULL;
 	kobject_unregister(&mddev->kobj);
+	mutex_unlock(&disks_mutex);
 }
 
 static mddev_t * mddev_find(dev_t unit)
@@ -2948,7 +2953,6 @@ int mdp_major = 0;
 
 static struct kobject *md_probe(dev_t dev, int *part, void *data)
 {
-	static DEFINE_MUTEX(disks_mutex);
 	mddev_t *mddev = mddev_find(dev);
 	struct gendisk *disk;
 	int partitioned = (MAJOR(dev) != MD_MAJOR);
