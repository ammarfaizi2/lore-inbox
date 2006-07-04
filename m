Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWGDVwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWGDVwN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 17:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWGDVwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 17:52:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:60371 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751258AbWGDVwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 17:52:12 -0400
Date: Tue, 4 Jul 2006 14:48:24 -0700
From: Greg KH <greg@kroah.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, hal@freedesktop.org
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Battery-related regression between 2.6.17-git3 and 2.6.17-git6
Message-ID: <20060704214824.GC23762@kroah.com>
References: <200607020021.15040.rjw@sisk.pl> <200607032226.04094.rjw@sisk.pl> <20060703204519.GA11289@kroah.com> <200607041355.43361.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607041355.43361.rjw@sisk.pl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 01:55:43PM +0200, Rafael J. Wysocki wrote:
> On Monday 03 July 2006 22:45, Greg KH wrote:
> > On Mon, Jul 03, 2006 at 10:26:03PM +0200, Rafael J. Wysocki wrote:
> > > On Monday 03 July 2006 21:44, Greg KH wrote:
> > > > On Mon, Jul 03, 2006 at 09:39:22PM +0200, Rafael J. Wysocki wrote:
> > > > > On Monday 03 July 2006 20:00, Greg KH wrote:
> > > > > > On Mon, Jul 03, 2006 at 01:16:45PM +0200, Rafael J. Wysocki wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > On Sunday 02 July 2006 11:15, Rafael J. Wysocki wrote:
> > > > > > > > On Sunday 02 July 2006 00:21, Rafael J. Wysocki wrote:
> > > > > > > > > With the recent -git on my box (Asus L5D, x86_64 SUSE 10) the powersave
> > > > > > > > > demon is apparently unable to get the battery status, although the data in
> > > > > > > > > /proc/acpi/battery/BAT0 seem to be correct.  As a result, battery status
> > > > > > > > > notification via kpowersave doesn't work and it's hard to notice when the
> > > > > > > > > battery is low/critical.
> > > > > > > > > 
> > > > > > > > > So far I have verified that this feature works fine with 2.6.17-git3 and
> > > > > > > > > doesn't work with 2.6.17-git6 (-git5 doesn't compile here).
> > > > > > > > > 
> > > > > > > > > I'll try to get more information tomorrow (unless someone in the know has
> > > > > > > > > an idea of what's up ;-) ).
> > > > > > > > 
> > > > > > > > I've verified that the problem first appeared in 2.6.17-git4.
> > > > > > > 
> > > > > > > Apparently this happens because powersaved takes the battery status
> > > > > > > information from hald and the following kernel changes make hald crash on
> > > > > > > my system:
> > > > > > > 
> > > > > > > http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=43104f1da88f5335e9a45695df92a735ad550dda
> > > > > > > http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=bd00949647ddcea47ce4ea8bb2cfcfc98ebf9f2a
> > > > > > > http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=c182274ffe1277f4e7c564719a696a37cacf74ea
> > > > > > > http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=9bde7497e0b54178c317fac47a18be7f948dd471
> > > > > > > http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=36679ea59846d8f34a48f71ca1a37671ca0ad3c5
> > > > > > > 
> > > > > > > (ie. after reverting them hald works again).
> > > > > > 
> > > > > > Ick, that should not cause any problems, as sysfs should look identical
> > > > > > to how it was before those patches.  Except that the /sys/class/usb/
> > > > > > stuff is now symlinks instead of real directories, but HAL has had to
> > > > > > handle that for a long time now (and it's even documented in
> > > > > > Documentation/ABI/testing/sysfs-class)
> > > > > 
> > > > > Well, apparently one of them happens to trigger a buffer overflow in "my"
> > > > > version of hal. ;-)
> > > > > 
> > > > > > Can you tell me exactly which of the above patches breaks HAL?
> > > > > 
> > > > > That would be quite a bit of testing and now I'm sure it's a hal issue.
> > > > 
> > > > git bisect would help out a lot.  Or just ask the HAL developers, they
> > > > might know.
> > > 
> > > Anyway I'd have to compile and test at least a couple of kernels.
> > > [For the record: I'm quite sure that 36679ea59846d8f34a48f71ca1a37671ca0ad3c5
> > > and 9bde7497e0b54178c317fac47a18be7f948dd471 together break hal on
> > > my system; this seems to be related to endpoints' paths in sysfs.]
> > 
> > I don't understand why that would break HAL, we are just adding new
> > devices to the sysfs device tree, which the kernel is free to do at any
> > time.  HAL should not care about that.
> > 
> > Oh, and 36679ea59846d8f34a48f71ca1a37671ca0ad3c5 is just an internal api
> > change, it does not affect userspace in any way.  So I don't see how
> > that would have anything to do with HAL at all.
> 
> Could you please have a look at the end of the attached output of
> 'strace -f /usr/sbin/hald --daemon=yes --retain-privileges --verbose=yes'
> (produced on vanilla 2.6.17-git4)?
> 
> I'm not sure what exactly happens there, but I think hal crashes due to
> a buffer overflow.

Yes, that looks like what is happening.  Perhaps one of the HAL
developers can point you at a patch that you can apply to your version
of HAL to get it working.

Either way, this is not a kernel bug, as it could have happened with any
very long depth device tree, you were just lucky it didn't happen
sooner.

thanks,

greg k-h
