Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262582AbTCZWRG>; Wed, 26 Mar 2003 17:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262577AbTCZWRG>; Wed, 26 Mar 2003 17:17:06 -0500
Received: from services.paradyne.com ([135.90.22.16]:51877 "EHLO
	pigeon.is.paradyne.com") by vger.kernel.org with ESMTP
	id <S262559AbTCZWQ6>; Wed, 26 Mar 2003 17:16:58 -0500
Message-ID: <3E82292E.536D9196@paradyne.com>
Date: Wed, 26 Mar 2003 17:26:54 -0500
From: "Mark Studebaker" <mds@paradyne.com>
Organization: Paradyne Corporation
X-Mailer: Mozilla 4.7 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Jan Dittmer <j.dittmer@portrix.net>, azarah@gentoo.org,
       KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>,
       sensors@Stimpy.netroedge.com
Subject: Re: w83781d i2c driver updated for 2.5.66 (without sysfs support)
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you rename the files and/or split multivalue files into separate
single value files, or change the format of the contents,
and continue these changes across the 30 or so "chip" drivers of ours,
you will completely blow up our libsensors library, and userspace programs.

If all the patches do is move all the files unchanged from
/proc/sys/dev/sensors/... to /sysfs/... then that change is much much easier
to incorporate in our programs.

While not all drivers conform perfectly to the our standard (link below)
(lm75 temp_os and temp_hyst don't), this is the naming and
data format standard we attempt to follow. This has evolved
over the years. If the chip drivers in the kernel
diverge from this, or even worse diverge from each other haphazardly,
we're going to end up with a mess and no usable userspace tools
for a long long time. 

Please consider keeping the file names and contents unchanged.

thanks
mds

------------


lm_sensors /proc naming standars for sensors chip drivers:

http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/developers/proc



Greg KH wrote:
> 
> On Wed, Mar 26, 2003 at 08:40:58PM +0100, Jan Dittmer wrote:
> > Martin Schlemmer wrote:
> > >
> > >I did look at the changes needed for sysfs, but this beast have
> > >about 6 ctl_tables, and is hairy in general.  I am not sure what
> > >is the best way to do it for the different chips, so here is what
> > >I have until I or somebody else can do the sysfs stuff.
> > >
> > I've just done this with the via686a driver. Saves about 100 lines of code.
> >
> > Comments?
> 
> <snip>
> 
> > +/* following are the sysfs callback functions */
> > +static ssize_t show_in(struct device *dev, char *buf, int nr) {
> > +     struct i2c_client *client = to_i2c_client(dev);
> > +     struct via686a_data *data = i2c_get_clientdata(client);
> > +     via686a_update_client(client);
> > +
> > +     return sprintf(buf,"%ld %ld %ld\n",
> > +             IN_FROM_REG(data->in_min[nr], nr),
> > +             IN_FROM_REG(data->in_max[nr], nr),
> > +             IN_FROM_REG(data->in[nr], nr) );
> > +}
> 
> We should really split these multivalue files up into individual files,
> as sysfs is for single value files.  Makes parsing easier too.
> 
> Here's a patch for the lm75.c driver that does this.
