Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263835AbTICBNU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 21:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263842AbTICBNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 21:13:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:28881 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263835AbTICBNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 21:13:15 -0400
Date: Tue, 2 Sep 2003 18:13:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: stoffel@lucent.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.0-test4-mm4 - USD disconnect oops
Message-Id: <20030902181336.5dfe624f.akpm@osdl.org>
In-Reply-To: <20030903000448.GA21173@kroah.com>
References: <16210.44543.579049.520185@gargle.gargle.HOWL>
	<20030901065928.GB22647@kroah.com>
	<16213.12008.527588.874265@gargle.gargle.HOWL>
	<20030903000448.GA21173@kroah.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Tue, Sep 02, 2003 at 07:59:36PM -0400, John Stoffel wrote:
> > >>>>> "Greg" == Greg KH <greg@kroah.com> writes:
> > 
> > >> Here's the backtrace, my .config is at the end.  It's a PIII Xeon 2 x
> > >> 550mhz, Dell Precision 610 motherboard/system, 768mb of RAM.  The only
> > >> USB devices are the controllers and the CompactFlash reader, which
> > >> works great under 2.4.  
> > 
> > Greg> Does this happen on 2.6.0-test4?  (no -mm).
> > 
> > Well, I can now use the usb-storage device under 2.6.0-test4 without
> > any problems, but I just did a quick test.  So there's something in
> > -mm4 which is messing me and usb in general up.  I've made the
> > following changes though, so I should go back and check:
> > 
> > - upgrade to module-init-tools-0.9.13
> > - upgrade to hotplug-2003_08_05-1
> > 	     hotplug-base-2003_08_05-1
> > 
> > I'll see if I can figure out what changed in the -mm4 patch to cause
> > this problem.  Could it be the kobject patch Akpm posted?  It looks
> > like the oops I've gotten.
> 
> Try adding that patch and see if it helps.  It sure can't hurt as it
> fixes a real bug in the -mm tree :)
> 

Yes.  It's the same oops.


diff -puN lib/kobject.c~kobject-unlimited-name-lengths-use-after-free-fix lib/kobject.c
--- 25/lib/kobject.c~kobject-unlimited-name-lengths-use-after-free-fix	Tue Sep  2 14:43:47 2003
+++ 25-akpm/lib/kobject.c	Tue Sep  2 14:43:47 2003
@@ -445,13 +445,13 @@ void kobject_cleanup(struct kobject * ko
 	struct kset * s = kobj->kset;
 
 	pr_debug("kobject %s: cleaning up\n",kobject_name(kobj));
+	if (kobj->k_name != kobj->name)
+		kfree(kobj->k_name);
+	kobj->k_name = NULL;
 	if (t && t->release)
 		t->release(kobj);
 	if (s)
 		kset_put(s);
-	if (kobj->k_name != kobj->name)
-		kfree(kobj->k_name);
-	kobj->k_name = NULL;
 }
 
 /**

_

