Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbUCWPbs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 10:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbUCWPbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 10:31:48 -0500
Received: from goliath.sylaba.poznan.pl ([213.17.226.43]:46090 "EHLO
	goliath.sylaba.poznan.pl") by vger.kernel.org with ESMTP
	id S262608AbUCWPbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 10:31:42 -0500
Subject: Re: 2.6.3 BUG - can't write DVD-RAM - reported as write-protected
From: Olaf =?iso-8859-2?Q?Fr=B1czyk?= <olaf@cbk.poznan.pl>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, td@linuxgang.com
In-Reply-To: <20040323152339.GI1481@suse.de>
References: <1078434953.1961.13.camel@venus.local.navi.pl>
	 <20040305082350.GO31750@suse.de>
	 <1078487159.3300.23.camel@venus.local.navi.pl>
	 <20040307105911.GH23525@suse.de>
	 <1078819165.1525.1.camel@venus.local.navi.pl>
	 <20040309091221.GV23525@suse.de>
	 <1079263025.1428.4.camel@venus.local.navi.pl>
	 <20040314112208.GH6955@suse.de>
	 <1080053402.1473.0.camel@venus.local.navi.pl>
	 <20040323152339.GI1481@suse.de>
Content-Type: text/plain
Message-Id: <1080056187.1473.15.camel@venus.local.navi.pl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 23 Mar 2004 16:36:27 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-23 at 16:23, Jens Axboe wrote:
> On Tue, Mar 23 2004, Olaf Fr?czyk wrote:
> > > You broke it, the first check simply returns the header so .erasable
> > > must be 0 because we cleared the buffer first.
> > > 
> > > ===== drivers/cdrom/cdrom.c 1.49 vs edited =====
> > > --- 1.49/drivers/cdrom/cdrom.c	Thu Mar 11 13:31:15 2004
> > > +++ edited/drivers/cdrom/cdrom.c	Sun Mar 14 12:21:44 2004
> > > @@ -2658,11 +2658,13 @@
> > >  	/* set up command and get the disc info */
> > >  	init_cdrom_command(&cgc, di, sizeof(*di), CGC_DATA_READ);
> > >  	cgc.cmd[0] = GPCMD_READ_DISC_INFO;
> > > -	cgc.cmd[8] = cgc.buflen = 2;
> > > -	cgc.quiet = 1;
> > > +	cgc.cmd[8] = cgc.buflen = 8;
> > > +	cgc.quiet = 0;
> > >  
> > > -	if ((ret = cdo->generic_packet(cdi, &cgc)))
> > > +	if ((ret = cdo->generic_packet(cdi, &cgc))) {
> > > +		printk("cdrom: read_di failed, %d\n", ret);
> > >  		return ret;
> > > +	}
> > >  
> > >  	/* not all drives have the same disc_info length, so requeue
> > >  	 * packet with the length the drive tells us it can supply
> > > @@ -2673,6 +2675,7 @@
> > >  	if (cgc.buflen > sizeof(disc_information))
> > >  		cgc.buflen = sizeof(disc_information);
> > >  
> > > +	printk("cdrom: re-reading di, len=%d\n", cgc.buflen);
> > >  	cgc.cmd[8] = cgc.buflen;
> > >  	return cdo->generic_packet(cdi, &cgc);
> > >  }
> > On 2.6.4 with your patch I get:
> > Mar 23 15:46:03 venus kernel: cdrom: read_di failed, -95
> 
> Ok, so your drive doesn't support GPCMD_READ_DISC_INFO at all. Probably
> the best bet is simply to allow writable open if cdrom_get_disc_info()
> fails after all, even though I hate doing stuff like that.
> 
> ===== drivers/cdrom/cdrom.c 1.50 vs edited =====
> --- 1.50/drivers/cdrom/cdrom.c	Tue Mar 16 09:41:01 2004
> +++ edited/drivers/cdrom/cdrom.c	Tue Mar 23 16:23:07 2004
> @@ -725,7 +725,7 @@
>  	disc_information di;
>  
>  	if (cdrom_get_disc_info(cdi, &di))
> -		return 0;
> +		return -1;
>  
>  	return di.erasable;
>  }
> @@ -735,7 +735,16 @@
>   */
>  static int cdrom_dvdram_open_write(struct cdrom_device_info *cdi)
>  {
> -	return !cdrom_media_erasable(cdi);
> +	int ret = cdrom_media_erasable(cdi);
> +
> +	/*
> +	 * allow writable open if media info read worked and media is
> +	 * erasable, _or_ if it fails since not all drives support it
> +	 */
> +	if (!ret)
> +		return 1;
> +
> +	return 0;
>  }
>  
>  static int cdrom_mrw_open_write(struct cdrom_device_info *cdi)
Just to be sure. In 2.4 it was not checked?
Will your patch go in 2.6.5/2.6.6 or I'll have to patch it manually till
end of my life ? :)
Regards,

Olaf

