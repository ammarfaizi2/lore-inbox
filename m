Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752186AbWCCIQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbWCCIQI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 03:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbWCCIQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 03:16:08 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:43923 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752186AbWCCIQG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 03:16:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=arOGUVLoBQBXNPrqeuDWk3Ht6vTtWXFRd4Q04hEllAAgL+vA1Pz3ugNwK1szlUN4e+O+vdDsW7G2lxLfGId/R4Rj0saB3IyW4z45TallEKMhTlTGHrmMivkPWa1AxL97E9WDAf8zu5L9BLSVc0Q5XS7owL4BRJYmqfszORJmuHU=
Message-ID: <756b48450603030016r36940139m4d64da5c23156d00@mail.gmail.com>
Date: Fri, 3 Mar 2006 16:16:05 +0800
From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
To: "Yu, Luming" <luming.yu@intel.com>
Subject: Re: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840AFD4B93@pdsmsx403>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <AcY1+QTZumb9d6e3RHms9ocp4LswwgAtmORQ>
	 <3ACA40606221794F80A5670F0AF15F840AFD4B93@pdsmsx403>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/06, Yu, Luming <luming.yu@intel.com> wrote:
> It would be better if you can merge this stuff with acpi video driver.
> If you look at video.c, there is NO HID definition for video device.
> we rely on acpi_video_bus_match to recoginize video device in ACPI
> namespace.

I took a quick look and I think Atlas might be ugly. The current acpi
video driver, as you pointed out, looks for well known required nodes,
specifically _DOD,_DOS,_ROM,.... None of these nodes are provided on
Atlas. From looking at the DSDT, all I see are _BCL and _BCM. It
doesn't even have _BQC. So, from a quick look at the existing video
driver, I see a couple of problems that I need advice on:

- is it ok if I add a _BCM check in acpi_video_bus_match. i think this
is not a problem.
- acpi_video_bus_check fails out if no _DOS,_ROM,_GPD,_SPD,_VPO. this
check fails on Atlas because it doesn't have any of those
capabilities. The video driver does check for _BCM in
video_device_find_cap but that's at a much later stage. Do you want me
to do something like if (acpi_video_bus_check() &&
acpi_video_output_device_exceptions_detect() )... or do you want me to
do something cleaner and move the whole _BCM detection earlier in the
process?
- acpi_video_bus_get_devices will only call video_bus_get_one_device
if the device node has children. In Atlas, the "Video Bus", (ie: LCD
device in the DSDT I pasted before) has no children, at least as found
by scan.c, so we won't get to get_one_device(). What do you think I
should do about this?

I have a suspicion that for boards like this where ACPI support isn't
so complete, we should just use board specific drivers rather than
mangling the mainstream video driver code. What do you think?

Thanks,
jayakumar
