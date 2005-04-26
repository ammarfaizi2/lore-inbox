Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVDZLNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVDZLNb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 07:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVDZLNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 07:13:31 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:58059 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261427AbVDZLNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 07:13:14 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] i386: optimize swab64
Date: Tue, 26 Apr 2005 14:12:40 +0300
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200504251019.30173.vda@port.imtp.ilyichevsk.odessa.ua> <20050425155307.GB65287@muc.de>
In-Reply-To: <20050425155307.GB65287@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504261412.41571.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 April 2005 18:53, Andi Kleen wrote:
> On Mon, Apr 25, 2005 at 10:19:30AM +0300, Denis Vlasenko wrote:
> > I noticed that swab64 explicitly swaps 32-bit halves, but this is
> > not really needed because CPU is 32-bit anyway and we can
> > just tell GCC to treat registers as being swapped.
> 
> No, we went through this exactly when the code was originally done.
> gcc puts long long only into aligned register pairs, and with 

I don't see this. However, gcc is indeed does some unneeded moves,
both with and without xchgl. I filed a bug report:

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=21202

> register swap you need at least 4 registers which blows near
> all possible registers away and completely breaks register
> allocation in the function. Dont apply this!

Andi, are you saying that code gets worse with this patch?
This is not true at least for gcc 3.4.3 and 4.0.0.
I just re-checked this.

This is with original code:

# objdump -r -d crypto/wp512.o
00000000 <wp512_process_buffer>:
       0:       55                      push   %ebp
       1:       89 e5                   mov    %esp,%ebp
       3:       57                      push   %edi
       4:       56                      push   %esi
       5:       53                      push   %ebx
       6:       81 ec 00 02 00 00       sub    $0x200,%esp
       c:       31 ff                   xor    %edi,%edi
       e:       8b 4d 08                mov    0x8(%ebp),%ecx
      11:       8b 54 f9 24             mov    0x24(%ecx,%edi,8),%edx
      15:       8b 44 f9 20             mov    0x20(%ecx,%edi,8),%eax
      19:       8d 77 01                lea    0x1(%edi),%esi
      1c:       89 b5 f4 fd ff ff       mov    %esi,0xfffffdf4(%ebp)
      22:       89 c1                   mov    %eax,%ecx
      24:       89 d6                   mov    %edx,%esi
      26:       0f c9                   bswap  %ecx
      28:       0f ce                   bswap  %esi
      2a:       87 ce                   xchg   %ecx,%esi             <=======
      2c:       89 8c fd 74 ff ff ff    mov    %ecx,0xffffff74(%ebp,%edi,8)
      33:       89 b4 fd 78 ff ff ff    mov    %esi,0xffffff78(%ebp,%edi,8)

Patched:

# objdump -r -d crypto_noswap/wp512.o
00000000 <wp512_process_buffer>:
       0:       55                      push   %ebp
       1:       89 e5                   mov    %esp,%ebp
       3:       57                      push   %edi
       4:       56                      push   %esi
       5:       53                      push   %ebx
       6:       81 ec 00 02 00 00       sub    $0x200,%esp
       c:       31 ff                   xor    %edi,%edi
       e:       8b 4d 08                mov    0x8(%ebp),%ecx
      11:       8b 44 f9 20             mov    0x20(%ecx,%edi,8),%eax
      15:       8b 54 f9 24             mov    0x24(%ecx,%edi,8),%edx
      19:       8d 77 01                lea    0x1(%edi),%esi
      1c:       89 b5 f4 fd ff ff       mov    %esi,0xfffffdf4(%ebp)
      22:       89 c3                   mov    %eax,%ebx
      24:       89 d6                   mov    %edx,%esi
      26:       0f cb                   bswap  %ebx
      28:       0f ce                   bswap  %esi
                                                  <========= NO xchg
      2a:       89 b4 fd 74 ff ff ff    mov    %esi,0xffffff74(%ebp,%edi,8)
      31:       89 9c fd 78 ff ff ff    mov    %ebx,0xffffff78(%ebp,%edi,8)

It is not a win only for wp512, other crypto modules are a tiny bit smaller too:

# echo crypto*/*.o | xargs -n1 | grep -Fv .mod. | sort -t / -k2,99 | xargs size
   text    data     bss     dec     hex filename
  17743     108       0   17851    45bb crypto/khazad.o
  17735     108       0   17843    45b3 crypto_noswap/khazad.o
    666     108       0     774     306 crypto/sha1.o
    664     108       0     772     304 crypto_noswap/sha1.o
   5160     364       0    5524    1594 crypto/sha512.o
   5156     364       0    5520    1590 crypto_noswap/sha512.o
  10239     364       0   10603    296b crypto/tgr192.o
  10233     364       0   10597    2965 crypto_noswap/tgr192.o
  22774     364       0   23138    5a62 crypto/wp512.o
  22770     364       0   23134    5a5e crypto_noswap/wp512.o
--
vda

