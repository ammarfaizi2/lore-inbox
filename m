Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWEIRlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWEIRlx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 13:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWEIRlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 13:41:53 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:53127 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S1750780AbWEIRlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 13:41:52 -0400
Date: Tue, 9 May 2006 19:41:44 +0200
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Bill Nottingham <notting@redhat.com>, Kay Sievers <kay.sievers@vrfy.org>,
       Pierre Ossman <drzeus-list@drzeus.cx>, Andrew Morton <akpm@osdl.org>,
       ambx1@neo.rr.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
Message-ID: <20060509174143.GA2320@ojjektum.uhulinux.hu>
References: <20060302165816.GA13127@vrfy.org> <44082E14.5010201@drzeus.cx> <4412F53B.5010309@drzeus.cx> <20060311173847.23838981.akpm@osdl.org> <4414033F.2000205@drzeus.cx> <20060312172332.GA10278@vrfy.org> <20060313165719.GB4147@devserv.devel.redhat.com> <20060313192411.GA23380@vrfy.org> <20060313222644.GD1311@devserv.devel.redhat.com> <20060314152944.797390cd.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060314152944.797390cd.vsu@altlinux.ru>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Mar 14, 2006 at 03:29:44PM +0300, Sergey Vlasov wrote:
> On Mon, 13 Mar 2006 17:26:44 -0500 Bill Nottingham wrote:
> 
> > Kay Sievers (kay.sievers@vrfy.org) said: 
> > > > See:
> > > >   https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=178998
> 
> I have written a comment in that bugzilla entry, but it is probably too
> terse, so I'll try to explain the problem and my proposed solution
> better.
> 
> > > > This doesn't work for everything.
> > > 
> > > Sure not, and I don't think "everything" in PnP will ever work. :) But
> > > it does the same as the modalias patch to the kernel we are talking about.
> > > There are device table entries completely missing and some other don't
> > > match. Some of them can be fixed by adding the aliases as modprobe.conf
> > > entries.
> > 
> > Well, it's just that if this is the solution proposed, I'd like it if
> > it worked for any of the people who are seeing problems - in our bugs,
> > it hasn't helped any of them yet.
> 
> There are two kinds of PNP drivers:
> 
> 1) PNP device drivers, which use struct pnp_driver.  These drivers use
>    struct pnp_device_id in id_table entries; struct pnp_device_id
>    contains a single device ID field which is used for matching.
>    Aliases for these drivers have the form:
> 
> 	pnp:dXXXYYYY*
> 
>    where XXXYYYY is the PNP ID which is matched.
> 
> 2) PNP card drivers, which use struct pnp_card_driver.  These drivers
>    use struct pnp_card_device_id in id_table entries; struct
>    pnp_card_device_id contains ID for the card itself and a variable
>    number of logical device IDs.  drivers/pnp/card.c:match_card() uses
>    these rules for matching struct pnp_card_device_id to a device:
> 
>     a) the card IDs must match;
>     b) all device IDs mentioned in struct pnp_card_device_id must be
>        present in the card, but can be in any order (and there may be
>        more devices than listed in the ID table).
> 
>    Aliases for card drivers currently have the form:
> 
> 	pnp:cXXXYYYYdXXXYYYYdXXXYYYY*
> 
>    The first "cXXXYYYY" part is the card ID, and "dXXXYYYY" parts are
>    device IDs (there may be up to PNP_MAX_DEVICES == 8 of them).
> 
> Now, for the drivers of the first type the only problem is that the
> devices can have several compatible IDs in addition to the primary ID,
> and this requires either a multiline "modalias" attribute, or a helper
> script to call modprobe multiple times with the pnp:dXXXYYYY alias for
> all available IDs.  
> 
> Drivers of the second type - PNP card drivers - are only used for isapnp
> (pnpbios and pnpacpi have only plain devices).  Cards itself have only a
> single ID (there are no compatible IDs for cards), but every logical
> device on a card can have up to DEVICE_COUNT_COMPATIBLE == 4 compatible
> IDs in addition to the primary ID.
> 
> (BTW, #define DEVICE_COUNT_COMPATIBLE 4 is duplicated in <linux/pci.h>
> and <linux/isapnp.h> - if these values were different, it would be a
> nasty bug.)
> 
> For the card drivers, in addition to the problem with compatible IDs, we
> have another problem - the alias format for them is wrong!  The problem
> is that if device IDs in the alias happen to be in a different order
> than the same IDs in the actual device (or even in the same order, but
> some devices are not mentioned in the ID table), fnmatch() used by
> modprobe will not match this alias.
> 
> To solve this problem, I suggest to do this:
> 
> 1) Change the alias format for PNP card drivers to require logical
>    device IDs to be sorted, and add an "*" before every device ID part.
>    The alias format becomes:
> 
> 	pnp:cXXXYYYY*dXXXYYYY*dXXXYYYY*
> 
> 2) Update scripts/mod/file2alias.c:do_pnp_card_entry() to write the new
>    alias format (it should sort device IDs - no need to change all
>    drivers to list device IDs in sorted order and create potential for
>    bugs when someone adds a non-sorted entry).
> 
> 3) Update /etc/udev/isapnp script mentioned in bugzilla entry to sort
>    device ID values before concatenating them.
> 
> After dust settles, we can then add "modalias" attribute generation for
> PNP card devices to the kernel - note that this attribute would have
> only a single value which would list the card ID and all (primary and
> compatible) IDs of all logical devices in sorted order.
> 
> BTW, we can change the alias format for PNP device drivers to
> 
> 	pnp:*dXXXYYYY*
> 
> (note the additional "*" before the device ID).  This would allow us to
> have a single-value "modalias" attribute for PNP logical devices too -
> it would have the form
> 
> 	pnp:dXXXYYYYdXXXYYYYdXXXYYYY
> 
> (listing all IDs, in this case sorting is not required, because each
> driver will match at most only a single dXXXYYYY entry).


