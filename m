Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129406AbQK0V5d>; Mon, 27 Nov 2000 16:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129689AbQK0V5Y>; Mon, 27 Nov 2000 16:57:24 -0500
Received: from lipta.cendio.se ([193.180.23.53]:31246 "EHLO lipta.cendio.se")
        by vger.kernel.org with ESMTP id <S129406AbQK0V5I>;
        Mon, 27 Nov 2000 16:57:08 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
In-Reply-To: <200011270556.VAA12506@baldur.yggdrasil.com> <20001127094139.H599@almesberger.net> <200011270839.AAA28672@pizda.ninka.net> <20001127182113.A15029@athlon.random> <20001127182113.A15029@athlon.random> <20001127123655.A16930@munchkin.spectacle-pond.org>
From: Marcus Sundberg <marcus@cendio.se>
Date: 27 Nov 2000 22:27:00 +0100
In-Reply-To: meissner@spectacle-pond.org's message of "Mon, 27 Nov 2000 12:36:55 -0500"
Message-ID: <vey9y5umvv.fsf@lipta.cendio.se>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

meissner@spectacle-pond.org (Michael Meissner) writes:

> On Mon, Nov 27, 2000 at 06:21:13PM +0100, Andrea Arcangeli wrote:
> > On Mon, Nov 27, 2000 at 12:39:55AM -0800, David S. Miller wrote:
> > > Also I believe linkers are allowed to arbitrarily reorder members in
> > > the data and bss sections.  I could be wrong on this one though.
> > 
> > I'm not sure either, but we certainly rely on that behaviour somewhere.
> > Just to make an example fs/dquot.c:
> > 
> > 	int nr_dquots, nr_free_dquots;
> > 
> > kernel/sysctl.c:
> > 
> > 	{FS_NRDQUOT, "dquot-nr", &nr_dquots, 2*sizeof(int),
> > 
> > The above is ok also on mips in practice though.
> 
> That needs to be fixed ASAP to use an array (not a structure).  It is simply
> wrong to depend on two variables winding up in at adjacent offsets.

This reminded me of an old bug which apparently still hasn't been
fixed (not in 2.2 at least). In init/main.c we have:

extern int rd_image_start;	/* starting block # of image */
#ifdef CONFIG_BLK_DEV_INITRD
kdev_t real_root_dev;
#endif
#endif

int root_mountflags = MS_RDONLY;

and then in kernel/sysctl.c:

#ifdef CONFIG_BLK_DEV_INITRD
	{KERN_REALROOTDEV, "real-root-dev", &real_root_dev, sizeof(int),
	 0644, NULL, &proc_dointvec},
#endif

Because rd_image_start and root_mountflags are both int-aligned,
this happens to work on little endian platforms. On big endian
platforms however writing a value in the range 0-65535 to 
/proc/sys/kernel/real-root-dev will place 0 in real_root_dev,
and the actual value in the two padding bytes...

(Yes, I'm one of the few that have actually used this feature. ;-)

Unfortunately proc_dointvec() doesn't support shorts, so what is
the correct fix? Changing:
kdev_t real_root_dev;
into
int real_root-dev;
is a perfectly working solution, but is it acceptable?

//Marcus
-- 
-------------------------------+-----------------------------------
        Marcus Sundberg        |       Phone: +46 707 452062
  Embedded Systems Consultant  |      Email: marcus@cendio.se
       Cendio Systems AB       |       http://www.cendio.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
