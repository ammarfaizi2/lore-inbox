Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbTLXT1X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 14:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTLXT1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 14:27:23 -0500
Received: from pooh.lsc.hu ([195.56.172.131]:64214 "EHLO pooh.lsc.hu")
	by vger.kernel.org with ESMTP id S263788AbTLXT1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 14:27:20 -0500
Date: Wed, 24 Dec 2003 20:12:58 +0100
From: GCS <gcs@lsc.hu>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Peter Osterlund <petero2@telia.com>
Subject: Re: 2.6.0-mm1
Message-ID: <20031224191258.GA19528@lsc.hu>
References: <20031224095921.GA8147@lsc.hu> <20031224115342.GA10350@lsc.hu> <20031224122342.GA11399@lsc.hu> <200312241017.44225.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <200312241017.44225.dtor_core@ameritech.net>
User-Agent: Mutt/1.3.28i
X-Operating-System: GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 24, 2003 at 10:17:43AM -0500, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> May we see your dmegs, XF86Config and the parameters you are passing
> to GPM please?
 Sure, sorry for not doing it earlier:
-- dmesg --
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.6
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
-- dmesg --

-- XF86Config-4 --
Section "Module"
        Load    "GLcore"
        Load    "bitmap"
        Load    "dbe"
        Load    "ddc"
        Load    "dri"
        Load    "extmod"
        Load    "glx"
        Load    "int10"
        Load    "record"
        Load    "speedo"
        Load    "type1"
        Load    "vbe"
        Load    "xtt"
        Load    "synaptics"
EndSection

Section "InputDevice"
        Driver        "synaptics"
        Identifier    "Configured Mouse"
        Option        "Device"        "/dev/gpmdata"
        Option        "Protocol"      "auto-dev"
        Option        "LeftEdge"      "1900"
        Option        "RightEdge"     "5400"
        Option        "TopEdge"       "1900"
        Option        "BottomEdge"    "4000"
        Option        "FingerLow"     "25"
        Option        "FingerHigh"    "30"
        Option        "MaxTapTime"    "180"
        Option        "MaxTapMove"    "220"
        Option        "VertScrollDelta" "100"
        Option        "MinSpeed"      "0.02"
        Option        "MaxSpeed"      "0.18"
        Option        "AccelFactor" "0.0010"
        Option        "SHMConfig"     "on"
#       Option       "Repeater"      "/dev/ps2mouse"
EndSection
-- XF86Config-4 --

The Synaptics driver used is 0.12.2, compiled for myself, evdev is in
module, but ofcourse it's loaded before XFree86 starts. (I have stripped
down the files a bit, if you would like to see the whole files or other
parts, please ask - I thought it would be easier to see the relevant
lines only). gpm is configured by /etc/gpm.conf , but it should be:
gpm -m /dev/psaux -t ps2 -R raw
Also, the XFree86 Synaptics driver prints this while starting and
switching between console and XFree86:
Synaptics DeviceInit called
SynapticsCtrl called.
Synaptics DeviceOn called
Synaptics DeviceOff called
[the last two repeated more times]

> Btw, what version of GPM are you using?
 I am running Debian Sid, thus I also thought gpm is the newest; as I
do understand I should use 1.20.1, which is the latest AFAIK. Thus I was
shocked a bit on what 'dpkg -l gpm' gives:
ii  gpm            1.19.6-12.1    General Purpose Mouse Interface
More than a year old! Already filed an important bug on this. Sorry, it
seems to be the problem, or at least produces strange behavior:
I plugged in an USB mouse, which works while the touchpad still not
under XFree86 (both works at the same time under console - even if I did
not specified any additional config for gpm). The config for XFree86:
-- XF86Config-4 --
Section "InputDevice"
        Identifier      "USB Mouse"
        Driver          "mouse"
        Option          "CorePointer"
        Option          "Device"                "/dev/input/mice"
        Option          "Protocol"              "imps/2"
        Option          "Emulate3Buttons"       "true"
        Option          "ZAxisMapping"          "4 5"
EndSection
-- XF86Config-4 --

Made it the only one pointer input. Now, if I kill gpm with 'gpm -k',
then the touchpad begins to work! Sometimes if I release it, then the
pointer jumps a bit from where I pointed it, but that's all. I'm not
good in mice stuff, so I can't explain this. Anyway, I will try to
compile a newer gpm, change it's device, so play a bit; maybe I can come
up with something.

> As far as reverting patches I would start with
> input-08-synaptics-protocol-discovery.patch
 It did not help. :-(

Thanks, and Merry Christmas!
GCS
