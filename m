Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbVK1BeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVK1BeL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 20:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVK1BeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 20:34:11 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:35014
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751206AbVK1BeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 20:34:09 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] make miniconfig (take 2)
Date: Sun, 27 Nov 2005 18:59:20 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
References: <200511170629.42389.rob@landley.net> <200511251512.20330.rob@landley.net> <Pine.LNX.4.61.0511271841320.1610@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0511271841320.1610@scrub.home>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oZliDKxXzFVaV6Y"
Message-Id: <200511271859.20735.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_oZliDKxXzFVaV6Y
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 27 November 2005 17:20, Roman Zippel wrote:
> Hi,
>
> On Fri, 25 Nov 2005, Rob Landley wrote:
> > Ok, what's the best thing I can do to help get this implemented, working
> > _with_ you rather than against?
>
> It's not exactly simple, as it requires some kconfig hacking.
> Something relatively simply would be to change the miniconfig.sh script
> into a C program, where it would have to access to all the information to
> do the job fast and correctly.

We are in agreement that miniconfig.sh sucks.  (I always saw it as a temporary 
measure, to be replaced with kconfig being able to write it out directly 
someday.)  Unfortunately, while I've sort of poked at kconfig before, I don't 
understand its dependency mechanism well enough to calculate the result I 
want reliably.

The current miniconfig.sh is based on a very simple (and slow) procedure, and 
even then I still haven't figured out why miniconfig.sh run on a straight 
allnoconfig insists that CONFIG_PM should be set.  (It correctly eliminates 
everything else...)

I can take a stab at making conf.c do this if you'd like.  (Or possibly 
confdata.c...)  Is the (admittedly sucky) shell script your main objection?

> I think it can even be done in a single pass over all the symbols, where
> boolean/tristate symbols are checked if they are already at the minimum
> value and string/hex/int values are compared with their default values.

Minimum value?

> Next step could be to add a variation of allnoconfig with better error
> checking (e.g. checking that all requested symbols have been set),

Um, I thought my patch did that.  If any unrecognized symbols were 
encountered, my miniconfig patch would report it and exit with an error by 
the simple expedient of making the warning count a global and checking it 
afterwards.  (I did a sort of -Werror for kconfig.)  If it attempts to set an 
unrecognized symbol, it would already generate a warning, and if the warning 
count is nonzero it bails out with an error at the end.  Seemed to work quite 
well, for me anyway...

What cases would that not catch?

(In theory, I could just has easily have done that part in a pure makefile 
change, copying mini.config to allno.config, running the existing allnoconfig 
suppressing stdout and capturing stderr to an environment variable, printing 
the content of the environment variable, and then exiting with an error if 
the environment variable isn't blank.  I just thought patching the .c code 
was the correct way to do it.)

> the basic allnoconfig functionality is just a few lines of code, the fun is
> in the extras.
>
> To further reduce the config size one could look at the dependecies, e.g.:
>
> config FOO
>  depends on BAR && BAZ1 || BAZ2
>
> In this case FOO could also set BAR, but not BAZ1/BAZ2.

Good point, but the existing format is 90% of the gain for 10% of the effort.  
Going from .config to miniconfig for my laptop's kernel, for example, goes 
from 1370 lines to 138 lines, almost exactly a 10x reduction.  And that can 
be done (admittedly badly) today, with the patch I posted.

Dropping that 138 down to 120, or even to 100, is a polishing step in 
comparison.  Do you think there are another 30 lines that could be trimmed 
out of that 138?  (Attached.)

Looking through it, I remember setting most if not all of of those symbols in 
menuconfig...

> But this also requires a new frontend to read such a minimized config
> file and is quite a bit more complex.

Right now, I have mini.configs that the existing infrastructure can read.  
Currently, creating a miniconfig by hand involves setting exactly the set of 
symbols that you would modify in menuconfig.  And conceptually, to me, that's 
what a miniconfig is.  Only the symbols indicating exactly the features the 
human wants to include.  This has the advantage of being understandable to 
said human.

This miniconfig is using the same symbol names as the existing config system 
(which was originally designed to be human readable, long ago), it's just 
eliminating unnecessary information (almost all dependency information, 
except for some menu-opening symbols), and being a lot more forgiving to 
human editing (while the existing .config explicitly says "don't edit" in a 
comment at the top).

I don't understand what advantage the new frontend that's quite a bit more 
complex would give here.  Which symbols would we then not have to specify?  
(Can you give me an example from any currently existing .config?)

> bye, Roman

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.

--Boundary-00=_oZliDKxXzFVaV6Y
Content-Type: text/plain;
  charset="iso-8859-1";
  name="mini.config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mini.config"

CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_EMBEDDED=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SHMEM=y
CONFIG_LBD=y
CONFIG_IOSCHED_CFQ=y
CONFIG_MPENTIUMII=y
CONFIG_X86_GENERIC=y
CONFIG_HPET_TIMER=y
CONFIG_PREEMPT_VOLUNTARY=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_I8K=y
CONFIG_MTRR=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_ASUS=y
CONFIG_ACPI_IBM=y
CONFIG_ACPI_TOSHIBA=y
CONFIG_X86_PM_TIMER=y
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_SPEEDSTEP_ICH=y
CONFIG_PCI_MSI=y
CONFIG_ISA=y
CONFIG_PCCARD=y
CONFIG_CARDBUS=y
CONFIG_YENTA=y
CONFIG_BINFMT_ELF=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_NETFILTER=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IRC=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_IPRANGE=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IEEE80211=y
CONFIG_IEEE80211_CRYPT_WEP=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_CDROM_PKTCDVD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_NETDEVICES=y
CONFIG_BONDING=y
CONFIG_TUN=y
CONFIG_NET_RADIO=y
CONFIG_IPW2200=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_UNIX98_PTYS=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_ATI=y
CONFIG_DRM=y
CONFIG_DRM_RADEON=y
CONFIG_VGA_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SB16=y
CONFIG_SND_INTEL8X0=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_PRINTER=y
CONFIG_USB_STORAGE=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_VFAT_FS=y
CONFIG_PROC_FS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_UTF8=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_EARLY_PRINTK=y
CONFIG_4KSTACKS=y

--Boundary-00=_oZliDKxXzFVaV6Y--
