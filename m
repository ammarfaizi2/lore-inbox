Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129880AbRAWSLH>; Tue, 23 Jan 2001 13:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129789AbRAWSLA>; Tue, 23 Jan 2001 13:11:00 -0500
Received: from internal-bristol33.naxs.com ([216.98.66.33]:56071 "HELO
	internal-bristol33.naxs.com") by vger.kernel.org with SMTP
	id <S131105AbRAWSHp>; Tue, 23 Jan 2001 13:07:45 -0500
Date: Tue, 23 Jan 2001 12:54:54 -0500
From: William Thompson <wt@electro-mechanical.com>
To: linux-kernel@vger.kernel.org
Subject: M68K mac 2.2.18 doesn't compile
Message-ID: <20010123125454.A29940@coredump.electro-mechanical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First few things I noticed were things left out.  I'm not sure about any of
these.  The last thing is vmlinux doesn't link.  Tons of missing symbols.

This is what I did to compile:

---cut---
diff -rux*.o arch/m68k/kernel/setup.c
/mnt2/usr/src/linux/arch/m68k/kernel/setup.c
--- arch/m68k/kernel/setup.c    Tue Jan 23 07:52:41 2001
+++ /mnt2/usr/src/linux/arch/m68k/kernel/setup.c        Tue Jan 23 11:01:41
2001
@@ -398,7 +398,7 @@
     else
        mmu = "unknown";
 
-    clockfreq = loops_per_sec*clockfactor;
+    clockfreq = loops_per_jiffy*clockfactor;
 
     return(sprintf(buffer, "CPU:\t\t%s\n"
                   "MMU:\t\t%s\n"
@@ -408,8 +408,8 @@
                   "Calibration:\t%lu loops\n",
                   cpu, mmu, fpu,
                   clockfreq/1000000,(clockfreq/100000)%10,
-                  loops_per_sec/500000,(loops_per_sec/5000)%100,
-                  loops_per_sec));
+                  loops_per_jiffy/500000,(loops_per_jiffy/5000)%100,
+                  loops_per_jiffy));
 
 }
 
diff -u arch/m68k/mac/iop.c /mnt2/usr/src/linux/arch/m68k/mac/iop.c
--- arch/m68k/mac/iop.c Tue Jan 23 07:52:42 2001
+++ /mnt2/usr/src/linux/arch/m68k/mac/iop.c     Tue Jan 23 11:37:01 2001
@@ -134,6 +134,9 @@
 
 int iop_get_proc_info(char *, char **, off_t, int, int);
   
+/* added wt */
+#define PROC_MAC_VIA   0
+
 static struct proc_dir_entry proc_mac_iop = {
 	PROC_MAC_VIA, 7, "mac_iop",
 	S_IFREG | S_IRUGO, 1, 0, 0,
diff -ru include/asm-m68k/delay.h
/mnt2/usr/src/linux/include/asm-m68k/delay.h
--- include/asm-m68k/delay.h    Wed Sep 25 03:47:41 1996
+++ /mnt2/usr/src/linux/include/asm-m68k/delay.h        Fri Jan 19 10:34:22
2001
@@ -27,7 +27,7 @@
        usecs *= 4295;          /* 2**32 / 1000000 */
        __asm__ ("mulul %2,%0:%1"
                : "=d" (usecs), "=d" (tmp)
-               : "d" (usecs), "1" (loops_per_sec));
+               : "d" (usecs), "1" (loops_per_jiffy));
        __delay(usecs);
 }
diff -ru include/linux/nubus.h /mnt2/usr/src/linux/include/linux/nubus.h
--- include/linux/nubus.h       Tue Jan 23 07:54:42 2001
+++ /mnt2/usr/src/linux/include/linux/nubus.h   Fri Jan 19 14:40:26 2001
@@ -321,4 +321,6 @@
        return (void *)(0xF0000000|(slot<<24));
 }
 
+#define PROC_BUS_NUBUS_DEVICES 10
+
 #endif LINUX_NUBUS_H
