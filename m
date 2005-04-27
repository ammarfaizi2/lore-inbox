Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVD0WJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVD0WJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 18:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVD0WJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 18:09:26 -0400
Received: from moutng.kundenserver.de ([212.227.126.185]:2768 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262039AbVD0WJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 18:09:09 -0400
Message-ID: <42700D83.2000907@systematics-online.org>
Date: Thu, 28 Apr 2005 00:09:07 +0200
From: Dario Birtic <joys@systematics-online.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050424)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: Bogus PNI flag in /proc/cpuinfo]
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070300070308080704040004"
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:391d23fe2942d4fd0a1783a5c557536b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070300070308080704040004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------070300070308080704040004
Content-Type: message/rfc822;
 name="Bogus PNI flag in /proc/cpuinfo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Bogus PNI flag in /proc/cpuinfo"

Message-ID: <42700CC6.9090408@systematics-online.org>
Date: Thu, 28 Apr 2005 00:05:58 +0200
From: Dario Birtic <joys@systematics-online.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050424)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hpa@zytor.com
Subject: Bogus PNI flag in /proc/cpuinfo
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I am expiriencing bogus PNI /proc/cpuinfo flag (and as far I can tell,
out of plenty of auxillary /proc/cpuinfo flags I have seen on the
internet, everyone having the athlon64 architecture also):

cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 15
model name      : AMD Athlon(tm) 64 Processor 3500+
stepping        : 0
cpu MHz         : 2340.189
cache size      : 512 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 pni syscall nx mmxext lm
3dnowext 3dnow
bogomips        : 4636.67
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

Though this processor doesn't support PNI (aka SSE3) it is reported in
the flags.

cat /proc/version
Linux version 2.6.11-gentoo-r6 (root@beast) (gcc version 3.4.3 20041125
(Gentoo Linux 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)) #2 Mon Apr 25 00:34:25
CEST 2005

I am expiriencing this behaviour since cca. 2.6.8.1.

A simple testcase shows:
cat << "EOF" > test_pni.c
#include <stdint.h>

uint8_t __attribute__((aligned(64))) current[64];
uint8_t previous[64];

int main()
{
   int i;
   uint64_t result;
   uint32_t _eax, _ebx, _ecx, _edx;
   uint8_t _cpuid[13];
   uint32_t *_cpuid0 = (uint32_t*) _cpuid;
   uint32_t *_cpuid1 = (uint32_t*) ( _cpuid + 4 );
   uint32_t *_cpuid2 = (uint32_t*) ( _cpuid + 8 );
   uint8_t *ptr0 = current;
   uint8_t *ptr1 = previous;

   __asm__ __volatile__ (
         "cpuid\n"
         : "=a" (_eax),
         "=b" (*_cpuid0), "=d" (*_cpuid1), "=c" (*_cpuid2)
         : "a" (0) );
   _cpuid[12] = 0;
   printf( "cpuid(0) returns %d (%s)\n", _eax, _cpuid );
   __asm__ __volatile__ (
         "cpuid\n"
         : "=a" (_eax), "=b" (_ebx), "=c" (_ecx), "=d" (_edx)
         : "a" (1) );
   printf( "cpuid(1) returns %08x %08x %08x %08x\n",
         _eax, _ebx, _ecx, _edx );
   memset( current, 0xaa, 64 );
   memset( previous, 0x55, 64 );
   for( i = 0; i < 4; i ++ ) {
      __asm__ __volatile__ (
            "movdqa %0, %%xmm0\n"
            "movdqu %1, %%xmm1\n"
            "psadbw %%xmm1, %%xmm0\n"
            "paddw  %%xmm0, %%xmm2\n"
            "haddps %%xmm2, %%xmm2\n"
            "haddps %%xmm2, %%xmm2\n"
            : : "m" (*ptr0),
            "m" (*ptr1) : "xmm0", "xmm1", "xmm2" );
      ptr0 += 16;
      ptr1 += 16;
   }
   __asm__ __volatile__ (
         "movq %%xmm2, %0\n"
         : "=m" (result) );
   printf( "Result is %llu\n", result );
}
EOF
gcc -o test_pni test_pni.c
./test_pni

cpuid(0) returns 1 (AuthenticAMD)
cpuid(1) returns 00000ff0 00000800 00000000 078bfbff
Illegal instruction

This is expected since there is no PNI on this processor supported
(haddps being SSE3 instruction). Please also note that ECX bit 0 (PNI
support) is clear showing that SSE3 is *not* supported.

Regards
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCcAzG0UeelEJkwB4RAuKVAJ0fjAn/f58oUBOHXyP91D7Wa8AsHgCg4hUq
PuToRHnlBD/lLoG1Y+RIBTk=
=erX+
-----END PGP SIGNATURE-----


--------------070300070308080704040004--
