Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265114AbUGCN40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265114AbUGCN40 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 09:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265115AbUGCN40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 09:56:26 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:38404 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S265114AbUGCN4Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 09:56:16 -0400
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, bug-parted@gnu.org,
       "K.G." <k_guillaume@libertysurf.fr>,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for BIOS / CHS stuff)
References: <Pine.LNX.4.21.0407030050330.30622-100000@mlf.linux.rulez.org>
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5gk6xlqk17.fsf@patl=users.sf.net>
Date: 03 Jul 2004 09:56:15 -0400
In-Reply-To: <Pine.LNX.4.21.0407030050330.30622-100000@mlf.linux.rulez.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Szakacsits Szabolcs <szaka@sienet.hu> writes:

> Currently no code or a way to do this for all kernels neither in user, 
> nor in kernel space, AFAIK. 
>
> Several tools need it. 

Right, which is why putting the logic in Parted is the wrong design.

> However there are cases like empty partition table, fixing partition
> table if asked, mkntfs, ntfsck, etc when you need the bootloader
> friendly geometry what I suspect is the EDD geometry, usually. Linux
> can't do that: HDIO_GETGEO doesn't tell and no user space code that
> could be used for all kernels.

Right.  So this "smart" code has no place in Parted for two reasons:

  1) The best approach varies depending on your kernel.

  2) Parted is not the only tool which needs the Windows-compatible
     geometry.

Parted should do the simplest possible thing.  Allow the user to
specify the geometry, and default it to HDIO_GETGEO (or just
X/255/63).

> If my memory serves well, you wrote once long ago that your project
> needs the "legacy" value to make things work.
>
> Kernel 2.4 guessed usually legacy, right? 

On a blank disk, yes, I believe so.  Or it tried to parse the CMOS
tables or something.  It may have had some "infer from the partition
table" logic, too...  I never looked at it very carefully.

> Kernel 2.6 returns extended and it more upsets tools and users with
> trashed partitions.
>
> So a simple question: why is returning the extended values better
> than returning always the legacy values (or even the previous
> guess)?

Because in 2.6, the extended values are obtained by talking directly
to the IDE controller, not the BIOS.  The "raw controller" geometry
happens to match the extended geometry on every system I have seen.

The problem with having the kernel use the BIOS is complexity; in
particular, the complexity of mapping between BIOS disk numbers and
Linux devices.  This task is "impossible" in theory but quite possible
in practice, and becoming more possible all the time (as more BIOSes
support EDD 3.0).  But it is still complicated, which is why the logic
belongs in user space.

 - Pat
