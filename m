Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWBZXws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWBZXws (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWBZXws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:52:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59785 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751107AbWBZXwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:52:47 -0500
Date: Mon, 27 Feb 2006 00:52:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: improve memory shrinking
Message-ID: <20060226235227.GD2396@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602261627.18012.rjw@sisk.pl> <20060226185319.GB2055@elf.ucw.cz> <200602270032.25324.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602270032.25324.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 27-02-06 00:32:24, Rafael J. Wysocki wrote:
> Hi,
> 
> On Sunday 26 February 2006 19:53, Pavel Machek wrote:
> > > > > > I did try shrink_all_memory() five times, with .5 second delay between
> > > > > > them, and it freed more memory at later tries.
> > > > > 
> > > > > I wonder if the delays are essential or if so, whether they may be shorter
> > > > > than .5 sec.
> > > > 
> > > > I was using this with some success... (Warning, against old
> > > > kernel). But, as I said, I consider it ugly, and it would be better to
> > > > fix shrink_all_memory.
> > > 
> > > Appended is a patch against the current -mm.
> > >   [It also makes
> > > swsusp_shrink_memory() behave as documented for image_size = 0.
> > > Currently, if it states there's enough free RAM to suspend, it won't bother
> > > to free a single page.]
> > 
> > Could we get bugfix part separately?
> 
> Sure.  Appended is the bugfix (I haven't tested it separately yet, but I think
> it's simple enough) ...

Are you sure? The way I read old code ... it looks correct to me.

size is always > 1000 or so. if image_size = 0, size >
image_size/PAGE_SIZE and we'll loop as long as shrink_all_memory()
frees something.

								Pavel

        printk("Shrinking memory...  ");
        do {
                /* size = How much memory would we need if we did not
free anything? */
                size = 2 * count_highmem_pages();
                size += size / 50 + count_data_pages();
                size += (size + PBES_PER_PAGE - 1) / PBES_PER_PAGE +
                        PAGES_FOR_IO;

                /* tmp = How much memory do we *need* to free in order
to fit? */
                tmp = size;
                for_each_zone (zone)
                        if (!is_highmem(zone))
                                tmp -= zone->free_pages;
                if (tmp > 0) {
                        tmp = shrink_all_memory(SHRINK_BITE);
                        if (!tmp)
                                return -ENOMEM;
                        pages += tmp;
                } else if (size > image_size / PAGE_SIZE) {
                        tmp = shrink_all_memory(SHRINK_BITE);
                        pages += tmp;
                }
                printk("\b%c", p[i++%4]);



-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
