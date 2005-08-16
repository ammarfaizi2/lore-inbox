Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965215AbVHPNee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965215AbVHPNee (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 09:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbVHPNee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 09:34:34 -0400
Received: from adsl-67-65-14-122.dsl.austtx.swbell.net ([67.65.14.122]:65470
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S965215AbVHPNee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 09:34:34 -0400
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base
	Driver (dcdbas) with sysfs support
From: Michael E Brown <Michael_E_Brown@dell.com>
To: Greg KH <greg@kroah.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
       Douglas_Warzecha@dell.com, Matt_Domsch@dell.com
In-Reply-To: <20050816081622.GA22625@kroah.com>
References: <4277B1B44843BA48B0173B5B0A0DED4352817E@ausx3mps301.aus.amer.dell.com>
	 <DEFA2736-585A-4F84-9262-C3EB53E8E2A0@mac.com>
	 <1124161828.10755.87.camel@soltek.michaels-house.net>
	 <20050816081622.GA22625@kroah.com>
Content-Type: text/plain
Date: Tue, 16 Aug 2005 08:34:24 -0500
Message-Id: <1124199265.10755.310.camel@soltek.michaels-house.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-16 at 01:16 -0700, Greg KH wrote:
> On Mon, Aug 15, 2005 at 10:10:28PM -0500, Michael E Brown wrote:
> > To take a concrete example, I suggested to Doug to mention fan status. I
> > get the feeling that you possibly think that this would be better
> > integrated into lmsensors, or something like that.
> 
> Yes it should.  That way you get the benifit of all userspace
> applications that already use the lmsensors library without having to be
> rewritten in order to support your new library.

Little did I know when I first mentioned it how big of a mistake it
would be to mention the sensor functions. *sigh*

The dcdbas driver allows access to all of the Dell SMIs. Sensors are
only one instance of SMI code (only two functions, in fact, if I am
reading this spec correctly). The other (roughly) 58 functions have
nothing to do with sensors. The presence of the dcdbas driver would not
stop anybody from writing another driver to provide a hwmon interface to
just the sensors pieces. 

This isn't like a PCI device where there can be only one driver. With
the dcdbas driver in place, other drivers could also be written to
provide subsystem-specific interfaces to the same data, such as hwmon.
There isn't anything in dcdbas that would conflict with or lock out
anybody from creating another driver that provides access to the same
data.

> 
> > That really isn't the case, as lmsensors is really geared towards
> > bit-banging lm81 (for example) chips to get fan status.
> 
> Not true at all.  It is geared toward providing a common userspace
> interface for all sensor information in the system.  Now if it provides
> this in a good and easy to use way is another story...
> 
> But anyway, there is a standard way to export fan speed and temperature
> information from the kernel, the hwmon interface (see -mm for examples
> and documentation, and the i2c stuff in mainline today.)

I don't really know a bunch about lmsensors. I just downloaded it and
started poking around. I would have thought, though, that they would
provide an easy way to provide a userspace library method of extending
for new sensors. I suppose I was wrong here as I don't see such
functionality on first glance.

> 
> > In our case, we have a standardized BIOS interface to get this info,
> > and that standardized method involves SMI and not bit-banging
> > interfaces. Once this driver is accepted into the kernel, we can go
> > and add support in the _userspace_ lmsensors libs to poll fan and temp
> > using this driver.
> 
> No, export this data properly through sysfs like all other temperature
> and sensor data is.  Don't create a new one, no matter how much you
> would like to keep from changing kernel code in the future for new
> hardware.

This driver is not trying to create a new way to do sensor and monitor
data. This just happens to be a side effect of the main use case.

> 
> > For example, we already have at least one buggy implementation of this
> > exact stack in the kernel as the i8k driver. The i8k driver was reverse-
> > engineered and works, but it does not follow the spec at all, and so is
> > subject to major breakage if the BIOS changes. With dcdbase + libsmbios,
> > we can write this _correctly_, and in such a way that it follows the
> > spec and will not break on BIOS updates.
> 
> No, fix the i8k driver as you have access to the specs.  It was there
> first.

Ok.

> 
> > What you are asking us to do is just not feasible on many levels. First,
> > just from the number of functions we would have to implement. We would
> > have to implement about 60 new sysfs files, with at least 120 separate
> > functions for read/write.
> 
> No problem at all, we can create that with only 2 read/write functions.
> See the i2c code for details.

file/line#? I did a quick search and didn't see anything special.

My main point here is that each SMI call would require it's own kernel-
space parsing of parameter and return values, as each call has different
argument passing requirements.

> 
> > Each function would have to take into account the specific calling
> > requirements of that specific function.
> 
> Again, no different from any other sensor driver.

Again, this driver is not a sensor driver. 

> 
> > Then, we would have to implement all of the bugfixes and
> > platform-specific workarounds in the kernel for each of those
> > functions for each Dell platform.
> 
> Yup.
> 
> > Each time another function is added to BIOS, we would have to go out
> > and patch everybody's kernel to support the new function.
> 
> Yup.  I suggest you complain to the bios people about this horrible way
> to design hardware then :)

You have a smiley there, but you know very well that even the most well-
intentioned BIOS folk make errors in design or implementation from time
to time. Once it is in BIOS, there really isn't much choice but try to
work around it. 

> 
> > Besides the fact that this is just not a good design, there just isn't
> > the manpower to maintain all of these in the kernel along with the
> > requisite testing for each update, not to mention the lag between when
> > we have to submit something and when it would show up in a vendor
> > kernel.
> 
> And the lag for your userspace library would not be the same?

For some odd reason, our customers have less concerns with updating a
userspace library. 

Ok, here is a short list of the things you can do with the Dell SMI
implementation. Note that this is a rough categorization of functions.
As implemented, get and set are normally separate SMI calls, so for each
that says get/set or read/write, read that as two SMI calls.

I am in the process of writing detailed docs for these (at least the
ones I have docs for) in libsmbios and hope to be done in a few days.

1) Read/Write Non-Volatile Storage
	-- main use case for libsmbios. This lets us set all of the rest of the
