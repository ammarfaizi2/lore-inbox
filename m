Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262955AbREaB3o>; Wed, 30 May 2001 21:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262957AbREaB3e>; Wed, 30 May 2001 21:29:34 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:54558 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S262955AbREaB3Y>; Wed, 30 May 2001 21:29:24 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Frank Davis <fdavis112@juno.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.5-ac4 es1371.o unresolved symbols 
In-Reply-To: Your message of "Wed, 30 May 2001 18:15:31 +0200."
             <20010530181531.A12836@suse.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 31 May 2001 11:29:06 +1000
Message-ID: <13404.991272546@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001 18:15:31 +0200, 
Vojtech Pavlik <vojtech@suse.cz> wrote:
>On Wed, May 30, 2001 at 02:46:42PM +1000, Keith Owens wrote:
>> This is messy.  gameport.h is included by code outside the joystick
>> directory and it needs to expand differently based on whether
>> gameport.o is compiled or not.  Also gameport.o needs to be built in if
>> _any_ consumers are built in (either joystick or sound), it needs to be
>> a module otherwise.  Lots of cross config and cross directory
>> dependencies :(.
>
>What about this solution? It's a little cleaner.
>
>diff -urN linux-2.4.5-ac4/drivers/char/joystick/Config.in linux/drivers/char/joystick/Config.in
>+tristate 'Game port support' CONFIG_INPUT_GAMEPORT
>+   dep_tristate '  Classic ISA/PnP gameports' CONFIG_INPUT_NS558 $CONFIG_INPUT_GAMEPORT

CONFIG_INPUT_GAMEPORT must be a derived symbol, not a user selected
symbol.  CONFIG_INPUT_GAMEPORT is 'n' if no gameport drivers are
installed.  It is 'm' if all gameport drivers are modules *and* all
users of gameport_register_port() are modules, otherwise it is 'y'.

With your patch, if a user selects CONFIG_INPUT_GAMEPORT=m and
CONFIG_SOUND_ES1370=y then the built in es1370 driver has unresolved
references to gameport_register_port() which is in a module, vmlinux
will not link.  That is why I derived CONFIG_INPUT_GAMEPORT based on
the config options in two separate directories.

