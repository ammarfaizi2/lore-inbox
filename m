Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314327AbSEIUmz>; Thu, 9 May 2002 16:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314329AbSEIUmy>; Thu, 9 May 2002 16:42:54 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:15432 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S314327AbSEIUmx>; Thu, 9 May 2002 16:42:53 -0400
Date: Thu, 9 May 2002 16:41:09 -0400
From: Doug Ledford <dledford@redhat.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: [PATCH] Fix scsi.c kmod noise
Message-ID: <20020509164109.F11386@redhat.com>
In-Reply-To: <mailman.1020966481.25371.linux-kernel2news@redhat.com> <200205092033.g49KXxG06486@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2002 at 04:33:59PM -0400, Pete Zaitcev wrote:
> > [...] This error crops up whenever scsi.c
> > is compiled in (which is fairly common in 2.4, Red Hat Linux does this
> > as well).
> 
> > "kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2"
> 
> > --- linux/drivers/scsi/scsi.c.OLD	Wed May  1 16:33:14 2002
> > +++ linux/drivers/scsi/scsi.c	Wed May  1 16:34:46 2002
> > @@ -2389,10 +2389,18 @@
> 
> > +/* This doesn't make much sense to do unless CONFIG_SCSI is a module itself.
> > + *
> > + * ~spot <tcallawa@redhat.com> 05012002
> > + */
> > +
> > +#ifdef MODULE
> >  #ifdef CONFIG_KMOD
> >  		if (scsi_hosts == NULL)
> >  			request_module("scsi_hostadapter");
> >  #endif
> > +#endif
> >  		return scsi_register_device_module((struct Scsi_Device_Template *) ptr);
> 
> I do not see how you suppose this should work. What if scsi.c
> is compiled in, and sunesp.c is not? Besides, why are you running
> a kernel with CONFIG_KMOD if exec returns -ENOENT? I suspect
> something is broken in the Aurora land.

Actually, it happens because of the standard initrd.  In the initrd we 
load scsi_mod first, and on initialization scsi_mod attempt to 
request_module the host adapter, but there is no /sbin/modprobe (and no 
/etc/modules.conf for modprobe to read either) so you get the error above.  
Then, the initrd continues on to load the specific scsi modules.  So, in 
actuallity, it makes sense to *disable* this entire code section if scsi 
is a module because it will *always* be loaded before the host adapter (it 
has to for dependancy's sake) and will always be a failure.  When compiled 
into the kernel I'm not sure it makes any sense either since if the scsi 
driver isn't loaded yet, then where would we be getting modprobe and 
/etc/modules.conf from?  It would either have to be an initrd (in which 
case the linuxrc script can load the module manually) or / is on ide (or 
something like that) which doesn't depend on our host adapter, in which 
case it makes no sense to go around loading things without them being 
specifically requested.  Personally, I think this code should just die, 
period.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
