Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVCCAF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVCCAF2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVCBX5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:57:41 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42928 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261405AbVCBXzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:55:11 -0500
Date: Thu, 3 Mar 2005 00:54:56 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andi Kleen <ak@suse.de>, kernel list <linux-kernel@vger.kernel.org>,
       paul.devriendt@amd.com
Subject: Re: BIOS overwritten during resume (was: Re: Asus L5D resume on battery power)
Message-ID: <20050302235456.GB1439@elf.ucw.cz>
References: <200502252237.04110.rjw@sisk.pl> <200503022250.12823.rjw@sisk.pl> <20050302220537.GD1616@elf.ucw.cz> <200503030047.43625.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503030047.43625.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > It seems that we write to the BIOS while moving the image, at least on my box,
> > > which is quite not correct, IMO.
> [-- snip --]
> > > 
> > > IMO this may lead to unexpected results, like the mysterious reboots during
> > > resume.
> > 
> > Well, I always thought that ROM-BIOS is expected to
> > be... well... read-only? Can you really write to your BIOS? [I know
> > about Flash-BIOSen, but they are certainly not writable by "normal"
> > write.] Plus we should overwrite it with same values...
> > 
> > Anyway, IMO bios should be marked as reserved (and we should not be
> > touching reserved pages). Can you verify that your BIOS is properly
> > marked reserved? [Ccing l-k, this might be interesting.]
> 
> It is, but that's even more interesting.  Namely, the BIOS-e820 memory map
> looks as follows:
> 
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000001ff40000 (usable)
>  BIOS-e820: 000000001ff40000 - 000000001ff50000 (ACPI data)
>  BIOS-e820: 000000001ff50000 - 0000000020000000 (ACPI NVS)
>  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
> 
> and the pages in the first two reserved areas are properly marked as reserved.
> Moreover, there is an apparent hole between a0000 and e0000 which also
> is marked as reserved.  However, we treat all of these pages as saveable
> (a page is treated as non-saveable if it is marked as reserved _and_ satisfies
> specific condition which is met by only one page on my system).  Consequently,
> during resume we try to overwrite all of these pages and we not only try to
> write to (theoretically) read-only areas, but also we try to write to where there's
> nothing. :-)
> 
> Still, there are almost 3500 reserved pages on my system and I'm not sure that
> we don't need to save at least some of them.  Anyway, I'm attaching the full
> list of pages that are marked as reserved and treated as saveable, so they get
> overwritten during resume.  Please have a look (these are virtual x86-64
> addresses, but the mapping is straightforward).

[looking at code]

IIRC kernel code/data is marked as PageReserved(), that's why we need
to save that :(. Not sure what to do with data e820 marked as
reserved...

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
