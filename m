Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWDQQLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWDQQLt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 12:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWDQQLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 12:11:49 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:48057 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750786AbWDQQLs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 12:11:48 -0400
Subject: Re: [RFC] binary firmware and modules
From: Marcel Holtmann <marcel@holtmann.org>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: Arjan van de Ven <arjan@infradead.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       Oliver Neukum <oliver@neukum.org>, Jon Masters <jcm@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200604171715.45252.duncan.sands@math.u-psud.fr>
References: <1145088656.23134.54.camel@localhost.localdomain>
	 <20060417142214.GI5042@tuxdriver.com>
	 <1145284193.2847.53.camel@laptopd505.fenrus.org>
	 <200604171715.45252.duncan.sands@math.u-psud.fr>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 18:10:49 +0200
Message-Id: <1145290250.26498.37.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Duncan,

> > in order to not fall in the naming-policy trap: do we need a translation
> > layer here? eg the module asks for firmware-<modulename>
> > and userspace then somehow maps that to a full filename via a lookup
> > table?
> 
> since the same module can handle different devices which need
> different firmware, firmware-<modulename> is not sufficient.  An example
> is the speedtouch USB modems, which need different firmware depending on
> the modem revision.  In fact each modem needs two blobs uploaded, a small
> one (stage 1 blob) followed by a large one (stage 2 blob).  These blobs
> are fairly independant, for example a given stage 1 blob can work for a
> wider range of modem revisions than a given stage 2 blob.  Also, the
> manufacturer made a bunch of exotic variations on the modem (all with
> the same product ids, but different revisions); I don't have a complete
> list, and I don't know which ones require special firmware.  That means
> that the driver does not have a complete list of different firmware names.
> It could always use the same names "stage1" and "stage2", regardless of
> the revision, and expect the user to place the right firmware there; but
> then what about people who have multiple modems with different revisions
> (like me)?  As a result of all this, the driver needs to export the following
> to userspace, to let user-space find the right firmware:
> 
> (0) module name
> (1) stage 1 or stage 2
> (2) modem major revision number
> (3) modem minor revision number (I don't know if this is really needed,
> but I heard a rumour that it was: ISDN modems needing special firmware
> but only varying in their minor revision from non-ISDN modems IIRC).
> 
> This is all exported in the hotplug environment.  However, current hotplug
> scripts don't have any cleverness in them for handling this kind of thing
> (I don't know about udev).

we don't really have hotplug anymore. Now it is all handled by udev or
the udev helper programs.

For my drivers, I don't have this problem of different firmware images
for different versions and I personally don't really like abusing the
firmware name for some kind of revision control. However initially the
idea behind request_firmware() was that the userspace is totally dumb
and its only job is to copy a binary image from the filesystem into the
kernel memory, so it can be used by the driver. Another idea was that we
can reuse the firmware filenames from the Windows driver if they are
separate from the driver. This allowed us in most cases to tell the end
users to simply extract that file and copy it to /lib/firmware/ and
everything was working.

So for the fist step, I think a MODULE_FIRMWARE() extension (with maybe
and additional comment per firmware name) will be a good think to feed
back the information of firmware files to the userspace. After that we
might need to look into messed up devices and drivers. I also expect
that some WiFi drivers might have the same problem.

Regards

Marcel


