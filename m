Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLOTKC>; Fri, 15 Dec 2000 14:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbQLOTJw>; Fri, 15 Dec 2000 14:09:52 -0500
Received: from r1944.muc.dial.surf-callino.de ([213.21.8.166]:2820 "EHLO
	notebook.diehl.home") by vger.kernel.org with ESMTP
	id <S129345AbQLOTJk>; Fri, 15 Dec 2000 14:09:40 -0500
Date: Fri, 15 Dec 2000 19:39:35 +0100 (CET)
From: Martin Diehl <mdiehlcs@compuserve.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Martin Mares <mj@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: yenta, pm, ioremap(!) problems (was: PCI irq routing..)
In-Reply-To: <Pine.LNX.4.10.10012071031300.2496-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012151627280.713-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Linus Torvalds wrote:

> Ok, definitely needs some more work. Thanks for testing - I have no
> hardware where this is needed.

Well, so I've tried to go on since my box has this "feature". Seems I
finally got the thing tracked down to several issues with mutual influence
and thus really hard to reproduce.
Apparently there are not (yet?) so much people hurt by it so my believe is
the required cleanup would be post-2.4.0(final). Just want to give you
some idea of the interesting things I've seen so far:

1) cardbus_resume() gets invoked more than once, even at test12, where the
"bridges hit twice" case from pci_pm stuff is fixed.
The reason is pcmcia_core stuff sleeping in the resume path waiting for
card detection. So we are scheduled with the resume still pending and
cardbus_resume() is entered again from kapm-idled (first was from userland
apmd context). So we get screwed when doing a second init while already
waiting for the card to finish interrogation.
My solution: asynch semantics for cardbus_resume() wrt to pcmcia_core
using a scheduled resume_bh. So we finish the pm callback before
sleeping.

2) While 1) prevents us from fooling ourselves there might be other
drivers sleeping in resume. According to Documentation/pm.txt it is legal
to do so. Probably, instead of speaking of some unspecified advantage to
finish fast, it should be stated as strongly discouraged to sleep.
Otherwise one single driver could trigger the multiple resume case for all
others. Anyway, best solution might be a clean state machine which handles
the pm transitions (and pci hotplugging). IMHO this is 2.5 stuff so I've
tried to protect the yenta stuff by its own (lockable) state flag.

3) The TI1131 is apparently not PCI PM 1.0 compliant. At least it seems it
has been replaced by the 12xx series at the moment some major player
required PCI PM 1.0 to get his "Designed for ..." label in '98 ;-)
So I had to add some code to save and restore things like memory and io
windows of the bridge which were lost after resume. This is implemented as
a controller specific addon to the common yenta operations similar to the
open/init case.

4) The final bang was when I realized that after all that done the
content of the CardBus/ExCA register space was total garbage after
resume. And, even worse, it completely failed to restore - not even
0's written to it could be read back as such. This turned out to be a
io-mapping issue! Believe it or not - my solution is to disable the
cardbus controller in BIOS setup. The rationale is as follows:

- When controller is enabled the BIOS assigns BASE_0 to 0xe6000/0xe7000.
  This is mapped to 0xc00e6000 by ioremap(). Everything works fine until
  we suspend. Furthermore I've proved by use of virt_to_bus() and vice
  versa the mapping is still there after resume. However the content is
  not writeable anymore and contains some arbitrary garbage - which always
  stays the same, even over cold reboot. But no Oops or so - just if
  you were writing to /dev/null and reading some hardwired bytes.
  Even unmapping it at suspend and remapping after resume did not help.

- With controller disabled on the other hand the BIOS does not assign
  BASE_0. So we do it during pciscan (btw., that's why I needed the VLSI
  router stuff first, since the IRQ is unrouted too in this case). This
  assigns bus-address like 0x10000000 to the guy which we are mapping
  to 0xc3-somewhere - fine. This mapping however does not only survive the
  suspend/resume like the first one, its content also remains valid -
  i.e. no garbage and writeable - here we go :)

Well, at the end yenta is now working together with pm if 1-4) applied.
So I would stop here with this workaround for me and things to be
addressed later at 2.5. Of course I could prepare 2 or 3 patches in case
it might be helpful at pre-2.4. All changes are to yenta_socket only, so
it would at least not break anything else.

However, I don't see what makes bus address 0xe6000 differ from 0x10000000
- except we are crossing the 1M barrier.
>From the i386/ioremap() code I've seen the 640k-1M range is handled
separately since it's always mapped. Some chance to loose something here
during suspend? Pagetables/-caches are expected to remain valid - right?
Btw, all access to the cardbus/exca registers go to the inlines at the top
of yenta.c using read[bwl]() - which is (for the i386) defined to simply
dereference __io_virt(addr). But we have addr pointing somewhere to the
cardbus registers already memory mapped, so we could simply say *addr.
Just a minor notational inconsistency or is there good reason to access
iomem one way or the other (aliasing, caching,...)?

Regards
Martin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