BIOS F2 options that are settable. To rehash from an earlier email, BIOS
stores some options in CMOS, these are already available in libsmbios.
The rest of the options are stored in SMI, and in fact almost all the
new options being added are SMI-only, as CMOS has run out of room.
	-- There are roughly 300 different tokens (usually equivalent to a BIOS
F2 option, but not always). These are split between CMOS and SMI, but a
good percentage of these are SMI. 

2) Read/Write Battery/AC mode settings. Read system status. 
	-- Fans/Voltage. This interface is only used by laptops (currently used
by i8k driver).
	-- Systems status gives failing sensor count.

3) Dynamic system status:
	AC Available
	Lid Closed
	Battery Available
	Docked
	Main Battery Critical
	Main Battery Avail
	Aux. Battery Critical
	Aux. Battery Avail.
	SCSI Available
	Network Available
	Module bay contents (floppy, cd, ls120, etc)

4) Get/Set Boot Device Priority
	-- set system boot order (floppy, cd, hard drive, pxe, etc)

5) Get/Set BBS IPL/BCV priority
	-- more fine grained way to set boot priority. lets you choose which
add-in card gets to be C: drive.

6) Get display type
	-- laptops. gets display res + misc attributes

7) Get display resolution

8) Get/Set active display
	-- laptops: switch between crt/lcd

9) Get battery information

10) Get/set/verify user/user II/administrator passwords

11) Get/Set asset/service/property/eppid tags

12) Get/Set monitor refresh rate

13) Get slice type. (laptop expansion thingy, I suppose)

14) Onboard NIC status (laptops)

15) Get/Set onboard radio status
	-- turn on/off wifi antenna

16) Application Program Registration (your guess is as good as mine.)
17) User customization control (same)

18) Get Message information.
	--returns bios event information (english only) for stuff like overtemp

19) Get hard drive size (why? I don't know)

20) Get/Clear ECC memory single-bit error status

21) Get memory test support information.

22) Start/Stop memory test

23) Get memory test error information/ map error information

24) Get/set server boot device priority

25) Issue Read-only SBDS Command
	-- "Smart Battery Data Specification" -- whatever that is.

--
Michael

