Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284178AbRLPBlM>; Sat, 15 Dec 2001 20:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284176AbRLPBkw>; Sat, 15 Dec 2001 20:40:52 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:27072 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S284171AbRLPBkj>;
	Sat, 15 Dec 2001 20:40:39 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: keyboard + PS/2 mouse locks after opening psaux
In-Reply-To: <m3elodw1tv.fsf@defiant.pm.waw.pl>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 16 Dec 2001 02:36:31 +0100
In-Reply-To: <m3elodw1tv.fsf@defiant.pm.waw.pl>
Message-ID: <m3zo4k0wv4.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The original problem description:

> I'm having the following problem: after I start X11 (or gpm with no X)
> my keyboard and PS/2 mouse sometimes locks up. What could that be?
> 
> 440BX UP celeron mobo here (Abit - BH6?), '94 AT keyboard, '2000 A4tech
> 2-wheel mouse, various Linux 2.4 versions (usually -ac, currently 2.4.10ac3).
> I'm using NVidia Xserver module, but it doesn't seem related (the lookup
> occured with no X while starting gpm once or twice).
> 
> If I kill Xserver (haven't tried with gpm), the keyboard (and mouse) start
> working again (the next Xserver spawn works fine).
> 
> For me, it looks like some race condition between open_aux and mouse
> (kbd?) interrupt, causing interrupts or kbd controller to stay disabled
> after the mouse device is opened. The interrupt counters for both kbd
> and psaux stay constant when I move the mouse and/or press buttons/keyboard
> keys:

I finally found some free time for investigation. It seems the problem is
the mouse + the keyboard controller - it's A4Tech WWW-something mouse
with 3 buttons and 2 wheels (PS/2 Intellimouse-compatible). The mother-
board is Abit BH6 (slot-1, Intel 440BX + Winbond W83977 - I'm not sure
which IC works as the keyboard controller).

The following script hangs on dd (keyboard hangs as well) on my system
after few seconds:

q=0;
while :; do
        (echo -en '\xe8\x03'; dd bs=1 count=2 >/dev/null)<>/dev/psaux 1>&0;
        q=$[$q+1];
        echo $q;
done

(If you want to check this script on your system, remember it may lock
your PS/2 mouse and keyboard and you may need to use remote shell to kill
the script - closing /dev/psaux makes keyboard alive again). Of course,
it's pointless to run it if you don't have PS/2 mouse. Before running
the script, make sure no processes have /dev/psaux open (kill gpm, Xserver
etc).

The script basically opens /dev/psaux (the kernel initializes mouse),
writes E8 03 (two bytes) there, tries to read 2 bytes back, then closes
the psaux. It looks like under some circumstances, the mouse does something
really bad to the keyboard controller and then it stops requesting
interrupts.

After swapping the mouse with old MS 2-key one, the script no longer
hangs the keyboard. I'm not sure if the (A4Tech) mouse can cause malfunction
to other machines (with other motherboards), but it doesn't do any harm
to my notebook (internal mouse off).


Last accesses to the keyboard controller before a hang (gpm start):
Dec 15 20:46:46 kernel: CMD D4 KBD_CCMD_WRITE_MOUSE
Dec 15 20:46:46 kernel: STA 3F
Dec 15 20:46:46 kernel: INP FA
Dec 15 20:46:46 kernel: STA 3C
Dec 15 20:46:46 kernel: OUT F3 AUX_SET_SAMPLE
Dec 15 20:46:46 kernel: STA 34
Dec 15 20:46:46 kernel: CMD D4 KBD_CCMD_WRITE_MOUSE
Dec 15 20:46:46 kernel: STA 3D
Dec 15 20:46:46 kernel: INP FA
Dec 15 20:46:46 kernel: STA 3C
Dec 15 20:46:46 kernel: OUT 64 (100)
Dec 15 20:46:46 kernel: STA 34
Dec 15 20:46:46 kernel: CMD D4 KBD_CCMD_WRITE_MOUSE
Dec 15 20:46:46 kernel: STA 3D
Dec 15 20:46:46 kernel: INP FA
Dec 15 20:46:46 kernel: STA 3C
Dec 15 20:46:46 kernel: OUT E8 AUX_SET_RES
Dec 15 20:46:46 kernel: STA 34
Dec 15 20:46:46 kernel: CMD D4 KBD_CCMD_WRITE_MOUSE
Dec 15 20:46:46 kernel: STA 3F
Dec 15 20:46:46 kernel: INP FA
Dec 15 20:46:46 kernel: STA 3C
Dec 15 20:46:46 kernel: OUT 03 (3)
Dec 15 20:46:46 kernel: STA 34 <<<<<<<<<<< status = 34 here
Dec 15 20:46:55 root: kbd and mouse dead

CMD - command write, STA - status read, INP - data read, OUT - data write.
The last mouse command is E8 03 (AUX_SET_RES 3).


gpm started without a hang:
...
Dec 15 20:44:44 kernel: INP FA
Dec 15 20:44:44 kernel: STA 3C
Dec 15 20:44:44 kernel: OUT 03 (3)
Dec 15 20:44:44 kernel: STA 35 <<<<<<<<<<< status is different here
Dec 15 20:44:44 kernel: INP FA
Dec 15 20:44:46 kernel: STA 15
Dec 15 20:44:46 kernel: INP 1C
Dec 15 20:44:46 kernel: STA 15
Dec 15 20:44:46 kernel: INP 9C
Dec 15 20:44:46 kernel: STA 14
Dec 15 20:44:47 root: kbd ok


I've noted that the status after the AUX_SET_RES(3) command is always
0x35 when there is no hang, and 0x34 or 0x36 otherwise.


The question is - is the hardware (kbd controller or mouse) faulty,
or should we do something to it in the kernel?
-- 
Krzysztof Halasa
Network Administrator
