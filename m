Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129366AbQKPAas>; Wed, 15 Nov 2000 19:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129279AbQKPAa2>; Wed, 15 Nov 2000 19:30:28 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:32781 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129177AbQKPAaY>; Wed, 15 Nov 2000 19:30:24 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Ivan Kanis <ivank@wrq.com>
Date: Thu, 16 Nov 2000 11:00:02 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14867.9090.689736.462761@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs-devel@linux.kernel.org
Subject: Re: [BUG] knfsd causes file system corruption when files are locked. 
In-Reply-To: message from Ivan Kanis on Wednesday November 15
In-Reply-To: <14867.6967.292440.394045@jedi.wrq.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 15, ivank@wrq.com wrote:
> [1.] knfsd causes file system corruption when files are locked.
> 
> [2.] Lock down a file using the NLM_SHARE sharing mechanism. Remove
> the file. Unlock the file using NLM_UNSHARE. The filesystem does not
> recover the file space. I am running this on ext2fs. Fsck-ing the
> filesystem does not help. The only way to recover the space is to
> reformat the partition.
> 
> [3.] knfsd, lock, NLM_SHARE, NLM_UNSHARE
> 
> [4.] Linux version 2.2.16 (root@jedi) (gcc version 2.7.2.3)

Lots of changes have gone into knfsd since 2.2.16.  Could you please
try again with either a later 2.2.18pre kernel, or 2.2.16 with patches
from 
   http://nfs.sourceforge.net/
applied?  Thanks.

Quick guide is:
    2.2.16
  plus
    http://www.fys.uio.no/~trondmy/src/nfsv3-old/linux-2.2.16-nfsv3-0.22.0.dif.bz2
  plus
    http://download.sourceforge.net/nfs/kernel-nfs-dhiggen_merge-2.0.gz

NeilBrown

