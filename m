Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbUBZObV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 09:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUBZObV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 09:31:21 -0500
Received: from village.ehouse.ru ([193.111.92.18]:12554 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261623AbUBZObH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 09:31:07 -0500
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1 IO lockup on SMP systems
Date: Thu, 26 Feb 2004 17:30:51 +0300
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org, gluk@php4.ru, anton@megashop.ru,
       mfedyk@matchmail.com
References: <200401311940.28078.rathamahata@php4.ru> <200402261519.35506.rathamahata@php4.ru> <20040226045331.060c07d3.akpm@osdl.org>
In-Reply-To: <20040226045331.060c07d3.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402261730.51874.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 February 2004 15:53, Andrew Morton wrote:
> "Sergey S. Kostyliov" <rathamahata@php4.ru> wrote:
> >
> > Yet another lockup has just occurred. I could be wrong but from the
> > /proc/meminfo content it doesn't looks like memory leak (neither kernel
> > nor userspace), doesn't it?
> 
> I think it's a kernel leak.
> 
> > Thu Feb 26 05:00:15 MSK 2004
> > MemTotal:      2073868 kB
> > MemFree:          2528 kB
> > Buffers:          2180 kB
> > Cached:          34216 kB
> > SwapCached:     643808 kB
> > Active:         999316 kB
> > Inactive:        12088 kB
> > HighTotal:     1179648 kB
> > HighFree:          576 kB
> > LowTotal:       894220 kB
> > LowFree:          1952 kB
> > SwapTotal:     3583968 kB
> > SwapFree:      2559796 kB
> > Dirty:               0 kB
> > Writeback:        3052 kB
> > Mapped:        1001208 kB
> > Slab:            23932 kB
> > Committed_AS:  1979784 kB
> > PageTables:       4840 kB
> > VmallocTotal:   114680 kB
> > VmallocUsed:      7448 kB
> > VmallocChunk:   107232 kB
> 
> A gig of mapped memory, most of it in swapcache.  That's probably all
> highmem.  Only a gig of memory on the page LRU.  Where is the rest?  Lost.
> 
> Almost no pagecache at all, slab is small.
> 
> > 3) sysrq-T:
> > ===========
> > http://sysadminday.org.ru/2.6.3-lockup/20040226/sysrq-T
> 
> hm, you have 34 instances of crond running.   How odd.
> 
> > 3) `vmstat 30':
> > ===============
> > procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
> >  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
> >  0 19 1255096   1952   1996  19920  426 1763   505  1778 1068   172  0  1  0 99
> >  0 24 1260156   1944   2028  19816  374 1650   463  1670 1067   165  0  1  0 99
> 
> Again, all your memory has vanished.
> 
> I'd say that we've leaked everything in lowmem and everyone is stuck trying
> to reclaim some lowmem memory.  Not sure why the oom-killer didn't do
> anything.  I haven't tested it in a year - maybe it broke.
> 
> So.  What are you using which is different from everyone else?  DAC960 I
> see.  What about firewall setups, NIC drivers, RAID/MD/etc?  Anything in
> there which isn't a mainstream thing?

Iptables (ipt_REJECT,ipt_state,ip_conntrack,ipt_state,iptable_filter modules)
is used as firewall.

I think NICs are pretty usual:
00:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
00:05.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
handled by Intel e100 driver.

Only plain partitions (there is no md, dm or something like this):
[rathamahata@ope rathamahata]$ mount
/dev/rd/host0/target0/part1 on / type reiserfs (rw)
none on /proc type proc (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/rd/host0/target1/part2 on /usr/local type reiserfs (rw)
/dev/rd/host0/target3/part1 on /var type reiserfs (rw,noatime,nodiratime)
/dev/rd/host0/target7/part1 on /var/www/html/fo type reiserfs (rw,noatime,nodiratime)
/dev/rd/host0/target2/part1 on /home type reiserfs (rw,noatime,nodiratime)
/dev/rd/host0/target4/part1 on /var/lib/innodb/1 type reiserfs (rw,noatime,nodiratime,notail)
/dev/rd/host0/target5/part1 on /var/lib/innodb/2 type reiserfs (rw,noatime,nodiratime,notail)
/dev/rd/host0/target6/part1 on /var/lib/oracle/db04 type reiserfs (rw,noatime,nodiratime,notail)
sysfs on /sys type sysfs (rw)

Here is a .config:
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_ACPI_BOOT=y
CONFIG_APM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_DAC960=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_NETFILTER=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_NET_PCI=y
CONFIG_E100=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_EXT2_FS=m
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=m
CONFIG_FS_MBCACHE=m
CONFIG_REISERFS_FS=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_DEVFS_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y

> 
> 
> 

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
