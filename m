Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282453AbRLBSs3>; Sun, 2 Dec 2001 13:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282062AbRLBSsT>; Sun, 2 Dec 2001 13:48:19 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:2751 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281210AbRLBSsE>; Sun, 2 Dec 2001 13:48:04 -0500
Date: Sun, 2 Dec 2001 11:47:48 -0700
Message-Id: <200112021847.fB2IlmZ11175@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: andrew may <acmay@acmay.homeip.net>
Cc: Adam Schrotenboer <ajschrotenboer@lycosmail.com>,
        =?iso-8859-1?Q?Christian_Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.17pre2: devfs: devfs_mk_dir(printers): could not append to dir: dffe45c0 "", err: -17
In-Reply-To: <20011201180940.B21185@ecam.san.rr.com>
In-Reply-To: <E16A6LR-00042s-00@mrvdom02.schlund.de>
	<200112011808.fB1I8lq31535@vindaloo.ras.ucalgary.ca>
	<20011202013724.9085AFB80D@tabris.net>
	<20011201180940.B21185@ecam.san.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andrew may writes:
> On Sat, Dec 01, 2001 at 08:37:24PM -0500, Adam Schrotenboer wrote:
> > On Saturday 01 December 2001 13:08, Richard Gooch wrote:
> > > linux-kernel@borntraeger.net writes:
> > <snip>
> > > The new devfs core is less forgiving about these kinds of
> > > bugs/misuses.
> > >
> > > > devfs: devfs_register(nvidiactl): could not append to parent, err: -17
> > > > devfs: devfs_register(nvidia0): could not append to parent, err: -17
> > > >
> > > > with 2.4.16 and before the message was:
> > > >
> > > > devfs: devfs_register(): device already registered: "nvidia0"
> > >
> > > Who knows what nvidia does? Talk to them. Could be a bug in their
> > > driver where they create duplicate entries (the old devfs code would
> > > often let you get away with this). Or again, perhaps something in
> > > user-space is creating these entries.
> > >
> > As of 1541 anyway (haven't tried anything newer, assuming newer exists), the 
> > make install of the nvidia driver also runs makedevices.sh (a vendor sp 
> > script that makes the devnodes. This may also have been put in the 
> > initscripts (mine isn't, but i tend to use the tar.gz fmt, not using the RPMs)
> > Perhaps there is no check for devfs (likely will be fixed in the next 
> > release, as this is a new situation)
> 
> There is now a 2313 version of the driver. It has put in devfs
> calls, but it seems they still call the makedefs script in the make
> install.

What's important is whether something has been added to the boot
scripts which create these device nodes in /dev.

> I don't know if the devfs code is correct but here it is.
> 
> from nv.c modules_init();
> 
> #ifdef CONFIG_DEVFS_FS
>     rc = devfs_register_chrdev(nv_major, "nvidia", &nv_fops);
> #else
>     rc = register_chrdev(nv_major, "nvidia", &nv_fops);
> #endif
> 
>     if (rc < 0) {
>         NV_EMSG((nv_state_t *) 0, "init_module: register failed");
>         return rc;
>     }
> 
>     osMemSet(nv_linux_devices, 0, sizeof(nv_linux_state_t) * NV_MAX_DEVICES);
>     num_devices = nvos_probe_devices();
>     
> #ifdef CONFIG_DEVFS_FS
>     osMemSet(nv_dev_handle, 0, sizeof(devfs_handle_t) * NV_MAX_DEVICES);
>     do {
>         char name[16];
>         int i;
> 
>         nv_ctl_handle = devfs_register(NULL, "nvidiactl",
>                             DEVFS_FL_DEFAULT, nv_major, 255,
>                             S_IFCHR | S_IRUGO | S_IWUGO,
>                             &nv_fops, NULL);
> 
>         for (i = 0; i < num_devices; i++) {
>             snprintf(name, 16, "nvidia%d", i);
>             nv_dev_handle[i] = devfs_register(NULL, name,
>                                   DEVFS_FL_DEFAULT, nv_major, i,
>                                   S_IFCHR | S_IRUGO | S_IWUGO,
>                                   &nv_fops, NULL);
>         }
>     } while(0);
> #endif

This appears reasonable. However, if they call this initialisation
code twice, it's a bug.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
