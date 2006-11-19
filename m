Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933118AbWKSTyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933118AbWKSTyk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 14:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933121AbWKSTyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 14:54:40 -0500
Received: from firewall.rowland.harvard.edu ([140.247.233.35]:61906 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S933118AbWKSTyj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 14:54:39 -0500
Date: Sun, 19 Nov 2006 14:54:37 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: linux1394-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: deadlock in "modprobe -r ohci1394" shortly after "modprobe
 ohci1394"
In-Reply-To: <tkrat.8ead93641e26cf48@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.44L0.0611191431120.15059-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2006, Stefan Richter wrote:

> I wrote:
> > http://bugzilla.kernel.org/show_bug.cgi?id=6706 :
> ...
> > Right now I don't see a sane fix but I will have a few nights sleep over
> > it...
> 
> A couple of reboots and a slightly charred pizza later I found out the
> following:
> 
> 1. If Alan's 2.6.16 patch is reverted, the deadlock is gone as expected.
>    See bugzilla for the reverting patch.
> 
> 2. The following patch works too, without the need to revert Alan's
>    driver core changes.
> 
> 3. Now that I have an at least unsane (sic) fix for the deadlock, a new
>    bug in eth1394's remove code was revealed. This is a separate issue
>    and logged as http://bugzilla.kernel.org/show_bug.cgi?id=7550 .
> 
> Please comment on the patch below.
> 
> 
> From: Stefan Richter <stefanr@s5r6.in-berlin.de>
> Subject: ieee1394: nodemgr: fix deadlock in shutdown
> 
> If "modprobe ohci1394" was quickly followed by "modprobe -r ohci1394",
> say with 1 second pause in between, the modprobe -r got stuck in
> uninterruptible sleep in kthread_stop.  At the same time the knodemgrd
> slept uninterruptibly in bus_rescan_devices_helper.
> 
> This was a regression since Linux 2.6.16,
> 	commit bf74ad5bc41727d5f2f1c6bedb2c1fac394de731
> 	"Hold the device's parent's lock during probe and remove"
> 
> The fix lets ieee1394's nodemgr temporarily counteract the driver core's
> downed parent->sem.  Thus bus_rescan_devices_helper can proceed and
> knodemgrd terminates properly.
> 
> Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
> ---
>  drivers/ieee1394/nodemgr.c |   11 +++++++++++
>  1 files changed, 11 insertions(+)
> 
> Index: linux-2.6.19-rc4/drivers/ieee1394/nodemgr.c
> ===================================================================
> --- linux-2.6.19-rc4.orig/drivers/ieee1394/nodemgr.c	2006-11-18 23:31:35.000000000 +0100
> +++ linux-2.6.19-rc4/drivers/ieee1394/nodemgr.c	2006-11-19 15:14:50.000000000 +0100
> @@ -1873,8 +1873,19 @@ static void nodemgr_remove_host(struct h
>  {
>  	struct host_info *hi = hpsb_get_hostinfo(&nodemgr_highlevel, host);
>  
> +	/* Here comes a potential deadlock. A "modprobe -r ohci1394" calls
> +	 * nodemgr_remove_host from driver_detach which takes the parent->sem.
> +	 * Meanwhile, knodemgrd may be running into bus_rescan_devices_helper
> +	 * which would block on the same semaphore. Therefore lift the
> +	 * semaphore until knodemgrd exited. */
>  	if (hi) {
> +		/* up(&host->device.sem);	--- apparently not required */
> +		if (host->device.parent)
> +			up(&host->device.parent->sem);
>  		kthread_stop(hi->thread);
> +		if (host->device.parent)
> +			down(&host->device.parent->sem);
> +		/* down(&host->device.sem);	--- apparently not required */
>  		nodemgr_remove_host_dev(&host->device);
>  	}
>  }

Obviously this patch isn't pretty.  It's also incorrect, because it 
reacquires the parent's semaphore while holding the child's -- that's 
another recipe for deadlock.

Knowing nothing at all about ieee1394, I get the feeling that the culprit
here is a strange subsystem design.  In fact, I don't understand exactly
what's going wrong.  Evidently the rmmod thread owns the locks for both
the host being removed and its parent, and it wants to stop knodemgrd,
which is waiting to acquire the host's parent's lock because it is
attempting to rescan the parent.  Is that right?

It doesn't make sense.  If knodemgrd is rescanning the parent then the 
parent must not have a driver.  If it doesn't have a driver, how can it 
have children?

Alan Stern

