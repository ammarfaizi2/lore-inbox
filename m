Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbTGAJQi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 05:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTGAJQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 05:16:38 -0400
Received: from mail.convergence.de ([212.84.236.4]:6039 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261688AbTGAJQc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 05:16:32 -0400
Message-ID: <3F0154BD.3040901@convergence.de>
Date: Tue, 01 Jul 2003 11:30:37 +0200
From: Holger Waechtler <holger@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
CC: Michael Hunold <hunold@convergence.de>,
       Johannes Stezenbach <js@convergence.de>
Subject: Re: Patch: replacing devfs_register(), please revert
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph, hi everybody else,

please understand this mail as pretty late reply to your message 
http://www.ussg.iu.edu/hypermail/linux/kernel/0304.3/1172.html. This 
Maybe I'm a bit harsh, but...

Christoph, by applying the API change you announced in this mail you 
significantly crippled the functionality of the devfs system. Since I 
was not able to find any replies or complains I hope I'm just too stupid 
to understand your deeper intentions. Please enlighten if that's true.

The first major problem is that you removed the option to pass a pointer 
for file->private_data. This is usually worked around by static device 
lookup tables (evil, they cost static memory, usually about 80% of this 
memory is never used, in the remaining cases you are limited to 
NUM_MAX_XXX_DEVICES) or device lists that are searched using the minor 
number (still not very elegant).

This issue is getting pretty awful if you compare the voodoo we have to 
do in dvbdev.c  where we have a pretty complex device file 
infrastructure with different devices using the same major number (for 
historical reasons, the roots of this API were once defined by Nokia). 
Compare the code path we have to go for a devfs-only system 
(CONFIG_DEVFS_ONLY is defined) compared to the else case for a classic 
major/minor based system (the #else case).

Take 
http://linuxtv.org/cgi-bin/cvsweb.cgi/dvb-kernel/linux/drivers/media/dvb/dvb-core/dvbdev.c?rev=1.22&content-type=text/x-cvsweb-markup 
as reference, the version in the kernel source tree is stripped down and 
does not contains the 'correct', plain, devfs-only code path.

Even when the info pointer was only used by a single driver in the 
kernel when you proposed the API castration (drivers/input/evdev.c): 
this one was right. The correct way would have been to replace the old 
static device tables with their NUM_MAX_XXX_DEVICES #defines and all 
device lists including the search and list maintenance code by a single 
devfs_register() call using the info pointer.

Even more serious is the fact that you removed the possibility to pass 
the file operation struct on a per device basis. This causes even more 
braindead and complex workaround code, see the above dvbdev.c link, 
especially the function dvb_device_open(). it's a nifty piece of code, 
isn't it? Easy to understand and maintain -- we're doing there nothing 
else then replacing the fops by the one fitting this device. Note: also 
this code is only required for the #else path.

As side effect you always have to use both register_chrdev() and 
devfs_mk_cdev() in a driver. Useless bloat and error prone.

The third limitation introduced by removing the possibility of automatic 
major/minor allocation, the DEVFS_FL_AUTO_DEVNUM flag.

This causes an artificial limit in new DVB driver revisions to only 4 
DVB adapters because of the limited number of available minor devices 
per major. (we need up to 64 minors per DVB adapter in complex settop 
box environments where we have multiple demultiplexers, MPEG decoders 
and conditional access devices per adapter). I suppose similiarly 
structured subsystems like the linux input subsystem will run in 
similiar troubles.

Well, we could work around this by allocating multiple major numbers for 
the DVB subsystem, but that's not really a alternative for a misdesigned 
API, right?
(FYI: using 2.4 kernels people reported using up to 6 DVB cards in a PC 
using devfs and still have room for e.g. USB DVB devices)

so please revert your changes, or even better -- implement something 
like this:

extern int devfs_mk_node (dev_t proposed_major_minor,
                           umode_t mode,
                           struct file_operations *fops,
                           void *private_data,
                           const char *fmt, ...);

extern void devfs_remove (const char *fmt, ...);

and adjust the semantic maybe that way: leading directories in <fmt> get 
created automatically and removed as soon they're empty. This 
refcounting is already implemented in the current devfs implementation.

Re-enable the (de_)alloc_devnum() functions. Call these when the user 
passes a special proposed_major_minor, e.g. 0xff/0xff.

You don't need any devfs_mk_dir() function anymore. Fix all drivers 
using static device tables and make them use the private_data pointer.

Doing it this way you could save ~60 lines of pretty evil workaround 
code in the DVB subsystem device registration, I suppose similiar 
numbers are valid for other drivers as soon you remove the static device 
tables and lists.


@Christoph: Sorry for the harsh tone, but your ignorance and arrogance 
caused about 6 men-weeks useless work and workarounds in the DVB 
subsystem code (many thanks to Michael for his patience with your 
person), we just don't have the menpower to work around your toy API 
changes just for fun. We have 3 support for 4 new types of DVB PCI and 
USB adapters in the pipeline, we support a few more frontends but these 
patches are now delayed since months. Please keep compabitlity with 
existing APIs in mind when you break things next time. Functions that 
get a different semantic should get a different name, if you remove 
functionality from an existing API please check twice if it might make 
sense to use it and better fix the drivers using this API if so. 
Whenever you really want to rewrite an existing subsystem then _rewrite_ 
it, don't change things in place but start writing new code with an 
independent API and then move over all old dependent systems to the new 
one. Don't remove the old subsystem as long it's still used unless 
you're willing to fix the arising problems.

end of rant,
many thanks for your patience,

Holger

