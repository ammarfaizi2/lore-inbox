Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270206AbUJTEQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270206AbUJTEQQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 00:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265477AbUJTELN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 00:11:13 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:36799 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270351AbUJTEFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 00:05:36 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: forcing PS/2 USB emulation off
Date: Tue, 19 Oct 2004 23:05:32 -0500
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, Alexandre Oliva <aoliva@redhat.com>,
       linux-kernel@vger.kernel.org
References: <orzn2lyw8k.fsf@livre.redhat.lsd.ic.unicamp.br> <20041019063057.GA3057@ucw.cz> <200410190148.30386.dtor_core@ameritech.net>
In-Reply-To: <200410190148.30386.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410192305.32681.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 October 2004 01:48 am, Dmitry Torokhov wrote:
> On Tuesday 19 October 2004 01:30 am, Vojtech Pavlik wrote:
> > On Mon, Oct 18, 2004 at 09:45:39AM -0700, Greg KH wrote:
> > 
> > > I'm a little leary of changing the way the kernel grabs the USB hardware
> > > from the way we have been doing it for the past 6 years.  So by
> > > providing the option for people who have broken machines like these, we
> > > will let them work properly, and it should not affect any of the zillion
> > > other people out there with working hardware.
> > > 
> > > Or, if we can determine a specific model of hardware that really needs
> > > this option enabled, we can do that automatically.  If you look at the
> > > patch, we do that for some specific IBM machines for this very reason.
> > > 
> > > Is there any consistancy with the type of hardware that you see being
> > > reported for this issue?
> >  
> > Like 30% of all notebooks? ;) They do boot without the USB handoff, the
> > PS/2 mouse works, but only as a PS/2 mouse, no extended capabilities
> > detection is possible due to the BIOS interference.
> > 
> 
> I will send a list of examples tomorrow but so far it includes IBM
> Thinkpads, Dells, Sonys, Compaqs, Fujitsus, Toshibas, Supermicro-based
> boards and nonames. 
> 
> We risk growing that DMI list pretty big ;)
> 

OK, here are the different cases that I was able to find:

http://www.ussg.iu.edu/hypermail/linux/kernel/0401.3/0484.html
Sony Vaio GR7/K - PhoenixBIOS 4.0 Release 6.0 - R0208C0.
... Anyway I solved this problem loading uhci_hcd + hid before
psmouse in /etc/modules

http://mike2k.de/cgi-bin/t40.cgi
Thinkpad T40p
... When booting a 2.6.2 kernel with apm enabled, the synaptics
touchpad is not recognized by the Kernel if a USB Mouse is plugged
in at boottime and thus only the usb mouse is usable.

http://lkml.org/lkml/2004/7/6/32
Unknown
> > input: SynPS/2 Synaptics TouchPad on isa0060/serio1
> 
> Try making psmouse modular as well and load it _after_ all USB stuff is
> loaded - you may be having issues with USB Legacy emulation.

Ok, this has fixed it. At least the other way round: compiling in the
basic usb stuff and psmouse did the trick in -mm6, too.

http://www.redhat.com/archives/fedora-test-list/2004-June/msg00168.html
Supermicro boards seem to have problems
... As far as people can currently tell that is down to supermicro bios bugs.
Compiling the HCD in hides this by turning off USB legacy emulation before
the bios can get involved - so the kernel ends up talking to the real
PS/2 hardware.

http://seclists.org/lists/linux-kernel/2004/Mar/0348.html
Model: unknown
> On Tuesday 02 March 2004 05:03 am, Emiliano 'AlberT' Gabrielli wrote: 
> > Hi all, 
> > I have a strange behaviour on my laptop: touchpad is not probed by the 
> > kernel (2.6.3) *if* and only if at boot time the USB mouse is plugged in 
> > ... 
> 
> It is usually caused by USB Legacy emulation - BIOS makes a USB mouse look 
> like a PS/2 mouse. Look in your BIOS setup if there is an option to turn it 
> off. Otherwise you will have to load ehci/uhci_hcd and hid modules before 
> loading psmouse module as loading full-blown USB support disables that 
> emulation. 
perfect, now all works fine 
thank you so much

http://forums.gentoo.org/viewtopic.php?t=169145
sony vaio PCG-R600HFPD
(handoff did not seem to help in this case though)

http://forums.gentoo.org/viewtopic.php?t=178056&highlight=
Vaio PCG-GRX650.
Result unknown

http://forums.gentoo.org/viewtopic.php?t=215876&highlight=
Model: unknown
... it works like a charm when compiled psmouse as a module.

http://forums.gentoo.org/viewtopic.php?t=223819&highlight=
Premio 6010N (czech made in ATComputers)

http://www.ussg.iu.edu/hypermail/linux/kernel/0409.0/1930.html
Fujitsu S7010
May help.

http://www.fedoraforum.org/forum/archive/index.php/t-21097.html
... I have a Toshiba A70, and needed to disable 'legacy USB support'
in the bios. As soon as I did that, the touchpad (minus wheel
functionality) began working.

http://forums.gentoo.org/viewtopic.php?p=1665865#1665865
Keyboard does not work unless usb-handoff is used.

http://bugme.osdl.org/show_bug.cgi?id=1882
IBM T40

There is also issue of IBMs reporting presence of an active multiplexing
controller unless USB is activated before i8042.

J.A. Magallon has complained that his mouse is jerky unless legacy
emulation is disabled.

Note that only staring with 2.6 PS/2 initialization happens before
USB because before GPM/X was doing it way after USB has been activated
event if USB was compiled as modules.

-- 
Dmitry
