Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262605AbTCZWmT>; Wed, 26 Mar 2003 17:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262606AbTCZWmT>; Wed, 26 Mar 2003 17:42:19 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:25862 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262605AbTCZWmP>;
	Wed, 26 Mar 2003 17:42:15 -0500
Date: Wed, 26 Mar 2003 14:52:34 -0800
From: Greg KH <greg@kroah.com>
To: Mark Studebaker <mds@paradyne.com>
Cc: Jan Dittmer <j.dittmer@portrix.net>, azarah@gentoo.org,
       KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>,
       sensors@Stimpy.netroedge.com
Subject: lm sensors sysfs file structure
Message-ID: <20030326225234.GA27436@kroah.com>
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com> <3E82292E.536D9196@paradyne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E82292E.536D9196@paradyne.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject changed to reflect change in topic, and to call attention to
others who might be interested.

On Wed, Mar 26, 2003 at 05:26:54PM -0500, Mark Studebaker wrote:
> If you rename the files and/or split multivalue files into separate
> single value files, or change the format of the contents,
> and continue these changes across the 30 or so "chip" drivers of ours,
> you will completely blow up our libsensors library, and userspace programs.

Well ideally libsensors can change and then userspace programs will
never know the difference :)

I need to start digging into the libsensors code to be able to back this
up, but at first glance I think it's feasible.

> If all the patches do is move all the files unchanged from
> /proc/sys/dev/sensors/... to /sysfs/... then that change is much much easier
> to incorporate in our programs.

True, but multi-valued files are not allowed in sysfs.  It's especially
obnoxious that you have 3 value files when you read them, but only
expect 2 values for writing.  The way I split up the values in the
lm75.c driver shows a user exactly which values are writable, and
enforces this on the file system level.

I don't want to detract from all of the work you, and the lm_sensors
group has done in the past, it's quite nice.  I'm just trying to fit the
drivers into current kernel policies in the best way possible.
Remember, I want this to work, and for everyone to come to an
understanding.

> lm_sensors /proc naming standars for sensors chip drivers:
> 
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/developers/proc

Thanks for the link.  I don't really think this is a problem.  As an
example, the temp files, which are currently defined as a proc file with
this description:

Entry	Values	Function
-----	------	--------
temp,
temp[1-3]  3	Temperature max, min or hysteresis, and input value.
	       	Floating point values XXX.X or XXX.XX in degrees Celcius.
		'temp' is used if there is only one temperature sensor on the
		chip; for multiple temps. start with 'temp1'.
		Temp1 is generally the sensor inside the chip itself,
		generally reported as "motherboard temperature".
		Temp2 and temp3 are generally sensors external to the chip
		itself, for example the thermal diode inside the CPU or a
		termistor nearby. The second value is preferably a hysteresis
		value, reported as a absolute temperature, NOT a delta from
		the max value.
		First two values are read/write and third is read only.

Could be rewritten to say:

Entry		Function
-----		--------
temp_max[1-3]	Temperature max value.
		Fixed point value in form XXXXX and should be divided by
		100 to get degrees Celsius.
		Read/Write value.

temp_min[1-3]	Temperature min or hysteresis value.
		Fixed point value in form XXXXX and should be divided by
		100 to get degrees Celsius.  This is preferably a
		hysteresis value, reported as a absolute temperature, NOT
		a delta from the max value.
		Read/Write value.

temp_input[1-3]	Temperature input value.
		Read only value.

		If there are multiple temperature sensors, temp_*1 is
		generally the sensor inside the chip itself, generally
		reported as "motherboard temperature".  temp_*2 and
		temp_*3 are generally sensors external to the chip
		itself, for example the thermal diode inside the CPU or a
		thermistor nearby.

That would give us one value per file, use no floating point in the
kernel (fake or not) and generally make things a whole lot more orderly.
Also, if a sensor does not have a max value (for example, I don't really
know if this is true), instead of having to fake a value, it can just
not create the file.  Then userspace can easily detect this is not
supported, and is not a placeholder value.

Does that sound reasonable?

thanks,

greg k-h

