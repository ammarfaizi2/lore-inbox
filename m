Return-Path: <linux-kernel-owner+w=401wt.eu-S1754806AbXABLEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806AbXABLEW (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 06:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755181AbXABLEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 06:04:22 -0500
Received: from gate.crashing.org ([63.228.1.57]:55983 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754806AbXABLEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 06:04:21 -0500
In-Reply-To: <20070101.203043.112622209.davem@davemloft.net>
References: <445cb4c27a664491761ce4e219aa0960@kernel.crashing.org> <20070101.005714.35017753.davem@davemloft.net> <1167710760.6165.32.camel@localhost.localdomain> <20070101.203043.112622209.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <d4e6d795118aca69982b619e13590ef9@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, devel@laptop.org, dmk@flex.com,
       benh@kernel.crashing.org, wmb@firmworks.com, hch@infradead.org,
       jg@laptop.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Tue, 2 Jan 2007 12:03:10 +0100
To: David Miller <davem@davemloft.net>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It has proved a good idea in general as I can easily get an exact
>> device-tree dump from users by asking for a tarball of  
>> /proc/device-tree
>> and in some case, the data in there -is- binary (For example, the EDID
>> properties for monitors left by video drivers, or things like that).
>
> Yes and with openpromfs I can get the EDID too :-)
>
> root@sunset:/proc/openprom/pci@1f,700000/SUNW,XVR-100@3# cat edid
> 00ffffff.ffffff00.4dd9d000.67175700.2d0d0103.0e321f78.eacea9a3.574c9926 
> .19484cbd.ee80a940.81808140.01010101.01010101.0101734b.80a072b0.2a4080d 
> 0.1300ef35.1100001c.483f4030.62b03240.40c01300.ef351100.001e0000.00fd00 
> 37.411e5f14.000a2020.20202020.000000fc.0053444d.2d503233.32570a20.20200 
> 0af
> root@sunset:/proc/openprom/pci@1f,700000/SUNW,XVR-100@3#

And how do you know from this output that the property
didn't contain this stuff as a text string?

> I think there is high value in an OFW filesystem representation
> that gives you _EXACTLY_ what the OFW command line prompt does
> when you try to traverse the device tree from there, and that
> is what openpromfs tries to do.

I suppose you're referring to the OF .properties command,
it's trivial to get at the *actual property contents* from
the OF prompt too.

.properties is a OF _user interface_ command, it is a helper
thing to show the properties in a more easily human digestible
format.  The analogue in Linux would be a user land tool.

> If you want raw access, use a character device or a similar auxilliary
> access to the data items.  Another idea is to provide a seperate file
> operation (such as ioctl) on the OFW property files in order to fetch
> things raw and in binary.

If user space can get raw access to the data via a device
file, there shouldn't be a filesystem at all, just some
tool that interfaces to the device.  Since the data we're
representing is naturally tree-based though, a filesystem
is a much nicer solution than a character device with a
bunch of ioctls.

> When I get some binary data out of a procfs or sysfs file I feel like
> strangling somebody.

Right, let's encode PCI config space (all of it, not just the
few standard fields) into 256 files config-00, ..., config-ff.
Superb plan!

The fact is, if you get some data (a property value, or the
contents of config space), that you do not know what it means
or how it is structured even, there is no good way to represent
it other than passing it through as-is.  Or you can guess, and
guess wrong (sometimes at least).  Scripts parsing your output
will have to read all formats you produce and transform it back
into something usable -- they can *never* use it as-is, they
can't assume some property will always be text for example (be
text according to your heuristic, that is).  Oh, except the format
you chose cannot be transformed back at all.

Another example of that then: I'd like to _see_ the difference
between (as hex bytes) "61 62 63" and "61 62 63 00" -- if only
to find bugs in OF code, or whatever.  With the property_show()
thing in openpromfs, I can't tell (well maybe the first one
crashes on the strlen() call, if prop->val doesn't get an extra
0 tagged onto the end during creation, I didn't check).

> I'm grovelling around in a filesystem from the
> command line so that I can get some information as a user.  If you
> don't give me text I can't tell what the heck it is.

Sure, but you don't need the kernel to present it as text, use
some helper thing instead, that can use *much* better heuristics
(like .properties in OF actually does) to decide on matters.

> Simple system tools should not need to interpret binary data in
> order to provide access to simple structured data like this, that's
> just stupid.

The structure within a property is context-dependent, it isn't
simple at all (in general).  And the binary data doesn't need
interpretation, the text representation of it does though --
interpretation back to usable binary form.


Segher

