Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262924AbUKYCmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262924AbUKYCmk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 21:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbUKYCmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 21:42:40 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:34715 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262924AbUKYClF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 21:41:05 -0500
Subject: Re: Suspend 2 merge: 26/51: Kconfig and makefile.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0411241718400.1284@scrub.home>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101296580.5805.292.camel@desktop.cunninghams>
	 <Pine.LNX.4.61.0411241718400.1284@scrub.home>
Content-Type: text/plain
Message-Id: <1101339103.4490.3.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 13:37:21 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-25 at 03:34, Roman Zippel wrote:
> Please don't use such indentations.
> There is no need to use to select here either. If you really want to make 
> it modular (and you can convince Christoph), you want to do something like 
> this:

I think I've caught on to what you're meaning. Is this better?

menu "Software Suspend 2"

config SOFTWARE_SUSPEND2
	tristate "Software Suspend 2"
	depends on PM
	---help---
	  Software Suspend 2 is the 'new and improved' suspend support. You
	  can now build it as modules, but be aware that this requires
	  initrd support (the modules you use in saving the image have to
	  be loaded in order for you to be able to resume!)
	  
	  See the Software Suspend home page (softwaresuspend.berlios.de)
	  for FAQs, HOWTOs and other documentation.

config SOFTWARE_SUSPEND2_CORE
	def_bool SOFTWARE_SUSPEND2

if SOFTWARE_SUSPEND2
	comment 'Image Storage (you need at least one writer)'
	depends on SOFTWARE_SUSPEND2_CORE
	
	config SOFTWARE_SUSPEND_SWAPWRITER
		tristate '   Swap Writer'
		depends on SWAP && SOFTWARE_SUSPEND2
		---help---
		  This option enabled support for storing an image in your
		  swap space. Swap partitions are supported. Swap file
		  support is currently broken (16 April 2004).

	comment 'Page Transformers'

	config SOFTWARE_SUSPEND_LZF_COMPRESSION
		tristate '   LZF image compression (Preferred)'
		---help---
		  This option enables compression of pages stored during suspending
		  to disk, using LZF compression. LZF compression is fast and
		  still achieves a good compression ratio.

		  You probably want to say 'Y'.

	config SOFTWARE_SUSPEND_GZIP_COMPRESSION
		tristate '   GZIP image Compression (Slow)'
		select ZLIB_DEFLATE
		select ZLIB_INFLATE
		---help---
		  This option enables compression of pages stored during Software Suspend
		  process. Pages are compressed using the zlib library, with a default
		  setting (in code) of fastest compression (still VERY slow!). If your swap
		  device is painfully slow compared to your CPU, you might possibly want
		  this. Then again, you might just want to upgrade your storage (if you
		  can).
	  		
		  Just in case you haven't gotten the hint yet, this option should be off
		  for most people. If will make your computer take a minute to suspend
		  when it could take seconds.

	config SOFTWARE_SUSPEND_DEVICE_MAPPER
		tristate '   Device Mapper support'
		depends on BLK_DEV_DM
		---help---
		  This option creates a module which allows Suspend to tell the
		  device mapper code to allocate enough memory for its work while
		  suspending. It doesn't do anything else, but without it, dm-crypt
		  won't work properly.

		  This option should be off for most people.

	comment 'User Interface Options'

	config SOFTWARE_SUSPEND_BOOTSPLASH
		tristate '  Bootsplash support'
		depends on BOOTSPLASH
		---help---
		  This option enables support for Bootsplash (bootsplash.org). Suspend
		  can set the progress bar value and switch between silent and verbose
		  modes. (Silent mode is used when the debug level is 0 or 1). 

	config SOFTWARE_SUSPEND_TEXT_MODE
		tristate '  Text mode console support'
		depends on VT
		---help---
		  This option enables support for a text mode 'nice display'. If you don't
		  have/want bootsplash support, you probably want this.

	comment 'General Options'

	config SOFTWARE_SUSPEND_DEFAULT_RESUME2
		string '   Default resume device name'
		---help---
		  You normally need to add a resume2= parameter to your lilo.conf or
		  equivalent. With this option properly set, the kernel has a value
		  to default. No damage will be done if the value is invalid.

	config SOFTWARE_SUSPEND_KEEP_IMAGE
		bool '   Allow Keep Image Mode'
		---help---
		  This option allows you to keep and image and reuse it. It is intended
		  __ONLY__ for use with systems where all filesystems are mounted read-
		  only (kiosks, for example). To use it, compile this option in and boot
		  normally. Set the KEEP_IMAGE flag in /proc/software_suspend and suspend.
		  When you resume, the image will not be removed. You will be unable to turn
		  off swap partitions (assuming you are using the swap writer), but future
		  suspends simply do a power-down. The image can be updated using the
		  kernel command line parameter suspend_act= to turn off the keep image
		  bit. Keep image mode is a little less user friendly on purpose - it
		  should not be used without thought!

	comment 'Debugging'

	config SOFTWARE_SUSPEND_DEBUG
		bool '   Compile in debugging output'
		---help---
		  This option enables the inclusion of debugging info in the software
		  suspend code. Turning it off will reduce the kernel size but make
		  debugging suspend & resume issues harder to do.

		  For normal usage, this option can be turned off.

	config SOFTWARE_SUSPEND_CHECKSUMS
		tristate '   Compile checksum module'
		---help---
		  This option enables compilation of a checksumming module, which can
		  be used to verify the correct operation of suspend.

		  For normal usage, this option can be turned off.
endif

endmenu


