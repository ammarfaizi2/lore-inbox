Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVEFLPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVEFLPN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 07:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVEFLPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 07:15:13 -0400
Received: from hera.cwi.nl ([192.16.191.8]:64218 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261211AbVEFLPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 07:15:00 -0400
Date: Fri, 6 May 2005 13:14:45 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, hubert.tonneau@fullpliant.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3 fails to read partition table
Message-ID: <20050506111445.GC25418@apps.cwi.nl>
References: <055UDZ711@server5.heliogroup.fr> <20050505161610.GA4604@pclin040.win.tue.nl> <20050505194342.5ecde856.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050505194342.5ecde856.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2005 at 07:43:42PM -0700, Andrew Morton wrote:
> Andries Brouwer <aebr@win.tue.nl> wrote:
> >
> > Earlier Linux disregarded partition types, today 0 means "unused".
> 
> A number of people are being bitten by this.  Don't you think we should
> revert this change?

Executive summary: No strong opinion. Maybe, yes.

Two people report that it fixes an oops, four people notice that
partitions of type 0 are ignored now.

Discussion:

(i) Why was it added?
Because of the report by Uwe Bonnes:

----
the partition table of the USB stick in question is valid:

 1B0:  00 00 00 00 00 00 00 00   53 3F 3C B9 00 00 00 01 ........S?<.....
 1C0:  01 00 06 10 21 7D 25 00   00 00 DB F3 01 00 00 00 ....!}%.........
 1D0:  00 00 00 00 00 00 00 00   00 00 00 00 00 00 00 00 ................
   *
 1F0:  00 00 00 00 00 00 00 54   72 75 6D 70 4D 53 55 AA .......TrumpMSU.

Entry 1 is a FAT partition of exactly the size of the stick, and entries 2
to 4 are empty, marked by id zero. However the manufacturer decided to put a
name string  "Trump" ( /sbin/lsusb gives
Bus 004 Device 012: ID 090a:1bc0 Trumpion Microelectronics, Inc.) just before
the "55 AA" partition table magic and our code reads this string as a
(bogus) size for the fourth entry, taking it for real.

> on a Suse 9.2 System with Suse Hotplug, the phantom partition was somehow
> recognized as Reiserfs, and then the Hotplug mechanism trying to mount the 
> bogus partition as a Reiser Filesystem ended in an Oops...
----

So: the reason to add it is weak: a bad manufacturer sells devices
with a non-standard partition table that happens to work under Windows
because type 0 is ignored there, and a bad Linux vendor does recognition,
also known as guessing, and guesses wrong, and a bad kernel does not
survive mounting garbage as reiserfs.


If the patch is reverted, and we spend some more time fixing
filesystem code so that it survives mounting garbage, then
the kernel is OK and we can put the remaining blame with SuSE.


(ii) Was adding this check a step in the right direction?

No, it was just a bandaid - although handling things more like
other OSs do might be viewed a step in the right direction.

The right direction as far as I am concerned is moving partition parsing
out to user space, to udev or upart or so.


(iii) Should it be reverted?

I have no strong opinion on this.
As far as I know type 0 is ignored by Microsoft and is not
created by Linux vendor installation programs, or by Linux
*fdisk type programs, unless the user asks for it explicitly.
So, the number of people that hit this will be small, and since
they put the 0 there themselves will be able to put something else there.

I think I saw four people so far. Now that all readers of l-k know,
anybody who encounters a problem will be told quickly how to avoid it.


(iv) If I were maintainer of 2.6 - would I revert it?

Hmm... Not sure... Maybe, yes.

Andries
