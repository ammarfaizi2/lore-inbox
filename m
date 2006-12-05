Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935968AbWLEF0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935968AbWLEF0L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 00:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937341AbWLEF0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 00:26:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42358 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935968AbWLEF0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 00:26:09 -0500
From: "=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <krh@redhat.com>
Subject: [PATCH 0/3] New firewire stack
Date: Tue, 05 Dec 2006 00:22:29 -0500
To: linux-kernel@vger.kernel.org
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>
Message-Id: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm announcing an alternative firewire stack that I've been working on
the last few weeks.  I'm aiming to implement feature parity with the
current firewire stack, but not necessarily interface compatibility.
For now, I have the low-level OHCI driver done, the mid-level
transaction logic done, and the SBP-2 (storage) driver is basically
done.  What's missing is a streaming interface (in progress) to allow
reception and transmission of isochronous data and a userspace
interface for controlling devices (much like raw1394 or libusb for
usb).  I'm working out of this git repository:

  http://gitweb.freedesktop.org/?p=users/krh/juju.git

but I'll be sending 3 patches for review after this mail: first the
core subsystem, then the OHCI driver and finally the SBP-2 (SCSI over
firewire) driver.  For people who want to test this out, the easiest
approach right now is to clone the git repo and run make.  This
requires the kernel-devel RPM on Fedora Core; I'm sure other distros
have a similar package.

Now, I didn't set out to rewrite the entire firewire stack.  At first
I just wanted to fix the OHCI driver.  However any rewrite that
addresses the problems in the driver will shift the code around enough
to invalidate the quirks and workarounds there.  And frankly, I don't
trust most of the workarounds to begin with.  So I decided to write
the OHCI driver from scratch.

The rest of the stack has problems too, there's too many kernel
threads bouncing around, the nodemgr code is racy and doesn't really
consider issues such as hotplug during device probing.  And there is 5
different interfaces for doing isochronous streaming.

The new stack is more compact and I'd like to think it's easier to
follow the code.  Here are the sizes for the three patches that
follow:

[juju:linux-2.6]$ wc -l patches-juju/*.patch
  3983 patches-juju/fw-core.patch
  1510 patches-juju/fw-ohci.patch
  1114 patches-juju/fw-sbp2.patch
  6607 total

Compared to

[krh@dinky ieee1394]$ wc -l *.[ch]
 ...
 30431 total

The new stack can co-exists with the old stack, since it's sitting in
drivers/fw.  So users can pick which stack they want at compile time,
or maybe compile both and switch at run-time using a modprobe
blacklist file.  This allows a transition phase from the old stack to
the new one where interfaces will be awailable.

At this point I'm not proposing the stack for inclusion into mainline
yet, as I'm still developing the streaming interface and the userspace
control interface.  This is just a heads up for now, to announce the
effort and where I'd like to go with this.  It is basically useful
with the storage devices I have available here, though, and ready for
testing for that specific use case.  Once the remaining features land,
I'd like to see this in mainstream linux and I'm interested in hearing
how people feel about this.

cheers,
Kristian
