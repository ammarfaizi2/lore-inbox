Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbVJZJwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbVJZJwY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 05:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVJZJwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 05:52:24 -0400
Received: from mail-gate.ait.ac.th ([202.183.214.47]:56529 "EHLO
	mail-gate.ait.ac.th") by vger.kernel.org with ESMTP
	id S1751338AbVJZJwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 05:52:23 -0400
Date: Wed, 26 Oct 2005 16:52:21 +0700
From: Alain Fauconnet <alain@ait.ac.th>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13 ips.ko delay causes mkdevices to loop during initrd processing?
Message-ID: <20051026095220.GD32542@ait.ac.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List,

This is an IBM xSeries dual-P3 1.0Ghz server box with an IBM ServeRAID
4Mx controller and 3 * IBM 18 Gb SCSI hotswap disks.
Base O/S is Trustix 2.2, manually updated with a 2.6.13 kernel built
from source and a mkinitrd-4.1.18-2 RPM
stolen from FC3 because TSL 2.2's mkinitrd can't handle .ko modules.

After upgrading to kernel 2.6.13, the machine stops at boot during
initrd processing. After much head-scratching I've figured out that
the "mkdevices /dev" command  in the "init" script of the initrd was
looping.
Hand-editing the init script like this:

echo "Loading ips.ko module"
insmod /lib/ips.ko 
sleep 10                <-------- this line added
echo Creating block devices
mkdevices /dev

and rebuilding the initrd makes the problem go away. So it's really
a timing issue. Everything is fine too if I build the kernel with
ips and scsi modules statically linked.

When failing, console output goes like (approx., typed by hand):

Loading scsi_mod.ko module
SCSI subsystem initialized
Loading sd_mod.ko module
Loading ips.ko module
input: AT Translated Set 2 keyboard on isa0060/serio0
scsi0 : IBM PCI ServeRAID 7.12.02  Build 761 <ServeRAID 4Mx>
  Vendor: IBM       Model: SERVERAID         Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 71094272 512-byte hdwr sectors (36400 MB)
sda: got wrong page
sda: assuming drive cache: write through
SCSI device sda: 71094272 512-byte hdwr sectors (36400 MB)
sda: got wrong page
sda: assuming drive cache: write through
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: IBM       Model: SERVERAID         Rev: 1.00
  Type:   Processor                          ANSI SCSI revision: 02
  Vendor: IBM       Model: CaVv3 S2          Rev: 0   
  Type:   Processor                          ANSI SCSI revision: 02
Creating block devices
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1

(stops here... nothing happens anymore, system is *not* hung
though, typed characters echo, Ctrl-Alt-Del reboots)

Can anyone provide a hint here? I'm really stuck.
Of course I have two possible work-arounds, but I'd really like to understand.

Greets,
_Alain_



