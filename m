Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291619AbSBHPuX>; Fri, 8 Feb 2002 10:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291620AbSBHPuO>; Fri, 8 Feb 2002 10:50:14 -0500
Received: from jp.jh-inst.cas.cz ([147.231.28.95]:61826 "EHLO
	jp.jh-inst.cas.cz") by vger.kernel.org with ESMTP
	id <S291619AbSBHPuA>; Fri, 8 Feb 2002 10:50:00 -0500
Date: Fri, 8 Feb 2002 16:49:59 +0100
From: Jiri Pittner <jiri.pittner@jh-inst.cas.cz>
Message-Id: <200202081549.g18Fnx705768@jp.jh-inst.cas.cz>
To: linux-kernel@vger.kernel.org
Subject: BUG report - PROBLEM in LARGEFILE64 support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear kernel developers,

I would like to report a bug in the _LARGEFILE64 support.

SUMMARY: 
The function freopen64() causes core dump with 2.4 kernels, with 2.3.99-pre9 works well

DESCRIPTION: 
We traced down some strange behavior of application software to the problem
of freopen64() call, when the file size really exceeds 2GB. The example program
below works always, when the file is small, but with file offset of 3GB it worked only
with the kernel 2.3.99-pre9 LIBC 2.1 (debian).
 The SAME executable with identical shared libs failed when the machine was rebooted with 2.4.9 kernel.
The SuSE distribution 
Linux version 2.4.4-4GB (root@Pentium.suse.de) (gcc version 2.95.3 20010315 (SuSE)) #1 Wed May 16 00:37:55 GMT 2001
fails as well.
Always the ext2 filesystem was used.

It seems to be well reproducible on different machines, however, here is detailed description of the one with SuSE:
Linux jp 2.4.4-4GB #1 Wed May 16 00:37:55 GMT 2001 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.91.0.4
util-linux             2.11b
mount                  2.11b
modutils               2.4.5
e2fsprogs              1.19
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.25
PPP                    2.4.0
isdn4k-utils           3.1pre1a
Linux C Library        x    1 root     root      1343073 kvì 11  2001 /lib/libc.so.6
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0
Modules Loaded         ppp_async ppp_generic snd-pcm-oss snd-pcm-plugin snd-mixer-oss snd-seq-midi snd-seq-midi-event snd-seq snd-card-ymfpci snd-ymfpci snd-pcm snd-ac97-codec snd-mixer snd-opl3 snd-hwdep snd-timer snd-mpu401-uart snd-rawmidi snd-seq-device snd soundcore parport_pc lp parport keybdev mousedev hid input usb-uhci nfsd ipv6 serial_cs ds i82365 pcmcia_core af_packet pcnet32 ipchains irtty irda nls_iso8859-2 nls_cp852 usbcore lvm-mod


Best regards,

Jiri



===============================================================================

#define _LARGEFILE64_SOURCE
#include <stdio.h>
#include <fcntl.h>
#include<stdlib.h>

main()
{
FILE *f,*g;
int fn,gn;
off64_t o,p;
int a,b;
size_t r;

a=1234;


unlink("/scratch/jiri/large");

f=fopen64("/scratch/jiri/large","w+");
fn=fileno(f);

o=1024*1024*(long long)1024*3+100;//big - this fails on new kernels
//o=1024*(long long)1024*3+100;//small - this always works
p=lseek64(fn,o,SEEK_SET);
r=fwrite(&a,sizeof(int),1,f);printf("%d\n",r);
r=fwrite(&a,sizeof(int),1,f);printf("%d\n",r);
r=fwrite(&a,sizeof(int),1,f);printf("%d\n",r);
r=fwrite(&a,sizeof(int),1,f);printf("%d\n",r);
fflush(f);

g=freopen64("/scratch/jiri/large","r+",f);
gn=fileno(g);
printf("%d %d\n",fn,gn);

p=lseek64(gn,o,SEEK_SET);
r=fread(&b,sizeof(int),1,g);
printf("%d %d\n",r,b);
fclose(g);
system("ls -l /scratch/jiri/large");
}

