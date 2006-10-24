Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWJXCEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWJXCEI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 22:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbWJXCEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 22:04:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:55473 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030186AbWJXCEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 22:04:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QKZJWFk+npPFg+1pK5kDXiXKnVspDTwffXn4jdIxsYUzlOPWBqISDghTFCel+Ik+PO2QNjPuQven+w4/Ah9UYuVWwoSvzVPeEeNCX6Z9IZIMQAyJSoK/MnKx5hBsxUT4FZ61yoBx1njurpnliKUmvkC3+xH47oWOS+wy60GIRJs=
Message-ID: <41840b750610231904h775571b8l4a20cfa0a6202593@mail.gmail.com>
Date: Tue, 24 Oct 2006 04:04:01 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: Battery class driver.
Cc: linux-kernel@vger.kernel.org, olpc-dev@laptop.org, davidz@redhat.com,
       greg@kroah.com, mjg59@srcf.ucam.org, len.brown@intel.com,
       sfr@canb.auug.org.au, benh@kernel.crashing.org,
       linux-thinkpad@linux-thinkpad.org
In-Reply-To: <1161627633.19446.387.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1161627633.19446.387.camel@pmac.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 2006-10-23, David Woodhouse wrote:
> At git://git.infradead.org/battery-2.6.git there is an initial
> implementation of a battery class

Excellent. It's about time the messy, inconsistent /proc battery ABI
gets cleaned up.


> I think I probably want to make AC power a separate 'device' too, rather
> than an attribute of any given battery. And when there are multiple
> power supplies, there should be multiple such devices. So maybe it
> should be a 'power supply' class, not a battery class at all?

It should be seprate, and probably a different class since most
attributes don't make sense for AC.


