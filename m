Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263234AbTDCAko>; Wed, 2 Apr 2003 19:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263236AbTDCAko>; Wed, 2 Apr 2003 19:40:44 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:37383 "HELO
	pine.compass.com.ph") by vger.kernel.org with SMTP
	id <S263234AbTDCAkh>; Wed, 2 Apr 2003 19:40:37 -0500
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
In-Reply-To: <Pine.LNX.4.44.0304022245520.2488-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0304022245520.2488-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1049330578.1029.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Apr 2003 08:45:10 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-03 at 05:55, James Simmons wrote:
> 
> > James,
> > 
> > Here's a revised patch.  I was able to receive source code from SciTech
> > (c/o Kendall Bennett) which allowed me to fix bugs and complete the
> > parser.  It's probably around 90-95% complete in terms of basic parsing.
> > 
> > It also fixes memory leaks which was present in the old patch.
> 
> Let really good. I applied it to my local tree but haven't passed it to BK 
> fbdev yet. The only thing I like to see changed is get_EDID. At present it 
> accepts a struct pci_dev. Now for generic support for the intel platform 
> we can get this from the BIOS. You already have a patch that does this. 
> It doesn't need a struct pci_dev in this case. It is possible to get this 
> info from the i2c bus but I never seen any drivers do this. What data would
> we have to pass in get the EDID inforamtion? So the question is how 
> generic will get_EDID end up being or will we have to have driver specfic 
> hooks since I don't pitcure i2c approaches being the same for each video 
> card. Petr didn't you attempt this with the matrox driver at one time?
> 

I think we just need an additional method in struct fb_ops. Something like 
this:

unsigned char *fb_get_edid(struct fb_info *info)
{
	if (info->fbops->fb_get_edid)
		return info->fbops->fb_get_edid(info);
	else 
		return fallback_get_edid_method();
}

We can get the EDID by different methods:

1. User uploads EDID to kernel via an ioctl.  This is always preferred,
as it gives the user the power to override machine settings, or if there
is no other method to get the EDID.  We can also have a userland utility
that encodes user-specified monitor information and modelines into EDID
info (a reverse EDID parser).  For instance, selected entries in
/etc/fb.modes can be easily converted to EDID which the user can upload
to fbdev.

2. Gets it through device-specific hooks (i2c, whatever), if available. 
This is second choice, as it can get the EDID anytime.  This is useful
when a user decides to change monitors without rebooting, or if the
device is a non-primary display.

3.  Some architecture specific methods, such as doing it via the BIOS. 
This is the last choice, our fallback method. as this EDID may be static
and represents only the display detected at boot time.

For supplementary functions, we also need some kind of control that
allows the user to tell fbdev "I've switched monitors, please reread the
EDID". We want to avoid doing DDC each time fbdev does an fb_set_var(),
especially for DDC1 which can be very slow. 

Also, a way to download the EDID from kernel to userland.

Tony

  



