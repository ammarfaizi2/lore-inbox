Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967799AbWK3B1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967799AbWK3B1h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 20:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967800AbWK3B1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 20:27:36 -0500
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:62613 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S967799AbWK3B1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 20:27:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=MsHVPdgRKXZ6DCVo4JJC+PurpwlMSGz+yeMvF+1QTVWYMMJkcfK8DPtrb8DxVoqdaV9I9UoSc9/pYJYp7b7qTYZhl7LAVq+wVypgNOk9ddSwP6x+j/Mb0N0BeIQKhM04Zccry3VYpWQpHY3F8VaMjSUTScKyW7nhNtTZx0AgE6o=  ;
X-YMail-OSG: 0Zsy.hEVM1lRctWAlDiR8V2MRWYMVBfFajjCoLity.5m5HScai2kpwfuMKFAg2MukekaDUWQsD6KdpZHxdtwrL_RhadVvi6pmh1msoTsQ6ShyINZKwffWg--
From: David Brownell <david-b@pacbell.net>
To: Greg KH <gregkh@suse.de>
Subject: Re: [Bulk] Re: [patch 2.6.19-rc6] fix hotplug for legacy platform drivers
Date: Wed, 29 Nov 2006 17:27:31 -0800
User-Agent: KMail/1.7.1
Cc: Kay Sievers <kay.sievers@vrfy.org>, "Marco d'Itri" <md@Linux.IT>,
       linux-kernel@vger.kernel.org
References: <20061122135948.GA7888@bongo.bofh.it> <200611291450.59165.david-b@pacbell.net> <20061129230219.GA11539@suse.de>
In-Reply-To: <20061129230219.GA11539@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611291727.31999.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 November 2006 3:02 pm, Greg KH wrote:
> > 
> > Here's my fix.  ...
> > ... I audited all the drivers using the relevant APIs, and I can't 
> > see many (if any!) folk hitting problems from this.
> 
> But this still can cause the problem that your 'modalias' file in sysfs
> contains exactly the same name as the module itself, right?

Not a problem if folk stick to the original design.  Hotplug will at
most "modprobe $MODALIAS" (iff the device needs a driver) before doing
a udevsend ... and only coldplug uses "modprobe $(cat modalias)".

The two were provided to address distinct problems.  And the issue that
was described to me was _only_ relevant on the hotplug paths; coldplug
scripts, using /sys/devices/.../modalias files, see no problems.


I could update the patch so that attribute turns into a null string,
but that would have a **negative effect** since it would break coldplug
for all the platform init code which doesn't use platform_add_devices()
or maybe platform_device_register().


> That's not good, it should be an alias, not the "real name".

Well, adding unjustified complexity _after the fact_ isn't good either,
and that's what I see going on here.

How many years has KMOD been around?  It's worked just fine without that
sort of bizarre (and un-needed) rule.  Aliases were provided just to give
*additional* names to modules ... not to make one needlessly "special".
Kernel request_module() calls make no distinction between which type of
name they use ... and when the filesystem name changes, they still work
when the old name is properly aliased.

That whole "give a module an alias of itself" model just seems ludicrous
to me.  We _know_ that "A" means "A", so there's no point in aliasing it
as itself.


... plus it's a distraction from the real problem, namely that certain
"legacy" drivers, primarily stuffed onto the "platform" bus, can't ever
hotplug.  (While normal platform drivers do so just fine, without needing
strange rules to make some names "more equal than others".)

 
> That will ensure that userspace tools do not get confused, 

I don't observe any confusion on my systems.  Platform device hotplug
works just fine.  Udev creates their /dev nodes.  If there are some
tools getting confused, that seems best characterized as tool bugs.

- Dave

