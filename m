Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbVKWHOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbVKWHOE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 02:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbVKWHOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 02:14:04 -0500
Received: from gate.crashing.org ([63.228.1.57]:47322 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030342AbVKWHOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 02:14:01 -0500
Subject: Early boot issues (WAS: Christmas list for the kernel)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Jon Smirl <jonsmirl@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051122204918.GA5299@kroah.com>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <20051122204918.GA5299@kroah.com>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 18:10:35 +1100
Message-Id: <1132729836.26560.318.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-22 at 12:49 -0800, Greg KH wrote:
> On Tue, Nov 22, 2005 at 01:31:16PM -0500, Jon Smirl wrote:
> > 
> > 4) Merge klibc and fix up the driver system so that everything is
> > hotplugable. This means no more need to configure drivers in the
> > kernel, the right drivers will just load automatically.
> 
> What driver subsystem is not hotplugable and does not have automatically
> loaded modules today?
> 
> There are a few issues around PnP devices that I know of, and PCMCIA
> needs some seriously love, but other than that I think we are well off.
> Or am I missing something big here?

Well, there is at least one big problem :) We tend to call hotplug for
new devices way too early during boot, before it's even sane to try to
run userland. For example, we may well try to run it before we
created /dev/null or /dev/zero ... In some cases (PCI on various
platforms typically), devices are instanciated, then all sorts of
necessary fixups are applied, and it's assumed no driver will kick in
before those fixups are finished, etc...

I think it is be rather very unsafe to have /sbin/hotplug be called
before the system finishes with all initcalls...

There is a very similar problem lurking around the corner with
suspend/resume. Since during a machine suspend cycles, from the moment
we start suspending devices to the moment we have finished waking them
all up, any try to run userland things is doomed. The disk may be spun
down & locked, all other processes frozen, etc....

This is actually a real life problem with drivers using the
request_firmware interface nowadays: Some of them call it on resume, but
heh, it's too early, your disk may not be resumed yet ! Some of them
call it at more "normal" times, but in general, drivers have no way to
knwo that a machine suspend/resume cycle is in progress (the disk may
have been suspended already but the that other driver suspend not called
yet).

In fact, there is even a problem with GFP_KERNEL allocations :) In fact,
as soon as the suspend process is started, all allocations should be
silently turned into GFP_NOIO at the very least ...

Ben.



