Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316598AbSFPWCr>; Sun, 16 Jun 2002 18:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316599AbSFPWCq>; Sun, 16 Jun 2002 18:02:46 -0400
Received: from host194.steeleye.com ([216.33.1.194]:27401 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S316598AbSFPWCo>; Sun, 16 Jun 2002 18:02:44 -0400
Message-Id: <200206162202.g5GM2XT02750@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Oliver Neukum <oliver@neukum.name>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       David Brownell <david-b@pacbell.net>, Andries.Brouwer@cwi.nl,
       garloff@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, sancho@dauskardt.de,
       linux-usb-devel@lists.sourceforge.net,
       linux1394-devel@lists.sourceforge.net, dougg@torque.net
Subject: Re: [linux-usb-devel] Re: /proc/scsi/map 
In-Reply-To: Message from Oliver Neukum <oliver@neukum.name> 
   of "Sun, 16 Jun 2002 22:54:42 +0200." <200206162254.42323.oliver@neukum.name> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 16 Jun 2002 17:02:33 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oliver@neukum.name said:
> How would you find out what a device is ? If the kernel has to supply
> the information anyway, you could just as well pass all information to
> the script or devfs. 

But the kernel doesn't know this globally unique identifier information today, 
that's what the discussion is about.

The essence of the problem is that there's no one method that can get a unique 
identifier for every SCSI device (even though almost every device possesses 
one in one form or another).  So you have to implement a collection of ad hoc 
methods depending on what the device actually is.

The idea behind using hotplug to solve the problem is that with scsimon, a 
hotplug insertion event is generated for every SCSI device as it is added.  
The script is provided with the information the kernel knows (host, channel, 
pun lun, model and vendor inquiry strings---see www.torque.net/scsimon.html 
for details).  The hotplug script then does the remaining processing to 
extract the ID from the device (by ioctls, sending down SCSI commands etc.) 
and then binds it into the /dev/volume nodes using the identifier it 
determines.

The result is that however you move the device around (between controllers or 
even change its id), it will always show up as its unique /dev/volume name.

The key philosophy is that the code to make the policy decision for assigning 
a unique name isn't cluttering up the kernel, it's in user land where it can 
be easily customised.  Once scsimon is part of the kernel, we need no other 
kernel changes at all to implement this, since /dev/volume could just be done 
with symbolic links (although having the kernel know the name is useful).

James