> +static ssize_t battery_attribute_show_int(struct class_device *dev, char *buf, int attr)
> +{
> +        struct battery_classdev *battery_cdev = class_get_devdata(dev);
> +        ssize_t ret = 0;
> +	long value;

There's some tab-vs-space noise here and elsewhere.


> +static ssize_t battery_attribute_show_milli(struct class_device *dev, char *buf, int attr)
> +{
> +        struct battery_classdev *battery_cdev = class_get_devdata(dev);
> +        ssize_t ret = 0;
> +	long value;
> +
> +	ret = battery_cdev->query_long(battery_cdev, attr, &value);
> +	if (ret)
> +		return ret;
> +
> +	sprintf(buf, "%ld.%03ld\n", value/1000, value % 1000);
> +        ret = strlen(buf) + 1;
> +        return ret;
> +}

The sysfs spec (Documentation/hwmon/sysfs-interface) prescribes milli
as integer, not simulated floating point ("All sysfs values are fixed
point numbers"). Better follow that.


> +static ssize_t battery_attribute_show_status(struct class_device *dev, char *buf)
> +{
> +        struct battery_classdev *battery_cdev = class_get_devdata(dev);
> +        ssize_t ret = 0;
> +	unsigned long status;
> +
> +	status = battery_cdev->status(battery_cdev, ~BAT_STAT_AC);
> +	if (status & BAT_STAT_ERROR)
> +		return -EIO;
> +
> +	if (status & BAT_STAT_PRESENT)
> +		sprintf(buf, "present");
> +	else
> +		sprintf(buf, "absent");
> +
> +	if (status & BAT_STAT_LOW)
> +		strcat(buf, ",low");

I suggest a more sysfs-ish approach:

"present" attribute, containing 0 or 1.
"state" attribute, containing one of "charging","discharging" and "idle".
"low" attribute, containing 0 or 1.
Et cetera.


> +BATTERY_DEVICE_ATTR("temp1",TEMP1,milli);
> +BATTERY_DEVICE_ATTR("temp1_name",TEMP1_NAME,string);
> +BATTERY_DEVICE_ATTR("temp2",TEMP2,milli);
> +BATTERY_DEVICE_ATTR("temp2_name",TEMP2_NAME,string);
> +BATTERY_DEVICE_ATTR("voltage",VOLTAGE,milli);
> +BATTERY_DEVICE_ATTR("voltage_design",VOLTAGE_DESIGN,milli);
> +BATTERY_DEVICE_ATTR("current",CURRENT,milli);

The Smart Battery System spec
(http://www.sbs-forum.org/specs/sbdat110.pdf) defines two current
readouts: "Current()" for instantaneous value, and "AverageCurrent()"
for a one-minute rolling average.

On ThinkPads, the value reported by ACPI is actually AverageCurrent().
Both values can be read by accessing the embedded controller (the
tp_smapi out-of-tree driver does this). Both values are useful and can
differ considerably.

I suggest having both "current_now" and "current_avg", as done in tp_smapi.


> +BATTERY_DEVICE_ATTR("charge_rate",CHARGE_RATE,milli);

There's a terminology issue here. "Charge" is problematic for two reasons:
First, it's inaccurate: many batteries report not electric charge
(coulomb) but energy (watt-hour), and there are probably devices out
there that report only percent.
Second, it's confusing to have "charge" both as a quantity and as an action.

The SBS spec takes pain to always refer to "capacity" or "charge
capacity" as a generic term for energy or electric charge. I think
"capacity" is a reasonable generic term, and tp_smapi follows it.

For this attribute, I suggest using "rate_{now,avg}", and defining it
to use the same units as the capacity readouts.

In addition, there should be "power_{now,avg}" attributes which are
always in watts regardless of the capacity readouts. This does not
necessarily duplicate voltage * current_{now,avg}, because the
hardware may be able to perform accurate integration over time.


> +BATTERY_DEVICE_ATTR("charge_max",CHARGE_MAX,milli);

SBS uses "DesignCapacity()" and tp_smapi uses "design_capacity".
I suggest "capacity_design".


> +BATTERY_DEVICE_ATTR("charge_last",CHARGE_LAST,milli);

SBS uses "FullChargeCapacity()" and tp_smapi uses last_full_capacity.
I suggest "capacity_last_full".


> +BATTERY_DEVICE_ATTR("charge_low",CHARGE_LOW,milli);
> +BATTERY_DEVICE_ATTR("charge_warn",CHARGE_WARN,milli);
> +BATTERY_DEVICE_ATTR("charge_unit",CHARGE_UNITS,string);

s/charge/capacity/.
BTW, the SBS defines the possible capacity units (CAPACITY_MODE bit)
as mAh and 10mWh. I guess the latter should be normalized by drivers
to mWh where applicable.

> +BATTERY_DEVICE_ATTR("charge_percent",CHARGE_PCT,int);

Percent of what? SBS distinguishes between "RelativeStateOfCharge()"
(percent of last full capacity") and "AbsoluteStateOfCharge()"
(percent of design capacity).

I suggest defining it to be the former and calling it "capacity_percent".


> +BATTERY_DEVICE_ATTR("time_remaining",TIME_REMAINING,int);

Separate attributes are needed for "time to full charge" and
"remaining time to full discharge". They're completely different
things (and sysfs doesn't let you read the time and status
atomically).

SBS defines "RunTimeToEmpty()", "AverageTimeToEmpty()" and
"AverageTimeToFull()", which using my suggested convention would
become:

time_to_empty_now
time_to_empty_avg
time_to_full

I guess SBS considered charging rate to be stable enough not to bother
with average vs. instantaneous rates. However, with the OLPC hand/foot
crank in mind, maybe we should have the full set:

time_to_empty_now
time_to_empty_avg
time_to_full_now
time_to_full_avg


> +BATTERY_DEVICE_ATTR("type",TYPE,string);

What's this?


> +BATTERY_DEVICE_ATTR("oem_info",OEM_INFO,string);

Tthe ThinkPad embedded controller battery interface also provides a
"barcode" data, which is 13-character submodel identifer. Not sure if
it should get a separate attribute, or appended to "model". FWIW,
tp_smapi does the former.

There are also the following, defined in SBS and exposed by tp_smapi:
cycle_count
date_manufactured

And ThinkPads also have this non-SBS extension:
date_first_used

Do you intend to also encompass battery control commands?
See here for what ThinkPads can do:
http://thinkwiki.org/wiki/Tp_smapi#Battery_charge_control_features

  Shem
