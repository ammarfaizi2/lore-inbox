Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129211AbRBLRg3>; Mon, 12 Feb 2001 12:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129586AbRBLRgT>; Mon, 12 Feb 2001 12:36:19 -0500
Received: from gear.torque.net ([204.138.244.1]:27147 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S129211AbRBLRgH>;
	Mon, 12 Feb 2001 12:36:07 -0500
Message-ID: <3A881BBB.D2685106@torque.net>
Date: Mon, 12 Feb 2001 12:22:03 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Ishikawa <ishikawa@yk.rim.or.jp>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.orgsend.redhat.com
Subject: Re: devfs: "cd" device not showing up initially. [Fwd: Scan past lun 7 
 in
In-Reply-To: <3A8595DC.B33CB0B2@torque.net> <3A874BE2.51C58711@yk.rim.or.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ishikawa wrote:
> 
> > Chiaki,
> > The upper level scsi drivers (sd, sr, st, osst and sg) register
> > and unregister device names with devfs. After the mid level
> > recognizes a new scsi device it calls the detect() function
> > in the builtin upper level drivers and those that are currently
> > loaded as modules. That is your "problem", sr_mod.o is not
> > loaded until you do something like "ls -l /dev/sr0" (due to
> > that LOOKUP rule in /etc/devfsd.conf). The lsmod command will
> > show which modules are loaded (in your case look for sr_mod).
> >
> > There is no "push" mechanism in the scsi mid level to load
> > the sr_mod.o module when it sees a device with SCSI type
> > CDROM. Devfs (specifically devfsd) supplies various "pull"
> > mechanisms (e.g. LOOKUP) to load that module.
> 
> Doug,
> 
> Thank you for enlightening me on the subtle
> interaction of module loading and devfs.
> 
> One thing that confused me was that "generic" was
> present On my system, I use the module version of
> scsi generic driver.
> Am I right then assuming  that SCSI subsystem
> somehow supports the loading of "sg" driver module
> automagically (as opposed to mod_sr.o )?

Chiaki,
No, there is no special code in the kernel SCSI 
subsystem to load the sg driver.

The only special ("push") code within the SCSI subsystem
is a mid-level attempt to load a module called
"scsi_hostadapter". This will happen when any upper level
driver is registered _and_ there is not already a lower
level driver (i.e. adapter driver) registered.
[Hotplugging devices (e.g. USB mass storage) may be a
 good reason to add some more "push" code.]

> Otherwise I can't explain why "generic" was already
> present when I ran "ls", but "cd" wasn't.

It only requires one lookup on a /dev/sg* device name
to trigger devfsd (1.3.11) to load sg. Perhaps you need 
to closely examine devfsd's configuration files:
  - /etc/devfsd.conf
  - /etc/modules.devfs  [you are not meant to change this one]
  - /etc/modules.conf

There could also be something hidden away in your "rc"
system initialization scripts.

> (During the boot I see the string "sg" just prior to the
> loading of tmscsim (DC390) driver module. The NCR driver
> is built-in and recognized earlier. Aha, could it be that
> "sg" is used for the initial probing of
> device types and such?)

No, unless you call an app like SANE, cdrecord or scsidev.
I am aware that Debian are looking at devfs. Doing
'modprobe sg' is one way of populating the /dev/scsi
subtree when using devfs.

Doug Gilbert


P.S. Perhaps you could send me a copy of the 3 configuration
files mentioned above and the output from 'dmesg'.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
