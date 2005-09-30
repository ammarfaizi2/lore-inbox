Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbVI3Fcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVI3Fcy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 01:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVI3Fcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 01:32:54 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:52053 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932370AbVI3Fcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 01:32:53 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] nesting class_device in sysfs to solve world peace
Date: Fri, 30 Sep 2005 00:32:49 -0500
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
References: <20050928233114.GA27227@suse.de>
In-Reply-To: <20050928233114.GA27227@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509300032.50408.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 September 2005 18:31, Greg KH wrote:
> Alright, here's a patch that will add the ability to nest struct
> class_device structures in sysfs.  This should give everyone the ability
> to model what they need to in the class directory (input, video, etc.).
> 
> Dmitry, care to update your input patchset to take advantage of this?
> It should work out for what you want to do, and if not, please let me
> know.
> 
> udev will have to be changed to properly support this, but I think that
> Kay already has that taken care of, and is just waiting for some kernel
> code to take advantage of this.
> 
> Comments?
> 

Hi Greg,

I still do not believe it is the solution we want:

1. It does not allow installing separate hotplug handlers for devices
   and their sub-devices. This will cause hotplug handlers to resort to
   having some flags or otherwise detect the king of class device hotplug
   hanlder is being called for and change behavior accordingly - YUCK!

2. It does not allow user/program to scan for devices of given subclass.
   I understand that you want to tech udev about all existing handlers
   and having hotplug events allows to filter out unneeded names but for
   other programs I do not think we want to do that. Again, consider task
   of wanting to know all input interfaces, ot all available partiotions
   in a system. Do not say that the program has to know that there are hdX
   and sdX and ubX and adopt every time new type of device comes along
   since you would need to determine whether the name you see is an
   ordinary attribute or attribute group or the subdevice you are interested
   in. You can't really rely on presence of 'dev' attribute since subdevice
   does not have to have it. A better way would be to do
   "ls /sys/class/block/partitions/" or "ls /sys/class/input/interfaces"
   and get all this information.

3. It does not work well when you have an object that in your model is a
   logical subdevice but does not have a parent (or has multiple parents).
   Consider 'mice' multiplexor. Where would you put it? Together with
   inputX? But it is not an input_dev, it should not be there.

4. subdevice should have only one parent, your implementation allows to
   link subdevice to a class device and a real device at the same time,
   which IMHO is wrong. Only top-level class devices should be linked with
   physical /sys/devices/ device. 

I firmly believe that creating sub-classes (which solves hotplug issues)
and linking sub-class devices to their parent via 'device' link, much like
we link top-level class device to their physical parent devices (which
solves 2, 3 and 4) is much cleanier way. It provides everything that your
implementation does plus allows different views useful for other tasks
besides udev.

-- 
Dmitry
