Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285305AbRLNBkX>; Thu, 13 Dec 2001 20:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285309AbRLNBkO>; Thu, 13 Dec 2001 20:40:14 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:41713 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S285305AbRLNBkC>;
	Thu, 13 Dec 2001 20:40:02 -0500
Date: Thu, 13 Dec 2001 17:39:46 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, garzik@bougret.hpl.hp.com
Subject: New driver API for Wireless Extensions
Message-ID: <20011213173946.D520@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Hi,

	It's must be 2.5.X time. I've just finished the first phase of
improvement on Wireless Extensions, which is a new driver API.
	This e-mail contains some comment about why I think the new
API is good for me (and for you). Then, I will try to send the
relevant patches to the mailing list.
	All the material is available on my web page :
	http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html#newapi

	Note also that the patches *won't* apply to your kernel
because my previous wireless patch has disapeared in a black hole :
	http://www.uwsg.indiana.edu/hypermail/linux/kernel/0112.1/0591.html
	But trust me, they apply to *my* kernel ;-)

	I'm waiting for comments. Later on, if the stars are aligned,
this set of patches may go in the kernel... And I may even work on the
second phase...

	Have fun...

	Jean


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="we13.comments.txt"

		New driver API for Wireless Extensions
		--------------------------------------

Intro :
-----
	Over time, I've observed what's good and what's wrong with the
Wireless Extensions. After listening to complaints and comments from
various wireless driver developpers (me included), I've decided it's
time for a new driver API for Wireless Extensions.

Executive summary :
-----------------
	In the old driver API, all Wireless Extensions were processed
in the driver ioctl handler.
	With the new API, the driver defines a bunch of handler, each
associated with a specific Wireless Extension, and a kernel wrapper
make sure to call the appropriate handler with the appropriate
parameters.

Main advantages :
---------------
	o backward compatible with old API, both API can be mixed
	o easy migration from old API to new API (data structures unchanged)
	o break huge ioctl function in driver in small handlers
	o various parameters checks before calling the driver
	o handle all user-space <-> kernel-space data copy
	o remove all ioctl assumptions in the driver

Drawback :
--------
	o bloat (especially kernel)
	o need to migrate existing drivers to new API

Comments :
--------
	A lot of repetitive code has moved from the driver to the
kernel (like parameter checks and user/kernel space copy). This means
that the bugs are grouped into one place instead of scattered all over
the drivers, and also that things are simpler for people writting
drivers.
	The removal of ioctl assumptions from the driver (mostly the
removal of user/kernel space copy) mean that we are now free to change
the user space API and that we can call this code from the kernel. In
particular, it should be now trivial plug APIs like netlink or devfs
on top of the driver API.
	The bloat is a concern. The rest of the document look at this
in some details. Note that those numbers are for my configuration and
just serve as an estimate.
	I don't mention performance. Performance is not critical for
this API. However, I believe the new API is marginally faster (you are
free to prove me wrong).
	If you want more details, I'm afraid you will have to look in
the code.

Kernel bloat :
------------
	Size of the core networking object (without the protocols) as
found in linux/net/core :
		core.o after :		100133 bytes
		core.o before:		 97008 bytes
		bloat :			  3125 bytes -> +3%
	Of course, Wireless Extension is optional, and if you disable
the CONFIG_NET_RADIO and CONFIG_NET_PCMCIA_RADIO options, you don't
compile any of the stuff :
		core.o no-wireless :	 96803 bytes
	So, the Wireless Extensions overhead went from 205 bytes to
3330 bytes (0.2% to 3%).
	Note : the whole networking stack in my case is 603714 bytes,
and my vmlinux over 2 Mbytes, so for most kernels this bloat will be
lost in the noise...

Old Wavelan driver :
------------------
	I've chosen the old Wavelan driver because the old API
implementation has been really optimised in this driver and it uses
mostly simple extensions.
		wavelan.o after :	24900 bytes
		wavelan.o before :	24856 bytes
		bloat :			   44 bytes -> +0.2%
	Well, I'm disapointed. I guess I could squeeze more with the
new API by putting psa_checksum in a commit handler.

Orinoco driver :
--------------
	The Orinoco driver is representative of a modern 802.11 driver
and support a wide range of Wireless Extensions.
		orinoco.o after :	42420 bytes
		orinoco.o before :	47180 bytes
		bloat :			-4760 bytes -> -10%
	That's good news. The saving is mostly the removal of
copy_to/from_user and the removal of the big switch.

Conclusion :
----------
	Bloat is only a minor issue, and overall I beleive the new API
is worth the pain of upgrading.
	Note that the old API is *not* going away (at least, not
soon), so old drivers are forward compatible and driver maintainers
can take their time to migrate (i.e. : never).

	Jean II

--MGYHOYXEY6WxJCY8--
