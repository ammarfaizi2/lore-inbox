Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267614AbTACSNk>; Fri, 3 Jan 2003 13:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267615AbTACSNk>; Fri, 3 Jan 2003 13:13:40 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:40912 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S267614AbTACSNi>; Fri, 3 Jan 2003 13:13:38 -0500
From: Norbert Scheibner <scno@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: bug: accessing SCSI-MO drive
Date: Fri, 03 Jan 2003 19:23:57 +0100
X-Mailer: Forte Agent 1.91/32.564
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18UWSP-00083E-00@pat.hrz.tu-chemnitz.de>
X-Spam-Score: 0.8 (/)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18UWSP-0001HE-00*t00SLS5CH42*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Since changing to kernel version 2.4, sometimes doing a "dd" or a
"mount", which tries to access a Fujitsu SCSI 1.3 GB MO Drive with a 1.3
GB medium (HW Sector Size = 2048 Byte) results in an uninterruptable
sleep of the process, which tried to access the inserted MO medium.

After that happened, the system works still and logins on console or ssh
are still possible, but the only chance to reboot the system is doing a
hard reset. Any "shutdown -r now", "lilo" or "hdparm" results also in an
uninterruptable sleep.

Daily I start a backup script which looks every 3 minutes for a medium
in the MO drive with a "dd if /dev/sda of /dev/null bs 1 count 1" and if
one is found, checks for the label "backup" and then writes the
backup-volume to the medium and then eject it. The mount and umount
after a timeout of 20 seconds is done by autofs with no fs or blocksize
specified (the line from the autofs config file "mo -fstype=auto
:/dev/sda"). Sometimes the script tries this for several hours until
somebody inserts a new medium. The error occurs with the next
successfull "dd" or "mount" after a lot of useless tests with no medium
inserted.
I could not find a better way to trigger this behavior, Sometimes the
error occurs after a week sometimes the next day.

I tried every stable kernel from 2.4.13 or so to 2.4.20. Actually I use
2.4.21-pre2. The 2.4.20 was the first version wich wrote a log output.
I tried a NCR810 and a Dawicontrol DC-2976UW SCSI host adapter with no
effect, an AMD K6-2 on an ALI5 chipset and an Athlon on a VIA KT133
chipset with no effect too.

Portion of the logfile:
------------------------------------------------------------------------
Jan  1 13:56:34 server automount[974]: attempting to mount entry
/.autofs/mo
Jan  1 13:56:34 server automount[13779]: expired /.autofs/mo
Jan  1 13:56:48 server Device not ready.  Make sure there is a disc in
the drive.
Jan  1 13:56:48 server VFS: busy inodes on changed media.
Jan  1 13:56:48 server sda : READ CAPACITY failed.
Jan  1 13:56:48 server sda : status = 1, message = 00, host = 0, driver
= 08
Jan  1 13:56:48 server Current sd00:00: sense key Not Ready
Jan  1 13:56:48 server Additional sense indicates Medium not present
Jan  1 13:56:48 server sda : block size assumed to be 512 bytes, disk
size 1GB.
Jan  1 13:56:48 server sda: unknown partition table
Jan  1 13:56:58 server kernel BUG at ll_rw_blk.c:937!
Jan  1 13:56:58 server invalid operand: 0000
Jan  1 13:56:58 server CPU:    0
Jan  1 13:56:58 server EIP:    0010:[<c019f026>]    Not tainted
Jan  1 13:56:58 server EFLAGS: 00010246
Jan  1 13:56:58 server eax: 00002000   ebx: 00000001   ecx: 00000800
edx: 00000000
Jan  1 13:56:58 server esi: c1780d40   edi: 00000004   ebp: 000fffff
esp: c6799e94
Jan  1 13:56:58 server ds: 0018   es: 0018   ss: 0018
Jan  1 13:56:58 server Process umount (pid: 13798, stackpage=c6799000)
Jan  1 13:56:58 server Stack: 00000800 c1780d40 00000000 000fffff
c7f33e00 00002000 c624fa40 00000113
Jan  1 13:56:58 server c7fbb7dc 00000000 00000000 c0123675 c019f68c
c624fa18 00000001 c1780d40
Jan  1 13:56:58 server 00000004 00000001 00000001 00000002 c019f6ee
00000001 c1780d40 c1780d40
Jan  1 13:56:58 server Call Trace:    [<c0123675>] [<c019f68c>]
[<c019f6ee>] [<c019f847>] [<c88f97ec>]
Jan  1 13:56:58 server [<c88f88d9>] [<c88fb440>] [<c0136251>]
[<c014542e>] [<c0139d77>] [<c0145aaf>]
Jan  1 13:56:58 server [<c0124995>] [<c0145acc>] [<c0106d03>]
Jan  1 13:56:58 server
Jan  1 13:56:58 server Code: 0f 0b a9 03 62 9e 21 c0 0f b6 46 15 0f b7
4e 14 8b 14 85 a0
Jan  1 13:57:16 server <4>
------------------------------------------------------------------------

More LogFiles and additional info on
http://www-user.tu-chemnitz.de/~scno/bugreport/
bug.log - 2 log outputs from 2.4.20 and 2 from 2.4.21-pre2
config - .config file from the 2.4.21-pre2
copies of cpuinfo, iomem, ioports, ksyms, modules, scsi and the output
from a "ps ax" and "lspci -vv" captured on the last occurence of the
error with the 2.4.21-pre2
boot - compiled kernel und symbol map
lib/modules - compiled modules

Actual system:
Athlon 750 MHz
Abit KT133 - VIA KT133 Chipset
Dawicontrol DC-2976UW
Fujitsu SCSI 1.3 GigaMO Drive
2 SCSI CDROM drives

less important components:
128 MB SDRAM
4 Port Dec/Tulip Network Adapter
Orinoco Gold WLAN Adapter
37 GB IDE hard disk

One thing, I just saw, is, that it looks like the kernel detects
erroneously a blocksize of 512 Byte and not of 2048, when the error
occurs.

Regards
        Norbert

