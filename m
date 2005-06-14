Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVFNHdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVFNHdB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 03:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVFNHdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 03:33:01 -0400
Received: from ns1.suse.de ([195.135.220.2]:7625 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261305AbVFNHcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 03:32:52 -0400
Message-ID: <42AE8820.2010102@suse.de>
Date: Tue, 14 Jun 2005 09:32:48 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>, Greg KH <gregkh@suse.de>,
       Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Input sysbsystema and hotplug
References: <200506131607.51736.dtor_core@ameritech.net> <20050613212654.GB11182@vrfy.org> <200506131658.37583.dtor_core@ameritech.net> <200506131705.30159.dtor_core@ameritech.net>
In-Reply-To: <200506131705.30159.dtor_core@ameritech.net>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Monday 13 June 2005 16:58, Dmitry Torokhov wrote:
>>On Monday 13 June 2005 16:26, Kay Sievers wrote:
>>>On Mon, Jun 13, 2005 at 04:07:51PM -0500, Dmitry Torokhov wrote:
>>>>I am trying to convert input systsem to play nicely with sysfs and I am
>>>>having trouble with hotplug agent. The old hotplug mechanism was using
>>>>"input" as agent/subsystem name, unfortunately I can't simply use "input"
>>>>class because when Greg added class_simple support to input handlers
>>>>(evdev, mousedev, joydev, etc) he used that name. So currently stock
>>>>kernel gets 2 types of hotplug events (from input core and from input
>>>>handlers) with completely different arguments processed by the same
>>>>input agent.
>>>>
>>>>So I guess my question is: is there anyone who uses hotplug events
>>>>for input interface devices (as in mouseX, eventX) as opposed to
>>>>parent input devices (inputX).
>>>Hmm, udev uses it. But, who needs device nodes. :)
>>>
>>Oh, OK. Damn, Andrew will hate us for breaking mouse support yet again :(
>>because there are people (like me) relying on hotplug to load input handlers.
>>First time I booted by new input hotplug kernel I lost my mouse.
>>
>>I wonder should we hack something allowing overriding subsystem name
>>so we could keep the same hotplug agent? Or should we bite teh bullet and
>>change it?
>>
> 
> Any chance we could quickly agree on a new name for hander devices (other
> than "input") and roll out updated udev before the changes get into the
> kernel? For some reason it feels like udev is mmuch quicker moving than
> hotplug...
> 
My original patch used 'input_device' for it.
Would be nice if it could stay.
This way we have the following event sequence:

input_device event (contains all attributes like 'abs', 'ev' etc.)
-> triggers loading of any input modules
   -> creates the proper input devices
input event (contains the 'dev' attribute for udev)

As the main point of the original 'input' event is in fact the device
node creation (we only have max 4 input modules, which isn't that hard
to figure out), I'd vote for keeping the name 'input' for the device
event and use a new event type 'input_device' for the class device.

And yes, we should break compability and come up with a clean
implementation. And as the original input event is an abomination I
don't see the point in keeping compability with a broken interface.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