Hi all,

Sorry for the long quotation, but I think you might have forgotten what 
this thread was about.

Basically I implemented the above things, to be precise:
 - the alias for the pnp device drivers are in the form "pnp:*dXXXYYYY*" 
   instead of the old "pnp:dXXXYYYY*"
 - the alias for the pnp card drivers are in the form
     "pnp:cXXXYYYY*dXXXYYYY*dXXXYYYY*"
   instead of the old
     "pnp:cXXXYYYYdXXXYYYYdXXXYYYY*"
   _and_ the device id part are ordered
 - add a "modalias" file under sysfs for each pnp device, containing
     "pnp:dXXXYYYYdXXXYYYY..."
   where "dXXXYYYY" is appended for each pnp id the device has
 - add a "modalias" file under sysfs for each pnp card, containing
     "pnp:cXXXYYYYdXXXYYYYdXXXYYYY..."
   where "cXXXYYYY" is the card_id, and the device ids are appended 
   after it, _ordered_.


With this applied, I think we are close to be able to drop 
special-casing the pnp bus in udev rules.

What still needs to be done is exporting the MODALIAS env variable.
(Sorry, I do not see how it could be added elegantly.)

Please tell me what you think of it.

thanks,
pozsy



diff -urd a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
--- a/scripts/mod/file2alias.c	2006-05-02 23:38:44.000000000 +0200
+++ b/scripts/mod/file2alias.c	2006-05-08 21:57:33.000000000 +0200
@@ -273,21 +273,31 @@
 static int do_pnp_entry(const char *filename,
 			struct pnp_device_id *id, char *alias)
 {
-	sprintf(alias, "pnp:d%s", id->id);
+	sprintf(alias, "pnp:*d%s", id->id);
 	return 1;
 }
 
