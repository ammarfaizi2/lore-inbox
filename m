Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273951AbRIRVsl>; Tue, 18 Sep 2001 17:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273950AbRIRVsb>; Tue, 18 Sep 2001 17:48:31 -0400
Received: from [213.96.124.18] ([213.96.124.18]:53487 "HELO dardhal")
	by vger.kernel.org with SMTP id <S273948AbRIRVsZ>;
	Tue, 18 Sep 2001 17:48:25 -0400
Date: Tue, 18 Sep 2001 23:50:43 +0000
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: linux-kernel@vger.kernel.org
Subject: Reproducible bug in 2.4.9-ac10 (NTFS 1.1.18)
Message-ID: <20010918235042.A4164@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel gurus:

I've experienced a rather nasty bug in NTFS read-only driver 1.1.18 as
present on vanilla linux kernel 2.4.9-ac10. The bug can be triggered with
a simple "find /" command, and it makes the machine to reject any further
access to disks, but SysRq and network still work OK. The same test (which
I'll detail in more detail below) causes no problems with vanilla linux
kernel 2.4.9 (+ LVM 1.0.1 + devfs patch v.183), which includes NTFS driver
version 1.1.6 (compiled just with RO support).

The test setup is as follows: machine in single user mode, no modules
loaded except for ntfs.o and nls_iso8859-1.o. devfs is compiled in but not
mounted on boot. Root filesystem (/dev/hda5) is of type ext2. Windows 2000
workstation partition (/dev/hda1) is mounted read-only on /mnt/win2k. For
the test, / is remounted read-only (to avoid looong fsck's on reboot :).

A simple "find /" goes as expected until it enters /mnt/win2k, where
suddlenly the disks stop being accesed by the operating system. On both
test I've done so far, the problem happens just after the directory
"/mnt/win2k/Archivos de programa/Archivos comunes/Microsoft
Shared/Stationery" (Archivos de programa == Program files, Archivos
comunes == Common files). The machine still replies to pings, even gives
you a "connect" when, for example, telnet to port 25, but no activity on
the disks take place. SysRq still works, but any operation that tries to
access to disks fail (SysRq+S or SysRq+U don't work).

I repeated the same test, but this time I "straced" it (strace find /). As
said before, the machine stops accesing disks on the same directory as
before. The last few lines from strace follow:

write(1,"/mnt/win2k/Archivos de programa"..., 96/mnt/win2k/Archivos de
programa/Archivos comunes/Microsoft Shared/SpeechEngines/TTS/wttss22.dll
) = 96
chdir("..") = 0
lstat64(0x8050ca0,0xbfffee9c) = 0
chdir("..") = 0
lstat64(0x8050ca0,0xbfff04c) = 0
lstat64(0x8057eea,0xbffff15c) = 0
write(1,"/mnt/win2k/Archivos de programa/"...,77/mnt/win2k/Archivos de
programa/Archivos comunes/Microsoft Shared/Stationery
) = 77
open("Stationery",O_RDONLY|O_NONBLOCK|0x18000) = 4
fstat64(0x4,0xbfffef6c) = 0
shmat(4,0x8057eea,0x2ptrace:umoven:Input/output error
) = ?
ipc_subcall(0x4,0x80582e0,0x400,0

And the system "hangs" there (I had to take note of the trace by hand, but
I think I didn't miss anything). As said before, no problems with kernel
2.4.9 and driver 1.1.16.

Installed libc6 is version 2.2.4-1 (Debian Woody version).

If there are further tests needed to identify the problem, let me know and
I'll do them with great pleasure :)

-- 
Jos� Luis Domingo L�pez
Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => � Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

