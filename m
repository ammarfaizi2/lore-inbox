Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268017AbTAIWtT>; Thu, 9 Jan 2003 17:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268032AbTAIWtS>; Thu, 9 Jan 2003 17:49:18 -0500
Received: from esperi.demon.co.uk ([194.222.138.8]:39686 "EHLO
	esperi.demon.co.uk") by vger.kernel.org with ESMTP
	id <S268017AbTAIWsy>; Thu, 9 Jan 2003 17:48:54 -0500
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: strange sparc64 -> i586 intermittent but reproducible NFS write errors to one and only one fs
X-Emacs: or perhaps you'd prefer Russian Roulette, after all?
From: Nix <nix@esperi.demon.co.uk>
Date: 09 Jan 2003 22:56:45 +0000
Message-ID: <87bs2q3paq.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Military Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I rebooted my systems into 2.4.20 (from 2.4.19), I started seeing
EIO write() errors to files in my ext3 home directory (NFS-mounted,
exported async).

So I knocked up a test program (included below) to try to track the
failing writes down, and got more confused.

The properties of the failing writes that I've been able to determine
thus far are as follows; look out, they're weird as hell:

 - the failures are definitely from write(), not open().

 - writes from sparc64 to one filesystem, and only one filesystem, on
   i586, both running 2.4.20, UDP NFSv3; rquotad and quotas are on, but
   I am well within my quota. (quota 3.06, nfs-utils 1.0). Writes to
   other filesystems on the same machine, even if they too are using
   ext3, even if they too have user quotas for the same user.

   What differs between filesystems that work and the one that fails I
   can't tell; other FSen *on the same block device* work... (the block
   device is an un-RAIDed SCSI disk.)

 - local writes to the same filesystem, with the same test program,
   never fail.

 - writes from another IA32 box (all these boxes are near-clones of
   each other as far as software is concerned) to the NFS server box
   never fail.

 - It happens if I mount the fs with -o soft (my default for all NFS
   mounts for robustness-in-the-presence-of-machine-failure reasons),
   but also if I mount with -o hard :(( besides, the timeouts happen far
   too fast for it to be major timeout expiry that casues the EIOs.

 - The failure always occurs for writes that cross the 2^21 byte
   boundary, but not all such writes fail. You seem to need to have
   done a lot of write()s before, perhaps even starting with O_TRUNC
   and write()ing like mad from there on up (the WRITES_PER_OPEN
   #define is a way to test that; I've never had a failure for a file
   opened with O_APPEND, even if it crossed the 2^21 byte boundary).

 - It happens whether _LARGEFILE_SOURCE / _FILE_OFFSET_BITS are
   defined or not (I'd be amazed if this affected it, actually, but
   it never hurts to check).

 - Despite the EIO, the write actually *succeeds* most of the time
   (perhaps not all the time; again, I'm not sure yet). In fact...

 - It is quite thoroughly inconsistent. If you #define REPRODUCE to 1
   in the test program and fill out sizes_to_reproduce[] with a set
   of write() sizes that have caused the error in the past, the error
   happens again, but not always:

done
done
Input/output error writing buffer size 246392, total size 2253462, iteration 9, writes since open() 9
Sizes used: (278831, 368095, 327921, 177734, 341464, 74705, 104763, 266303, 313646, 246392)
done
Input/output error writing buffer size 246392, total size 2253462, iteration 9, writes since open() 9
Sizes used: (278831, 368095, 327921, 177734, 341464, 74705, 104763, 266303, 313646, 246392)
done
Input/output error writing buffer size 246392, total size 2253462, iteration 9, writes since open() 9
Sizes used: (278831, 368095, 327921, 177734, 341464, 74705, 104763, 266303, 313646, 246392)
done
Input/output error writing buffer size 246392, total size 2253462, iteration 9, writes since open() 9
Sizes used: (278831, 368095, 327921, 177734, 341464, 74705, 104763, 266303, 313646, 246392)
done
done
done
done
done
done
done
Input/output error writing buffer size 246392, total size 2253462, iteration 9, writes since open() 9
Sizes used: (278831, 368095, 327921, 177734, 341464, 74705, 104763, 266303, 313646, 246392)
done

(This is pretty much exactly what running the test program looks like if
REPRODUCE is off, as well, except that with it off the failing numbers
differ each time. :) )

The kernel logs are quite empty of anything at the time these errors
occur; there's not even an NFS timeout error.

I'm using gcc-3.2.1 and glibc-2.2.5; the kernel compilers were
egcs64-19980921.1 on the sparc64 side and gcc-2.95.4pre-as-of 2001-10-02
on the i586 side.

Anyway, here's the test program; --std=gnu99 required unless you make a
few tiny changes:

#define _FILE_OFFSET_BITS 64
#define _LARGEFILE_SOURCE 1
#define _GNU_SOURCE 1

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <time.h>

#define MAXSIZE 400000
#define ITERATIONS 10
#define WRITES_PER_OPEN 10
#define FNAME "/home/nix/tmp/test-big-write"
#define REPRODUCE 0

#if REPRODUCE
  size_t sizes_to_reproduce[ITERATIONS]={278831, 368095, 327921, 177734, 341464, 74705, 104763, 266303, 313646, 246392};
#endif

int main (void)
 {
  int foo;

  errno=0;

  if ((foo=open (FNAME, O_WRONLY | O_CREAT | O_TRUNC | O_LARGEFILE, 0644))<0)
   {
    perror ("opening file: ");
    exit (1);
   }

  srandom (time (NULL));
  
  int i=0;
  int writes_since_open=0;
  size_t size;
  char *buf = NULL;
  size_t sizes_used[ITERATIONS];

  for (i=0; i<ITERATIONS; ++i, ++writes_since_open)
   {
#ifdef REPRODUCE
    size=sizes_to_reproduce[i];
#else
    size=(((double)random()/RAND_MAX)*MAXSIZE);
#endif
    sizes_used[i]=size;

    free (buf);
    errno=0;
    if ((buf=(char *)calloc (size,1))==NULL)
     {
      perror ("allocating memory: ");
      close (foo);
      unlink (FNAME);
      exit (2);
     }

    errno=0;
    if ((write (foo, buf, size))<0)
     {
      struct stat foostat;

      fstat (foo, &foostat);
      fprintf (stderr,"%s writing buffer size %lu, total size %lli, iteration %i, writes since open() %i\n",strerror (errno),size,foostat.st_size, i, writes_since_open);
      fprintf (stderr,"Sizes used: (");
      for (int j=0; j<i; ++j)
       {
        fprintf (stderr, "%lu, ", sizes_used[j]);
       }
      fprintf (stderr, "%lu)\n", sizes_used[i]);
     }
    if (writes_since_open > WRITES_PER_OPEN)
     {
      writes_since_open=0;
      close (foo);
      if ((foo=open (FNAME, O_WRONLY | O_APPEND | O_LARGEFILE, 0644))<0)
       {
        perror ("reopening file: ");
        exit (1);
       }
     }
   }

  close (foo);
  unlink (FNAME);

  printf ("done\n");

  return 0;
 }

Change FNAME to point to a file you don't mind losing ;) set ITERATIONS,
MAXSIZE and WRITES_PER_OPEN such that some of the
randomly-sized-sets-of-writes will go over the 2^21-byte limit, and see
if you can reproduce it.

Here's the .config on the sparc64 side (there's more below this, scroll
down):

CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_BBC_I2C=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SPARC64=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_SBUS=y
CONFIG_SBUSCHAR=y
CONFIG_BUSMOUSE=y
CONFIG_SUN_MOUSE=y
CONFIG_SERIAL=y
CONFIG_SUN_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SUN_KEYBOARD=y
CONFIG_SUN_CONSOLE=y
CONFIG_SUN_AUXIO=y
CONFIG_SUN_IO=y
CONFIG_PCI=y
CONFIG_RTC=y
CONFIG_PCI_NAMES=y
CONFIG_SUN_OPENPROMFS=m
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_SPARC32_COMPAT=y
CONFIG_BINFMT_ELF32=y
CONFIG_BINFMT_ELF=m
CONFIG_BINFMT_MISC=m
CONFIG_SOLARIS_EMUL=m
CONFIG_ENVCTRL=m
CONFIG_WATCHDOG_CP1XXX=m
CONFIG_PROM_CONSOLE=y
CONFIG_SUN_OPENPROMIO=m
CONFIG_SUN_MOSTEK_RTC=y
CONFIG_SAB82532=y
CONFIG_OBP_FLASH=m
CONFIG_SUN_AURORA=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_RARP=y
CONFIG_IP_MROUTE=y
CONFIG_SYN_COOKIES=y
CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_NS87415=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=10
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_HAPPYMEAL=y
CONFIG_SUNBMAC=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=1024
CONFIG_QUOTA=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UFS_FS=m
CONFIG_INTERMEZZO_FS=m
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_SUN_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_15=m
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

And here's the .config on the i586 side:

CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_M586MMX=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_MCE=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=10
CONFIG_BLK_DEV_SR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_PLIP=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=y
CONFIG_QUOTA=y
CONFIG_REISERFS_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_MINIX_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_INTERMEZZO_FS=m
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_15=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=y
CONFIG_SOUND_OSS=m
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
CONFIG_SOUND_YM3812=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

Modules loaded, i586 side:

Module                  Size  Used by    Not tainted
opl3                   11040   0
sb                      7348   1
sb_lib                 32334   0 [sb]
uart401                 6020   0 [sb_lib]
sound                  51756   1 [opl3 sb_lib uart401]
nls_iso8859-1           2844   1 (autoclean)
nls_cp437               4348   1 (autoclean)

(No modules are loaded on the sparc64 side.)


Anyone got any ideas? This is really, really weird.

-- 
`I knew that there had to be aliens somewhere in the universe.  What I
 did not know until now was that they read USENET.' --- Mark Hughes,
      on those who unaccountably fail to like _A Fire Upon The Deep_
