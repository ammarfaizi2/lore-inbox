Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbULYWiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbULYWiK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 17:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbULYWiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 17:38:09 -0500
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:5268 "EHLO
	acheron.informatik.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S261406AbULYWh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 17:37:59 -0500
Message-ID: <41CDEE8A.80407@bio.ifi.lmu.de>
Date: Sat, 25 Dec 2004 23:49:46 +0100
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: kblockd/1: page allocation failure in 2.6.9
References: <41C7D32D.2010809@bio.ifi.lmu.de>	 <41CAAB61.3030704@bio.ifi.lmu.de>	 <200412231551.15767.vda@port.imtp.ilyichevsk.odessa.ua>	 <41CAEA62.4060903@bio.ifi.lmu.de>  <20041224132006.GC2528@suse.de> <1103916492.5448.27.camel@mulgrave>
In-Reply-To: <1103916492.5448.27.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

thanks for caring! I don't fully understand what you are talking about
in detail :-), but maybe I can give some more information that could help.

- If you suspect the gdth driver causing the error, it must be some very
   special situation on this host causing it. We have 2 other hosts
   with the same icp vortex GDT8514RZ controller like the host
   where the kblockd message occured. They all have internal raid1 disks
   (73gb or 146gb). One is our main NFS server (it has two raid1 with 146g
   each) and it has a lot of I/O, sometimes 50GB or more a day with peaks
   up to 200MB per second (reading), and we never saw any kblockd message
   in the logs (I just checked them all).

- there were no messages "around" the kblockd messages in /var/log/messages
   but the usual ones about remote ssh login, cron jobs etc., but the messages
   were all more than 10 minutes "away" before and after the kblockd happened.

- not much I/O can have taken place on the internal disks attached to the
   icp controller when the bug was triggered, because all the I/O for
   e.g. updates or backups happens only in the night for all hosts except
   the NFS servers.

- the host where the error occured is the only one that (in addition to the icp
   controller with the internal raid1) has two external SCSI-to-IDE-Raids
   attached to the adaptec 29160 controller that runs with the aic7xxx modul.

- According to the user working a lot on this host, it is possible that he
   did a dump of a large mysql database on the external SCSI-to-IDE raids
   around the time where the kblockd messages occured. He can't tell
   for sure if it was the same time.
   Since we never had any problems on the other hosts with the icp
   controllers and the gdth module, maybe the bug occurs in the aic7xxx
   module? Or if it occurs in the gdth, maybe it's caused by some interaction
   between the gdth and the aic7xxx driver both accessing the scsi bus?
   The gdth driver is compiled into the kernel, the aic7xxx loads as module.

- I did a "dd if=/dev/sd? of=/dev/null bs=500M" for all disks (sda on gdth,
   sdb and sdc on aic7xxx) to check if it could be some disk error or sth..
   but those dd went fine without triggering the bug.

Don't know if this info helps...

Please let me know if there is something I can do to help finding
the bug. I don't mind to compile a special kernel for this host if I can
turn on some debugging options. I saw some DEBUG_GDTH variable in gdth.c,
but I don't know how to turn this on exactly, would I have to define the
variable in the header file somehow? (Sorry, I'm not very familiar with
C :-() For the aic7xxx I found two config options AIC7XXX_DEBUG_ENABLE
and AIC7XXX_DEBUG_MASK. Could that help you identify the bug if I have all
this enabled when the bug shows up again?

Thanks!

Frank



-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr 17            Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:              -4054
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