> 
> [5.] N/A
> 
> [6.] This test.c program will reproduce the problem. You need to compile it
> on a Solaris machine because Linux fcntl does not support NLM_SHARE.
> 
> -----start here
> #include <fcntl.h> 
> #include <errno.h> 
> #include <stdio.h> 
>   
> int main (int argc, char *argv[])  
> { 
>   struct fshare lck; 
>   int fd, ret; 
>   if (argc != 2) { 
>     printf ("Usage: %s file to lock\n", argv[0]); 
>     return 1; 
>   } 
>   fd = open (argv[1], O_WRONLY); 
>   memset (&lck, 0, sizeof (struct flock)); 
>   lck.f_access = F_WRACC; 
>   lck.f_deny = F_NODNY; 
>   ret = fcntl (fd, F_SHARE, &lck); 
>   unlink (argv[1]); 
>   ret = fcntl (fd, F_UNSHARE, &lck); 
>  
>   return 0; 
> } 
> -----end here
> 
> Step to reproduce the problem
> 
> - Compile the program:
> gcc test.c -o test
> 
> - Mount a Linux nfs partition on Solaris: (Remember the partition will
> get corrupted, use a partition that you don't care about.)
> mount -o vers=2 jedi:/sandbox /mnt
> 
> - Create a chunk of data on /mnt
> dd if=/dev/zero of=/mnt/chunk count=10000
> 
> - Do a df before running the program
> 
> - Run the test program
> ./test /mnt/chunk
> 
> - Run df again. The free space reamains the same. The space is gone
> till you reformat the partition.
> 
> 
> [7.] This bug was seen on a Debian 2.2 machine. We have seen the same
> thing happens on systems running Red Hat 6.2 and TurboLinux 6.0 distributions.
> 
> [7.1] Environment:
> Kernel modules         found
> Gnu C                  2.95.2
> Binutils               2.9.5.0.37
> Linux C Library        ..
> Dynamic Linker (ld.so) 1.9.11
> ls: /usr/lib/libg++.so: No such file or directory
> Procps                 2.0.6
> Mount                  2.10f
> Net-tools              (1999-04-20)
> Kbd                    0.99
> Sh-utils               2.0
> Sh-utils               Parker.
> Sh-utils               
> Sh-utils               Inc.
> Sh-utils               NO
> Sh-utils               PURPOSE.
> 
> [7.2] Processor information 
> 
> processor	: 0
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 5
> model name	: Pentium II (Deschutes)
> stepping	: 2
> cpu MHz		: 447.700
> cache size	: 512 KB
> fdiv_bug	: no
> hlt_bug		: no
> sep_bug		: no
> f00f_bug	: no
> coma_bug	: no
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 2
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
> bogomips	: 891.29
> 
> [7.3] Module information
> 
> aic7xxx               124328   1
> nfsd                  140436   8 (autoclean)
> snd-pcm-oss            16840   1 (autoclean)
> snd-pcm-plugin         13000   0 (autoclean) [snd-pcm-oss]
> snd-mixer-oss           4308   1 (autoclean) [snd-pcm-oss]
> snd-card-cs4236         5224   2
> snd-mpu401-uart         2356   0 [snd-card-cs4236]
> snd-rawmidi             9752   0 [snd-mpu401-uart]
> snd-seq-device          3476   0 [snd-rawmidi]
> isapnp                 27572   0 [snd-card-cs4236]
> snd-cs4236             20580   0 [snd-card-cs4236]
> snd-cs4231             19008   0 [snd-card-cs4236 snd-cs4236]
> snd-mixer              23536   0 [snd-mixer-oss snd-cs4236 snd-cs4231]
> snd-pcm                29784   0 [snd-pcm-oss snd-pcm-plugin snd-cs4231]
> snd-opl3                4328   0 [snd-card-cs4236]
> snd-timer               8224   0 [snd-cs4231 snd-pcm snd-opl3]
> snd-hwdep               3052   0 [snd-opl3]
> snd                    36300   1 [snd-pcm-oss snd-pcm-plugin snd-mixer-oss snd-card-cs4236 snd-mpu401-uart snd-rawmidi snd-seq-device snd-cs4236 snd-cs4231 snd-mixer snd-pcm snd-opl3 snd-timer snd-hwdep]
> soundcore               2448   3 [snd]
> 3c59x                  18212   1
> 
> [7.4] SCSI Information
> 
> Attached devices: 
> Host: scsi0 Channel: 00 Id: 05 Lun: 00
>   Vendor: NEC      Model: CD-ROM DRIVE:465 Rev: 1.03
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> 
> [7.5] N/A
> 
> [8.] Here is a trace from the Solaris snoop program while the test
> program mentioned above is running:
> 
>          sun -> jedi.wrq.com NFS C LOOKUP2 FH=2344 chunk 
> jedi.wrq.com -> sun          NFS R LOOKUP2 OK FH=D308 
>          sun -> jedi.wrq.com NLM C SHARE3 OH=0009 FH=D308 Mode=0 Access=2 
> jedi.wrq.com -> sun          NLM R SHARE3 OH=0009 granted 0 
>          sun -> jedi.wrq.com NLM C UNSHARE3 OH=000A FH=D308 Mode=0 Access=2 
> jedi.wrq.com -> sun          NLM R UNSHARE3 OH=000A granted 0 
>          sun -> jedi.wrq.com NFS C GETATTR2 FH=2344 
> jedi.wrq.com -> sun          NFS R GETATTR2 OK 
>          sun -> jedi.wrq.com NFS C LOOKUP2 FH=2344 chunk 
> jedi.wrq.com -> sun          NFS R LOOKUP2 OK FH=D308 
>          sun -> jedi.wrq.com NFS C LOOKUP2 FH=2344 .nfs5FC7 
> jedi.wrq.com -> sun          NFS R LOOKUP2 No such file or directory 
>          sun -> jedi.wrq.com NFS C RENAME2 FH=2344 chunk to FH=2344 .nfs5FC7 
> jedi.wrq.com -> sun          NFS R RENAME2 OK 
>          sun -> jedi.wrq.com NLM C UNSHARE3 OH=000B FH=D308 Mode=0 Access=1 
> jedi.wrq.com -> sun          NLM R UNSHARE3 OH=000B granted 0 
>          sun -> jedi.wrq.com NFS C REMOVE2 FH=2344 .nfs5FC7 
> jedi.wrq.com -> sun          NFS R REMOVE2 OK 
> 
> /
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
