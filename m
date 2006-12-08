Return-Path: <linux-kernel-owner+w=401wt.eu-S1760736AbWLHN6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760736AbWLHN6U (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 08:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760734AbWLHN6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 08:58:20 -0500
Received: from [212.33.187.138] ([212.33.187.138]:32924 "EHLO
	localhost.localdomain" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760731AbWLHN6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 08:58:19 -0500
From: Al Boldi <a1426z@gawab.com>
To: Jean-Paul Saman <jean-paul.saman@nxp.com>
Subject: Re: [PATCH]: typo in init/initramfs.c
Date: Fri, 8 Dec 2006 16:58:24 +0300
User-Agent: KMail/1.5
References: <OFFC8397EF.1D0C38CD-ONC125723E.002EA3BB-C125723E.002EE367@philips.com>
In-Reply-To: <OFFC8397EF.1D0C38CD-ONC125723E.002EA3BB-C125723E.002EE367@philips.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612081658.24194.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Paul Saman wrote:
> linux-kernel-owner@vger.kernel.org wrote on 06-12-2006 19:17:27:
> > Jean-Paul Saman wrote:
> > > In populate_rootfs() the printk on line 554. It says "Unpacking
> > > initramfs..", which is confusing because if that line is reached the
> > > code has already decided that the image is an initrd image.
> >
> > Are you sure?
>
> Yes.

Are you really sure?

> > > The printk is thus
> > > wrong in stating that it is unpacking an "initramfs". It should says
> > > "initrd" instead. The attached patch corrects this typo.
> > >
> > > Signed-off-by: Jean-Paul Saman <jean-paul.saman@nxp.com>
> > >
> > > diff --git a/init/initramfs.c b/init/initramfs.c
> > > index d28c109..f6020db 100644
> > > --- a/init/initramfs.c
> > > +++ b/init/initramfs.c
> > > @@ -551,7 +551,7 @@ #ifdef CONFIG_BLK_DEV_RAM
> >
> > This is where initramfs is discerned from initrd, as both are available.
> >
> > >                         free_initrd();
> > >                 }
> > >  #else
> >
> > Otherwise it's initramfs only.
>
> No otherwise it falls under CONFIG_BLK_DEV_INITRD and it that suggests it
> must be a initrd, not a initramfs as the original printk() suggests.

This is what 2.6.19 says:

=========================
#ifdef CONFIG_BLK_DEV_INITRD
	if (initrd_start) {
#ifdef CONFIG_BLK_DEV_RAM
		int fd;
		printk(KERN_INFO "checking if image is initramfs...");
		err = unpack_to_rootfs((char *)initrd_start,
			initrd_end - initrd_start, 1);
		if (!err) {
			printk(" it is\n");
			unpack_to_rootfs((char *)initrd_start,
				initrd_end - initrd_start, 0);
			free_initrd();
			return;
		}
		printk("it isn't (%s); looks like an initrd\n", err);
		fd = sys_open("/initrd.image", O_WRONLY|O_CREAT, 0700);
		if (fd >= 0) {
			sys_write(fd, (char *)initrd_start,
					initrd_end - initrd_start);
			sys_close(fd);
			free_initrd();
		}
#else // <=== of #ifdef CONFIG_BLK_DEV_RAM
		printk(KERN_INFO "Unpacking initramfs...");
		err = unpack_to_rootfs((char *)initrd_start,
			initrd_end - initrd_start, 0);
		if (err)
			panic(err);
		printk(" done\n");
		free_initrd();
#endif // <=== of #ifdef CONFIG_BLK_DEV_RAM
	}
#endif // <=== of #ifdef CONFIG_BLK_DEV_INITRD
=========================

Maybe you're getting confused with the dual intitrd naming-convention.  
InitRD used to mean InitRamDisk only, now it means InitRamFS and InitRamDisk 
#ifdef CONFIG_BLK_DEV_RAM, else it means InitRamFS only.

But still, it's rather refreshing to see you so convinced.


Thanks!

--
Al

