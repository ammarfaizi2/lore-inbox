Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTJBUjU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 16:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbTJBUjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 16:39:20 -0400
Received: from gprs149-169.eurotel.cz ([160.218.149.169]:61572 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263488AbTJBUjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 16:39:18 -0400
Date: Thu, 2 Oct 2003 22:39:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix oops after saving image
Message-ID: <20031002203906.GB7407@elf.ucw.cz>
References: <20031001223751.GA6402@elf.ucw.cz> <Pine.LNX.4.44.0310020933140.997-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310020933140.997-100000@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > --- tmp/linux/kernel/power/swsusp.c	2003-10-02 00:04:35.000000000 +0200
> > +++ linux/kernel/power/swsusp.c	2003-10-01 23:56:49.000000000 +0200
> > @@ -345,7 +348,7 @@
> >  	printk( "|\n" );
> >  
> >  	MDELAY(1000);
> > -	free_page((unsigned long) buffer);
> > +	/* Trying to free_page((unsigned long) buffer) here is bad idea, not sure why */
> >  	return 0;
> >  }
> 
> Patches like this really do a disservice to anyone trying to read the code 
> and figure out what is going on. I've spent a considerable amount of time 
> deciphering and santizing the swsusp code, which is why pmdisk exists. 
> 
> The patch is simply a band-aid, and completely meaningless without the 
> context of the email. If I applied this, one would be able to ascertain 
> the reason for the patch, if they manipulated the BK tools correctly. 
> However, seeing that line solely in the context on the rest of the source 
> makes one cock their head, squint their eyes and pray that they never have 
> to look at that file again. 
> 
> If you're seeing an Oops, please search more for the cause and submit a 
> real fix for it. 
> 
> Or, simply change the semantics of the code enough to eliminate the
> possibility of a problem. In the pmdisk code, I've statically declared the 
> header, so we don't need that alloc/free. Please see that file for an 
> example. 

I do not want to waste 4K, does this look better?
									Pavel

--- tmp/linux/kernel/power/swsusp.c	2003-10-02 22:29:06.000000000 +0200
+++ linux/kernel/power/swsusp.c	2003-10-02 22:27:07.000000000 +0200
@@ -283,6 +283,9 @@
 	unsigned long address;
 	struct page *page;
 
+	if (!buffer)
+		return -ENOMEM;
+
 	printk( "Writing data to swap (%d pages): ", nr_copy_pages );
 	for (i=0; i<nr_copy_pages; i++) {
 		if (!(i%100))
@@ -345,7 +348,7 @@
 	printk( "|\n" );
 
 	MDELAY(1000);
-	free_page((unsigned long) buffer);
+	/* No need to free anything, system is going down, anyway. */
 	return 0;
 }
 


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
