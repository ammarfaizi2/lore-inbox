Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317845AbSIOF0U>; Sun, 15 Sep 2002 01:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317855AbSIOF0U>; Sun, 15 Sep 2002 01:26:20 -0400
Received: from mta01bw.bigpond.com ([139.134.6.78]:65218 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S317845AbSIOF0M>; Sun, 15 Sep 2002 01:26:12 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Brian Craft <bcboy@thecraftstudio.com>, linux-kernel@vger.kernel.org
Subject: Re: delay before open() works
Date: Sun, 15 Sep 2002 15:25:01 +1000
User-Agent: KMail/1.4.5
References: <20020914094225.A1267@porky.localdomain>
In-Reply-To: <20020914094225.A1267@porky.localdomain>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209151525.01920.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 15 Sep 2002 02:42, Brian Craft wrote:
<snip>
> This is pretty gross, since I have to determine the "15" by playing with
> it, and I'm sure it will fail some of the time unless I make it reeeeeally
> long. I suspected this was some hardware issue -- USB latencies on device
> discovery, or boot time for the scanner -- but a friend who isn't
> attempting to power-up his devices says he sees the same behavior when just
> scripting "modprobe". So it appears there's some fairly long delay in the
> kernel itself.
>
> Anyone know off-hand what causes this delay, or if there's some way to get
> the open() to block?
There is a fundamental problem with the way hotplugging works in this case.

The underlying hardware (in this case USB) detects a status change. It calls 
call_usermode_helper(), and hands off the task to keventd. Then things wait. 
Eventually keventd gets around to calling /sbin/hotplug, which loads modules, 
runs scripts, writes config files, exec code - whatever. The problem is that 
if module initialisation isn't complete, then clearly its interfaces may not 
be established (or in some badly-coded cases, may contain races where the 
interface is registered but isn't valid). 

After discussions with Oliver Neukem at Linux Kongress, the idea of a second 
hotplug event emerges. This is signalled by the driver that actually 
registers the interface after the interface is properly established (so in 
your example, USB core does one call_usermode_helper(), which probably does 
something like "modprobe scanner"; and the scanner driver does a second 
call_usermode_helper(), which loads xsane).

BTW: I'm not sure who actually came up with the idea - it was in the hotplug 
BoF, but I missed this part of it.

Solves this race. Unfortunately requires some janitorial work. Patch away...

Brad

- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9hBmtW6pHgIdAuOMRAsblAKCKoiHGDnKnCU3kORyTJKEy8sjPKwCfSwDj
QGrrS/elmJ/YbBwmpksI+WU=
=yclZ
-----END PGP SIGNATURE-----

