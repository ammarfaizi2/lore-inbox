Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261784AbSKCLXf>; Sun, 3 Nov 2002 06:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261766AbSKCLXf>; Sun, 3 Nov 2002 06:23:35 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:34830 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261784AbSKCLXa>; Sun, 3 Nov 2002 06:23:30 -0500
Message-Id: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: Some functions are not inlined by gcc 3.2, resulting code is ugly
Date: Sun, 3 Nov 2002 14:17:02 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems gcc started to de-inline large functions.
We got bitten:

# sort -t ' ' +2 <System.map
...
c01876f0 t __cleanup_transaction
c0150f90 t __clear_page_buffers
c01d9fa0 T __clear_user
c011b020 T __cond_resched
c01d9ea0 T __const_udelay
c0107150 t __constant_c_and_count_memset
c0107fd0 t __constant_c_and_count_memset

[~seven screenfuls (!) snipped]

c010c7f0 t __constant_c_and_count_memset
c010e210 t __constant_c_and_count_memset
c03609e0 t __constant_c_and_count_memset
c03634f0 t __constant_c_and_count_memset
c0107ec0 t __constant_memcpy
c010fc10 t __constant_memcpy

[more snipped]

c0111410 t __constant_memcpy
c0111e10 t __constant_memcpy
c0114b50 t __constant_memcpy
c0353e50 t __constant_memcpy
c03573a0 t __constant_memcpy
c035bfc0 t __constant_memcpy
c03633e0 t __constant_memcpy
c01da040 T __copy_from_user
c011dd30 t __copy_fs_struct
c01da000 T __copy_to_user

This happens in 2.4.19 too.

Let's take exit.c compilation as an example:

gcc -Wp,-MD,kernel/.exit.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i486 -Iarch/i386/mach-generic -nostdinc -iwithprefix include   
-DKBUILD_BASENAME=exit   -c -o kernel/exit.o kernel/exit.c

[2.5] objdump -D exit.o, abridged
=================================
exit.o:     file format elf32-i386

Disassembly of section .text:

...........
000004c0 <reparent_to_init>:
...........
     5ab:	68 84 03 00 00       	push   $0x384
     5b0:	50                   	push   %eax
     5b1:	e8 0a 12 00 00       	call   17c0 <__constant_memcpy>


Eek.... __constant_memcpy??! It carries this in string.h:
/*
 * This looks horribly ugly, but the compiler can optimize it totally,
 * as the count is constant.
 */
static inline void * __constant_memcpy(void * to, const void * from, size_t n)


and when it _does_ gets compiled it _does_ look horribly ugly:


