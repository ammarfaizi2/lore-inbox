Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319317AbSIKUDf>; Wed, 11 Sep 2002 16:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319311AbSIKUDf>; Wed, 11 Sep 2002 16:03:35 -0400
Received: from transport.cksoft.de ([62.111.66.27]:52486 "EHLO
	transport.cksoft.de") by vger.kernel.org with ESMTP
	id <S319322AbSIKUDS>; Wed, 11 Sep 2002 16:03:18 -0400
Date: Wed, 11 Sep 2002 22:07:34 +0200 (CEST)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
X-X-Sender: bz@e0-0.zab2.int.zabbadoz.net
To: linux-kernel@vger.kernel.org
Subject: 2.5.3x devfs and partition scanning
Message-ID: <Pine.BSF.4.44.0209112136580.13460-100000@e0-0.zab2.int.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

having some probs with/questions on devfs in 2.5.3x{-bk} and partition
scanning [devfs ml seems to be offline, broken, unresponsive ?].


if I boot with

Kernel command line: \
	debug root=/dev//dev/ide/host0/bus1/target1/lun0/part2 \
	devfs=dall,mount,only \
	console=tty0 console=ttyS0,9600n8r

I do get:
request_module[block-major-22]: not ready
and do_open [fs/block_dev.c:do_open()] fails at:
--- snipp ---
	if (!old) {
		if (!ops)
			goto out;		<-- takes this path
		bdev->bd_op = ops;
	} else {
--- snipp ---


if I boot without devfs=only (all other options the same) I get
past the
--- snipp ---
	if (devfs_only())
		return 0;
--- snipp ---
in register_blkdev [fs/block_dev.c:register_blkdev()] and get

 /dev/ide/host0/bus1/target1/lun0:

but then the thing hangs in check_partition()
[fs/partitions/check.c:check_partition()]
at

--- snipp ---
	state->limit = 1<<hd->minor_shift;
	for (i = 0; check_part[i]; i++) {
		int res, j;
		struct hd_struct *p;
passes printk here ->>>
		memset(&state->parts, 0, sizeof(state->parts));
		res = check_part[i](state, bdev);
never gets to printk here -->>>
		if (!res)
			continue;
--- snipp ---

within the first pass (i=0).



Questions:
--------------------

a) shouldn't there be a way to boot from ide with devfs=only turned on ?

b) anyone any idea why I cannot find any partition or why the thing
	hangs ? no oops, .... only stopped.

	I would epxect a p1 p2 p3 or s.th. like that ...

c) not really related but can we remove that extra /dev/ from
	init/do_mounts.c:225 ?




Some information:
(if anybody needs further information please let me know, and I can
place my serial-debugging-output with the source files, etc. on the web)

that's the way it looks like on 2.4.xx w/o devfs:

bz@megablast:~> mount
/dev/hdd2 on / type ext2 (rw,errors=remount-ro,errors=remount-ro)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/hdd3 on /home/bz/vmware type ext2 (rw,errors=remount-ro)
/dev/hdc1 on /export/dump type ext2 (rw)


this is info on what I did my tests with ...

Linux version 2.5.34 (bz@megablast) (gcc version 3.2) #24 SMP Wed Sep 11 17:25:57 UTC 2002

--- a .config excerpt ---
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

CONFIG_EXPERIMENTAL=y

CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y

CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_SMP=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_HAVE_DEC_LOCK=y


CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y

CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m

CONFIG_PNP=y
CONFIG_ISAPNP=y

CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=8192

CONFIG_IDE=y

CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDEDMA=y

CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y

CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

CONFIG_AUTOFS4_FS=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_CRAMFS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVFS_DEBUG=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y

CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SMB_FS=m
CONFIG_ZISOFS_FS=y

CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
--- /a .config excerpt ---

-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

