Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262873AbREaHXU>; Thu, 31 May 2001 03:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262989AbREaHXK>; Thu, 31 May 2001 03:23:10 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:11136 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S262873AbREaHWv>;
	Thu, 31 May 2001 03:22:51 -0400
Date: Thu, 31 May 2001 08:08:45 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Keith Owens <kaos@ocs.com.au>
Cc: Frank Davis <fdavis112@juno.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.5-ac4 es1371.o unresolved symbols
Message-ID: <20010531080845.A808@suse.cz>
In-Reply-To: <20010530181531.A12836@suse.cz> <13404.991272546@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <13404.991272546@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Thu, May 31, 2001 at 11:29:06AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2001 at 11:29:06AM +1000, Keith Owens wrote:
> On Wed, 30 May 2001 18:15:31 +0200, 
> Vojtech Pavlik <vojtech@suse.cz> wrote:
> >On Wed, May 30, 2001 at 02:46:42PM +1000, Keith Owens wrote:
> >> This is messy.  gameport.h is included by code outside the joystick
> >> directory and it needs to expand differently based on whether
> >> gameport.o is compiled or not.  Also gameport.o needs to be built in if
> >> _any_ consumers are built in (either joystick or sound), it needs to be
> >> a module otherwise.  Lots of cross config and cross directory
> >> dependencies :(.
> >
> >What about this solution? It's a little cleaner.
> >
> >diff -urN linux-2.4.5-ac4/drivers/char/joystick/Config.in linux/drivers/char/joystick/Config.in
> >+tristate 'Game port support' CONFIG_INPUT_GAMEPORT
> >+   dep_tristate '  Classic ISA/PnP gameports' CONFIG_INPUT_NS558 $CONFIG_INPUT_GAMEPORT
> 
> CONFIG_INPUT_GAMEPORT must be a derived symbol, not a user selected
> symbol.  CONFIG_INPUT_GAMEPORT is 'n' if no gameport drivers are
> installed.  It is 'm' if all gameport drivers are modules *and* all
> users of gameport_register_port() are modules, otherwise it is 'y'.
> 
> With your patch, if a user selects CONFIG_INPUT_GAMEPORT=m and
> CONFIG_SOUND_ES1370=y then the built in es1370 driver has unresolved
> references to gameport_register_port() which is in a module, vmlinux
> will not link.  That is why I derived CONFIG_INPUT_GAMEPORT based on
> the config options in two separate directories.

Have you tried the patch? Because the gameport.h define has:

#if defined(CONFIG_INPUT_GAMEPORT) || (defined(CONFIG_INPUT_GAMEPORT_MODULE) && defined(MODULE))
void gameport_register_port(struct gameport *gameport);
void gameport_unregister_port(struct gameport *gameport);
#else
void __inline__ gameport_register_port(struct gameport *gameport) { return; }
void __inline__ gameport_unregister_port(struct gameport *gameport) { return; }
#endif

I think it should work.

-- 
Vojtech Pavlik
SuSE Labs