000017c0 <__constant_memcpy>:
    17c0:	57                   	push   %edi
    17c1:	56                   	push   %esi
    17c2:	51                   	push   %ecx
    17c3:	8b 4c 24 18          	mov    0x18(%esp,1),%ecx
    17c7:	83 f9 14             	cmp    $0x14,%ecx
    17ca:	8b 54 24 10          	mov    0x10(%esp,1),%edx
    17ce:	8b 74 24 14          	mov    0x14(%esp,1),%esi
    17d2:	77 7c                	ja     1850 <__constant_memcpy+0x90>
    17d4:	ff 24 8d 28 01 00 00 	jmp    *0x128(,%ecx,4)
    17db:	8a 06                	mov    (%esi),%al
    17dd:	88 02                	mov    %al,(%edx)
    17df:	90                   	nop    
    17e0:	89 d0                	mov    %edx,%eax
    17e2:	5a                   	pop    %edx
    17e3:	5e                   	pop    %esi
    17e4:	5f                   	pop    %edi
    17e5:	c3                   	ret    
    17e6:	66 8b 06             	mov    (%esi),%ax
    17e9:	66 89 02             	mov    %ax,(%edx)
    17ec:	eb f2                	jmp    17e0 <__constant_memcpy+0x20>
    17ee:	66 8b 06             	mov    (%esi),%ax
    17f1:	66 89 02             	mov    %ax,(%edx)
    17f4:	8a 46 02             	mov    0x2(%esi),%al
    17f7:	88 42 02             	mov    %al,0x2(%edx)
    17fa:	eb e4                	jmp    17e0 <__constant_memcpy+0x20>
    17fc:	8b 06                	mov    (%esi),%eax
    17fe:	89 02                	mov    %eax,(%edx)
    1800:	eb de                	jmp    17e0 <__constant_memcpy+0x20>
    1802:	8b 06                	mov    (%esi),%eax
    1804:	89 02                	mov    %eax,(%edx)
    1806:	66 8b 46 04          	mov    0x4(%esi),%ax
    180a:	66 89 42 04          	mov    %ax,0x4(%edx)
    180e:	eb d0                	jmp    17e0 <__constant_memcpy+0x20>
    1810:	8b 06                	mov    (%esi),%eax
    1812:	89 02                	mov    %eax,(%edx)
    1814:	8b 46 04             	mov    0x4(%esi),%eax
    1817:	89 42 04             	mov    %eax,0x4(%edx)
    181a:	eb c4                	jmp    17e0 <__constant_memcpy+0x20>
    181c:	8b 06                	mov    (%esi),%eax
    181e:	89 02                	mov    %eax,(%edx)
    1820:	8b 46 04             	mov    0x4(%esi),%eax
    1823:	89 42 04             	mov    %eax,0x4(%edx)
    1826:	8b 46 08             	mov    0x8(%esi),%eax
    1829:	89 42 08             	mov    %eax,0x8(%edx)
    182c:	eb b2                	jmp    17e0 <__constant_memcpy+0x20>
    182e:	8b 06                	mov    (%esi),%eax
    1830:	89 02                	mov    %eax,(%edx)
    1832:	8b 46 04             	mov    0x4(%esi),%eax
    1835:	89 42 04             	mov    %eax,0x4(%edx)
    1838:	8b 46 08             	mov    0x8(%esi),%eax
    183b:	89 42 08             	mov    %eax,0x8(%edx)
    183e:	8b 46 0c             	mov    0xc(%esi),%eax
    1841:	89 42 0c             	mov    %eax,0xc(%edx)
    1844:	eb 9a                	jmp    17e0 <__constant_memcpy+0x20>
    1846:	8d 76 00             	lea    0x0(%esi),%esi
    1849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,1),%edi
    1850:	89 c8                	mov    %ecx,%eax
    1852:	83 e0 03             	and    $0x3,%eax
    1855:	83 f8 01             	cmp    $0x1,%eax
    1858:	74 46                	je     18a0 <__constant_memcpy+0xe0>
    185a:	83 f8 01             	cmp    $0x1,%eax
    185d:	72 31                	jb     1890 <__constant_memcpy+0xd0>
    185f:	83 f8 02             	cmp    $0x2,%eax
    1862:	74 0f                	je     1873 <__constant_memcpy+0xb3>
    1864:	c1 e9 02             	shr    $0x2,%ecx
    1867:	89 d7                	mov    %edx,%edi
    1869:	f3 a5                	repz movsl %ds:(%esi),%es:(%edi)
    186b:	66 a5                	movsw  %ds:(%esi),%es:(%edi)
    186d:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    186e:	e9 6d ff ff ff       	jmp    17e0 <__constant_memcpy+0x20>
    1873:	c1 e9 02             	shr    $0x2,%ecx
    1876:	89 d7                	mov    %edx,%edi
    1878:	f3 a5                	repz movsl %ds:(%esi),%es:(%edi)
    187a:	66 a5                	movsw  %ds:(%esi),%es:(%edi)
    187c:	e9 5f ff ff ff       	jmp    17e0 <__constant_memcpy+0x20>
    1881:	eb 0d                	jmp    1890 <__constant_memcpy+0xd0>
    1883:	90                   	nop    
    1884:	90                   	nop    
    1885:	90                   	nop    
    1886:	90                   	nop    
    1887:	90                   	nop    
    1888:	90                   	nop    
    
BTW, this string of nops is deeply unfunny...
looks similar to inter-function 16 byte alignment,
but it's _inside_ of a function.
GCC aligned branch target?? :(((

    1889:	90                   	nop    
    188a:	90                   	nop    
    188b:	90                   	nop    
    188c:	90                   	nop    
    188d:	90                   	nop    
    188e:	90                   	nop    
    188f:	90                   	nop    
    1890:	c1 e9 02             	shr    $0x2,%ecx
    1893:	89 d7                	mov    %edx,%edi
    1895:	f3 a5                	repz movsl %ds:(%esi),%es:(%edi)
    1897:	e9 44 ff ff ff       	jmp    17e0 <__constant_memcpy+0x20>
    189c:	8d 74 26 00          	lea    0x0(%esi,1),%esi
    18a0:	c1 e9 02             	shr    $0x2,%ecx
    18a3:	89 d7                	mov    %edx,%edi
    18a5:	f3 a5                	repz movsl %ds:(%esi),%es:(%edi)
    18a7:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    18a8:	e9 33 ff ff ff       	jmp    17e0 <__constant_memcpy+0x20>
    18ad:	8b 06                	mov    (%esi),%eax
    18af:	89 02                	mov    %eax,(%edx)
    18b1:	8b 46 04             	mov    0x4(%esi),%eax
    18b4:	89 42 04             	mov    %eax,0x4(%edx)
    18b7:	8b 46 08             	mov    0x8(%esi),%eax
    18ba:	89 42 08             	mov    %eax,0x8(%edx)
    18bd:	8b 46 0c             	mov    0xc(%esi),%eax
    18c0:	89 42 0c             	mov    %eax,0xc(%edx)
    18c3:	8b 46 10             	mov    0x10(%esi),%eax
    18c6:	89 42 10             	mov    %eax,0x10(%edx)
    18c9:	e9 12 ff ff ff       	jmp    17e0 <__constant_memcpy+0x20>
    18ce:	89 f6                	mov    %esi,%esi
--
vda
