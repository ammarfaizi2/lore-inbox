Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSEJAql>; Thu, 9 May 2002 20:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315750AbSEJAqk>; Thu, 9 May 2002 20:46:40 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:22518 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315746AbSEJAqi>; Thu, 9 May 2002 20:46:38 -0400
Date: Thu, 9 May 2002 17:46:32 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Doug Ledford <dledford@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix scsi.c kmod noise
Message-ID: <20020509174632.A13819@eng2.beaverton.ibm.com>
In-Reply-To: <mailman.1020966481.25371.linux-kernel2news@redhat.com> <200205092033.g49KXxG06486@devserv.devel.redhat.com> <20020509164109.F11386@redhat.com> <1020984118.1847.7.camel@zorak.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2002 at 06:41:58PM -0400, Tom 'spot' Callaway wrote:

> I agree, but I didn't want to make any sort of drastic changes to scsi.c
> in Aurora (I'm still getting my feet wet here!). 
> 
> As to the claim that this is broken solely due to Aurora being broken, I
> can dispell that simply by pointing to the fact that Red Hat Linux 7.3
> exhibits this behavior as shipped, on machines where the scsi drivers
> are modular. dmesg log from 2.4.18-3smp is attached to this email.
> 
> In fact, sunesp is modular in Aurora, which is how this issue came to
> light. When I made the change from compiled in to modular (and started
> using an initrd), several testers reported this as a bug. 
> 
> Feel free to correct me (and Doug) if I'm wrong, because I cede that you
> know a HELL of a lot more about this than I do. My Aurora kernels use
> this, the scsi subsystem works (the modules all load as they should),
> and I don't have a kmod error message in dmesg. 
> 
> For reference, Aurora builds kernels with the following relevant
> options: 
> 
> CONFIG_MODULES=y 
> CONFIG_MODVERSIONS=y 
> CONFIG_KMOD=y 
> 
> CONFIG_SCSI=y 
> CONFIG_BLK_DEV_SD=y 
> 
> CONFIG_SCSI_SUNESP=m 
> 
> 
> The Red Hat Linux 7.3 i686 config builds kernels with the following
> relevant options: 
> 
> CONFIG_MODULES=y 
> CONFIG_MODVERSIONS=y 
> CONFIG_KMOD=y 
> 
> CONFIG_SCSI=m 
> CONFIG_BLK_DEV_SD=m 
> 
> CONFIG_SCSI_AIC7XXX=m 
> 
> As a result of further testing and thought, I definitely agree with
> Doug. The patch that I originally submitted will only get rid of the
> kmod error noise when BLK_DEV_SD is compiled into the kernel. Perhaps
> this block of code should die? I'll leave that to the experts to decide.
> 
> ~spot

It is the upper level device init/insmod that is driving the load of the
scsi adapter (in scsi.c), not the init/insmod of scsi.o. I can't think of
a good reason to just load the scsi adapter if you want it, rather than
having the init of sd.o load it.

IMO, it should go away or always happen - not conditionally on whether another
adapter is already available, or whether sd.o is loading.

If you are booting without initrd, aren't there lines in /etc/modules.conf
for scsi_hostadapter?

If you are booting with initrd, my RH 7.2 mkinitrd shows:

ln -s /bin/nash $MNTIMAGE/sbin/modprobe

man nash says:

	Additionally,  if  nash  is  invoked  as modprobe, it will
	immediately exit with a return code of zero.  This  is  to
	allow  initrd's  to  prevent  some extraneous kernel error
	messages during startup.

-- Patrick