diff -ru include/linux/sched.h /mnt2/usr/src/linux/include/linux/sched.h
--- include/linux/sched.h       Tue Jan 23 07:54:42 2001
+++ /mnt2/usr/src/linux/include/linux/sched.h   Tue Jan 23 08:58:25 2001
@@ -332,6 +332,9 @@
 
 /* oom handling */
        int oom_kill_try;
+
+       /* misc added - wt */
+       siginfo_t buserr_info;
 };
 
 /*

---cut---
This is the error when linking:
ld -m m68kelf -T /usr/src/linux/arch/m68k/vmlinux.lds arch/m68k/kernel/head.o init/main.o init/version.o \
        --start-group \
        arch/m68k/kernel/kernel.o arch/m68k/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/m68k/mac/mac.o arch/m68k/fpsp040/fpsp.o \
        fs/filesystems.a \
        net/network.a \
        drivers/block/block.a drivers/char/char.o drivers/misc/misc.a drivers/nubus/nubus.a drivers/net/net.a drivers/scsi/scsi.a drivers/cdrom/cdrom.a drivers/video/video.a \
        /usr/src/linux/lib/lib.a arch/m68k/lib/lib.a \
        --end-group \
        -o vmlinux
arch/m68k/kernel/kernel.o: In function `rs_init':
arch/m68k/kernel/kernel.o(.text+0x317e): undefined reference to `m68k_rs_init'
arch/m68k/kernel/kernel.o: In function `register_serial':
arch/m68k/kernel/kernel.o(.text+0x318c): undefined reference to `m68k_register_serial'
arch/m68k/kernel/kernel.o: In function `unregister_serial':
arch/m68k/kernel/kernel.o(.text+0x319c): undefined reference to `m68k_unregister_serial'
arch/m68k/mac/mac.o: In function `mackbd_init_hw':
arch/m68k/mac/mac.o(.text.init+0xb5c): undefined reference to `key_maps'
arch/m68k/mac/mac.o(.text.init+0xb74): undefined reference to `key_maps'
arch/m68k/mac/mac.o(.text.init+0xb86): undefined reference to `key_maps'
arch/m68k/mac/mac.o(.text.init+0xb98): undefined reference to `key_maps'
arch/m68k/mac/mac.o(.text.init+0xbaa): undefined reference to `key_maps'
arch/m68k/mac/mac.o(.text.init+0xbbc): more undefined references to `key_maps' follow
drivers/char/char.o: In function `handle_diacr':
drivers/char/char.o(.text+0x5c8a): undefined reference to `accent_table_size'
drivers/char/char.o(.text+0x5c94): undefined reference to `accent_table'
drivers/char/char.o(.text+0x5c9c): undefined reference to `accent_table'
drivers/char/char.o(.text+0x5cda): undefined reference to `accent_table'
drivers/char/char.o: In function `do_fn':
drivers/char/char.o(.text+0x5d1e): undefined reference to `func_table'
drivers/char/char.o: In function `compute_shiftstate':
drivers/char/char.o(.text+0x5fba): undefined reference to `key_maps'
drivers/char/char.o: In function `vt_ioctl':
drivers/char/char.o(.text+0xcc50): undefined reference to `key_maps'
drivers/char/char.o(.text+0xccc0): undefined reference to `key_maps'
drivers/char/char.o(.text+0xccf0): undefined reference to `keymap_count'
drivers/char/char.o(.text+0xcd3c): undefined reference to `key_maps'
drivers/char/char.o(.text+0xcd50): undefined reference to `keymap_count'
drivers/char/char.o(.text+0xcda0): undefined reference to `keymap_count'
drivers/char/char.o(.text+0xce52): undefined reference to `func_table'
drivers/char/char.o(.text+0xcea0): undefined reference to `func_table'
drivers/char/char.o(.text+0xceaa): undefined reference to `funcbufsize'
drivers/char/char.o(.text+0xceb0): undefined reference to `funcbufleft'
drivers/char/char.o(.text+0xceba): undefined reference to `funcbufptr'
drivers/char/char.o(.text+0xcede): undefined reference to `func_table'
drivers/char/char.o(.text+0xcf08): undefined reference to `func_table'
drivers/char/char.o(.text+0xd03c): undefined reference to `func_table'
drivers/char/char.o(.text+0xd04e): undefined reference to `func_table'
drivers/char/char.o(.text+0xd066): undefined reference to `func_table'
drivers/char/char.o(.text+0xd076): undefined reference to `funcbufleft'
drivers/char/char.o(.text+0xd0b0): undefined reference to `func_table'
drivers/char/char.o(.text+0xd0be): undefined reference to `funcbufptr'
drivers/char/char.o(.text+0xd18a): undefined reference to `func_table'
drivers/char/char.o(.text+0xd190): undefined reference to `funcbufptr'
drivers/char/char.o(.text+0xd1a4): undefined reference to `func_table'
drivers/char/char.o(.text+0xd1be): undefined reference to `funcbufptr'
drivers/char/char.o(.text+0xd28e): undefined reference to `func_table'
drivers/char/char.o(.text+0xd294): undefined reference to `funcbufptr'
drivers/char/char.o(.text+0xd2aa): undefined reference to `func_table'
drivers/char/char.o(.text+0xd2be): undefined reference to `funcbufptr'
drivers/char/char.o(.text+0xd2c4): undefined reference to `func_buf'
drivers/char/char.o(.text+0xd2cc): undefined reference to `funcbufsize'
drivers/char/char.o(.text+0xd2dc): undefined reference to `funcbufptr'
drivers/char/char.o(.text+0xd2e2): undefined reference to `funcbufleft'
drivers/char/char.o(.text+0xd2ec): undefined reference to `funcbufsize'
drivers/char/char.o(.text+0xd2f2): undefined reference to `funcbufleft'
drivers/char/char.o(.text+0xd2f8): undefined reference to `funcbufsize'
drivers/char/char.o(.text+0xd2fe): undefined reference to `func_table'
drivers/char/char.o(.text+0xd31a): undefined reference to `accent_table_size'
drivers/char/char.o(.text+0xd330): undefined reference to `accent_table'
drivers/char/char.o(.text+0xd398): undefined reference to `accent_table_size'
drivers/char/char.o(.text+0xd3a4): undefined reference to `accent_table'
drivers/scsi/scsi.a(hosts.o)(.data+0xc): undefined reference to `proc_scsi_esp'
drivers/scsi/scsi.a(hosts.o)(.data+0x10): undefined reference to `esp_proc_info'
drivers/scsi/scsi.a(hosts.o)(.data+0x18): undefined reference to `mac_esp_detect'
drivers/scsi/scsi.a(hosts.o)(.data+0x24): undefined reference to `esp_info'
drivers/scsi/scsi.a(hosts.o)(.data+0x30): undefined reference to `esp_queue'
drivers/scsi/scsi.a(hosts.o)(.data+0x48): undefined reference to `esp_abort'
drivers/scsi/scsi.a(hosts.o)(.data+0x4c): undefined reference to `esp_reset'
make: *** [vmlinux] Error 1
---cut---
My .config (comments stripped)
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MAC=y
CONFIG_NUBUS=y
CONFIG_M68K_L2_CACHE=y
CONFIG_M68040=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_BINFMT_ELF=y
CONFIG_PROC_HARDWARE=y
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_PARIDE_PARPORT=y
CONFIG_PACKET=m
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ALIAS=y
CONFIG_IPX=m
CONFIG_ATALK=m
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_MAC_ESP=y
CONFIG_NETDEVICES=y
CONFIG_MACSONIC=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_ADBMOUSE=y
CONFIG_MAC_SCC=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_HFS_FS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=m
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_SMB_FS=m
CONFIG_NCP_FS=m
CONFIG_NCPFS_OS2_NS=y
CONFIG_NCPFS_SMALLDOS=y
CONFIG_NCPFS_MOUNT_SUBDIR=y
CONFIG_NCPFS_EXTRAS=y
CONFIG_MAC_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_ISO8859_1=m
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_MAC=y
CONFIG_FBCON_MFB=y
CONFIG_FBCON_CFB2=y
CONFIG_FBCON_CFB4=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_MAC=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_FONT_6x11=y
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
