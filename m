Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWDRXqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWDRXqc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 19:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWDRXqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 19:46:32 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:30340 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1750833AbWDRXqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 19:46:31 -0400
X-IronPort-AV: i="4.04,132,1144047600"; 
   d="scan'208"; a="1796296609:sNHT30608032"
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: class_device_create() and class_interfaces ?
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 18 Apr 2006 16:46:27 -0700
Message-ID: <adafykacur0.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 18 Apr 2006 23:46:28.0620 (UTC) FILETIME=[4FE77CC0:01C66342]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I'm trying to write some code that uses struct class_interface to do
something when a class device appears.  However, if I follow the new
world order of class_create() and class_device_create(), I seem to run
into a problem.

Because class_device_create() allocates its own struct class_device
memory, one can't use container_of() to get back to the original
driver-specific device information.  The standard solution is to use
class_set_devdata() to stash a pointer back.

However, if one has a class_interface registered for the class, then
the class_interface.add() method gets called before class_device_create()
even returns, so there's no chance to call class_set_devdata().  This
means that the class_interface can't really do much with the class_device
that it got, because it has no way to get to any interesting information
about the real device.

The situation I'm thinking of is one device that implements multiple
completely different functions -- for example an MPEG codec and a
thermometer -- through the exact same registers etc.  So I want to
have a core driver that manages real hardware access, and then
separate MPEG codec and thermometer drivers.  The design I have in
mind is that the MPEG and thermometer sub-drivers register class
interfaces with the core driver, which creates a class device for each
real hardware device it finds.  But the sub-drivers need some way of
getting from the class device to a structure that lets them call back
into the core driver.

I see several solutions:

 - Add a devdata parameter to class_device_create() so that devdata
   can be set before class_interfaces are called.
 - Create a new class_device_create_with_devdata() function to do the
   same thing without churning a bunch of existing drivers...
 - Solve the core driver/sub-driver problem in a better way that
   doesn't use class_devices or class_interfaces -- I'm open to
   suggestions here.  I could implement my own registration handling
   -- it's pretty trivial -- but duplicating what the driver model
   already has seems silly.

What are your thoughts?  I'm happy to code up a patch for 2.6.18 for
either of the first two solutions above.

Thanks,
  Roland
