Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264495AbTEPQy2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 12:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264496AbTEPQy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 12:54:28 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:30093 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S264495AbTEPQy0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 12:54:26 -0400
Date: Fri, 16 May 2003 19:07:05 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, Greg KH <greg@kroah.com>,
       jt@hpl.hp.com, Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030516170705.GA18732@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030515200324.GB12949@ranty.ddts.net> <20030516151352.D626@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030516151352.D626@nightmaster.csn.tu-chemnitz.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 03:13:52PM +0200, Ingo Oeser wrote:
> Hi all,
> 
> On Thu, May 15, 2003 at 10:03:24PM +0200, Manuel Estrada Sainz wrote:
> > 	
> > 	- echo 1 > /sysfs/class/firmware/dev_name/loading
> > 	- cat whatever_fw > /sysfs/class/firmware/dev_name/data
> > 	- echo 0 > /sysfs/class/firmware/dev_name/loading
>  
> Why not doing that in open and require firmware data to contain
> size information? Good firmware formats contain already size,
> checksum and version information.

 The reason for such an interface is to be able to do it on top of sysfs
 and so that drivers can implement the same interface on themselfs.

 They just need to export the device's firmware memory as 'data' via a
 class_device of class firmware_class.

 They also need to know when the load starts to set it up and when the
 load finishes to get the device going again with the new firmware, for
 that is 'loading' when they get a '1' they have to get ready for the
 load and when they get a '0' they have to get the device back working.

 Doing that, they would get the hotplug event and compatible hotplug
 support for free. Coping the firmware image in the appropriate
 directory would be the only userspace setup needed.

 Feedback on the interface (data/loading) would also be welcomed, I am
 probably biased by the hardware I have at hand.

 It is currently not possible, but the interface means to allow it.

> Bad firmware can be wrapped to get these. It should be made a
> requirement to contain at least a size and a checksum.

 That could be done, but I am not sure the complexity is worth it. If a
 privileged user wants to shoot on his foot, he can do so may other
 ways already.

> To handle the big varieties of firmware formats, I would suggest
> to either wrap all in user space or define 3 functions per
> firmware format like the seq_file support. The thing is very
> similiar, except that we read from user space instead of writing.
> 
> fw_begin_firmware_store()
> fw_next_firmware_bytes()
> fw_end_firmware_store()
> 
> fw_begin_firmware_store() gets at most a page of data and should
>    evaluate from this data, how much bytes it still needs from
>    user space. It will also setup a context and store it.
> 
> fw_next_firmware_bytes() will get passed more firmware bytes and
>    tells us again how much it still need. It will get passed the
>    context setup by fw_begin_firmware_store(). 
>    
>    This function can also abort a download by returning "no bytes
>    needed anymore" and marking the firmware "invalid" in the
>    context, which fw_end_firmware_store() will use to return
>    "discard this firmware" to the firmware fs.
> 
>    Also this function is not really necessary, if we set the
>    filesize of the firmware (truncate()) in firmware fs after
>    fw_begin_firmware_store() and let the VFS do its magic.
> 
> fw_end_firmware_store() will be called, after user space closed
>    the file descriptor (Note: This will handle SIGKILL also). It
>    must decide, whether the downloaded firmware is valid and will
>    be stored and can be used or will be discarded. It gets passed
>    the context setup by fw_begin_firmware_store() and will free
>    it's resources, if not needed anymore.
> 
> After fw_end_firmware_store(), the firmware can be downloaded to
> the device (not before!).
> 
> This is much simpler, then it sounds. The only problems are:
>    1.  getting the size of the firmware to be downloaded
>       a) firmware has always the same size, so this is a constant
>       b) firmware has size encoded -> use this 
>       c) firmware size is file size -> need to wrap this to be like 1.b)
> 
>    2. decide, whether the firmware is valid
>       a) checksum
>       b) versions
>       c) none -> trust or wrap to match 2.a) and/or 2.b)
> 
> What do you think?

 I think that this is an overkill, the most I can see reasonable is
 forcing an standard header on all firmware images with size/checksum.
 And still I am not sure it is worth it.

> The current idea (special file sytem) is great, but the interface
> to the driver is not really perfect.

 In which way is it not perfect?
 
 Detailed criticism gives me the chance to try to get things better :)

 Have a nice day

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
