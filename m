Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316217AbSFUEbh>; Fri, 21 Jun 2002 00:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316223AbSFUEbg>; Fri, 21 Jun 2002 00:31:36 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:38706 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316217AbSFUEbe>; Fri, 21 Jun 2002 00:31:34 -0400
Date: Fri, 21 Jun 2002 06:31:32 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa3
Message-ID: <20020621043132.GA29970@dualathlon.random>
References: <20020620055933.GA1308@dualathlon.random> <20020620224831.GE1742@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020620224831.GE1742@werewolf.able.es>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 12:48:31AM +0200, J.A. Magallon wrote:
> 
> On 2002.06.20 Andrea Arcangeli wrote:
> >
> >Also merges some stuff from 19pre10jam2, not all the same, in particular
> >irq-balance is quite different, previous algorithm looked not really
> >good while auditing it, benchmarks will tell, any feedback on this in
> >particular would be welcome. Have a look at xosview to see the
> >difference.
> >
> 
> Still not tested on the dual xeon, but on a BX with doal PII:
> werewolf:~# cat /proc/interrupts
>            CPU0       CPU1       
>   0:      83491      63920    IO-APIC-edge  timer
>   1:       2044       1213    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   5:          1          1   IO-APIC-level  bttv
>   8:          0          1    IO-APIC-edge  rtc
>  10:      52335      24289   IO-APIC-level  aic7xxx, EMU10K1
>  11:      69049      50801   IO-APIC-level  eth0, nvidia
>  12:      33155      23661    IO-APIC-edge  PS/2 Mouse
>  14:          2         14    IO-APIC-edge  ide0
>  15:          3         13    IO-APIC-edge  ide1
> NMI:          0          0 
> LOC:     147281     147325 
> ERR:          0
> MIS:         36
> 
> Old patch, on the dual P4Xeon box:
> werewolf:~> ssh annwn cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3       
>   0:    3302667    3295991    3299383    3299984    IO-APIC-edge  timer
>   1:       4813       4680       4796       4846    IO-APIC-edge  keyboard
>   2:          0          0          0          0          XT-PIC  cascade
>   8:          1          0          0          0    IO-APIC-edge  rtc
>  12:      64959      64803      65238      63623    IO-APIC-edge  PS/2 Mouse
>  16:      65038      66347      60169      67167   IO-APIC-level  e100
>  17:          0          0          0          0   IO-APIC-level  Intel ICH2
>  18:     529910     524941     535660     535544   IO-APIC-level  aic7xxx, eth2
>  19:      71883      71973      72540      72460   IO-APIC-level  usb-uhci, eth0
>  22:    2497022    2491901    2495182    2495298   IO-APIC-level  nvidia
>  23:          0          0          0          0   IO-APIC-level  usb-uhci
> NMI:          0          0          0          0 
> LOC:   13198438   13198374   13198440   13198453 
> ERR:          0
> MIS:          0
> 
> I think the old one looks much better... ;)

I think you're missing, the more irq you get in the same cpu the better.
You're wasting tons of icache for no good reason. It's an illusion that
seeing the number distributed is a good thing. With the foster the bad
thing is that all irqs are delivered to the same cpu, so the load cannot
scale, but for any benchmark (at least before my patch) you should use
irq binding to avoid wasting icache, now with my logic maybe we can rely
on the random distribution under load, and on the idle cpu distribution
in multiway and in general in workloads with sometime idle cpus.

Andrea
