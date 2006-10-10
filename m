Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWJJS7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWJJS7v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWJJS7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:59:51 -0400
Received: from mail.uni-bonn.de ([131.220.15.112]:32149 "EHLO uni-bonn.de")
	by vger.kernel.org with ESMTP id S1751093AbWJJS7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:59:49 -0400
From: Elias Oltmanns <oltmanns@uni-bonn.de>
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, hdaps-devel@lists.sourceforge.net
Subject: Re: Debugging strange system lockups possibly triggered by ATA commands
References: <741Eo-2m9-5@gated-at.bofh.it>
X-Hashcash: 1:20:061010:hdaps-devel@lists.sourceforge.net::dT+ImXbqL1tZX2cp:00000000000000000000000000000VKM
X-Hashcash: 1:20:061010:linux-ide@vger.kernel.org::91cdiBaF0HoasGvq:000000000000000000000000000000000000406h
X-Hashcash: 1:20:061010:linux-kernel@vger.kernel.org::3fmR4OlDE1KNH3Mc:0000000000000000000000000000000003HGq
Mail-Copies-To: nobody
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	hdaps-devel@lists.sourceforge.net
Date: Tue, 10 Oct 2006 20:58:56 +0200
Message-ID: <874pucatfz.fsf@denkblock.local>
User-Agent: Gnus/5.110006 (No Gnus v0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

here is some additional information and further test results:

Elias Oltmanns <oltmanns@uni-bonn.de> wrote:
[...]
> Unfortunately, my system just froze without displaying a panic
> message. Moreover, the lockup appears to be hard to reproduce.

I've been made aware that this might be a hint for all sorts of flacky
hardware. Admittedly, the test case presented, which involves a very
tight while true loop, means a lot of stress for the hardware. Let me
point out, however, that this is just my best approach to trigger the
problem as fast and reliably as possible. It was only after I had
experienced such lockups during normal operation that I developed
this particular test case. "Normal operation" in this context means
running the hdapsd daemon which writes a positive number to the sysfs
protect attribute whenever it detects an unusual condition from
reading data from an acceleration sensor. As soon as hdapsd thinks
that everything is alright again, it writes a 0 to the protect
attribute.

This means that in practice a very short sequence of writes to the
protect attribute under certain conditions suffices to freeze the
system. Please note, that repeated writes of 1 to the protect
attribute within an interval of less then one second between each of
these writes does actually issue the park command to the disk only
once and just updates the unfreeze timer until there are no further
writes to protect and the timeout expires and the request queue is
started again.

> Here are some details about some of the tests I've performed so far:
>
>
> 1. vanilla 2.6.18:
> ------------------
> I used my standard configuration for self compiled kernels and make
> oldconfig to adjust it to 2.6.18. Basically, that means a highly
> modularised kernel with ramdisk and initrd support compiled in - by
> that time I hadn't realised yet that ramdisk support isn't needed for
> initramfs support anymore. Amongst the modules: ide-core, ide-disk,
> ide-generic, piix, no sata support. With the hdaps_protect patch applied, I
> could reliably reproduce the system freeze by the following steps:
> Boot into single user mode
> # modprobe ibm-acpi
> # while true; do echo -n 1 > /sys/block/hda/queue/protect; \
> > echo -n 0 > /sys/block/hda/queue/protect; done
> The system freezes and there is no way to reactivate it, except a cold
> reset. Note that there was no freeze without ibm-acpi being loaded,
> even modprobe ibm-acpi; modprobe -r ibm-acpi and the while loop did
> not lead to a freeze. However, switching to the external monitor and
> back again after loading ibm-acpi prevents the system from freezing
> too which makes the whole thing even more difficult.
[...]

The freezes have been observed in all setups of the four test cases
described in my original post. The problem can be reproduced with
the while loop as described above but without loading ibm-acpi.
It seems to be sufficient that the disk is currently performing some
io operations. Doing ls /usr/sbin instead of modprobe ibm-acpi and
starting the while loop rather shortly afterwards works as well. At
least, that makes much more sense than the connection between this
problem and ibm-acpi. This also indicates that the problem is not as
configuration dependent as implied before.

Regards,

Elias
