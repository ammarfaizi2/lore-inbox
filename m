Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbUCOJSW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 04:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUCOJSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 04:18:22 -0500
Received: from mtagate7.de.ibm.com ([195.212.29.156]:28324 "EHLO
	mtagate7.de.ibm.com") by vger.kernel.org with ESMTP id S262448AbUCOJSS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 04:18:18 -0500
Subject: Re: [PATCH] s390 (8/10): zfcp fixes.
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF625BA2CA.1376AB85-ONC1256E58.002FCAD7-C1256E58.00331651@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 15 Mar 2004 10:18:00 +0100
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 15/03/2004 10:18:03
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Hi Greg,

> >  - Replace release function for device structures by kfree. Move struct
> >    device to the start of struct zfcp_port/zfcp_unit to make it work.
> Ick, ick, ick!
>
> Why?  Please do not do this, as it is not needed, and completly
> unnecessary.  The fact that you have to create a cast like:
>
> > +        unit->sysfs_device.release = (void (*)(struct device *))kfree;
>
> Should set off all kinds of "this is a something we should not be doing"
> warning flags.

As I first saw this my reaction was similar. But if you really think about
the problem at least I came to the conclusion that this is the simplest
solution to the problem. There is an alternative way to solve it but I
think its worse than the kfree trick.
What is the problem anyway? The zfcp scsi host adapter is a bit more
complicated than the standard scsi host adapater. You need to be able
to configure a SAN (ports and units). For this purpose new directories
are created in the sysfs directors of the ccw device, e.g.:

/sys/devices/css0/0.0.0012/0.0.d008: ccw device directory
  `- 0x5005076300cfa20a: port directory
    `- 0x5403000000000000: unit directory

It is these two new directories (= port and unit devices) which are causing
the problem. These additional devices have their own reference counting. We
want to be able to unload the zfcp module and this makes it impossible to
keep the release function for the port and unit device objects in the zfcp
module itself. As long as the release function might be called the
reference
count of the module need to be > 0. It is not in the control of the zfcp
module when the release function is called. This would make it necessary
to decrease the module counter in the release function. Since this could
be the last reference the module can then be unloaded while a cpu is still
executing code in the release function. Not good.
So we need an external release function, one that isn't part of the zfcp
module. This external release function is either a generic function for
all these objects or a dedicated release function for each of the
additional
device objects. A dedicated release function would mean to define a release
function somewhere in the kernel or another module just for the purpose of
freeing an object defined by the zfcp module. This is even more gross than
to use a generic release function. And the simplest release function is
kfree.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


