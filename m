Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbTHaVqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 17:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbTHaVqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 17:46:09 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:49115 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262696AbTHaVqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 17:46:05 -0400
Date: Sun, 31 Aug 2003 23:45:57 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: create_proc_entry and !CONFIG_PROC_FS
Message-ID: <20030831214557.GZ7038@fs.tum.de>
References: <20030831150632.GU7038@fs.tum.de> <20030831144033.6f9d8708.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831144033.6f9d8708.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 02:40:33PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@fs.tum.de> wrote:
> >
> > Hi,
> > 
> > I've observed a possible problem with create_proc_entry and 
> > !CONFIG_PROC_FS.
> > 
> > If !CONFIG_PROC_FS include/linux/proc_fs.h includes a dummy 
> > create_proc_entry that simply returns NULL.
> > 
> > Unfortunately, many callers of this function do things like e.g.
> > 
> > static int __init br2684_init(void)
> > {
> >         struct proc_dir_entry *p;
> >         if ((p = create_proc_entry("br2684", 0, atm_proc_root)) == NULL)
> >                 return -ENOMEM;
> >         p->proc_fops = &br2684_proc_operations;
> >         br2684_ioctl_set(br2684_ioctl);
> >         return 0;
> > }
> > 
> > 
> > IOW, the dummy create_proc_entry fixes the compilation but the init 
> > function always returns -ENOMEM if !CONFIG_PROC_FS.
> > 
> > Is there any better solution than removing the dummy create_proc_entry 
> > and #ifdef'ing all places where it's used?
> 
> The normal fix would be to sprinkle ifdefs throughout the driver itself.

That's what I was thinking of when I wrote "#ifdef'ing all places where 
it's used"...

> You need to lok at the driver and ask yourself "is anyone ever going to want
> to use this in a no-procfs system".  Probably, the answer is always "no". 
> In which case appropriate fixes would be to ignore the problem, or disable
> the driver in config if !CONFIG_PROC_FS.

The latter is IMHO the better solution, a driver that compiles but 
doesn't work (#if !CONFIG_PROC_FS) is simply useless.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

