Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbTADB4O>; Fri, 3 Jan 2003 20:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbTADB4O>; Fri, 3 Jan 2003 20:56:14 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:47753 "EHLO w-patman.des")
	by vger.kernel.org with ESMTP id <S263837AbTADB4M>;
	Fri, 3 Jan 2003 20:56:12 -0500
Date: Fri, 3 Jan 2003 18:44:58 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: inquiry in scsi_scan.c
Message-ID: <20030103184458.A19314@beaverton.ibm.com>
References: <UTC200301040021.h040LB128544.aeb@smtp.cwi.nl> <20030103170404.D4315@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030103170404.D4315@one-eyed-alien.net>; from mdharm-kernel@one-eyed-alien.net on Fri, Jan 03, 2003 at 05:04:04PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2003 at 05:04:04PM -0800, Matthew Dharm wrote:
> Actually, 5 isn't minimal... it's sub-minimal.  That's an error in the
> INQUIRY data.  The minimum (by spec) is 36 bytes.
> 
> There should probably be a sanity check to never ask for INQUIRY less than
> 36 bytes.  I thought there used to be such a thing....
> 
> Matt

Well we do ask for 36, but in Andries case only got back 5.

The zero fill is a good solution and matches what the device should do if it
can't get all of the INQUIRY data.

There should be a warning output, in case other bad things happen, and so
people know they have a borken device, and maybe a comment like:

        /*
         * If the response length is less than 36 the rest of the INQUIRY
	 * is zero filled.
	 *
	 * etc.
         */

> 
> On Sat, Jan 04, 2003 at 01:21:11AM +0100, Andries.Brouwer@cwi.nl wrote:
> > Got a new USB device and noticed some scsi silliness while playing with it.
> > 
> > A bug in scsi_scan.c is
> > 
> >         sdev->inquiry = kmalloc(sdev->inquiry_len, GFP_ATOMIC);
> >         memcpy(sdev->inquiry, inq_result, sdev->inquiry_len);
> >         sdev->vendor = (char *) (sdev->inquiry + 8);
> >         sdev->model = (char *) (sdev->inquiry + 16);
> >         sdev->rev = (char *) (sdev->inquiry + 32);
> > 
> > since it happens that inquiry_len is short (in my case it is 5)
> > and the vendor/model/rev pointers are wild.
> > Catting /proc/scsi/scsi now yields random garbage.

> > I made a patch but hesitated between a small patch and a larger one.
> > Why do we have this malloced inquiry field? As far as I can see
> > nobody uses it. And the comment in scsi_add_lun() advises us
> > not to save the inquiry, precisely what we did until recently.
> > So, should this change from 2.5.11 be reverted?

The INQUIRY was saved so that users could avoid sending a long INQUIRY to
a borken device and hang it, and just send an ioctl to retrieve it, but no
ioctl was ever added.

Rather than not saving it, we should just get the INQUIRY again (and
implicitly overwrite vendor/model/rev) after spin up or if we get a unit
attention with additional sense code of INQUIRY DATA HAS CHANGED; this
would probably break somehow for some devices (changing the INQUIRY after
a spin up is not out of spec), and is hard to handle with our current
scanning (scsi_scan.c sends the INQUIRY, but sd.c has the spin up code),
as per comments in scsi_probe_lun.

-- Patrick Mansfield
