Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbTDKSA1 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 14:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbTDKSA1 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 14:00:27 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:60908 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261323AbTDKSAZ (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 14:00:25 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] udev 0.1 release
Date: Fri, 11 Apr 2003 20:12:05 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       message-bus-list@redhat.com, Daniel Stekloff <dsteklof@us.ibm.com>
References: <20030411032424.GA3688@kroah.com> <200304110837.37545.oliver@neukum.org> <20030411172011.GA1821@kroah.com>
In-Reply-To: <20030411172011.GA1821@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304112012.05054.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > - There's a race with replugging, which you can do little about
>
> True, but this can get smaller.

There isn't such a thing as a small race. Either there is a race or there
is no race. 'Should usually work' is not enough, especially when security
is concerned.

> > - Error handling. What do you do if the invocation ends in EIO ?
>
> Which invocation?  From /sbin/hotplug?

Yes.
This is a serious problem. Your scheme has very nasty failure modes.
By implementing this in user space you are introducing additional
failure modes.
- You need disk access -> EIO
- You have no control over memory allocation -> ENOMEM, EIO in swap space
Usually I'd not care about EIO, but here security is threatened. EIO crashing
the system under some circumstances is inevitable, EIO opening a security
hole is not acceptable however.

> > - Performance. What happens if you plug in 4000 disks at once?
>
> You crash your power supply :)
>
> Seriously, the kernel spawns 4000 instances of /sbin/hotplug just like
> it always does.  I'm working on keeping udev from spawning anything else
> to keep the process cound down (right now it fork/execs for mknod, but
> that was just me being lazy.)

4000 spawnings is 32MB for kernel stacks alone.
You cannot assume that resources will be sufficient for that.

That again is a serious problem, because you cannot resync.
If you lose a 'remove' event you're screwed.

And of course, what do you do if the driver is not yet loaded?

	Regards
		Oliver

