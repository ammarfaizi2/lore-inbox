Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263316AbTC0RIH>; Thu, 27 Mar 2003 12:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263307AbTC0RHY>; Thu, 27 Mar 2003 12:07:24 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:12176 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S263308AbTC0RFt>; Thu, 27 Mar 2003 12:05:49 -0500
Date: Thu, 27 Mar 2003 12:16:38 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Jan Dittmer <j.dittmer@portrix.net>, azarah@gentoo.org, greg@kroah.com,
       mds@paradyne.com, linux-kernel@vger.kernel.org, linux@brodo.de,
       sensors@Stimpy.netroedge.com
Subject: Re: lm sensors sysfs file structure
Message-ID: <20030327171638.GA23888@earth.solarsys.private>
Mail-Followup-To: Jean Delvare <khali@linux-fr.org>,
	Jan Dittmer <j.dittmer@portrix.net>, azarah@gentoo.org,
	greg@kroah.com, mds@paradyne.com, linux-kernel@vger.kernel.org,
	linux@brodo.de, sensors@Stimpy.netroedge.com
References: <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com> <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com> <3E82D678.9000807@portrix.net> <1048762244.4773.1258.camel@workshop.saharact.lan> <3E82EE25.3070308@portrix.net> <1048768432.4774.1263.camel@workshop.saharact.lan> <3E82F736.2000704@portrix.net> <20030327143140.0428fcd7.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030327143140.0428fcd7.khali@linux-fr.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2003-03-27 14:31:40 +0100]:
> > Ah, and I don't want to do small corrections like 1 or 2 percent up or
> > or down, but things like this for lm80:
> >      compute in0 (24/14.7 + 1) * @ ,       @ / (24/14.7 + 1)
> >      compute in2 (22.1/30 + 1) * @ ,       @ / (22.1/30 + 1)
> >      compute in3 (2.8/1.9) * @,            @ * 1.9/2.8
> >      compute in4 (160/30.1 + 1) * @,       @ / (160/30.1 + 1)
> > 
> > These differ a lot. And as stated in the sensors.conf seem to be from 
> > the datasheet of the lm80 and not mainboard specific.
> 
> They may be mainboard specific. The formulae rely on *suggested*
> resistor values, which the integrators may or may not follow. There
> definitely is a need for userspace conversion. Libsensors needs to be
> tunable by the user.
> 
> I don't know about the kernel conversion Jan is talking about (never
> coded a sensor driver myself), so I can't talk about this half, but I'm
> pretty sure you shouldn't even think of moving all conversions into
> kernel space.
> 
> Mark, Phil, maybe you could explain the reasons better than I would?

I'm not the Mark to which Jean refers, but anyway...  he is correct.
The sensor chip cannot read temperatures directly, only voltage.  The
conversion from degress C to V is dependent on the mainboard for the
reasons Jean mentions.

But also, the chip driver cannot read voltage directly, only bits in a
register.  *That* conversion is *not* mainboard dependent; it is
sensor chip specific.

Even when the subject in question is voltage (e.g. power supply +12V),
there is mainboard dependent nonsense between the "real value" and what
is presented at the pin of the sensor chip.

So there is a legitimate need for two conversions.  IMHO, the 
mainboard dependent one *must* be done in userspace (as Jean says).
But the conversion of raw register values to volts should happen in
the kernel; fixed point maths are sufficient for that.

(Yes I'm simplifying; external sensors can present data to sensors
chips in other electrical formats, e.g. PWM.  Same argument applies.)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

