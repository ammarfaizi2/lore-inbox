Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVHPUg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVHPUg6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 16:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVHPUg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 16:36:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16297 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932395AbVHPUg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 16:36:57 -0400
Date: Tue, 16 Aug 2005 22:31:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Michael E Brown <Michael_E_Brown@dell.com>
Cc: Greg KH <greg@kroah.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       linux-kernel@vger.kernel.org, Douglas_Warzecha@dell.com,
       Matt_Domsch@dell.com
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Message-ID: <20050816203156.GB516@openzaurus.ucw.cz>
References: <4277B1B44843BA48B0173B5B0A0DED4352817E@ausx3mps301.aus.amer.dell.com> <DEFA2736-585A-4F84-9262-C3EB53E8E2A0@mac.com> <1124161828.10755.87.camel@soltek.michaels-house.net> <20050816081622.GA22625@kroah.com> <1124199265.10755.310.camel@soltek.michaels-house.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124199265.10755.310.camel@soltek.michaels-house.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > To take a concrete example, I suggested to Doug to mention fan status. I
> > > get the feeling that you possibly think that this would be better
> > > integrated into lmsensors, or something like that.
> > 
> > Yes it should.  That way you get the benifit of all userspace
> > applications that already use the lmsensors library without having to be
> > rewritten in order to support your new library.
> 
> Little did I know when I first mentioned it how big of a mistake it
> would be to mention the sensor functions. *sigh*
> 
> The dcdbas driver allows access to all of the Dell SMIs. Sensors are
> only one instance of SMI code (only two functions, in fact, if I am
> reading this spec correctly). The other (roughly) 58 functions have
> nothing to do with sensors. The presence of the dcdbas driver would not

Perhaps it is okay to export 2 values through lmsensors and the remaining 58
by some other approach, but I think we could find sensible way to export more
than two functions...

> stop anybody from writing another driver to provide a hwmon interface to
> just the sensors pieces. 

Good, hwmon can use dcdbas interface internally.

> Ok, here is a short list of the things you can do with the Dell SMI
> implementation. Note that this is a rough categorization of functions.
> As implemented, get and set are normally separate SMI calls, so for each
> that says get/set or read/write, read that as two SMI calls.
> 
> I am in the process of writing detailed docs for these (at least the
> ones I have docs for) in libsmbios and hope to be done in a few days.
> 
> 1) Read/Write Non-Volatile Storage
> 	-- main use case for libsmbios. This lets us set all of the rest of the
> BIOS F2 options that are settable. To rehash from an earlier email, BIOS
> stores some options in CMOS, these are already available in libsmbios.
> The rest of the options are stored in SMI, and in fact almost all the
> new options being added are SMI-only, as CMOS has run out of room.
> 	-- There are roughly 300 different tokens (usually equivalent to a BIOS
> F2 option, but not always). These are split between CMOS and SMI, but a
> good percentage of these are SMI. 

This one is going to be tough, altrough sysfs file with ascii representation of
all 300 options would be cool.

> 2) Read/Write Battery/AC mode settings. Read system status. 
> 	-- Fans/Voltage. This interface is only used by laptops (currently used
> by i8k driver).
> 	-- Systems status gives failing sensor count.

We already have interfaces for battery status. One in /proc/apm, one in /proc/acpi.

> 3) Dynamic system status:
> 	AC Available
> 	Lid Closed
> 	Battery Available

See acpi.

> 	Docked

Other notebooks can dock, too. It would be nice to do just one interface.

> 	Main Battery Critical
> 	Main Battery Avail
> 	Aux. Battery Critical
> 	Aux. Battery Avail.

Thats battery status, see above.

> 	SCSI Available
> 	Network Available
> 	Module bay contents (floppy, cd, ls120, etc)

Does it get any info you can't get in other way?

> 4) Get/Set Boot Device Priority
> 	-- set system boot order (floppy, cd, hard drive, pxe, etc)

Sounds like cmos options above...

> 5) Get/Set BBS IPL/BCV priority
> 	-- more fine grained way to set boot priority. lets you choose which
> add-in card gets to be C: drive.

Cmos options.

> 6) Get display type
> 	-- laptops. gets display res + misc attributes 
> 7) Get display resolution

Framebuffer driver already knows about this.

> 8) Get/Set active display
> 	-- laptops: switch between crt/lcd
> 9) Get battery information

Acpi again.

> 10) Get/set/verify user/user II/administrator passwords

Looks like cmos; not sure how to solve that one.
 
> 11) Get/Set asset/service/property/eppid tags

cmos again.

> 12) Get/Set monitor refresh rate

This should go through fbdev somehow, but I see its hard.

> 13) Get slice type. (laptop expansion thingy, I suppose)

If even you don't know what its good for, we probably don't want to support it
anyway.

> 14) Onboard NIC status (laptops)

Redundant.

> 15) Get/Set onboard radio status
> 	-- turn on/off wifi antenna

Should integrate with wlan support.

> 16) Application Program Registration (your guess is as good as mine.)
> 17) User customization control (same)

Then do not support it.

> 18) Get Message information.
> 	--returns bios event information (english only) for stuff like overtemp

Wow, nice; acpi has something similar. Common solution needed...

> 19) Get hard drive size (why? I don't know)

No support, then.

> 20) Get/Clear ECC memory single-bit error status
> 21) Get memory test support information.
> 22) Start/Stop memory test
> 23) Get memory test error information/ map error information

Not sure about those.

> 24) Get/set server boot device priority

Looks like cmos again.

> 25) Issue Read-only SBDS Command
> 	-- "Smart Battery Data Specification" -- whatever that is.
> 

There's spec somewhere. Some acer notebooks have only smart battery interface.

			Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

