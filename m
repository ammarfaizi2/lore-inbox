Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbSKNAXM>; Wed, 13 Nov 2002 19:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264739AbSKNAXL>; Wed, 13 Nov 2002 19:23:11 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:27283 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S264730AbSKNAXK>; Wed, 13 Nov 2002 19:23:10 -0500
Message-ID: <F2DBA543B89AD51184B600508B68D4000F866009@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: local APIC may cause XFree86 hang
Date: Wed, 13 Nov 2002 16:29:48 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Are we disabling vm86 code to access to PIT or PIC? I saw some video ROM
code (either BIOS call or far call) did access PIT, confusing the OS.

Thanks,
Jun

> -----Original Message-----
> From: torvalds@transmeta.com [mailto:torvalds@transmeta.com]
> Sent: Wednesday, November 13, 2002 3:53 PM
> To: linux-kernel@vger.kernel.org
> Subject: Re: local APIC may cause XFree86 hang
> 
> In article <15826.53818.621879.661253@kim.it.uu.se>,
> Mikael Pettersson  <mikpe@csd.uu.se> wrote:
> >
> >Does XFree86 (its core or particular drivers) use vm86() to
> >invoke, possibly graphics card specific, BIOS code?
> >That would explain the hangs I got. The fix would be to
> >disable the local APIC around vm86()'s BIOS calls, just like
> >we now disable it before APM suspend.
> 
> It does.
> 
> HOWEVER, vm86() mode is very very different from APM, which uses real
> mode.  External interrupts in vm86 mode will not be taken inside vm86
> mode - and disabling the local timer (by disabling the APIC) around a
> vm86 mode is definitely _not_ a good idea, since it would be an instant
> denial-of-service attack on SMP machines (the PIT timer only goes to
> CPU0, so we depend on the local timer to do process timeouts etc on
> other CPUs).  The vm86 code might just be looping forever.
> 
> In other words, if it is really vm86-related, then
>  (a) it's a CPU bug
>  (b) we're screwed
> 
> I bet it's something else.  Possibly just timing-specific (the APIC
> makes interrupts much faster), but also possibly something to do with
> the VGA interrupt (some XFree86 drivers actually use the gfx interrupts
> these days)
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
