Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbVKWRhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbVKWRhs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 12:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVKWRhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 12:37:48 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:31155 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751277AbVKWRhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 12:37:47 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: floppy regression from "[PATCH] fix floppy.c to store correct ..."
To: jonathan@jonmasters.org, Andrew Morton <akpm@osdl.org>,
       cp@absolutedigital.net, linux-kernel@vger.kernel.org,
       jcm@jonmasters.org, torvalds@osdl.org, viro@ftp.linux.org.uk,
       hch@lst.de
Reply-To: 7eggert@gmx.de
Date: Wed, 23 Nov 2005 18:39:27 +0100
References: <59olg-7rC-3@gated-at.bofh.it> <59rsT-3Co-27@gated-at.bofh.it> <5arTK-5Wu-1@gated-at.bofh.it> <5bAW4-8wm-19@gated-at.bofh.it> <5bEYO-6oH-15@gated-at.bofh.it> <5bOEG-5jk-19@gated-at.bofh.it> <5bUK2-61i-5@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1Eeyae-00012o-CV@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Masters <jonmasters@gmail.com> wrote:
> On 11/22/05, Andrew Morton <akpm@osdl.org> wrote:

>> In the meanwhile I think we should revert back to the 2.6.14 version of
>> floppy.c - the present problem is probably worse than the one which it
>> kinda-fixes.
> 
> Ok, as you please. It's probably going to take something much more
> ugly to make this work with things as they stand - I'll get something
> out at the weekend.

I think it should be a general solution to flipped CP switches on floppies
and USB sticks as well as network block devices on a fs that got remounted
ro or hdparm -W.

The device needs a WP status that gets updated on open or mount (must
complete before open()/mount() completes), on failed write()s iff the write
failed because of write protection error and whenever checking is cheap.
If the check can't be done sanely on open() calls (as in the case of NBD),
asume it to be RW enabled unless we know otherwise (e.g. the user told us).
(re)mounts should allways enforce the check as long as it's possible.
The filesystems will need to get updated to use this status as well and
remount themselves ro (or do a panic/reboot, if desired).

This will still misbehave, but I think it will misbehave in a sane way. You
may get a rw mount on ro devices in corner cases, but you can't keep it. If
you erroneously got your device ro, you can update the status by remounting,
so you won't get stuck with a busy ro filesystem. "true>/dev/node" will
update the state, too, but I doubt it's usefullness unless the application
using the device is designed to take use of this feature.

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