+static int _compare_pnp_id(const void *a, const void *b)
+{
+	const char *aa = a;
+	const char *bb = b;
+	return strcmp(aa, bb);
+}
+
 /* looks like: "pnp:cCdD..." */
 static int do_pnp_card_entry(const char *filename,
 			struct pnp_card_device_id *id, char *alias)
 {
-	int i;
+	int i, j;
 
 	sprintf(alias, "pnp:c%s", id->id);
-	for (i = 0; i < PNP_MAX_DEVICES; i++) {
-		if (! *id->devs[i].id)
-			break;
-		sprintf(alias + strlen(alias), "d%s", id->devs[i].id);
+	for (j = 0; j < PNP_MAX_DEVICES; j++) {
+		if (! *id->devs[j].id)
+		    break;
+	}
+	qsort(id->devs, j, sizeof(id->devs[0]), _compare_pnp_id);
+	for (i = 0; i < j; i++) {
+		sprintf(alias + strlen(alias), "*d%s", id->devs[i].id);
 	}
 	return 1;
 }
diff -Naurd a/drivers/pnp/card.c b/drivers/pnp/card.c
--- a/drivers/pnp/card.c	2006-05-02 23:38:44.000000000 +0200
+++ b/drivers/pnp/card.c	2006-05-09 19:25:08.000000000 +0200
@@ -8,6 +8,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/sort.h>
 #include <linux/pnp.h>
 #include "base.h"
 
@@ -159,10 +160,34 @@
 
 static DEVICE_ATTR(card_id,S_IRUGO,pnp_show_card_ids,NULL);
 
+static ssize_t pnp_card_modalias_show(struct device *dmdev, struct device_attribute *attr, char *buf)
+{
+	char *str = buf;
+	struct pnp_card *card = to_pnp_card(dmdev);
+	struct pnp_id * pos = card->id;
+	struct pnp_dev *dev;
+	int i, count = 0;
+	char ids[PNP_MAX_DEVICES][PNP_ID_LEN];
+
+	card_for_each_dev(card, dev) {
+		strcpy(&ids[count++], dev->id);
+	}
+	sort(ids, count, PNP_ID_LEN, strcmp, NULL);
+	str += sprintf(str, "pnp:c%s", pos->id);
+	for (i = 0; i < count; i++) {
+		str += sprintf(str, "d%s", ids[i]);
+	}
+	str += sprintf(str, "\n");
+	return (str - buf);
+}
+
+static DEVICE_ATTR(modalias,S_IRUGO,pnp_card_modalias_show,NULL);
+
 static int pnp_interface_attach_card(struct pnp_card *card)
 {
 	device_create_file(&card->dev,&dev_attr_name);
 	device_create_file(&card->dev,&dev_attr_card_id);
+	device_create_file(&card->dev,&dev_attr_modalias);
 	return 0;
 }
 
diff -Naurd a/drivers/pnp/interface.c b/drivers/pnp/interface.c
--- a/drivers/pnp/interface.c	2006-05-02 23:38:44.000000000 +0200
+++ b/drivers/pnp/interface.c	2006-05-09 19:25:08.000000000 +0200
@@ -459,10 +459,28 @@
 
 static DEVICE_ATTR(id,S_IRUGO,pnp_show_current_ids,NULL);
 
+static ssize_t pnp_modalias_show(struct device *dmdev, struct device_attribute *attr, char *buf)
+{
+	char *str = buf;
+	struct pnp_dev *dev = to_pnp_dev(dmdev);
+	struct pnp_id * pos = dev->id;
+
+	str += sprintf(str, "pnp:");
+	while (pos) {
+		str += sprintf(str,"d%s", pos->id);
+		pos = pos->next;
+	}
+	str += sprintf(str, "\n");
+	return (str - buf);
+}
+
+static DEVICE_ATTR(modalias,S_IRUGO,pnp_modalias_show,NULL);
+
 int pnp_interface_attach_device(struct pnp_dev *dev)
 {
 	device_create_file(&dev->dev,&dev_attr_options);
 	device_create_file(&dev->dev,&dev_attr_resources);
 	device_create_file(&dev->dev,&dev_attr_id);
+	device_create_file(&dev->dev,&dev_attr_modalias);
 	return 0;
 }



-- 
pozsy
