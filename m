Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbTFLJYP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 05:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbTFLJYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 05:24:14 -0400
Received: from camus.xss.co.at ([194.152.162.19]:50437 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S264488AbTFLJXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 05:23:53 -0400
Message-ID: <3EE8497C.1090303@xss.co.at>
Date: Thu, 12 Jun 2003 11:35:56 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anders Karlsson <anders@trudheim.com>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc7
References: <Pine.LNX.4.55L.0306031353580.3892@freak.distro.conectiva>	 <3EDF3310.7040501@xss.co.at> <3EE208F1.4000008@xss.co.at>	 <Pine.LNX.4.55L.0306111745130.31893@freak.distro.conectiva> <1055408183.2552.18.camel@tor.trudheim.com>
In-Reply-To: <1055408183.2552.18.camel@tor.trudheim.com>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Anders Karlsson wrote:
> On Wed, 2003-06-11 at 21:48, Marcelo Tosatti wrote:
>
>>On Sat, 7 Jun 2003, Andreas Haumer wrote:
>
> [snip]
>
>>>I had this system running under heavy load for about 24 hours
>>>without problems. I then stopped the stress testing, and had
>>>several system freezes since then.
>>>
>>>With system freeze I mean:
>>>
>>>*) machine doesn't answer to ping, no reaction to console
>>>   keyboard, no message on the console screen, no message
>>>   in logfile, no oops, no noticeable system activity
>
>
> I have this problem without actually stressing the machine too hard. The
> average load on my Thinkpad over a weekend would perhaps be 0.05, yet I
> can have several hard hangs where there seems to be no trace of a hang
> at all in logfiles.
>
I have to admit that "system freeze" is a quite unspecific
symptom. It could have a zillion of different reasons.

In my case I'm currently chasing SCSI errors which I think
could have something to do with it (besides, it's _not_ an Adaptec
controller, but a LSI 53c1030 with Fusion MPT driver... :-)

In my server logs I sometimes see SCSI timeouts like this:

[...]
scsi : aborting command due to timeout : pid 1148093, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 00 0f af 00 00 10 00
mptscsih: OldAbort scheduling ABORT SCSI IO (sc=dfca8e00)
  IOs outstanding = 3
mptscsih: ioc0: Issue of TaskMgmt Successful!
SCSI host 0 abort (pid 1148093) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
mptscsih: OldReset scheduling BUS_RESET (sc=dfca8e00)
  IOs outstanding = 4
SCSI Error Report =-=-= (0:0:0)
  SCSI_Status=02h (CHECK CONDITION)
  Original_CDB[]: 2A 00 00 3C 4D 78 00 00 02 00 - "WRITE(10)"
  SenseData[20h]: 70 00 06 00 00 00 00 18 00 00 00 00 29 02 00 00 00 00 ...
  SenseKey=6h (UNIT ATTENTION); FRU=00h
  ASC/ASCQ=29h/02h "SCSI BUS RESET OCCURRED"
SCSI Error Report =-=-= (0:1:0)
  SCSI_Status=02h (CHECK CONDITION)
  Original_CDB[]: 28 00 00 00 0F AF 00 00 10 00 - "READ(10)"
  SenseData[20h]: 70 00 06 00 00 00 00 18 00 00 00 00 29 02 00 00 00 00 ...
  SenseKey=6h (UNIT ATTENTION); FRU=00h
  ASC/ASCQ=29h/02h "SCSI BUS RESET OCCURRED"
SCSI Error Report =-=-= (0:2:0)
  SCSI_Status=02h (CHECK CONDITION)
  Original_CDB[]: 28 00 00 4E 0A 37 00 00 08 00 - "READ(10)"
  SenseData[20h]: 70 00 06 00 00 00 00 18 00 00 00 00 29 02 00 00 00 00 ...
  SenseKey=6h (UNIT ATTENTION); FRU=00h
  ASC/ASCQ=29h/02h "SCSI BUS RESET OCCURRED"
SCSI Error Report =-=-= (0:3:0)
  SCSI_Status=02h (CHECK CONDITION)
  Original_CDB[]: 28 00 03 B0 08 6F 00 00 08 00 - "READ(10)"
  SenseData[20h]: 70 00 06 00 00 00 00 18 00 00 00 00 29 02 00 00 00 00 ...
  SenseKey=6h (UNIT ATTENTION); FRU=00h
  ASC/ASCQ=29h/02h "SCSI BUS RESET OCCURRED"
[...]

There are 4 hot swap SCSI disks in the server, and all of them
eventually report those timeouts (so it's not specific to a single
disk)
I already replaced cabling, tried a different hot swap (SCA)
cage, and I'm now trying to replace the disks one by one to
eventually find the culprit.

There are two problems with this approach:

1.) After each change I have to wait several hours up to two
    days for a SCSI timeout to occur as I can not reproduce
    the problem at will.

2.) I'm not _sure_ if those SCSI timeouts are related to the server
    freeze symptoms I see. It's just an assumption.
    IMHO it could work as follows: SCSI timeouts occure somtimes.
    The driver then aborts the command and resets the SCSI bus
    to get it into a sane state again. But what if the bus reset
    doesn't work as expected and the bus remains unusable for a
    while? Could this bring the whole system into this "freeze"
    state (the system is still running, but everything waits for
    the SCSI bus to recover)? Could this explain the symptom of
    those big delays of ICMP ping answer messages I saw?

So the most precious resource for chasing this problem is time,
and this is also the resource which I don't have available as
much as I'd like to... :-(

>
>>Maybe the NMI oopser helps?
>
>
> Marcelo, where can I get hold of this and would there be documentation
> included with it for how to install/use it?
>
Look at /usr/src/linux/Documentation/nmi_watchdog.txt

Regards,

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+6El7xJmyeGcXPhERAqykAKCumORTm/lDofkrg52FX33rOfgC/ACeNxR7
l9/znrbi0lZoR/zw+LTdNhI=
=W7Gt
-----END PGP SIGNATURE-----

