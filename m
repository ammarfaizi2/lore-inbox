Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbWAKWyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWAKWyJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWAKWyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:54:09 -0500
Received: from cantor2.suse.de ([195.135.220.15]:37782 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932505AbWAKWyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:54:08 -0500
From: Neil Brown <neilb@suse.de>
To: sander@humilis.net
Date: Thu, 12 Jan 2006 09:53:59 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17349.35975.929839.197710@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at fs/sysfs/symlink.c:87 happens with 2.6.15 too
In-Reply-To: message from Sander on Wednesday January 11
References: <20060111151308.GA30047@favonius>
	<20060111192055.GB19209@favonius>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday January 11, sander@humilis.net wrote:
> Sander wrote (ao):
> # I'll try plain 2.6.15 now.
> 
> The same thing happens. I try to create a raid1 over nine disks (eight
> on Promise SX8):
> 
> mdadm -C -l1 -n9 /dev/md0 /dev/sda1 /dev/sx8/0p1 /dev/sx8/1p1 /dev/sx8/2p1 /dev/sx8/3p1 /dev/sx8/4p1 /dev/sx8/5p1 /dev/sx8/6p1 /dev/sx8/7p1
> 
> It Segfaults and gives this:
> 
> Difference with 2.6.15-mm2 is that 2.6.15 keeps on running.
> 
> I'll enable some debug options now. Any advice on what I can try besides
> this? Am I doing something wrong?

No, you aren't doing anything wrong.

It appears that the 'kobject_add' call in bind_rdev_to_array is not
setting the ->dentry field for the kobject.
i.e. it is failing to create
   /sys/block/md0/md/dev-XXXX

where 'XXXX' is the internal name for the component device, as
returned by 'bdevname'.  The most likely reason I can think of for
this is that the name is already in use. i.e. different sx devices get
the same name.... let's see....

Close, but not quite.
sx8 creates device names with a '/' in them as we can see from:
> 
> [ 2281.547827] md: bind<sda1>
> [ 2281.547877] md: bind<sx8/0p1>
                             ^

That's unfortunate.  We will have to remove them.
You will find that the names in /sys/block look like
    /sys/block/sx8!0

The following patch should achieve the same substitution for
md.

NeilBrown

--------------------------
Remove slashed from disk names when creation dev names in sysfs

e.g. The sx8 driver uses names like sx8/0.
This would make a md component dev name like
   /sys/block/md0/md/dev-sx8/0
which is no allowed.  So we change the '/' to '!' just like
fs/partitions/check.c(register_disk) does.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    3 +++
 1 file changed, 3 insertions(+)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-01-12 09:43:11.000000000 +1100
+++ ./drivers/md/md.c	2006-01-12 09:44:39.000000000 +1100
@@ -1238,6 +1238,7 @@ static int bind_rdev_to_array(mdk_rdev_t
 	mdk_rdev_t *same_pdev;
 	char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
 	struct kobject *ko;
+	char *s;
 
 	if (rdev->mddev) {
 		MD_BUG();
@@ -1277,6 +1278,8 @@ static int bind_rdev_to_array(mdk_rdev_t
 	bdevname(rdev->bdev,b);
 	if (kobject_set_name(&rdev->kobj, "dev-%s", b) < 0)
 		return -ENOMEM;
+	while ( (s=strchr(rdev->kobj.k_name, '/')) != NULL)
+		*s = '!';
 			
 	list_add(&rdev->same_set, &mddev->disks);
 	rdev->mddev = mddev;
