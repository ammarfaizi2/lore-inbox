Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268060AbUI1WGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268060AbUI1WGk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 18:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268070AbUI1WGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 18:06:40 -0400
Received: from mail.inter-page.com ([12.5.23.93]:48400 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S268060AbUI1WED convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 18:04:03 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Andrea Arcangeli'" <andrea@novell.com>,
       "'Nigel Cunningham'" <ncunningham@linuxmail.org>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Chris Wright'" <chrisw@osdl.org>, "'Jeff Garzik'" <jgarzik@pobox.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: RE: mlock(1)
Date: Tue, 28 Sep 2004 15:03:44 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAM/+M3vc36kiUY6px1It1rQEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20040925012705.GC3309@dualathlon.random>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Stupid Idea Warning... 8-)

The top-n reasons (mentioned) to want to have your swap encrypted involve things like
dealing with a stolen/sold drive or someone using a boot CD to peak into your swapped
data.  To a great extent this sort of thing would be semi-automagic with a (cringing)
DRM chip.  (This is not a pro-trusted-computing thing, as if I don't have the keys to
my machine, it isn't really my machine, IMHO.)

The truth of the matter is that, on the intel platform at least, you have the CPU ID.
You also have the unique serial number burned into clock chips by the manufacturer on
both Intel and many other platforms.  As always milage may varry.

You also have the GUUIDs that you can write into ext2/3 file systems etc.

And you have your kernel boot command line.

There is "enough" data in that pile to create a sufficiently unique key for matching
the various users various needs.

So I would say that it should be possible to create a meta-boot-block that could be
written to the swap in a well-known location that would (re)generate the key based on
the local config.

This wouldn't have cryptographic closure in most cases, but it *would* prevent all
but the most determined from abusing a restore.

Consider the "typical default" Intel meta-boot-block; it would combine[1] at least
the checksum of the boot command line, the GUUID of the selected root file system,
the clock serial number and the CPU0 serial number to create the swap/restore key.
If the kernel image checksum were available that would be good too.  Reguardless,
this default minimal key generation would prevent the swap space from being
accessible to all the various "easy" alternate boot methodologies.  You would never
"restore" using a different file system or invocation args, nor would you restore if
you separated the drive from the mother board.

So why the meta-boot-block?

1) Being a little (4k) applet, the application itself could contain entropy data.
That is, if you aren't doing a restore, you wouldn't use the boot-block at all.  So
for each non-restore boot you could have completely different entropy value that was
never recorded outside of active kernel ram.

2) The meta-boot-block would only be written upon (attempted) suspend.  So the
meta-boot-block location would not normally contain the key-generating code and data.
So a power-switch-event couldn't be used to compromise the swap image.  That gets you
as close as possible to the orderly start and end states of the OS before you are in
the key-saving business.

3) [maybe really 2a] since the boot block isn't written until the last moment, if the
swap structures are themselves encoded, any swap image from the drive would be
useless to a non-restart inspection of the swap by any means.  So for systems where
suspend never happens, the swap is "always" cryptographically secure.

4) If the meta-boot-block is created at the last moment, and destroyed on startup,
the absence of a well-signed (it _would_ need some sort of checksum) block would be
authoritative of the absence of an opportunity to restore.  That is, if the
meta-boot-block region doesn't checksum then you *know* you cannot restore.  [If you
somehow have a good boot block but it doesn't decode the swap headers then you know
the boot block is stale, so old-blocks, when combined with regular-boot selection of
entropy is self-correcting.]  It would, of course, be important to destroy the
boot-block area after reading it to keep the restore-session as secure as the
first-run session.

5) Different installations could use different boot-block applets to match their own
need.  If you have a cool security chip you could use a custom security-chip based
meta-boot-block while most of us would just use the base model that "makes sure" that
the restore/decode is happening on our own hardware using the same root and the same
startup args etc.  That is, the default would be good enough for most of us.  People
who want a boot/restore password could have that via yet another boot block.

6) People who don't want restore at all could have the "null" boot block that
produces the "don't bother" null key  (e.g. "return 0;" as the text of the function
etc.) without having to build a no-meta-boot kernel.

7) Since it is a "smidgen of code", individual implementations could be made that
looked for just about anything.  4k (one typical swap block) is actually a good bit
of space, so one could even have this thing check a dongle or stripe-load a disk
region (a-la gump) and run a longer bunch of text or data (possibly lifted out of the
"wherever it got swapped to" part of the swap space.  That is, a much longer datum
could be hidden-in-plain-sight by allocating a region of uninitialized memory and
then saving over it plain-text "wherever it landed in the swap image"  some necessary
additional code or data or god knows what else.

As I said this isn't secure against someone who has all the vital information about
your computer and had the skill to dummy-up a kernel that would provide the bogus
information to itself.  (e.g. their kernel set up to "fake" all your IDs and serial
numbers.)  But it would produce an image that would keep "most" leaks and virtually
all mistakes from happening.  So all the "boot from CD and take a peak", or "pull the
power cord, steal the disk, and do forensics" attacks would be nicely thwarted.

Someone with more crypto knowledge could probably perfect this into a far-less stupid
idea, but I think the basic premise is sound without being "too complex to be
workable".

[1] The Composition operation would involve a one-way hash of chosen datum.  The hash
would be run against the system IDs and invocation information, probably with some
other entropy value(s) added in, when the kernel starts.  That is, during a
non-restore startup the kernel would "manufacture" a meta-boot-block in-situ and run
it to produce a key, it would then initialize the swap space, effectively destroying
the old swap and any old boot block.  On suspend, the kernel would write that block
to the meta-boot-block region of the primary swap device (or similar).  On restore,
the saved block would be restored and checked.  If it checked out, and the key it
produced "properly decoded" the swap headers, then the block region would be erased
and restore would continue using that block.  If the block didn't check out or didn't
decode the swap headers, then the kernel goes back to the non-restore boot sequence
and manufactures a new key-generation-block (so that a system cannot be attacked by
installing a trivial key-generation-block in a swap partition).

Rob White
Casabyte, Inc.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org]
On Behalf Of Andrea Arcangeli
Sent: Friday, September 24, 2004 6:27 PM
To: Nigel Cunningham
Cc: Alan Cox; Chris Wright; Jeff Garzik; Linux Kernel Mailing List; Andrew Morton
Subject: Re: mlock(1)

On Sat, Sep 25, 2004 at 03:07:59AM +0200, Andrea Arcangeli wrote:
> about it either, it'll be always different, it will be choosed randomly
> by userspace while booting the machine.
  ^^^^^^^^^^^^

while the above would work fine too, I'm starting thinking it's simpler
and cleaner to make it completely transparent to userspace, we can
choose the random key within sys_swapon, userspace will only have to
tweak if to enable the crypto-swap feature or not before calling swapon
(maybe via sysctl).
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



