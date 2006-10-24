Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWJXBbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWJXBbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 21:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWJXBbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 21:31:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6072 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964972AbWJXBbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 21:31:35 -0400
Subject: Re: Battery class driver.
From: David Zeuthen <davidz@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       olpc-dev@laptop.org, mjg59@srcf.ucam.org, len.brown@intel.com,
       sfr@canb.auug.org.au, benh@kernel.crashing.org
In-Reply-To: <20061023225905.GA10977@kroah.com>
References: <1161627633.19446.387.camel@pmac.infradead.org>
	 <1161641703.2597.115.camel@zelda.fubar.dk>
	 <20061023225905.GA10977@kroah.com>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 21:31:09 -0400
Message-Id: <1161653469.2801.91.camel@zelda.fubar.dk>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-23 at 15:59 -0700, Greg KH wrote:
> > So, perhaps the battery class should provide a file called 'timestamp'
> > or something that is only writable by the super user. If you read from
> > that file it gives the time when the information was last updated. If
> > you write to the file it will force the driver query the hardware and
> > update the other files. Reading any other file than 'timestamp' will
> > just read cached information. 
> 
> You can poll the sysfs file, which means you just sleep until something
> changes in it and then you wake up and read it.  Sound accepatble?

Yea, however I still think there needs to be a 'timestamp' file so 

 a) we don't need to poll every file in /sys/class/battery/BAT0
   (if we had to do that, we would (potentially) wake up N times!); and 

 b) if the kernel ensures that the 'timestamp' file is updated last,
    we get atomic updates (which might matter for drawing pretty graphs,
    guestimating remaining time etc.); and

 c) it provides some mechanism to instruct the driver to go read the
    values from the hardware (if that is what user space wants)
    nonwithstanding that the hardware / driver delivers asynchronous
    updates once in a while via an IRQ.

    Notably user space can see _when_ the values from the hardware was
    retrieved the last time which makes it easier to work around with
    hardware / drivers that don't provide asynchronous updates even
    when they are supposed to (if there is some bug with e.g. the ACPI
    stack).

This implies that the battery class should probably cache the values as
to make the platform driver as simple as possible. I've got a bad
feeling things like caching is badly frowned upon in kernel space but I
thought I'd ask for it anyway :-). I hope I've stated my case :-)

(Anyway, the point is that I want to avoid having an open file
descriptor for each and every file in /sys/class/battery/BAT0 to put it
into the huge poll() stmt in my main loop (granted with things like glib
it's dead simple), that's all.. Caching might also avoid excessive round
trips to the hardware but one can argue both way in most cases.)

So.. how all this relates to hwmon I'm not sure.. looking briefly at
Documentation/hwmon/sysfs-interface no such thing seems to be available,
I'm not sure how libsensors get by here but the problem is sorta
similar. I do think batteries in itself deserves it's own abstraction
instead of using hwmon but I'm no expert on this.

Btw, an OLPC specific feature is also to instruct the Embedded
Controller (EC) to stop delivering IRQ's on battery/ac_adapter changes.
This is so the host CPU won't be woken up when e.g. in e-book reader
mode (or whatever) where the host CPU is supposed to be turned off to
save juice. 
This is simple right now as the EC currently doesn't deliver any IRQ's
at all [1] and I guess a simple sysfs file in the OLPC platform device
will let us do that once we actually get IRQ delivery. Thus, I'm not
sure "stop IRQ delivery" belongs in the battery class proper. This is
also why we need device link to the OLPC platform device.

     David

[1] : but see http://dev.laptop.org/ticket/224



