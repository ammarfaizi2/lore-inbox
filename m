Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317398AbSGIUUi>; Tue, 9 Jul 2002 16:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317401AbSGIUUi>; Tue, 9 Jul 2002 16:20:38 -0400
Received: from relay02.valueweb.net ([216.219.253.236]:33037 "EHLO
	relay02.valueweb.net") by vger.kernel.org with ESMTP
	id <S317398AbSGIUUd>; Tue, 9 Jul 2002 16:20:33 -0400
Message-ID: <3D2B3FE5.2AD6859A@opersys.com>
Date: Tue, 09 Jul 2002 15:56:21 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: John Levon <movement@marcelothewonderpenguin.com>
CC: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org, Richard Moore <richardj_moore@uk.ibm.com>,
       bob <bob@watson.ibm.com>
Subject: Re: Enhanced profiling support (was Re: vm lock contention reduction)
References: <20020708113928.GA80073@compsoc.man.ac.uk> <Pine.LNX.4.44.0207081039390.2921-100000@home.transmeta.com> <20020709165754.GA96901@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been following oprofile's development for a while and was quite
happy to see a DCPI equivalent come to Linux. The LTT data engine
collection is actually inspired by the one described in the DCPI paper.

As I said earlier, much of the kernel behavior information oprofile
requires is made available by LTT. Instead of redirecting the syscall
table, for example, LTT hooks itself within the syscall path to obtain
all syscall entries and exits (all contained within #ifdef's of course).
The same goes for important events such as forks/reads/writes/scheduling
etc. The mapping of PID to the name of an executable, for instance,
is easily extracted from this information.

As with other applications/uses which require insight into the dynamics
of the kernel, it would seem to me that oprofile would greatly benefit
from the integration of the LTT patch in the mainline kernel. If
nothing else, oprofile could use the LTT collection engine to forward
its data to user-space, much like DProbes currently does.

By the same token, the LTT collection engine could replace the slew
of per-driver tracing systems already in the kernel, providing therefore
a uniform tracing system:
drivers/char/ftape/lowlevel/ftape-tracing.c
drivers/char/ip2/ip2trace.c
drivers/char/dtlk.c
drivers/char/mwavedd.h
drivers/char/n_r3964
drivers/acpi/utilities/utdebug.c
drivers/cdrom/sbpcd.c
drivers/isdn/eicon/eicon_mod.c
drivers/scsi/gdth.c
drivers/scsi/megaraid.c
drivers/scsi/qlogicfc.c
drivers/scsi/qlogicisp.c
drivers/net/wavelan.c
drivers/net/skfp/hwmtm.c
drivers/net/pcmcia/wavelan_cs.c
drivers/net/wireless/orinoco.c
drivers/net/wireless/orinoco_cs.c
drivers/video/radeonfb.c
drivers/usb/pwc.h
drivers/usb/hpusbscsi.c
include/linux/jdb.h for fs/ext3/*.c and fs/jdb/*.c
net/irda/irnet/irnet.h
etc.

The above list is but a sample of the files containing actual code
implementing tracing and/or data collection engines. There a great
deal many files that actually have trace points already in them. A
simple "grep -r TRACE *" provides an interesting insight to the
number of subsystems requiring tracing, each implementing their own
scheme.

It is time to provide a uniform tracing and high-throughput data
collection engine for all to use. LTT has already been field-tested
for these purposes and is very easily extended to include any
additional functionality required.

Any comments/thoughts are greatly appreciated.

Cheers,

Karim

John Levon wrote:
> 
> On Mon, Jul 08, 2002 at 10:52:36AM -0700, Linus Torvalds wrote:
> 
> >  - I'd associate each profiling event with a dentry/offset pair, simply
> >    because that's the highest-level thing that the kernel knows about and
> >    that is "static".
> 
> This makes sense, I think.
> 
> >  - I'd suggest that the profiler explicitly mark the dentries it wants
> >    profiled, so that the kernel can throw away events that we're not
> >    interested in. The marking function would return a cookie to user
> >    space, and increment the dentry count (along with setting the
> >    "profile" flag in the dentry)
> 
> For a system-wide profiler, this needs to be /all/ dentries that get
> mapped in with executable permissions, or we lose any mappings of shared
> libraries we don't know about etc. Essentially, oprofile wants samples
> against any dentry that gets mmap()ed with PROT_EXEC, so this marking
> would really need to happen at mmap() time. Missing out on any dentry
> profiles amounts to data loss in the system profile and has the
> potential to mislead.
> 
> >  - the "cookie" (which would most easily just be the kernel address of the
> >    dentry) would be the thing that we give to user-space (along with
> >    offset) on profile read. The user app can turn it back into a filename.
> >
> > Whether it is the original "mark this file for profiling" phase that saves
> > away the cookie<->filename association, or whether we also have a system
> > call for "return the path of this cookie", I don't much care about.
> > Details, details.
> >
> > Anyway, what would be the preferred interface from user level?
> 
> oprofile currently receives eip-pid pairs, along with the necessary
> syscall tracing info needed to reconstruct file offsets. The above
> scheme removes the dependency on the pid, but this also unfortunately
> throws away some useful information.
> 
> It is often useful to be able to separate out shared-library samples on
> a per-process (and/or per-application) basis. Any really useful profile
> buffer facility really needs to preserve this info, but just including
> the raw pid isn't going to work when user-space can't reconstruct the
> "name" of the pid (where "name" would be something "/bin/bash") because
> the process exited in the meantime.
> 
> The same goes for kernel samples that happen in process context.
> 
> So this might work well in tandem with some global process-tree tracing
> scheme, but I don't know what form that might take ...
> 
> (Then there are kernel modules, but that's probably best served by
> patching modutils)
> 
> regards
> john
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
