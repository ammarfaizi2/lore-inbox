Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267425AbUHSVdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267425AbUHSVdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 17:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267428AbUHSVdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 17:33:12 -0400
Received: from cantor.suse.de ([195.135.220.2]:398 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267425AbUHSVdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 17:33:04 -0400
Date: Thu, 19 Aug 2004 23:28:24 +0200
From: Olaf Hering <olh@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Hollis Blanchard <hollisb@us.ibm.com>, Dave Boutcher <boutcher@us.ibm.com>,
       linuxppc64-dev@lists.linuxppc.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: module.viomap support for ppc64
Message-ID: <20040819212824.GA13204@suse.de>
References: <20040812173751.GA30564@suse.de> <1092339278.19137.8.camel@localhost> <1092354195.25196.11.camel@bach> <20040813094040.GA1769@suse.de> <1092404570.29604.5.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1092404570.29604.5.camel@bach>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Aug 13, Rusty Russell wrote:

> On Fri, 2004-08-13 at 19:40, Olaf Hering wrote:
> >  On Fri, Aug 13, Rusty Russell wrote:
> > 
> > > 2) Please modify scripts/mod/file2alias.c in the kernel source, not the
> > > module tools.  The modules.XXXmap files are deprecated: device tables
> > > are supposed to be converted to aliases in the build process, and that
> > > is how userspace tools like hotplug are to find them.
> > 
> > I found no user of the modules.alias file. Hotplug still uses the map
> > files. Parsing one big file will not improve performance, but thats a
> > different story.
> 
> You don't use the modules.alias file.  You simply "modprobe vio:xyz^abc"
> and modprobe reads modules.alias if necessary (the user can also insert
> aliases in the modprobe.conf file, for example).  Note that fnmatch is
> used, so you can actually use ? and * in your generated aliases.

But that complicates the parser. Current the hotplug agent script reads
the simple modules.foomap and generates a list of possible drivers. Then
it looks into the blacklist file to see if one of the possible modules
should not be loaded, and skips this module.
Is there such functionality for the modules.alias file in
module-init-tools? I played around with modprobe -n, but could not
figure it out. Unfortunately, some hardware has more than one driver.
bcm5700/tg3, eepro100/e100 and maybe more.


#!/bin/bash

cd /sys/bus/pci/devices || exit 1
for i in *
do
test -d $i || continue
read pci_class            < $i/class
read pci_vendor           < $i/vendor
read pci_device           < $i/device
read pci_subsystem_vendor < $i/subsystem_vendor
read pci_subsystem_device < $i/subsystem_device
pci_baseclass=$((($pci_class >> 16) & 0xff))
pci_subclass=$((($pci_class >> 8) & 0xff))
pci_interface=$(($pci_class & 0xff))
pci_alias=`printf 'pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02X' ${pci_vendor} ${pci_device} ${pci_subsystem_vendor} ${pci_subsystem_device} ${pci_baseclass} ${pci_subclass} ${pci_interface}`
echo $i # $pci_alias
/sbin/modprobe -nvva $pci_alias
done

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
