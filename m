Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754014AbWKGFFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014AbWKGFFc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 00:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754013AbWKGFFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 00:05:32 -0500
Received: from ns2.suse.de ([195.135.220.15]:48292 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1754009AbWKGFFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 00:05:31 -0500
From: Neil Brown <neilb@suse.de>
To: dean gaudet <dean@arctic.org>
Date: Tue, 7 Nov 2006 16:05:23 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17744.5139.805134.577609@cse.unsw.edu.au>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Greg KH <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001 of 6] md: Send online/offline uevents when an md
 array starts/stops.
In-Reply-To: message from dean gaudet on Monday November 6
References: <20061031164814.4884.patches@notabene>
	<1061031060046.5034@suse.de>
	<20061031211615.GC21597@suse.de>
	<3ae72650611020413q797cf62co66f76b058a57104b@mail.gmail.com>
	<17737.58737.398441.111674@cse.unsw.edu.au>
	<1162475516.7210.32.camel@pim.off.vrfy.org>
	<17738.59486.140951.821033@cse.unsw.edu.au>
	<1162542178.14310.26.camel@pim.off.vrfy.org>
	<17742.32612.870346.954568@cse.unsw.edu.au>
	<Pine.LNX.4.64.0611060030320.20361@twinlark.arctic.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 6, dean@arctic.org wrote:
> On Mon, 6 Nov 2006, Neil Brown wrote:
> 
> > This creates a deep disconnect between udev and md.
> > udev expects a device to appear first, then it created the
> > device-special-file in /dev.
> > md expect the device-special-file to exist first, and then created the
> > device on the first open.
> 
> could you create a special /dev/mdx device which is used to 
> assemble/create arrays only?  i mean literally "mdx" not "mdX" where X is 
> a number.  mdx would always be there if md module is loaded... so udev 
> would see the driver appear and then create the /dev/mdx.  then mdadm 
> would use /dev/mdx to do assemble/creates/whatever and cause other devices 
> to appear/disappear in a manner which udev is happy with.
> 
> (much like how /dev/ptmx is used to create /dev/pts/N entries.)
> 
> doesn't help legacy mdadm binaries... but seems like it fits the New World 
> Order.
> 
> or hm i suppose the New World Order is to eschew binary interfaces and 
> suggest a /sys/class/md/ hierarchy with a bunch of files you have to splat 
> ascii data into to cause an array to be created/assembled.

I have the following patch sitting in my patch queue (since about
March).
It does what you suggest via /sys/module/md-mod/parameters/MAGIC_FILE
which is the only md-specific part of the /sys namespace that I could
find.

However I'm not at all convinced that it is a good idea.  I would much
rather have mdadm control device naming than leave it up to udev.

An in any case, we have the semantic that opening an md device-file
creates the device, and we cannot get rid of that semantic without a
lot of warning and a lot of pain.  And adding a new semantic isn't
really going to help.

We simply need to find the best way for udev and md to play together,
and I think we can achieve something quite workable.  Both sides just
have to give a bit.

NeilBrown


Allow md devices to be created by writing to sysfs.

Until now, to create an md device, you needed to open the relevant 
device-special file.  This created a catch-22 with udev.

This patch provides an alternate.
Options include

 echo 10 > /sys/module/md-mod/paramters/create
to create legacy device with minor 10,
 echo d10 > /sys/module/md-mod/paramters/create
to create partitionable device 10<<6
 cat /sys/module/md-mod/paramters/next_free_legacy
to return major:minor device of an unused legacy array, which will exist.
 cat /sys/module/md-mod/paramters/next_free_partitionable
to return major:minor device of an unused partitionable array which will exist.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-03-27 09:20:58.000000000 +1100
+++ ./drivers/md/md.c	2006-03-27 09:20:56.000000000 +1100
@@ -5525,6 +5525,62 @@ module_param_call(start_ro, set_ro, get_
 module_param(start_dirty_degraded, int, 0644);
 
 
+static int md_create(const char *val, struct kernel_param *kp)
+{
+	/* NN or dNN creates the numbered device */
+	int part = 0;
+	int num;
+	char *e;
+	if (*val == 'd' || *val == 'p') {
+		part = 1;
+		val++;
+	}
+	num = simple_strtoul(val, &e, 10);
+	if (*val && (*e == '\0' || *e == '\n')) {
+		/* success! */
+		dev_t dev;
+		if (part)
+			dev = MKDEV(mdp_major, num << MdpMinorShift);
+		else
+			dev = MKDEV(MD_MAJOR, num);
+		md_probe(dev, NULL, NULL);
+		return 0;
+	}
+	return -EINVAL;
+}
+static int md_next_free(char *buffer, struct kernel_param *kp)
+{
+	mddev_t *mddev;
+	int major = MD_MAJOR;
+	int inc = 1;
+	int next = MKDEV(MD_MAJOR,0);
+	if (kp->arg) {
+		next = MKDEV(mdp_major,0);
+		major = mdp_major;
+		inc = 1 << MdpMinorShift;
+	}
+	spin_lock(&all_mddevs_lock);
+	list_for_each_entry(mddev, &all_mddevs, all_mddevs)
+		if (MAJOR(mddev->unit) == major) {
+			if (atomic_read(&mddev->active)<=1 &&
+				mddev->pers == NULL &&
+				mddev->raid_disks == 0) {
+				next = mddev->unit;
+				break;
+			} else if (mddev->unit >= next)
+				next = mddev->unit + inc;
+		}
+	spin_unlock(&all_mddevs_lock);
+	md_probe(next, NULL, NULL);
+	return sprintf(buffer, "%d:%d", major, MINOR(next));
+}
+static int ignore(const char *val, struct kernel_param *kp) { return -EINVAL; }
+
+
+module_param_call(create, md_create, NULL, NULL, 0200);
+module_param_call(next_free_legacy, ignore, md_next_free, (void*)0, 0400);
+module_param_call(next_free_partitionable, ignore, md_next_free, (void*)1, 0400);
+
 EXPORT_SYMBOL(register_md_personality);
 EXPORT_SYMBOL(unregister_md_personality);
 EXPORT_SYMBOL(md_error);
