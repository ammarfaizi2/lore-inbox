Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263342AbUCNLWU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 06:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbUCNLWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 06:22:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45228 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263342AbUCNLWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 06:22:15 -0500
Date: Sun, 14 Mar 2004 12:22:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Olaf Fr?czyk <olaf@cbk.poznan.pl>
Cc: linux-kernel@vger.kernel.org, td@linuxgang.com
Subject: Re: 2.6.3 BUG - can't write DVD-RAM - reported as write-protected
Message-ID: <20040314112208.GH6955@suse.de>
References: <1078434953.1961.13.camel@venus.local.navi.pl> <20040305082350.GO31750@suse.de> <1078487159.3300.23.camel@venus.local.navi.pl> <20040307105911.GH23525@suse.de> <1078819165.1525.1.camel@venus.local.navi.pl> <20040309091221.GV23525@suse.de> <1079263025.1428.4.camel@venus.local.navi.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079263025.1428.4.camel@venus.local.navi.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14 2004, Olaf Fr?czyk wrote:
> On Tue, 2004-03-09 at 10:12, Jens Axboe wrote: 
> > On Tue, Mar 09 2004, Olaf Fr?czyk wrote:
> > > On Sun, 2004-03-07 at 11:59, Jens Axboe wrote:
> > > > On Fri, Mar 05 2004, Olaf Fr?czyk wrote:
> > > > > On Fri, 2004-03-05 at 09:23, Jens Axboe wrote:
> > > > > > On Thu, Mar 04 2004, Olaf Fr?czyk wrote:
> > > > > > > Hi,
> > > > > > > I switched to 2.6.3 from 2.4.x serie.
> > > > > > > When I mount DVD-RAM it is mounted read-only:
> > > > > > > 
> > > > > > > [root@venus olaf]# mount /dev/dvdram /mnt/dvdram
> > > > > > > mount: block device /dev/dvdram is write-protected, mounting read-only
> > > > > > > [root@venus olaf]#
> > > > > > > 
> > > > > > > In 2.4 it is mounted correctly as read-write.
> > > > > > > 
> > > > > > > Drive: Panasonic LF-201, reported in Linux as:
> > > > > > > MATSHITA        DVD-RAM LF-D200         A120
> > > > > > > 
> > > > > > > SCSI controller: Adaptec 2940U2W
> > > > > > 
> > > > > > What does cat /proc/sys/dev/cdrom/info say? Do you get any kernel
> > > > > > messages in dmesg when the rw mount fails?
> > > > > 
> > > > > I get nothing in /var/log/dmesg and in /var/log/messages
> > > > > In /proc/sys/dev/cdrom/info I get:
> > > > > [olaf@venus olaf]$ cat /proc/sys/dev/cdrom/info
> > > > > CD-ROM information, Id: cdrom.c 3.20 2003/12/17
> > > > >  
> > > > > drive name:             sr1     sr0     hdc
> > > > > drive speed:            0       16      44
> > > > > drive # of slots:       1       1       1
> > > > > Can close tray:         1       1       1
> > > > > Can open tray:          1       1       1
> > > > > Can lock tray:          1       1       1
> > > > > Can change speed:       1       1       1
> > > > > Can select disk:        0       0       0
> > > > > Can read multisession:  1       1       1
> > > > > Can read MCN:           1       1       1
> > > > > Reports media changed:  1       1       1
> > > > > Can play audio:         1       1       1
> > > > > Can write CD-R:         0       1       1
> > > > > Can write CD-RW:        0       1       1
> > > > > Can read DVD:           1       0       0
> > > > > Can write DVD-R:        0       0       0
> > > > > Can write DVD-RAM:      1       0       0
> > > > > Can read MRW:           0       0       1
> > > > > Can write MRW:          0       0       1
> > > > > 
> > > > > The one I'm mounting is /dev/scd1.
> > > > > As there is capablity to write-protect DVD-RAM disk (like a 1.44"
> > > > > Floppy), I think that the linux kernel interprets some message from
> > > > > device in wrong way.
> > > > 
> > > > Please repeat with this patch applied and send back the results, thanks.
> > > > 
> > > > ===== drivers/cdrom/cdrom.c 1.48 vs edited =====
> > > > -- 1.48/drivers/cdrom/cdrom.c	Mon Feb  9 21:58:21 2004
> > > > +++ edited/drivers/cdrom/cdrom.c	Sun Mar  7 11:58:40 2004
> > > > @@ -645,9 +645,12 @@
> > > >  {
> > > >  	disc_information di;
> > > >  
> > > > -	if (cdrom_get_disc_info(cdi, &di))
> > > > +	if (cdrom_get_disc_info(cdi, &di)) {
> > > > +		printk("cdrom: read di failed\n");
> > > >  		return 0;
> > > > +	}
> > > >  
> > > > +	printk("cdrom: erasable: %d\n", di.erasable);
> > > >  	return di.erasable;
> > > >  }
> > > >  
> > > I get:
> > > cdrom: read di failed
> > 
> > Can you try to instrument drivers/cdrom/cdrom.c:cdrom_get_disc_info()
> > and find out where it fails? Change the cgc.quiet = 1 to a = 0 in there
> > as well (that alone might be enough to pin point the problem).
> Sorry for the delay. I couldn't take tha machine down.
> After setting cgc.quiet=0 I get no additional messages from kernel.
> cdrom_get_disc_info returns after FIRST:
> cdo->generic_packet(cdi, &cgc).

