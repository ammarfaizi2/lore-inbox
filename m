Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbTDEUHb (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 15:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTDEUHb (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 15:07:31 -0500
Received: from mcomail02.maxtor.com ([134.6.76.16]:63246 "EHLO
	mcomail02.maxtor.com") by vger.kernel.org with ESMTP
	id S262649AbTDEUHa (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 15:07:30 -0500
Message-ID: <785F348679A4D5119A0C009027DE33C102E0D069@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@maxtor.com>
To: "'Andre Hedrick'" <andre@linux-ide.org>,
       "Mudama, Eric" <eric_mudama@Maxtor.com>
Cc: "'Chuck Ebbert '" <76306.1226@compuserve.com>,
       "'linux-kernel '" <linux-kernel@vger.kernel.org>
Subject: RE: PATCH: Fixes for ide-disk.c
Date: Sat, 5 Apr 2003 13:17:38 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andre Hedrick [mailto:andre@linux-ide.org]
> Sent: Saturday, April 05, 2003 12:52 PM
> To: Mudama, Eric
> Subject: RE: PATCH: Fixes for ide-disk.c
>
> 6-10 seconds is a nice idea, the reality as we both know it is up to 30
> seconds to return because of OOB seeks to write on reallocations.

Of course, 6-10 is the non-error case.  Depending on how hard one has been
pounding the drive with writes, there is no reason that error recovery can't
creep up into the multiple-minute domain in some cases if you happen to have
excessively high temperature, vibrations, and be working on an old drive
with ratty servo bursts in a certain location or something.

> FLUSH CACHE/FLUSH CACHE EXT ...
>
> If you have a drive that is not larger than 28-bit in geometry 
> regardless if it supports the 48-bit feature set, if it fails
> to comply with 28-bit flush cache it is a "BAD DEVICE", period.

Agreed.  They're different opcodes, E7 and EA.

In either case, according to the spec, when a FLUSH CACHE (normal or EXT,
doesn't matter) completes with "good" status (0x50) all the write cache has
been successfully flushed to the disk.

A 48-bit sized drive should still commit dirty data when issued the 28-bit
FLUSH CACHE command, it will simply have problems reporting potential error
locations if it gets a fatal error on the write.  

> You will not be allowed to push off the 48-bit feature set rules.
> Regardless if the new smart data is set the the GPL and not Smart
> Logs.

I don't understand what you mean.  I am looking at the ATA7 r1a spec now,
and don't see the 48-bit specific feature set rules that you're referring to
being "pushed off".

>If you are suggesting a pole for completion on the FLUSH, say so.
>Otherwise, standard non-data INTQ completion is default.

Clearing of the busy bit with a status of 0x50 is what to look for.  Polled
or INTQ doesn't matter.

If the drive reports 0x50 without a completely clean write cache, it is
broken.


