Return-Path: <linux-kernel-owner+w=401wt.eu-S1751615AbWLQUWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbWLQUWB (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 15:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbWLQUWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 15:22:01 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:36278 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbWLQUWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 15:22:00 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4585A6C3.6010107@s5r6.in-berlin.de>
Date: Sun, 17 Dec 2006 21:21:23 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       linux1394-devel@lists.sourceforge.net
Subject: Re: ieee1394 in 2.6.20-rc1 (was Re: Linux 2.6.20-rc1)
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <200612171311.38763.gene.heskett@verizon.net> <45858CF2.7080402@s5r6.in-berlin.de> <200612171404.56278.gene.heskett@verizon.net>
In-Reply-To: <200612171404.56278.gene.heskett@verizon.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Cc linux1394-devel, for the record)

Gene Heskett wrote:
> On Sunday 17 December 2006 13:31, Stefan Richter wrote:
>> Is your version of kino still using dv1394 or does it work without
>> dv1394 loaded too?
>>
> AFAIK, its kino is 0.9.3.  Ok, while kino is running I did a modprobe -rv 
> dc1394 and it removed dv1394.ko and ohci1394.ko

When dv1394 is loaded, the use count of ohci1394 is incremented because
dv1394 uses symbols of ohci1394. Likewise, when dv1394 is removed,
ohci1394's use count is decremented which may render ohci1394 "unused".
It will then be removed too. This is of course not desired in many cases.

> Now when going to the capture screen is says the device /dev/raw1394 is 
> gone or the kernel module isn't loaded.  raw1394 is still resident 
> according to an lsmod, so I'm puzzled as to why the device was removed 
> when the module is still present.

raw1394 does not mark FireWire hosts as in use. I think we should add
try_module_get(host->driver->owner) and module_put(host->driver->owner)
either to initiation and release of requests, or to the raw1394_open()
and raw1394_release() hooks for all hosts which are present when the
file is opened, or simply to raw1394's add_host() and remove_host() hooks.

I'll make a note on bugzilla.kernel.org and try to find a proper fix
some time.

> So I modprobe -rv raw1394 and it took 
> out raw1394 and ieee1394, then reloaded raw1394 which loaded ieee1394.  
> And kino is still without controls but does not now report the error at 
> the bottom of its screen.  Quitting it and restarting it restores the 
> error.  Then loading dv1394 also brings in ohci1394, and a recycle out and 
> back to the capture window restored the controls.
> 
> So I removed dv1394, and reloaded only ohci1384,

That's what was necessary after you removed dv1394.

> but an attempt to change 
> screens in kino locked the box up tight, not even the x-clock in the 
> right corner was running and I had to hard reset it.

This is, how should I put it, not good. Maybe raw1394 still held
resources on behalf of kino which related to the host that first
vanished, then reappeared as a new one. Anyway; raw1394 is supposed to
handle life addition and removal of hosts, but we obviously missed
something.

> With 4 modules to play with and 4!=15, its the lack of the dv1394 module 
> that isn't exactly friendly, the other combo's just kill the controls.
> 
> AIUI, it *should* be ohci1394 handling the controls stuff, so this 
> represents a bit of a puzzle.  Or the AIUI is wrong :)
...

What if you prevent dv1394 from ever being loaded, or don't build it in
the first place? CONFIG_IEEE1394_DV1394=n
-- 
Stefan Richter
-=====-=-==- ==-- =---=
http://arcgraph.de/sr/
