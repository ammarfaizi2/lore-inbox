Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbVLPKQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVLPKQo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 05:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbVLPKQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 05:16:44 -0500
Received: from ns2.suse.de ([195.135.220.15]:24483 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750851AbVLPKQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 05:16:44 -0500
Date: Fri, 16 Dec 2005 11:16:23 +0100
From: Stefan Seyfried <seife@suse.de>
To: Andy Isaacson <adi@hexapodia.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>,
       LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [RFC/RFT] swsusp: image size tunable (was: Re: [PATCH][mm] swsusp: limit image size)
Message-ID: <20051216101623.GA7878@suse.de>
References: <200512072246.06222.rjw@sisk.pl> <20051210160641.GB5047@elf.ucw.cz> <200512102106.41952.rjw@sisk.pl> <200512102356.27271.rjw@sisk.pl> <20051216020903.GB26568@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051216020903.GB26568@hexapodia.org>
X-Operating-System: SUSE LINUX 10.0 (i586), Kernel 2.6.13-SL100_BRANCH_20051213150629-default
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 06:09:03PM -0800, Andy Isaacson wrote:
 
> I did have one concerning failure during an earlier test, though - I
> have only 512MB of swap with 1.25GB RAM.  Now obviously if there are
> >500MB user pages, swsusp must fail; but I think I had a failure even
> though there was only about 400MB user pages - some of it was swapped
> out, and I had image_size=500, which resulted in an image that would not
> fit into the available swap space.
> 
> It sucks to fail the suspend just because the chosen image size didn't
> fit into the current state of the machine.  Now obviously I need to
> resize my swap partition to prevent this from happening, but it would
> be nice if swsusp would automatically "try harder!" if appropriate.

This is almost trivially solvable from userspace (not tested, beware :-):
- check the return code of your write() to /sys/power/state
- if it is ENOMEM (better look into the kernel code if this is what is
  actually reported...), then write "0" to image_size and try again.

or (not as sophisticated, and i am not sure if the paths are all correct):
----
#!/bin/sh
echo 150  > /sys/power/image_size
echo disk > /sys/power/state
if [ $? -ne 0 ]; then
    echo 0 > /sys/power/image_size
    echo disk > /sys/power/state
fi
----
this will retry on any error (e.g. process not stopped, no swap space
at all, device refused to suspend...) not only on ENOMEM, but echo
unfortunately does not return the error code, only success or failure.
Easy solution would be a small perl or C program.

I am not convinced that this should be handled in the kernel.
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
