Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317282AbSFRCks>; Mon, 17 Jun 2002 22:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317286AbSFRCkr>; Mon, 17 Jun 2002 22:40:47 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:20011 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S317282AbSFRCkp>; Mon, 17 Jun 2002 22:40:45 -0400
Date: Mon, 17 Jun 2002 22:40:47 -0400
From: Doug Ledford <dledford@redhat.com>
To: Kurt Garloff <kurt@garloff.de>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: /proc/scsi/map
Message-ID: <20020617224046.A6590@redhat.com>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20020615133606.GC11016@gum01m.etpnet.phys.tue.nl> <20020617180818.C30391@redhat.com> <20020617230648.GA3448@gum01m.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020617230648.GA3448@gum01m.etpnet.phys.tue.nl>; from kurt@garloff.de on Tue, Jun 18, 2002 at 01:06:48AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 01:06:48AM +0200, Kurt Garloff wrote:
> Hi Doug,
> 
> On Mon, Jun 17, 2002 at 06:08:18PM -0400, Doug Ledford wrote:
> > On Sat, Jun 15, 2002 at 03:36:06PM +0200, Kurt Garloff wrote:
> > > Life would be easier if the scsi subsystem would just report which SCSI
> > > device (uniquely identified by the controller,bus,target,unit tuple) belongs
> > > to which high-level device. The information is available in the kernel.
> > 
> > Umm, this patently fails to meet the criteria you posted of "stable device 
> > name".  Adding a controller to a system is just as likely to blow this 
> > naming scheme to hell as it is to blow the traditional linux /dev/sd? 
> > scheme.  IOW, even though the /proc/scsi/map file looks nice and usefull, 
> > it fails to solve the very problem you are trying to solve.
> 
> In case you just add controllers, you just need to make sure you get them the
> same numbers again. A solution for this exists already:
> * For a kernel where SCSI low-level drivers are loaded as modules,
>   you just need to keep the order constant
> * For compiled in SCSI drivers, use scsihosts=

No, this is not true.  If you add a new controller (for some new disks in 
a new external enclosure or whatever), and that controller uses the same 
driver as other controller(s) in your system, then you have no guarantee 
of order.  For example, adding a 4th aic7xxx controller to your system 
might or might not place the new controller at the end of the list 
depending on PCI scan order, etc.  There simply is *no* guarantee here of 
any consistent naming, so don't bother trying to claim there is.

Now don't get me wrong, I'm not saying the patch isn't usefull, but the 
patch doesn't provide *any* guarantee of consistent device naming and so 
using that as a reason to put the patch into the mainstream kernel is 
utter crap.  Go ahead and make your case for why it should be in the 
kernel, but don't use reasons that aren't correct.
 
> But actually, the patch is not meant to be the holy grail of persistent
> device naming. But it enables userspace tools to collect information 
> * reliably 
>   (fails so far due to possible open() failures with unknown
>    relation to the corresponding sg device (which could be opened))

This can be done without your patch (the mapping from /dev/sg to /dev/sd? 
or /dev/st? or /dev/scd? or whatever is not impossible from user space 
without your patch, it just requires a user space tool to open the files 
and start comparing host/bus/id/lun combinations from dev file to dev 
file).

> * without too much trouble

This part is true enough, it is easier to read the map file than to 
program the information retrieval I mentioned above.

> Both things I consider important and useful.
> 
> The patch basically does provide two pieces of information:
> * mapping between sg vs. other high level devices

This I think is usefull.

> * mapping CBTU to high-level devices

This I don't think is usefull at all.  It's no more reliable than our 
current system and people that are depending on this to solve their "I 
can't tell what device is what" delima are going to be sorely upset when 
they realize that hardware changes can change this stuff around just as 
fast as it changes around the /dev/sd? mappings.

> The latter one is enough for many setups,

The latter one is just as broken in design as the original /dev/sd? 
enumeration problem (which stands to reason since this method also is an 
enumeration method, it's just that instead of enumerating the disks 
starting at 0, we are enumerating the SCSI controllers starting at the 
first one we find and going from there).

> and the former can be used for
> more elaborate solutions involving userspace tools more advanced than the
> simple script I included in the patch.

Which is the much better way to go.

> If you want to go for the holy grail, you may either come up with a 
> unique address at hardware level (which does currently not exist for all
> types dealt with by the SCSI subsystem) and make it available to SCSI mid
> level or use signatures that allows you to find devices back. LVM, e.g.
> does the latter. 
> But at this moment, I fear, neither of them are possible in all cases.
> 
> Regards,
> -- 
> Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
> Physics: Plasma simulations    <K.Garloff@TUE.NL>     [TU Eindhoven, NL]
> Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
>  (See mail header or public key servers for PGP2 and GPG public keys.)



-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
