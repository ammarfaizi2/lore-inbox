Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbTJCWeR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 18:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTJCWeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 18:34:17 -0400
Received: from gprs149-76.eurotel.cz ([160.218.149.76]:3200 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261376AbTJCWeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 18:34:08 -0400
Date: Sat, 4 Oct 2003 00:33:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix oops after saving image
Message-ID: <20031003223352.GB344@elf.ucw.cz>
References: <20031002203906.GB7407@elf.ucw.cz> <Pine.LNX.4.44.0310031433530.28816-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310031433530.28816-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I do not want to waste 4K, does this look better?
> > 									Pavel
> > 
> > --- tmp/linux/kernel/power/swsusp.c	2003-10-02 22:29:06.000000000 +0200
> > +++ linux/kernel/power/swsusp.c	2003-10-02 22:27:07.000000000 +0200
> > @@ -283,6 +283,9 @@
> >  	unsigned long address;
> >  	struct page *page;
> >  
> > +	if (!buffer)
> > +		return -ENOMEM;
> > +
> >  	printk( "Writing data to swap (%d pages): ", nr_copy_pages );
> >  	for (i=0; i<nr_copy_pages; i++) {
> >  		if (!(i%100))
> 
> Argh! This bit was in the previous patch I applied. Please get it 
> straight, or just keep adding to one patch and resending it (with an 
> itemized list of changes). 

I do not want to do that (other people would have problems
reviewing). I'll try to be more carefull.

One thing would help me: could you reply with "Applied" when you apply
some patch? Just now it seems to be silence==applied and reply==some
problem, but that makes it "interesting" to guess what your tree looks
like.

> > @@ -345,7 +348,7 @@
> >  	printk( "|\n" );
> >  
> >  	MDELAY(1000);
> > -	free_page((unsigned long) buffer);
> > +	/* No need to free anything, system is going down, anyway. */
> >  	return 0;
> >  }
> 
> It's technically still incorrect, since you'd still be leaking memory if
> suspend failed. And, the comment is still in an unfortunate place.  
> Something like this, before the function helps to provide understanding of 
> the entire operation:

At this point, suspend may no longer fail: we have ready-to-run image
in swap, and rollback would happen on next reboot -- corrupting
data. Yep better docs is needed.

How about this one?
								Pavel

--- tmp/linux/kernel/power/swsusp.c	2003-10-04 00:21:55.000000000 +0200
+++ linux/kernel/power/swsusp.c	2003-10-04 00:17:19.000000000 +0200
@@ -274,6 +274,17 @@
 	swap_list_unlock();
 }
 
+/**
+ *    write_suspend_image - Write entire image to disk.
+ *
+ *    After writing suspend signature to the disk, suspend may no
+ *    longer fail: we have ready-to-run image in swap, and rollback
+ *    would happen on next reboot -- corrupting data.
+ *
+ *    Note: The buffer we allocate to use to write the suspend header is
+ *    not freed; its not needed since system is going down anyway
+ *    (plus it causes oops and I'm lazy^H^H^H^Htoo busy).
+ */
 static int write_suspend_image(void)
 {
 	int i;
@@ -345,7 +359,6 @@
 	printk( "|\n" );
 
 	MDELAY(1000);
-	free_page((unsigned long) buffer);
 	return 0;
 }
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
