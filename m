Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbUCNLNM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 06:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263342AbUCNLNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 06:13:12 -0500
Received: from goliath.sylaba.poznan.pl ([213.17.226.43]:3853 "EHLO
	goliath.sylaba.poznan.pl") by vger.kernel.org with ESMTP
	id S263340AbUCNLNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 06:13:05 -0500
Subject: Re: 2.6.3 BUG - can't write DVD-RAM - reported as write-protected
From: Olaf =?iso-8859-2?Q?Fr=B1czyk?= <olaf@cbk.poznan.pl>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040309091221.GV23525@suse.de>
References: <1078434953.1961.13.camel@venus.local.navi.pl>
	 <20040305082350.GO31750@suse.de>
	 <1078487159.3300.23.camel@venus.local.navi.pl>
	 <20040307105911.GH23525@suse.de>
	 <1078819165.1525.1.camel@venus.local.navi.pl>
	 <20040309091221.GV23525@suse.de>
Content-Type: text/plain
Message-Id: <1079263025.1428.4.camel@venus.local.navi.pl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 14 Mar 2004 12:17:05 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-09 at 10:12, Jens Axboe wrote: 
> On Tue, Mar 09 2004, Olaf Fr?czyk wrote:
> > On Sun, 2004-03-07 at 11:59, Jens Axboe wrote:
> > > On Fri, Mar 05 2004, Olaf Fr?czyk wrote:
> > > > On Fri, 2004-03-05 at 09:23, Jens Axboe wrote:
> > > > > On Thu, Mar 04 2004, Olaf Fr?czyk wrote:
> > > > > > Hi,
> > > > > > I switched to 2.6.3 from 2.4.x serie.
> > > > > > When I mount DVD-RAM it is mounted read-only:
> > > > > > 
> > > > > > [root@venus olaf]# mount /dev/dvdram /mnt/dvdram
> > > > > > mount: block device /dev/dvdram is write-protected, mounting read-only
> > > > > > [root@venus olaf]#
> > > > > > 
> > > > > > In 2.4 it is mounted correctly as read-write.
> > > > > > 
> > > > > > Drive: Panasonic LF-201, reported in Linux as:
> > > > > > MATSHITA        DVD-RAM LF-D200         A120
> > > > > > 
> > > > > > SCSI controller: Adaptec 2940U2W
> > > > > 
> > > > > What does cat /proc/sys/dev/cdrom/info say? Do you get any kernel
> > > > > messages in dmesg when the rw mount fails?
> > > > 
> > > > I get nothing in /var/log/dmesg and in /var/log/messages
> > > > In /proc/sys/dev/cdrom/info I get:
> > > > [olaf@venus olaf]$ cat /proc/sys/dev/cdrom/info
> > > > CD-ROM information, Id: cdrom.c 3.20 2003/12/17
> > > >  
> > > > drive name:             sr1     sr0     hdc
> > > > drive speed:            0       16      44
> > > > drive # of slots:       1       1       1
> > > > Can close tray:         1       1       1
> > > > Can open tray:          1       1       1
> > > > Can lock tray:          1       1       1
> > > > Can change speed:       1       1       1
> > > > Can select disk:        0       0       0
> > > > Can read multisession:  1       1       1
> > > > Can read MCN:           1       1       1
> > > > Reports media changed:  1       1       1
> > > > Can play audio:         1       1       1
> > > > Can write CD-R:         0       1       1
> > > > Can write CD-RW:        0       1       1
> > > > Can read DVD:           1       0       0
> > > > Can write DVD-R:        0       0       0
> > > > Can write DVD-RAM:      1       0       0
> > > > Can read MRW:           0       0       1
> > > > Can write MRW:          0       0       1
> > > > 
> > > > The one I'm mounting is /dev/scd1.
> > > > As there is capablity to write-protect DVD-RAM disk (like a 1.44"
> > > > Floppy), I think that the linux kernel interprets some message from
> > > > device in wrong way.
> > > 
> > > Please repeat with this patch applied and send back the results, thanks.
> > > 
> > > ===== drivers/cdrom/cdrom.c 1.48 vs edited =====
> > > -- 1.48/drivers/cdrom/cdrom.c	Mon Feb  9 21:58:21 2004
> > > +++ edited/drivers/cdrom/cdrom.c	Sun Mar  7 11:58:40 2004
> > > @@ -645,9 +645,12 @@
> > >  {
> > >  	disc_information di;
> > >  
> > > -	if (cdrom_get_disc_info(cdi, &di))
> > > +	if (cdrom_get_disc_info(cdi, &di)) {
> > > +		printk("cdrom: read di failed\n");
> > >  		return 0;
> > > +	}
> > >  
> > > +	printk("cdrom: erasable: %d\n", di.erasable);
> > >  	return di.erasable;
> > >  }
> > >  
> > I get:
> > cdrom: read di failed
> 
> Can you try to instrument drivers/cdrom/cdrom.c:cdrom_get_disc_info()
> and find out where it fails? Change the cgc.quiet = 1 to a = 0 in there
> as well (that alone might be enough to pin point the problem).
Sorry for the delay. I couldn't take tha machine down.
After setting cgc.quiet=0 I get no additional messages from kernel.
cdrom_get_disc_info returns after FIRST:
cdo->generic_packet(cdi, &cgc).

BTW, I suppose return codes are interpreted not well:
In cdrom_get_disc_info we return after first (cdo->generic_packet) if it
returns not 0. (Success?) And we return with not 0 value.
And in cdrom_media_erasable we assume that not 0 is error, not success.
So probably in cdrom_get_disc_info we should have:
        if (!(ret = cdo->generic_packet(cdi, &cgc)))
                return ret;

I tried it, but it changed nothing regarding to the problem.
It returns then after second cdo->generic_packet, but I still get: 
read di failed.

Regards,

Olaf

