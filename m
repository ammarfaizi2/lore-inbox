Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbTDKWPi (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTDKWPi (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:15:38 -0400
Received: from fmr02.intel.com ([192.55.52.25]:33476 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S261832AbTDKWPh convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 18:15:37 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780BEBAAAD@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Greg KH'" <greg@kroah.com>, "'oliver@neukum.name'" <oliver@neukum.name>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-hotplug-devel@lists.sourceforge.net'" 
	<linux-hotplug-devel@lists.sourceforge.net>,
       "'message-bus-list@redhat.com'" <message-bus-list@redhat.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>
Subject: RE: [ANNOUNCE] udev 0.1 release
Date: Fri, 11 Apr 2003 15:27:19 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> From: Greg KH [mailto:greg@kroah.com]
>
> But I can do a lot to prevent losses.  A lot of people around here point
> to the old way PTX used to regenerate the device naming database on the
> fly.  We could do that by periodically scanning sysfs to make sure we
> are keeping /dev in sync with what the system has physically present.
> That's one way, I'm sure there are others.

This might be a tad over-simplification, but sysfs knows by heart when
anything
is modified, because it goes through it's interface. If we only care about,
for example, devices, we could hook up into device_create() [was this the
name?];
line up in a queue all the devices for which an plug/unplug event hasn't
been
delivered to user space and create symlinks in /sysfs/hotplug-events/. 

Each entry in there is a symlink to the new device directory, named with an 
increasing integer for easy serialization. When the event is fully
processed, 
remove the entry from user space.

To avoid having to scan huge directories, it could be moved to have a single
file, event. When present, it means there are events available. It
represents
the head of the in-kernel event queue. Read it [or read the symlink] for
getting
the event information. If you remove it, that means the event is delivered.
If there is an event in the queue, the file is created again for that event.

Enhance it by creating another file for out-of-band events if needed ...

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
