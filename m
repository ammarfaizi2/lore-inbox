Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265937AbTLIOvT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 09:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265935AbTLIOvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 09:51:19 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:11539 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265937AbTLIOus
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 09:50:48 -0500
Message-ID: <3FD5E3B4.8060405@aitel.hist.no>
Date: Tue, 09 Dec 2003 16:01:08 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Maciej Zenczykowski <maze@cela.pl>
CC: Xavier Bestel <xavier.bestel@free.fr>, Greg KH <greg@kroah.com>,
       Witukind <witukind@nsbm.kicks-ass.org>, recbo@nishanet.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
References: <Pine.LNX.4.44.0312091358210.21314-100000@gaia.cela.pl>
In-Reply-To: <Pine.LNX.4.44.0312091358210.21314-100000@gaia.cela.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Zenczykowski wrote:
>>>>Am I wrong ?
> 
> 
>>>No, you are correct.  That's why I'm not really worried about this, and
>>>I don't think anyone else should be either.
> 
> 
> You are of course totally wrong - just because a device is present in the 
> system doesn't mean that it's kernel modules are loaded - for example my 
> floppy is always present in the system, but I access it like once a month 
> or so - currently devfs (which I'm using on 3 computers with no problems 
> for over a year now) will load the floppy module on access to /dev/fd0 and 
> the module will unload automatically a few dozen minutes later after I'm 
> done with the disk drive. On an 8 MB mem system keeping 60KB floppy 
> driver non-stop in unswappable kernel memory is wastefull.  Especially 
> since this also applies to microcode, sound drivers, scanners, rtc, etc...  
> The system is properly configured - the modules for devices are loaded 
> when needed - just because a device is present doesn't mean we need to 
> have the driver loaded for it.

Sure, the driver doesn't need to be present all the time.  If you
want to use it occationally you need some kind of "trigger" to
demand-load it.

With devfs, this trigger mechanism is devfs+devfsd and its configuration.
Devfs will notice that you're opening a nonexistant node, tell
devfsd do do something, devfsd will see that you have specified module
loading, do that, and then the suddenly present node is loaded.


The approach without devfs is to have the device node present
wheter or not the device is there. (i.e. /dev on ext2)
You don't need a /dev full of all the nodes makedev creates, but
you need nodes for devices you actually have. Set up udev
so it don't delete nodes (or at least not the floppy node) when
the driver go away.  You now have a permanent floppy device.
Trying to access it when it isn't there will cause the kernel
itself to run modprobe, if you configured "automatic module loading".

So, you can demand-load devices without devfs, you just need the
device node. It wastes little disk space and no memory (unless
you put your udev-managed /dev in tmpfs.  But then the memory
loss is quite small and the disk loss nonexistant.)

You can probably have udev help you set up the device nodes,
configure so nodes aren't deleted and load all your modules.
udev populates /dev and that job is done.

Compare to the devfs approach:
It too uses memory (for devfs and devfsd, as well as disk space
for devfsd.conf.  And there is one disadvantage, a program
cannot look in /dev to see what devices you have when the module
isn't loaded.  A program looking for floppy or sound devices
won't find any with devfs+modules, but will find the device
if you're using udev+modules.  And then the driver will load
when opened.

Helge Hafting










