Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbUKCUc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbUKCUc6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbUKCUc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:32:58 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:15273 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261848AbUKCUcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:32:25 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [patch 2/2] kbuild: fix crossbuild base config
Date: Wed, 3 Nov 2004 21:32:37 +0100
User-Agent: KMail/1.7.1
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       julian@sektor37.de, mcr@sandelman.ottawa.on.ca, sam@ravnborg.org
References: <20041102232001.370174C0BC@zion.localdomain> <Pine.LNX.4.61.0411031909460.877@scrub.home> <20041103183415.GH381@smtp.west.cox.net>
In-Reply-To: <20041103183415.GH381@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411032132.37947.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 19:34, Tom Rini wrote:
> On Wed, Nov 03, 2004 at 07:19:37PM +0100, Roman Zippel wrote:
> > Hi,
> >
> > On Wed, 3 Nov 2004, Tom Rini wrote:
> > > > > This has actually created not-working UML binaries (since UML is
> > > > > always "cross-compiled" for this purpose), as reported by Julian
> > > > > Scheid.

> > > > This rather suggests, there is a problem with UML. Either fix your
> > > > Kconfig to prevent nonvalid configurations or detect and report the
> > > > problem at runtime.

> > > No, this is a damn annoying kbuild problem when cross compiling.

> > The ability to create a nonworkable UML binary is _not_ a kbuild problem,
> > especially in the UML case I would expect it should be possible to avoid
> > this.

I agree that this is a UML problem and I'm addressing it, too (it maybe wasn't 
clear in the original mail, but it's obvious). And maybe, it is even 
unrelated from this issue.

That said, indipendently from the UML issue, it is *meaningless* to read a 
config default from /boot or /etc or /lib/modules. And, in fact, you never 
say "it's a good thing to do in that case".

You later say "If possible, I'd avoid this patch at all". Why? Is this code 
too intrusive, or implementing a wrong check, or bloating the source?

> How about how easy it is to create a totally bogus config for any arch?
> This isn't a UML problem, this is a cross compiling for any arch
> problem.

> > > > > We all agreed on this kind of general, not UML-only fix, and I
> > > > > (Paolo) implemented it.

> > > > I don't like the two separate lists, it would be easier to just skip
> > > > all absolute path names.
Ok, fine. I was dubious on this, too (I went the lazy way because it's just 3 
duplicated lines).

Would it be ok for this to use:

struct confsource {
 char * path;
 int * cross_valid;
}

?

Since you didn't comment on this, I also suppose the env.var idea is fine for 
you.

> > > > I would also like to avoid this patch at all.

> > > > If this really should 
> > > > be a problem, I'd consider to don't run kconfig at all in this case
> > > > if there is no configuration and instead suggest running defconfig
> > > > (or one of machine specific config targets) first.

When there is no .config and no other source, the last resort is taking the 
defaults from defconfig, normally, isn't it? So, when cross-compiling, that 
should still be correct.

> > > I have a feeling that changing the behavior of 'make {,x,g,q}config' to
> > > fail if there's no .config will upset a lot of users, possibly even
> > > more than would be upset by never looking in /boot or /lib ever.

> > I'm only talking about cross compiling here. From people who do this, I
> > sort of expect, that they know what they do.

* UML is always cross-compiled (even if the compiler is the host one), and 
most UML user *don't* know what they are doing.

* Looking in /boot, /etc or /lib is not documented at all, and "read the 
flaming source" is not a welcome documentation source.

> The following argument makes less sense, possibly, as 2.6 lives on, but
> this is new breakage for people moving up from 2.4 that just looked in
> .config and arch/$(ARCH)/defconfig and who don't otherwise know that
> things have been changed or broken, depending on how you look at it.

> > You can misconfigure a kernel
> > in native compiles as well, this patch solves the wrong problem.

> I disagree.  This solves the "why did the kernel decide to look at
> /boot/config when it really should have known better" problem.

> > E.g. if someone wrote a patch which stores the arch in .config and warns/
> > refuses to load it for a different configuration, I would accept it
> > happily.
Yes, this is another idea, which is also fine, while not excluding the other 
IMHO.
> We already have part of this, except I don't know for certain of
> CONFIG_ARCH == CONFIG_$(SUBARCH) (... to mix syntax all the hell up).

No warning is output. Or better, yes, you get warnings, but tons of not clear 
ones, like "warning, undefined symbol".

UML uses currently CONFIG_USERMODE rather than CONFIG_UM (is this a bug?). I 
have no idea for other archs. Do you suggest using KCONFIG_ARCH= or 
CONFIG_THIS_ARCH= or what?
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
