Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265098AbUGBXZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbUGBXZE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 19:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUGBXZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 19:25:04 -0400
Received: from av5-2-sn1.fre.skanova.net ([81.228.11.112]:5613 "EHLO
	av5-2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S265098AbUGBXY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 19:24:59 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH] CDRW packet writing support for 2.6.7-bk13
References: <m2lli36ec9.fsf@telia.com> <m2u0wqqdpl.fsf@telia.com>
	<20040702150819.646b6103.akpm@osdl.org>
	<20040702224720.GA7969@kroah.com>
	<20040702155945.5c375bd2.akpm@osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 03 Jul 2004 01:24:41 +0200
In-Reply-To: <20040702155945.5c375bd2.akpm@osdl.org>
Message-ID: <m27jtm0z7q.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Greg KH <greg@kroah.com> wrote:
> >
> > > const char *__bdevname(dev_t dev, char *buffer)
> > > {
> > > 	struct gendisk *disk;
> > > 	int part;
> > > 
> > > 	disk = get_gendisk(dev, &part);
> > > 	if (disk) {
> > > 		buffer = disk_name(disk, part, buffer);
> > > 		put_disk(disk);
> > > 	} else {
> > > 		snprintf(buffer, BDEVNAME_SIZE, "unknown-block(%u,%u)",
> > > 				MAJOR(dev), MINOR(dev));
> > > 	}
> > > 
> > > get_gendisk() did an internal module_get() in kobj_lookup().
> > 
> > But if kobj_lookup() succeeds, module_put() is called before returning
> > (actually it's always called, right?) 

But kobj_lookup() also calls probe(), which equals ata_probe() in the
IDE case, and ata_probe() calls get_disk() which calls
try_module_get() to acquire another reference to the module. I guess
all probe() functions behave the same way, as I've seen the same
problem with the sr_mod module.

> Oop, sorry, yes.  Peter, are you sure this is where the leak is coming from?

I'm sure that the module reference count as reported by lsmod
increases each time I access /proc/driver/pktcdvd/pktcdvd0. I can make
this problem go away either by patching __bdevname() or by deleting
the call to __bdevname() in pktcdvd.c.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
