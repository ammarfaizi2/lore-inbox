Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265073AbTFRHfN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 03:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265075AbTFRHfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 03:35:13 -0400
Received: from fmr01.intel.com ([192.55.52.18]:60142 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S265073AbTFRHfF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 03:35:05 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780DD16A55@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'viro@parcelfarce.linux.theplanet.co.uk'" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Kevin P. Fleming'" <kpfleming@cox.net>,
       "'Alan Stern'" <stern@rowland.harvard.edu>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Russell King'" <rmk@arm.linux.org.uk>, "'Greg KH'" <greg@kroah.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Flaw in the driver-model implementation of attributes
Date: Wed, 18 Jun 2003 00:48:59 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: viro@parcelfarce.linux.theplanet.co.uk
> On Tue, Jun 17, 2003 at 08:44:50PM -0700, Perez-Gonzalez, Inaky wrote:
> 
> > Maybe this is going to kill my argument as an analogy, but think
> > about a C++ class hierarchy, where belonging to a class means
> > ...
> 
> But there is no inheritance here.  Block device and IDE disk are
> different objects and relation is not "A is B with <...>", it's
> "among other things, A happens to use B in a way <...>".

Well, the device is an IDE disk that is linked through an IDE 
controller that is linked through a PCI controller to the system bus. 

That IDE device presents an interface. The block layer just presents 
the common interface that all block devices present (and that IDE
and SCSI disks are able to provide) - there is no inheritance, but
the concept is the same.
 
> Moreover, there is no such thing as "physical device 
> of that block device". There might be many.  There 
> might be none.  IOW, we have a bunch of constructors 
> for class "block device" and some of them happen to have
> some kinds of physical devices among their arguments. 

[I happen not to know the block layer as well as you and many others 
do, so please correct me where I am wrong ...]

So what? _every_ block device will have some form of physical 
back-up that can be linked back into sysfs.

In cases like this, doesn't it make sense to have some 
/sys/devices/SOMETHING/ hierarchy for those  "logical" or "virtual" 
devices that back-up those block devices? 

You could even say that RAID and ramdisks -as used in the example 
above- would belong to /sys/devices/"virtual"/raid/ and 
...../ramdisks/; after all, you have to create those devices before
being able to attach them (last time I checked):

(using subdirs for each layer for clarity)

/sys/devices/"virtual"/raid/0
  attr1
  attr2     ...   sysfs specific attrs 
  block/    ... block layer specific attrs
    attr1
    attr2
    component1 -> /sys/devices/pci/FOO/block/part1  
    component1 -> /sys/devices/pci/BAR/block/part4  

(I would also love to see the block device node being dropped in 
the corresponding "block" directory, but that's another story).

And extrapolating even more, I'd expect to see something 
like this for the block devices that are part of a physical device 
(partitions, I mean):

/sys/blabla/pci/3.14159/ide0/0.0
  attr1
  attr2     ...   sysfs specific attrs 
  block/    ... block layer specific attrs
    attr1
    attr2  
    part0/  ... partition specific stuff
      attr1
      attr...
    part1/
      attr1
      attr2 ...
  ide/      ... ide layer specific attrs
    attr1
    attr2 

In the tree structure it makes sense, because each block
device, at the end is or a partition (and thus is embedded
in a "true" block device) or a true block device on a 1:1
relationship with a physical device.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
