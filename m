Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282597AbRLQUIY>; Mon, 17 Dec 2001 15:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282707AbRLQUIP>; Mon, 17 Dec 2001 15:08:15 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:34026 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S282691AbRLQUIA>; Mon, 17 Dec 2001 15:08:00 -0500
Date: Mon, 17 Dec 2001 21:07:53 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Simon Roscic <simon.roscic@chello.at>, <vojtech@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: compile problem: es1371+gamepad
In-Reply-To: <20011217194305.ISZS1236.viefep13-int.chello.at@there>
Message-ID: <Pine.NEB.4.43.0112172057360.24574-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Simon Roscic wrote:

> hi,

Hi Simon,

> i have the following problem,
>
> i have a es1371 soundcard, with an ms sidewinder gamepad.
> i selected the es1371 to be compiled into the kernel, and the ms sidewinder gamepad driver as module.
>
> i just tried it with 2.4.17-rc1:
> (2.4.17-rc1 with preempt patch, but im sure the preempt patch is not
> the cause for the compile error)
>
> ---- snip ----
> drivers/sound/sounddrivers.o: In function `es1371_probe':
> drivers/sound/sounddrivers.o(.text+0x6de9): undefined reference to `gameport_register_port
> '
> drivers/sound/sounddrivers.o: In function `es1371_remove':
> drivers/sound/sounddrivers.o(.text+0x6f26): undefined reference to `gameport_unregister_po
> rt'
> make: *** [vmlinux] Error 1
> ---- snip ----
>....
> i attached my ".config",
>...


Simon: As an (untested) workaround until the bug I describe below is fixed
       it should work for you if select in the Character devices/Joysticks
       submenu the "Game port support" to be compiled statically into the
       kernel instead of compiling it as a module.


The problem is (note that CONFIG_INPUT_GAMEPORT is defined twice with
different values):

<--  snip  -->

...
#
# Joysticks
#
CONFIG_INPUT_GAMEPORT=m
...
#
# Sound
#
...
CONFIG_SOUND_ES1371=y
...
CONFIG_INPUT_GAMEPORT=y
...

<--  snip  -->

It survives even a "make oldconfig".
It's caused by the following in drivers/sound/Config.in:

<--  snip  -->

...
# A cross directory dependence. The sound modules will need gameport.o
compiled in,
# but it resides in the drivers/char/joystick directory. This
define_tristate takes
# care of that. --Vojtech

if [ "$CONFIG_INPUT_GAMEPORT" != "n" ]; then
  if [ "$CONFIG_SOUND_ESSSOLO1" = "y" -o "$CONFIG_SOUND_ES1370" = "y" -o
"$CONFIG_SOUND_ES1371" = "y" -o "$CONFIG_SOUND_SONICVIBES" = "y" ]; then
    define_tristate CONFIG_INPUT_GAMEPORT y
  fi
fi

<--  snip  -->


> simon.

cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400



