Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313103AbSC1IDC>; Thu, 28 Mar 2002 03:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313104AbSC1ICx>; Thu, 28 Mar 2002 03:02:53 -0500
Received: from [195.63.194.11] ([195.63.194.11]:13066 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313103AbSC1ICr>; Thu, 28 Mar 2002 03:02:47 -0500
Message-ID: <3CA2CDA1.7090505@evision-ventures.com>
Date: Thu, 28 Mar 2002 09:00:33 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: andersen@codepoet.org, Andre Hedrick <andre@linux-ide.org>,
        Jos Hulzink <josh@stack.nl>, jw schultz <jw@pegasys.ws>,
        linux-kernel@vger.kernel.org
Subject: Re: DE and hot-swap disk caddies
In-Reply-To: <E16qNvF-0006Xv-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>Ok.  How about my laptop?  I have an ATAPI zip drive I can plug
>>in instead of a second battery.  It is the only device on the
>>second IDE bus (hdc).  In windows there is a little hotplug
>>utility thing one runs before unplugging the zip drive.  In Linux
>>I currently have to reboot if I want the ide-floppy driver to see
>>the device...  I'm willing to bet that Dell has done mysterious
>>stuff to make the electrical part work.  It would sure be nice if
>>I could ask the ide driver to kindly re-scan for /dev/hdc now.
> 
> 
> I would imagine Dell have stuff there to do electrical isolation, or that
> they have parts of the IDE controller built into the actually removable drive 
> unit itself. With additional electronics you can safely do IDE hot plugging,
> but you do need the electronics and the host co-operation.

OK set's sheed a light on the issue:

Contrary to popular beleve the SCSI termination stuff wasn't
introduced for the pain of system administrators but just
to meet the simple rule of physics that an stripe of copper
with a dangling end can act as a nice antenna of Bluetooth like
radio networking called signal transfer by changing current in it ;-).

ATA is using a much much cheaper and simpler aproach to the
same problem: it's called pathetically "distributed termination".
In reality this means that the master drive contains half
of a proper passive termination resistor bridge and the
slave the other half. Additionally they just specified that
the cable can't become too long to make the whole thing non
functional if there is only one drive on the cable - which
means half the therminating resistance at the end. As an added
bonus they didn't care becouse they never expected too high
transfer rates (read signal frequencies) for this interface.

Did  you ever wonder why ATA cables can't be as long as SCSI?
This is the reason wy.

Now with the higher transfer rates the host chips simple started
to adjust they output drivers to the presence of one or two
devices on the cable (bus). Did you ever wonder why the CMD640
was sporadically corrupting data - well they did get this
adjustment barely right on the primary channel and
seriously wrong on the secondary. It's not cheap to
implement diode cascades in CMOS for on chip resistors with
adequate accuracy and CMD tryed to get away the cheap way...
and it was all about bus termination.

If you now suddenly remove one
device the termination will be improper and you will not
be able anylonger to provide acceptable transfer rates and you can
get some voltage spikes which can destroy the output drivers
of the involved controllers. However this is *very unlikely*,
becouse they can usually sustain quite reasonable currents -
but it's still possible. The simplest guard against this
kind of disaster is a zener diode around the output lines drivers -
this is a *very* common practice on electronics those days now,
so still the chances of a phyical desaster on recent hardware
are *very low*. Reconnecting is more interresting becouse
the gorund level differences between the devices can be
arbitrary and due to electrostatics there can be voltage
spikes which can indeed destroy you hardware...

Then there is this talking around about the "tristate of some" device.
I'm really a bit sick of it. Becouse there is no such a state
like a tri-state. We have just bus drivers on both ends.
They are implemented usually as Schmidt triggers. They have three
possible states on output: low voltage, high voltage, high resistance.

If you put the disk's and  the host chip's output drivers
into the *high resistance state* or in other words if
you de-select them (not an ominous "tristate")
and then there is only a single one disk on the channel,
then it *is* electrically just safe to disconnect it thereafter.
Many modern disks support this in esp. for example PCMCIA
card adapter based pseudo disks.

If there is a simple gate chip (74HC255 or similar comes to mind)
between the host chip and the external connector - which is possible
controlled by some spare controll line on the south brigde
- it can all be easly handled by the BIOS. However to support
OS which don't have special interacting drivers you will
most likely make this small gate chip pass-through as default...
This is what all the whole "docking station" stuff is about.

(Ehmmm.... let's possible just see whatever there is actually any current
on the external ATA interface of my notebook even when the CD-ROM
is disconnected...)

But there is not really any special magic involved!

