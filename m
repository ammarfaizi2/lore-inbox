Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWG0QXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWG0QXp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 12:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWG0QXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 12:23:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:34870 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750763AbWG0QXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 12:23:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=thU/i6S09ekvesbs180aa5lu9kFgrekmpa+VhwCxID/0ZKhIF3xUB9AUs/WBuKOMi5dWVfEa1R2+x9S9jSUflkFoOl8xdnpGwRneTLLUNiXiijIizwxiwuDWMTm1+r8CU+XKMyGxMBmk8Trq+TQ98X9GjX4c1v9nJisc6lMtcXo=
Message-ID: <41840b750607270923j21074661v6254ba52ec67b67a@mail.gmail.com>
Date: Thu, 27 Jul 2006 19:23:42 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: Generic battery interface
Cc: "Pavel Machek" <pavel@suse.cz>, "Matthew Garrett" <mjg59@srcf.ucam.org>,
       vojtech@suse.cz, "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6011259C4@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6011259C4@hdsmsx411.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, Brown, Len <len.brown@intel.com> wrote:
> Path names and file names in sysfs are an API, so it is important
> to choose them wisely.  The string "acpi" should not appear in
> any path-name or file-name in sysfs that is intended to be generic,
> as it would make no sense on a non-ACPI system.
>
> Neither the ACPI /proc/acpi/battery API or
> the tp_smapi /sys/devices/platform/smapi API qualify as generic.
> It it a historical artifact that /proc/acpi exists, I'd delete it
> immediately if that wouldn't instantly break every distro on earth.

Yes. But it looks like we'll have a hard time finding this common
interface, due to overlaps and omissions between battery drivers.

So I've proposed /sys/class/battery/{acpi,apm,thinkpad}/BAT?/* as a comrpromise:
A userspace app that only needs a generic voltage readout will try
(all of) /sys/class/battery/*/BAT0/voltage. This is your generic
interface.

A specialized app can be more specific and access
/sys/class/battery/thinkpad/BAT0/force_discharge.

And a complex system monitor like GKrellM will  let you configure a
list of paths, e.g., /sys/class/battery/acpi/BAT0 +
/sys/class/battery/mustek/UPS0.

The only drawback I see is the inelegant userspace code for
enumerating /sys/class/battery/* in languages like C. I suppose this
could be wrapped by a trivial userspace library.


> Vojtech suggested that we create a virtual battery interface,
> just like the input layer has virtual input devices.
[snip]
> In either case, user-space would look for a well known set
> of device file names, such as /dev/battery0, /dev/battery1
> or some such, do a select on the file and get events that way.

Isn't this an overkill? Battery status changes very slowly, so it
seems perfectly adequate to have the usual userspace daemons poll the
kernel every few seconds. No need for extra kernal event mechanisms,
device file allocation, IOCTLs...


> Drivers such as above could conjur up devices, and user-space
> could also create what look like batteries, say through a
> utility that knows how to talk to a UPS.

Excellent idea, but it's orthogonal to the API issue. You might as
well have  /sys/class/battery/usespace-battery/UPS0.


  Shem
