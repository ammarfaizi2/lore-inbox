Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUCIHzm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 02:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbUCIHzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 02:55:42 -0500
Received: from goliath.sylaba.poznan.pl ([213.17.226.43]:24069 "EHLO
	goliath.sylaba.poznan.pl") by vger.kernel.org with ESMTP
	id S261673AbUCIHzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 02:55:38 -0500
Subject: Re: 2.6.3 BUG - can't write DVD-RAM - reported as write-protected
From: Olaf =?iso-8859-2?Q?Fr=B1czyk?= <olaf@cbk.poznan.pl>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040307105911.GH23525@suse.de>
References: <1078434953.1961.13.camel@venus.local.navi.pl>
	 <20040305082350.GO31750@suse.de>
	 <1078487159.3300.23.camel@venus.local.navi.pl>
	 <20040307105911.GH23525@suse.de>
Content-Type: text/plain
Message-Id: <1078819165.1525.1.camel@venus.local.navi.pl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 09 Mar 2004 08:59:25 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-03-07 at 11:59, Jens Axboe wrote:
> On Fri, Mar 05 2004, Olaf Fr?czyk wrote:
> > On Fri, 2004-03-05 at 09:23, Jens Axboe wrote:
> > > On Thu, Mar 04 2004, Olaf Fr?czyk wrote:
> > > > Hi,
> > > > I switched to 2.6.3 from 2.4.x serie.
> > > > When I mount DVD-RAM it is mounted read-only:
> > > > 
> > > > [root@venus olaf]# mount /dev/dvdram /mnt/dvdram
> > > > mount: block device /dev/dvdram is write-protected, mounting read-only
> > > > [root@venus olaf]#
> > > > 
> > > > In 2.4 it is mounted correctly as read-write.
> > > > 
> > > > Drive: Panasonic LF-201, reported in Linux as:
> > > > MATSHITA        DVD-RAM LF-D200         A120
> > > > 
> > > > SCSI controller: Adaptec 2940U2W
> > > 
> > > What does cat /proc/sys/dev/cdrom/info say? Do you get any kernel
> > > messages in dmesg when the rw mount fails?
> > 
> > I get nothing in /var/log/dmesg and in /var/log/messages
> > In /proc/sys/dev/cdrom/info I get:
> > [olaf@venus olaf]$ cat /proc/sys/dev/cdrom/info
> > CD-ROM information, Id: cdrom.c 3.20 2003/12/17
> >  
> > drive name:             sr1     sr0     hdc
> > drive speed:            0       16      44
> > drive # of slots:       1       1       1
> > Can close tray:         1       1       1
> > Can open tray:          1       1       1
> > Can lock tray:          1       1       1
> > Can change speed:       1       1       1
> > Can select disk:        0       0       0
> > Can read multisession:  1       1       1
> > Can read MCN:           1       1       1
> > Reports media changed:  1       1       1
> > Can play audio:         1       1       1
> > Can write CD-R:         0       1       1
> > Can write CD-RW:        0       1       1
> > Can read DVD:           1       0       0
> > Can write DVD-R:        0       0       0
> > Can write DVD-RAM:      1       0       0
> > Can read MRW:           0       0       1
> > Can write MRW:          0       0       1
> > 
> > The one I'm mounting is /dev/scd1.
> > As there is capablity to write-protect DVD-RAM disk (like a 1.44"
> > Floppy), I think that the linux kernel interprets some message from
> > device in wrong way.
> 
> Please repeat with this patch applied and send back the results, thanks.
> 
> ===== drivers/cdrom/cdrom.c 1.48 vs edited =====
> --- 1.48/drivers/cdrom/cdrom.c	Mon Feb  9 21:58:21 2004
> +++ edited/drivers/cdrom/cdrom.c	Sun Mar  7 11:58:40 2004
> @@ -645,9 +645,12 @@
>  {
>  	disc_information di;
>  
> -	if (cdrom_get_disc_info(cdi, &di))
> +	if (cdrom_get_disc_info(cdi, &di)) {
> +		printk("cdrom: read di failed\n");
>  		return 0;
> +	}
>  
> +	printk("cdrom: erasable: %d\n", di.erasable);
>  	return di.erasable;
>  }
>  
I get:
cdrom: read di failed

Regards,

Olaf

