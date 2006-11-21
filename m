Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031272AbWKUSa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031272AbWKUSa0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 13:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031274AbWKUSaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 13:30:25 -0500
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:41048 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1031272AbWKUSaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 13:30:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=sbcglobal.net;
  h=Received:X-YMail-OSG:Message-ID:Date:From:Reply-To:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=rkT1BUGRH1JfOB0AI1/7xiYwkV/IZ3dfsa32uNabypRXaX2OrGlLilvaREh4uFHL1xR8X3t9AuIZ3v1gxa97+7lo4JbB71hDSPlncwQkC6F1IFMlZGj/jn2prdU8PPsCZidmLcIjROIkr+Ut1GW2N0fQ44XaqruwyuS0YCUIWh4=  ;
X-YMail-OSG: se97SRkVM1n1YzpOt7OOSh9inLSCBE9YeW1F7PaMjojIeFFnhiiHQyKLZHSVQP.Yi9ED.kf4H3V8KC5QEmI7_AQogJ6H.xQN7kGT76dfh0F7vfHy8.ZYcw--
Message-ID: <4563457B.2070806@sbcglobal.net>
Date: Tue, 21 Nov 2006 12:29:15 -0600
From: Matthew Frost <artusemrys@sbcglobal.net>
Reply-To: artusemrys@sbcglobal.net
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Paul Sokolovsky <pmiscml@gmail.com>, Jiri Slaby <jirislaby@gmail.com>,
       linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: Where did find_bus() go in 2.6.18?
References: <1154868495.20061120003437@gmail.com>	 <4560ECAF.1030901@gmail.com>  <664994303.20061120021314@gmail.com> <1164011675.31358.566.camel@laptopd505.fenrus.org>
In-Reply-To: <1164011675.31358.566.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Mon, 2006-11-20 at 02:13 +0200, Paul Sokolovsky wrote:
>> Hello Jiri,
>>
>> Monday, November 20, 2006, 1:45:51 AM, you wrote:
>>
>>> Paul Sokolovsky wrote:
>>>>   But alas, the commit message is not as good as some others are, and
>>>> doesn't mention what should be used instead. So, if find_bus() is
>>>> "unused", what should be used instead?
>>> You should probably mention what for?
>>   Indeed, I'm sorry! Looking at find_bus()'s docstring:
>>
>> /**
>>  *      find_bus - locate bus by name.
>>  *      @name:  name of bus.
>>
>>  So well, I'd like to know exactly that - what function should be
>> used instead of find_bus() to locate bus by name.
> 
> I think the question more was "what do you need to look up a bus by name
> for in the kernel"? Like.. what are you trying to achieve? What module
> is this for? (does it have a homepage where people can download the
> source etc so that they can give you a more informed answer)....
> 
> 
Arjan has a great point, and it's been mentioned elsewhere in this thread, too.
 Maybe I can help get us there.  Since you've already started to explain
(ignoring your non-sequitur on the development process):

----
  Ok, so the situation is following: we have a kind of multi-layered
driver here. Lowest level is a w1_slave bus driver, talking to a
specific chip and providing low-level API for accessing data in terms
of this chip (or chip class) notions. Above it, we have higher-level
driver which interprets data from the low-level one, converting it to
a standard device-independent form, plus possibly does some other
minor things, like providing feedback indication on these data.
(Forgot to say that this is battery driver.)

  So, just in case if some reader of this has quick suggestion of
merging these drivers into one, thanks, but they do different things,
and we want to keep them nicely decoupled. But now issue of how these
drivers talk between themselves raises, and that's exactly the grief
point.

  High-level driver used to find w1 bus by name, then enumerate
devices on the bus, to find compatible device on it, then hooks into
that device and its driver.

  So, you see the issue: we cannot enumerate devices on w1 bus. (And
yes, w1_bus_type is not exported).

  Sure, the source is up:
http://handhelds.org/cgi-bin/cvsweb.cgi/linux/kernel26/drivers/misc/h2200_battery.c?rev=1.20&content-type=text/x-cvsweb-markup
----

So you have nested drivers.  The bottom driver (w1/slaves/w1_ds2760.c) talks to
the hardware, and the top driver (misc/h2200_battery.c) interprets the output.
You're dealing with a Dallas 1-Wire Bus protocol to talk to your battery
management chip, which is a DS2760 High-Precision Li+ Battery Monitor.  You're
telling us that h2200_battery uses find_bus() to locate the w1 bus and then the
devices on that bus, so that it can use w1_ds2760 to read the chip.  So what is
hanging you up here is that your top-level driver can't find the bus that the
chip is on; once it can, everything should work?

The specific code:

void
h2200_battery_probe_work(void *data)
{
	struct bus_type *bus;

	/* Get the battery w1 slave device. */
	bus = find_bus("w1");
	if (bus)
		ds2760_dev = bus_find_device(bus, NULL, NULL,
					     h2200_battery_match_callback);

	if (!ds2760_dev) {
		/* No DS2760 device found; try again later. */
		queue_delayed_work(probe_q, &probe_work, HZ * 5);
		return;
	}
}

What we need to do is help you find a better way to locate and identify a w1 device.

(cc: E. Polyakov for the w1 expertise)

Matt
