Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271736AbTHHRrq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 13:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271737AbTHHRrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 13:47:45 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:29160 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271736AbTHHRrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 13:47:43 -0400
Date: Fri, 8 Aug 2003 19:47:36 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 bug: kconfig implementation doesn't match the spec
Message-ID: <20030808174736.GA16091@fs.tum.de>
References: <20030808145107.GY16091@fs.tum.de> <Pine.LNX.4.44.0308081714160.714-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308081714160.714-100000@serv>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08, 2003 at 05:16:09PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Fri, 8 Aug 2003, Adrian Bunk wrote:
> 
> > An example:
> > 
> > config FOO
> >         tristate
> >         default m
> > 
> > config BAR
> >         tristate
> >         default y if !FOO
> >         default n
> > 
> > 
> > According to the kconfig spec BAR should be y, but the implementation in
> > 2.6.0-mm5 sets BAR to n.
> 
> You probably forgot to set MODULES, tristate behaves like bool in this 
> case and FOO becomes 'y' and '!FOO' is 'n'.

No, this is with CONFIG_MODULES=y.

Let me give another example where the kconfig implementation is 
completely broken (BTW: again with CONFIG_MODULES=y):

According to your language definition,
  m && !m
evaluates to "m" (it sounds a bit strange but follows directly from
rules (5) and (7) together with the interpretation of "m" as 1 as 
explained in the section "Menu dependencies" of
Documentation/kbuild/kconfig-language.txt).

Let's take the following Kconfig snippet:

config MOD
        tristate
        default m

config TEST8
        tristate
        default MOD && !MOD

config TEST9
        tristate
        default m && !m

With the explations above it's obvious both TEST8 and TEST9 should be 
"m", but the current 2.6 kconfig implementation says:

# CONFIG_TEST8 is not set
CONFIG_TEST9=y


That's not only different from the expected result directly derived from 
the language definition, it also gives two completely different results 
for the same expression!


> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

