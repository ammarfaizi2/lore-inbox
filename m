Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWJXC4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWJXC4d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 22:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWJXC4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 22:56:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:13741 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751437AbWJXC4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 22:56:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aeDS5oa9kHtb2YAyuz+MM3pus7yVNtVFa67xR+4ycMaKLkwmpwi5PG0YbfOO08dYHD6kYLj5q3L4bkkO1ju1VyQz4KOg8gSkq5w4WyEFPehxnNzIziRPgmz+xaVG4tEP3+eIyeO0Lcp6dVdwze2AvYPn2tpke50k11Gj3OqOF7c=
Message-ID: <41840b750610231956ib1c7204tafb23ecd76f5d9d2@mail.gmail.com>
Date: Tue, 24 Oct 2006 04:56:30 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: "David Zeuthen" <davidz@redhat.com>
Subject: Re: Battery class driver.
Cc: "David Woodhouse" <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       olpc-dev@laptop.org, greg@kroah.com, mjg59@srcf.ucam.org,
       len.brown@intel.com, sfr@canb.auug.org.au, benh@kernel.crashing.org
In-Reply-To: <1161641703.2597.115.camel@zelda.fubar.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1161627633.19446.387.camel@pmac.infradead.org>
	 <1161641703.2597.115.camel@zelda.fubar.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/24/06, David Zeuthen <davidz@redhat.com> wrote:

> How do we plan to get updates to user space?

There was a long LKML thread ("Generic battery interface") about this in July.
This a general issue in sysfs, applicably whenever sysfs is used to
communicate device data (as opposed to system configuration). We need
a generic solution. Here are a few of the considerations that came up
in that thread:

- Efficiency on both poll-based and event-based hardware data sources.
- Avoiding unnecessary timer interrupts on tickless kernels.
- Letting multiple userspace clients poll the same data source at
different rates, without causing duplicate queries or unnecessary
process wakeups.
- Avoiding duplicate queries on poll-based hardware that provides
several attributes simultaneously.

Here's my latest proposed solution in that thread (but see the dozens
of messages before and after for context...):
http://lkml.org/lkml/2006/7/30/193


> The ACPI code today
> provides updates via the ACPI socket but that is broken on some hardware
> so essentially HAL polls by reading /proc/acpi/battery/BAT0/state some
> every 30 secs on, and, on some boxen, that generates a SMBIOS trap or
> some other expensive operation. That's wrong.

30 seconds? I've seen battery applets that poll 1sec intervals (that's
actually useful when you tweak power saving). And for things like the
hdaps accelerometer driver, we're at the 50HZ region.


> So, perhaps the battery class should provide a file called 'timestamp'
> or something that is only writable by the super user. If you read from
> that file it gives the time when the information was last updated. If
> you write to the file it will force the driver query the hardware and
> update the other files. Reading any other file than 'timestamp' will
> just read cached information.
>
> The mechanism to notify user space that something have been updated
> would be either to make the timestamp file pollable or use an uevent or
> something else (no input drivers please).
>
> If the hardware is able to generate an interrupt when certain data on
> the battery has changed the driver simply updates the timestamp file.
>
> With this scheme, user space simply does this
>
>  10 poll on /sys/class/battery/BAT0/timestamp with timeout=30sec
>  20 if timeout, write to 'timestamp' file to force polling
>  30 read values from sysfs and update graphics for battery icon etc.
>  40 goto 10
>
> and we only poll when the hardware don't provide such interrupts /
> hardware is broken so it don't provide interrupts.
>
> Specifically, user space can decide to make the timeout infinite or
> decide not to poll under certain conditions etc. etc.

This is a very interesting approach; I don't recall anything like this
from on the older thread.
There are a few problems though:
You can't require reading battery status to be a root-only operation.
When mutiple userspace apps poll the battery, you'll get race
conditions on timestamp, and even in the best case all the apps will
be woken up at the poll rate of the most-frequently-polling app (think
of that happening at 50HZ for hdaps...).

  Shem