Ok, at least that's a little clue... Maybe your drive is buggy (I think
we already established that, question is what the bug is) and doesn't
like to return just two bytes, please try with attached patch.

> BTW, I suppose return codes are interpreted not well:
> In cdrom_get_disc_info we return after first (cdo->generic_packet) if it
> returns not 0. (Success?) And we return with not 0 value.
> And in cdrom_media_erasable we assume that not 0 is error, not success.
> So probably in cdrom_get_disc_info we should have:
>         if (!(ret = cdo->generic_packet(cdi, &cgc)))
>                 return ret;

No, you are not reading the code correctly. ->generic_packet() returns 0
on success, or the error (standard kernel practice).
cdrom_media_erasable() returns a bool, and if cdrom_get_disc_info()
fails then we return it's not erasable.

> I tried it, but it changed nothing regarding to the problem.
> It returns then after second cdo->generic_packet, but I still get: 
> read di failed.

You broke it, the first check simply returns the header so .erasable
must be 0 because we cleared the buffer first.

===== drivers/cdrom/cdrom.c 1.49 vs edited =====
--- 1.49/drivers/cdrom/cdrom.c	Thu Mar 11 13:31:15 2004
+++ edited/drivers/cdrom/cdrom.c	Sun Mar 14 12:21:44 2004
@@ -2658,11 +2658,13 @@
 	/* set up command and get the disc info */
 	init_cdrom_command(&cgc, di, sizeof(*di), CGC_DATA_READ);
 	cgc.cmd[0] = GPCMD_READ_DISC_INFO;
-	cgc.cmd[8] = cgc.buflen = 2;
-	cgc.quiet = 1;
+	cgc.cmd[8] = cgc.buflen = 8;
+	cgc.quiet = 0;
 
-	if ((ret = cdo->generic_packet(cdi, &cgc)))
+	if ((ret = cdo->generic_packet(cdi, &cgc))) {
+		printk("cdrom: read_di failed, %d\n", ret);
 		return ret;
+	}
 
 	/* not all drives have the same disc_info length, so requeue
 	 * packet with the length the drive tells us it can supply
@@ -2673,6 +2675,7 @@
 	if (cgc.buflen > sizeof(disc_information))
 		cgc.buflen = sizeof(disc_information);
 
+	printk("cdrom: re-reading di, len=%d\n", cgc.buflen);
 	cgc.cmd[8] = cgc.buflen;
 	return cdo->generic_packet(cdi, &cgc);
 }

-- 
Jens Axboe

