Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267496AbTAQLpL>; Fri, 17 Jan 2003 06:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267497AbTAQLpL>; Fri, 17 Jan 2003 06:45:11 -0500
Received: from tomts20-srv.bellnexxia.net ([209.226.175.74]:56992 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267496AbTAQLpJ>; Fri, 17 Jan 2003 06:45:09 -0500
Date: Fri, 17 Jan 2003 06:53:43 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: questions about config files, I2C and hardware sensors (2.5.59)
Message-ID: <Pine.LNX.4.44.0301170636120.13098-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  just to make sure i understand the kbuild language, a couple
questions about the I2C config option and its menu dependencies.

  in .../drivers/i2c/Kconfig, we have the relevant lines:

-----------------

menu "I2C support"

config I2C
	tristate "I2C support"
     ... blah blah ...

config I2C_PROC
	tristate "more blah"
 	depends on I2C && SYSCTL

source drivers/i2c/busses/Kconfig
source drivers/i2c/chips/Kconfig

endmenu

-------------------

  so far, so good.  and since the next issue deals with both of 
those sourced files similarly, i'll just pick on the first one --
busses/Kconfig, which contains:

-------------------

#  .. All depend on EXPERIMENTAL, I2C and I2CPROC.

menu "I2C HW Sensors Mainboard Support"

config I2C_AMD756
	tristate "..."
	depends on I2C && I2C_PROC

config I2C_AMD8111
	tristate "..."
	depends on I2C && I2C_PROC

...

endmenu

--------------------

  so the issues:

1) trivial: comment is wrong, there is no dependency on 
   EXPERIMENTAL

2) since, in the sourcing Kconfig file, I2C_PROC *already* depends
   on I2C, is there any practical value in having the dependency
   "I2C && I2C_PROC".  wouldn't "depends on I2C_PROC" be sufficient?
   that is, do option dependencies carry across sourced Kconfig
   files?  not a major issue, just unnecessary verbosity.

3) finally, given that the comment at the top is adamant that
   all of these options depend on I2C and I2C_PROC, wouldn't it
   be cleaner to just make the menu itself say:

   menu "I2C HW Sensors Mainboard Support"
	depends on I2C && I2C_PROC		(or just I2C_PROC)
	...

   and let the internal options inherit this dependency?  as it
   is, those two submenu names show up even though clicking on
   them shows an empty option screen.  

   by changing to the above, these become invisible submenus
   until you actually select I2C_PROC in the "Option"
   window.  is there any drawback to this?  seems cleaner.
   (this assumes, of course, that *all* options in this menu
   share exactly the same dependencies, but that's what the
   comment seems to imply.)

i can easily knock off a patch for this as long as i'm 
understanding this correctly.

rday

