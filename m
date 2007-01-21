Return-Path: <linux-kernel-owner+w=401wt.eu-S1751547AbXAUNTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbXAUNTc (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 08:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbXAUNTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 08:19:32 -0500
Received: from mx3.mail.ru ([194.67.23.149]:6870 "EHLO mx3.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbXAUNTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 08:19:31 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Len Brown <lenb@kernel.org>
Subject: Re: 2.6.20-rc5:  BUG: lock held at task exit time! (pm_mutex){--..}, at: [<c013bfff>] enter_state+0x3f/0x170
Date: Sun, 21 Jan 2007 16:19:25 +0300
User-Agent: KMail/1.9.5
Cc: linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200701162122.42581.arvidjaar@mail.ru> <200701161529.28110.lenb@kernel.org>
In-Reply-To: <200701161529.28110.lenb@kernel.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701211619.26782.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 16 January 2007 23:29, Len Brown wrote:
> On Tuesday 16 January 2007 13:22, Andrey Borzenkov wrote:
> > I have Toshiba Portege 4000 that almost always hangs dead resuming from
> > STR. This was better before 2.6.18, since then STR is unusable. Sometimes
> > it manages to resume; yesterday I got on console and in dmesg:
> >
> > =====================================
> > [ BUG: lock held at task exit time! ]
> > -------------------------------------
> > echo/28793 is exiting with locks still held!
> > 1 lock held by echo/28793:
> >  #0:  (pm_mutex){--..}, at: [<c013bfff>] enter_state+0x3f/0x170
> >
> > stack backtrace:
> >  [<c0103fea>] show_trace_log_lvl+0x1a/0x30
> >  [<c01045f2>] show_trace+0x12/0x20
> >  [<c01046a6>] dump_stack+0x16/0x20
> >  [<c0132377>] debug_check_no_locks_held+0x87/0x90
> >  [<c011c8bb>] do_exit+0x4db/0x820
> >  [<c011cc29>] do_group_exit+0x29/0x70
> >  [<c011cc7f>] sys_exit_group+0xf/0x20
> >  [<c010300e>] sysenter_past_esp+0x5f/0x99
> >  =======================
>
> the global pm_mutex that this refers to is used in generic PM code, not USB
> code.
>
> enter_state() grabs it at the beginning of the suspend, and releases it
> when resume is completed.
>
> The mystery is why echo is exiting before enter_state() completes.
>
> >>    if ! (/bin/echo $PARAM > $FILE &) ;then
> >>        ret=1
> >>    fi
>
> Same if you don't put the echo in the background here?
>

I just tried once more on 2.6.20-rc5 with

boot ... init=/bin/sh
mount -t sysfs sysfs /sys
echo mem > /proc/power/state

this hung dead on resume - not a single message (kernel was compiled with 
PM_DEBUG). 

I usually do not get any messages at all. I believe it was two times I got 
anything; one is quoted in bug report and second here.

- -andrey

> > I have a bug report about resume issue but I may have wrongly attributed
> > it to ACPI: http://bugzilla.kernel.org/show_bug.cgi?id=7499
>
> hard to say if the failure is related to ACPI or not at this point --
> though it is not unusual for people to assume that STR and ACPI
> are synonyms, so that if STR doesn't work it must be due to ACPI
> rather than generic PM code or drivers.
>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFs2heR6LMutpd94wRAqS7AJ0TMRb12cEgKrH0o/mW/sF1oNJ9CwCglx3z
HhzT2c3bAjBbNT7pOyCbATE=
=pp1M
-----END PGP SIGNATURE-----
