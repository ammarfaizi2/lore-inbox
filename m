Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267333AbUIOTtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267333AbUIOTtT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 15:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267338AbUIOTtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 15:49:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26539 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267333AbUIOTtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 15:49:13 -0400
Subject: Re: [PATCH] allow root to modify raw scsi command permissions list
From: Peter Jones <pjones@redhat.com>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0409152151190.1972@kai.makisara.local>
References: <1095173470.5728.3.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409152151190.1972@kai.makisara.local>
Content-Type: text/plain
Date: Wed, 15 Sep 2004 15:49:00 -0400
Message-Id: <1095277740.20046.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 22:14 +0300, Kai Makisara wrote:
> On Tue, 14 Sep 2004, Peter Jones wrote:
> 
> > diff -urpN linux-2.5-export/drivers/block/Makefile pjones-2.5-export/drivers/block/Makefile
> > --- linux-2.5-export/drivers/block/Makefile	2004-09-10 11:54:01 -04:00
> > +++ pjones-2.5-export/drivers/block/Makefile	2004-09-10 12:11:50 -04:00
> > @@ -13,7 +13,7 @@
> >  # kblockd threads
> >  #
> [Patch snipped]
> 
> Your patch allows updating the filters for each device. This is one aspect 
> of the problem. Another problem is that the command filter appropriate for 
> CD/DVD writers is _forced on all devices_. In your patch this is in the 
> defaults. In the current scsi_ioctl filter it applies to everything.

My patch leaves the defaults as what are currently in the kernel.  

> I have already commented on MODE SELECT. I still think it is dangerous. 

It's only marked as being allowed if you have write access; /dev/hda
usually isn't a+w, last I checked.

I'd actually say that this isn't suitable for CD drives.  To do CDDA
reads in many cases you need MODE_SELECT.  As such, CD drives should
have MODE_SELECT in the list of things allowed to read.  But the point
is that this gives control of the policy to the userland, where it
belongs.

> Looking at the command list reveals a couple of other problems:
> - The command GPCMD_READ_DISC_INFO is "safe_for_read". The command 0x51
>   has also another use: XPWRITE(10), i.e., a write command. Clearly a
>   problem.
> - The "safe_for_read" command GPCMD_REPORT_KEY, 0xa4, has aliases 
>   CHANGE ALIAS, SET DEVICE IDENTIFIER and SET TARGET PORT.
> - The "safe_for_write" command GPCMD_SEND_DVD_STRUCTURE has alias
>   VOLUME SET OUT (raid configuration).

My intent with the patch isn't really to take any stance on which
commands should and shouldn't be allowed.  In fact, it's quite the
opposite -- this allows initscripts/hotplug to install an appropriate
list of commands for each device.

> There are other aliases but they return information and don't look too 
> dangerous. The command code is only 8 bits and there probably will be more 
> aliasing in future.
> 
> My conclusion is that the filter _necessary_ for burning CD/DVDs is _not 
> safe for all devices_.

Sure.  The point is that there's no reason the kernel should make that
its problem.

> How to solve this problem?

Let the distros pick the list.

> One idea I had was to add a sysfs-changable attribute accessible to the
> filter (disk or queue) that would have a few possible states: allow
> only root, allow filtered, allow all?

This is basically what my patch gives you.  Here's a handy table:

owner       mode  explanation
root.disk   0600  allow only root
root.disk   0400  allow root read commands, and write if CAP_SYS_RAWIO
root.disk   0660  allow root and disk members to do everything
root.disk   0640  allow root everything, disk can do read commands.
root.disk   0644  allow root everything, everybody read commands.
root.disk   0664  allow root and disk everything, all else get read
etc

That's everything except "allow all", but that is easy:

for x in {0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f}\
{0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f} ; do
  echo "add read $x" > /sys/block/hda/filter/ok_read_commands
  echo "add write %x" > /sys/block/hda/filter/ok_write_commands
done

> The default would be to "allow only root". The cdrom registering could
> set this to "allow filtered". This would allow the current behaviour
> for CD/DVD drives but would be safe for others. Other devices could be
> selectively allowed passthrough access if necessary.

There's no point in making the cdrom registration have code for this --
just let userland do the policy stuff, like it should.

> This could also be done in your approach. One possibility would be to 
> start with empty filter and call from CD/DVD registering a function that 
> sets the filter you currently have as default. This would be both flexible 
> and safe.

I don't want to do an empty filter, because that'll mean existing users
of SG_IO and such break for no real reason.  The approach my patch takes
is not to change *any* of the existing policy, but to enable distros to
change it to their hearts' content.  It's *dead* simple to make
initscripts and hotplug pick "correct" lists for each device.
-- 
        Peter

