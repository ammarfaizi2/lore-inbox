Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317056AbSG2MmQ>; Mon, 29 Jul 2002 08:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317059AbSG2MmQ>; Mon, 29 Jul 2002 08:42:16 -0400
Received: from office.mandrakesoft.com ([195.68.114.34]:27378 "EHLO
	vador.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S317056AbSG2MmO>; Mon, 29 Jul 2002 08:42:14 -0400
To: martin@dalecki.de
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: RFC: /proc/pci removal?
References: <20020729131717.A25451@flint.arm.linux.org.uk>
	<3D4532D5.1000706@evision.ag>
X-URL: <http://www.linux-mandrake.com/
Organization: MandrakeSoft
From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Date: Mon, 29 Jul 2002 14:46:17 +0200
In-Reply-To: <3D4532D5.1000706@evision.ag> (Marcin Dalecki's message of
 "Mon, 29 Jul 2002 14:19:33 +0200")
Message-ID: <m2it2yn1ly.fsf@vador.mandrakesoft.com>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.2
 (i386-mandrake-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcin Dalecki <dalecki@evision.ag> writes:

> > I seem to vaguely remember that a while ago (2.3 days?) there was
> > discussion about removing /proc/pci in favour of the lspci output,
> > however there doesn't seem much in google groups about it (and
> > marc seems useless with non-alphanumeric searches.)
>
> scanpci from XFree is using it as well. However i would rather still
> like it to be gone despite this inconvenience.

  neither gatos scanpci nor XFree86' scanpci do:

tv@vador ~ $ urpmf bin/scanpci
XFree86:/usr/X11R6/bin/scanpci
gatos:/usr/bin/scanpci

tv@vador ~ $ sudo strace /usr/X11R6/bin/scanpci 2>&1|fgrep open|uniq 
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
open("/lib/i686/libc.so.6", O_RDONLY)   = 3
open("/proc/bus/pci/devices", O_RDONLY) = 3


   gatos scanpci directly access pci config space.

   also lspci, libldetect (used by mandrake drakx, harddrake2,
   lspcidrake tools), kudzu uses /proc/bus/pci/* rather thatn
   /proc/pci as you can easily check with strace :

tv@vador ~ $ sudo strace lspcidrake 2>&1|fgrep open
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
open("/lib/i686/libc.so.6", O_RDONLY)   = 3
open("/proc/bus/pci/devices", O_RDONLY) = 3
open("/usr/share/ldetect-lst/pcitable", O_RDONLY) = 3
open("/proc/bus/usb/devices", O_RDONLY) = -1 ENOENT (No such file or
directory)

tv@vador ~ $ sudo  strace lspcidrake -f 2>&1|fgrep open
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
open("/lib/i686/libc.so.6", O_RDONLY)   = 3
open("/proc/bus/pci/devices", O_RDONLY) = 3
open("/proc/bus/pci/00/00.0", O_RDONLY) = 4
open("/proc/bus/pci/00/01.0", O_RDONLY) = 4
open("/proc/bus/pci/00/1e.0", O_RDONLY) = 4
open("/proc/bus/pci/00/1f.0", O_RDONLY) = 4
open("/proc/bus/pci/00/1f.1", O_RDONLY) = 4
open("/proc/bus/pci/00/1f.2", O_RDONLY) = 4
open("/proc/bus/pci/00/1f.3", O_RDONLY) = 4
open("/proc/bus/pci/00/1f.5", O_RDONLY) = 4
open("/proc/bus/pci/01/0c.0", O_RDONLY) = 4
open("/usr/share/ldetect-lst/pcitable", O_RDONLY) = 3
open("/proc/bus/usb/devices", O_RDONLY) = -1 ENOENT (No such file or directory)


tv@vador ~ $ sudo strace lspci 2>&1|fgrep open 
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
open("/lib/i686/libc.so.6", O_RDONLY)   = 3
open("/proc/bus/pci/devices", O_RDONLY) = 3
open("/proc/bus/pci/01/0c.0", O_RDONLY) = 3
open("/proc/bus/pci/00/1f.5", O_RDONLY) = 3
open("/proc/bus/pci/00/1f.3", O_RDONLY) = 3
open("/proc/bus/pci/00/1f.2", O_RDONLY) = 3
open("/proc/bus/pci/00/1f.1", O_RDONLY) = 3
open("/proc/bus/pci/00/1f.0", O_RDONLY) = 3
open("/proc/bus/pci/00/1e.0", O_RDONLY) = 3
open("/proc/bus/pci/00/01.0", O_RDONLY) = 3
open("/proc/bus/pci/00/00.0", O_RDONLY) = 3
open("/usr/share/pci.ids", O_RDONLY)    = 4


    (i wont put every output but i've straced and checked kudzu source
    in the past, have read harddrake1 source, 'm writting harrddrake2
    and so i do know for those)

