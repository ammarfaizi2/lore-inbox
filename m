Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264448AbTEPOJf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 10:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbTEPOJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 10:09:35 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:45712 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S264448AbTEPOJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 10:09:33 -0400
Date: Fri, 16 May 2003 15:13:52 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Manuel Estrada Sainz <ranty@debian.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, Greg KH <greg@kroah.com>,
       jt@hpl.hp.com, Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030516151352.D626@nightmaster.csn.tu-chemnitz.de>
References: <20030515200324.GB12949@ranty.ddts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030515200324.GB12949@ranty.ddts.net>; from ranty@debian.org on Thu, May 15, 2003 at 10:03:24PM +0200
X-Spam-Score: -4.5 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19Gg6H-0005lV-00*W1iNslh5km6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Thu, May 15, 2003 at 10:03:24PM +0200, Manuel Estrada Sainz wrote:
> 	
> 	- echo 1 > /sysfs/class/firmware/dev_name/loading
> 	- cat whatever_fw > /sysfs/class/firmware/dev_name/data
> 	- echo 0 > /sysfs/class/firmware/dev_name/loading
 
Why not doing that in open and require firmware data to contain
size information? Good firmware formats contain already size,
checksum and version information. Bad firmware can be wrapped to
get these. It should be made a requirement to contain at least a
size and a checksum.

To handle the big varieties of firmware formats, I would suggest
to either wrap all in user space or define 3 functions per
firmware format like the seq_file support. The thing is very
similiar, except that we read from user space instead of writing.

fw_begin_firmware_store()
fw_next_firmware_bytes()
fw_end_firmware_store()

fw_begin_firmware_store() gets at most a page of data and should
   evaluate from this data, how much bytes it still needs from
   user space. It will also setup a context and store it.

fw_next_firmware_bytes() will get passed more firmware bytes and
   tells us again how much it still need. It will get passed the
   context setup by fw_begin_firmware_store(). 
   
   This function can also abort a download by returning "no bytes
   needed anymore" and marking the firmware "invalid" in the
   context, which fw_end_firmware_store() will use to return
   "discard this firmware" to the firmware fs.

   Also this function is not really necessary, if we set the
   filesize of the firmware (truncate()) in firmware fs after
   fw_begin_firmware_store() and let the VFS do its magic.

fw_end_firmware_store() will be called, after user space closed
   the file descriptor (Note: This will handle SIGKILL also). It
   must decide, whether the downloaded firmware is valid and will
   be stored and can be used or will be discarded. It gets passed
   the context setup by fw_begin_firmware_store() and will free
   it's resources, if not needed anymore.

After fw_end_firmware_store(), the firmware can be downloaded to
the device (not before!).

This is much simpler, then it sounds. The only problems are:
   1.  getting the size of the firmware to be downloaded
      a) firmware has always the same size, so this is a constant
      b) firmware has size encoded -> use this 
      c) firmware size is file size -> need to wrap this to be like 1.b)

   2. decide, whether the firmware is valid
      a) checksum
      b) versions
      c) none -> trust or wrap to match 2.a) and/or 2.b)

What do you think?

Defining the prototypes and finding the places to hook into is
left as an exercise to the reader ;-)

The current idea (special file sytem) is great, but the interface
to the driver is not really perfect.

Regards

Ingo Oeser
