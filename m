Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290549AbSAYNXz>; Fri, 25 Jan 2002 08:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290626AbSAYNXq>; Fri, 25 Jan 2002 08:23:46 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:12760 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S290549AbSAYNXi>; Fri, 25 Jan 2002 08:23:38 -0500
Date: Fri, 25 Jan 2002 14:23:32 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@hades.uni-trier.de
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: preining@logic.at, <ttonino@users.sourceforge.net>,
        <moffe@amagerkollegiet.dk>, <timothy.covell@ashavan.org>,
        <Dieter.Nuetzel@hamburg.de>, <nitrax@giron.wox.org>, <mpet@bigfoot.de>,
        <lkml@sigkill.net>, <ed.sweetman@wmich.edu>, <pavel@suse.cz>,
        <vandrove@vc.cvut.cz>, <hpj@urpla.net>, <whitney@math.berkeley.edu>
Subject: acpi-rouble/amd disconnect patch
Message-ID: <Pine.LNX.4.40.0201251248090.30265-100000@hades.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!
i spend the morning (on my work *grin*) reading some papers (amd reviion
guide), rereading many of the mails on this topic and reading some reports
in the german c't magazin.
so...
let me "review" what problems we had:
* sound skips
* video skips / slowdown
* ultra-dma disk transfer slowdown
* system instability (one time : deadlock)
* generel performance loss on some computers
...

first: i found the answer why my patch works with acpi and not with apm:
apm only issues a halt signal loop. this does not trigger the disconnect
on STPGNT function which will cause significant power saving !!! ... the
c1 state also only provides halt (as far as i understand it). the c2 state
provides the stop-grant signal our searched STPGNT) -> ACPI C2 states
trigger the disconnect function in the northbridge, which will cause
power-saving ....

ok ....

now to the problems:
there are two known athlon bugs which cause trouble with the disconnect
function (errata 11 and errata 14 on the "AMD Athlon Processor Model 4
Revision Guide"). this bugs are present in ALL Athlon and Duron Revisions!
It looks like this bugs are not present in the Athlon XP and the new
Duron. (could be an answer to the question, why i don't have problems with
the disconnect function. i have an athlon xp 1600+)

what are now this errata bugs ?

bug 11:
when the processor is disconnected from the fsb, the internal clock is
slowed down to save power. when the processor is reconnected, it should
return to the normal clock ratio. but ... in some cases it doesn't ! "the
pll can exceed ther normal operating frequency, causing a failure to
maintain suffient system bus I/O drive strength levels in the driver
compension circuit. the compensation circuit attempts to correct this
drive strength, but if there is not sufficient time to perform this
function, the system bus cannot operate properly" (taken form the rev.
guide)
the laste few words could be a explanation for the video / sound skips ...
?

the guide also says, that a workaround is possible by bios manipulation
... so the manufacturer of the motherboard could make a bios which
corrects this problem ... (dimm it to a level where no system influence is
noticable)

bug14:
processors with half-frequency multipliers (like 11.5, 12.5, ...) may hang
upon wake-up from disconnect. this problem comes from a circuit which is
used to wake up from low-power states (c2 and c3) and which could glitch
when coming out of the c2 and c3 states.
this could cause an system hang!
-> suggested workaround from the guide: the bios programmer should disable
c2 and c3 (leastwise for the cpus with half frequency multio.)... very
helpfull :(


what other problems could be ?

some motherboards or cheaper powersuplies can't handle the jumps of
power-consumption when entering or leaving the 1/c2 states ... sometimes
this could be such extrem jumps like from 5W to 50W ... (information taken
from an asus page and vcool faq)

a suggestion which came up in the thread was, that pci latancy or other
pci-bios options could influence the "skips"-problem in video and
soundstreams ... i will test this today or tomorrow at my computer ...
but i am not shure whether i have a chance to reproduce any of the
problems, cause i have a cp cpu and a good motherboard and good
powersuply ...

oh ... and after what i have read the reconnect could take "some time"
maybe this could also be an answer for the skips if your system requires a
continual stream of data ....

what could you do ?

if you have problem: test whether some tuning on the pci settings in the
bios influences your problems ... maybe use some "slower" setting and lokk
whether the problems vanishes or get fewer ...

are there any people who have problems with the patch and an athlon xp ?

maybe test a newer bios ... !

does the "delay transaction" function influence the behavior ? Beware !
this function could cause data loss on some computers !

ok ... enough for now ...

daniel


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

