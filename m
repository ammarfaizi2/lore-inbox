Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266181AbUITJlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUITJlp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 05:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUITJlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 05:41:45 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:55561 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266181AbUITJle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 05:41:34 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: 2.4 -> 2.6: 'for(100000) close(open())' got slower
Date: Mon, 20 Sep 2004 12:39:56 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sVqTBKCojj6AA75"
Message-Id: <200409201239.56852.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_sVqTBKCojj6AA75
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[mail threading will be broken, sorry]

> On Fri, Sep 17, 2004 at 03:34:59PM +0300, Denis Vlasenko wrote:
> > 2.4:
> >   2994 total                                      0.0013
> >    620 link_path_walk                             0.2892
> >    285 d_lookup                                   1.2076
> >    156 dput                                       0.4815
> >    118 kmem_cache_free                            0.7564
> >    109 system_call                                1.9464
> >    106 kmem_cache_alloc                           0.5096
> >    103 strncpy_from_user                          1.2875
>
> [...]
>
> > 2.6:
> >   3200 total                                      0.0013
> >    790 link_path_walk                             0.2759
> >    287 __d_lookup                                 1.2756
> >    277 get_empty_filp                             1.4503
> >    146 strncpy_from_user                          1.8250
> >    110 dput                                       0.3254
> >    109 system_call                                2.4773
>
> Very odd that get_empty_filp() and strncpy_from_user() should be so
> high on your profiles. They're not tremendously different between 2.4
> and 2.6. It may be the case that 2.6 makes some inappropriate choice of
> algorithms for usercopying on systems of your vintage. get_empty_filp()
> is more mysterious still.

>On Fri, Sep 17, 2004 at 11:36:25PM +0300, Denis Vlasenko wrote:
>> Aha! Maybe it's just a might_sleep() overhead?
>
>How does 2.6 do with those might_sleep() calls removed?


I afraid this will have no effect. I revieved the code
and concluded that with my .configs, code will be identical.
I verified this:

2.4:
# gdb vmlinux
(gdb) disass strncpy_from_user
Dump of assembler code for function strncpy_from_user:
0xc03258a0 <strncpy_from_user>: push   %ebp
0xc03258a1 <strncpy_from_user+1>:       mov    %esp,%ebp
0xc03258a3 <strncpy_from_user+3>:       push   %edi
0xc03258a4 <strncpy_from_user+4>:       push   %esi
0xc03258a5 <strncpy_from_user+5>:       push   %ebx
0xc03258a6 <strncpy_from_user+6>:       sub    $0x8,%esp
0xc03258a9 <strncpy_from_user+9>:       mov    0xc(%ebp),%esi
0xc03258ac <strncpy_from_user+12>:      movl   $0xfffffff2,0xffffffec(%ebp)
0xc03258b3 <strncpy_from_user+19>:      mov    $0xffffe000,%eax
0xc03258b8 <strncpy_from_user+24>:      mov    %esi,%ebx
0xc03258ba <strncpy_from_user+26>:      and    %esp,%eax
0xc03258bc <strncpy_from_user+28>:      add    $0x1,%ebx
0xc03258bf <strncpy_from_user+31>:      sbb    %edx,%edx
0xc03258c1 <strncpy_from_user+33>:      cmp    %ebx,0xc(%eax)
0xc03258c4 <strncpy_from_user+36>:      sbb    $0x0,%edx
0xc03258c7 <strncpy_from_user+39>:      test   %edx,%edx
0xc03258c9 <strncpy_from_user+41>:      mov    0x8(%ebp),%edi
0xc03258cc <strncpy_from_user+44>:      mov    0x10(%ebp),%ecx
0xc03258cf <strncpy_from_user+47>:      jne    0xc03258e5 <strncpy_from_user+69>
0xc03258d1 <strncpy_from_user+49>:      mov    %ecx,%edx
0xc03258d3 <strncpy_from_user+51>:      test   %ecx,%ecx
0xc03258d5 <strncpy_from_user+53>:      je     0xc03258e2 <strncpy_from_user+66>
0xc03258d7 <strncpy_from_user+55>:      lods   %ds:(%esi),%al
0xc03258d8 <strncpy_from_user+56>:      stos   %al,%es:(%edi)
0xc03258d9 <strncpy_from_user+57>:      test   %al,%al
0xc03258db <strncpy_from_user+59>:      je     0xc03258e0 <strncpy_from_user+64>
0xc03258dd <strncpy_from_user+61>:      dec    %ecx
0xc03258de <strncpy_from_user+62>:      jne    0xc03258d7 <strncpy_from_user+55>
0xc03258e0 <strncpy_from_user+64>:      sub    %ecx,%edx
0xc03258e2 <strncpy_from_user+66>:      mov    %edx,0xffffffec(%ebp)
0xc03258e5 <strncpy_from_user+69>:      mov    0xffffffec(%ebp),%eax
0xc03258e8 <strncpy_from_user+72>:      add    $0x8,%esp
0xc03258eb <strncpy_from_user+75>:      pop    %ebx
0xc03258ec <strncpy_from_user+76>:      pop    %esi
0xc03258ed <strncpy_from_user+77>:      pop    %edi
0xc03258ee <strncpy_from_user+78>:      leave
0xc03258ef <strncpy_from_user+79>:      ret
End of assembler dump.

2.6:
# gdb vmlinux
(gdb) disass strncpy_from_user
Dump of assembler code for function strncpy_from_user:
0xc01d77b9 <strncpy_from_user>: push   %ebp
0xc01d77ba <strncpy_from_user+1>:       mov    %esp,%ebp
0xc01d77bc <strncpy_from_user+3>:       push   %edi
0xc01d77bd <strncpy_from_user+4>:       push   %esi
0xc01d77be <strncpy_from_user+5>:       push   %ebx
0xc01d77bf <strncpy_from_user+6>:       sub    $0x8,%esp
0xc01d77c2 <strncpy_from_user+9>:       mov    0xc(%ebp),%esi
0xc01d77c5 <strncpy_from_user+12>:      movl   $0xfffffff2,0xffffffec(%ebp)
0xc01d77cc <strncpy_from_user+19>:      mov    $0xffffe000,%eax
0xc01d77d1 <strncpy_from_user+24>:      mov    %esi,%ebx
0xc01d77d3 <strncpy_from_user+26>:      and    %esp,%eax
0xc01d77d5 <strncpy_from_user+28>:      add    $0x1,%ebx
0xc01d77d8 <strncpy_from_user+31>:      sbb    %edx,%edx
0xc01d77da <strncpy_from_user+33>:      cmp    %ebx,0x18(%eax)
0xc01d77dd <strncpy_from_user+36>:      sbb    $0x0,%edx
0xc01d77e0 <strncpy_from_user+39>:      test   %edx,%edx
0xc01d77e2 <strncpy_from_user+41>:      mov    0x8(%ebp),%edi
0xc01d77e5 <strncpy_from_user+44>:      mov    0x10(%ebp),%ecx
0xc01d77e8 <strncpy_from_user+47>:      jne    0xc01d77fe <strncpy_from_user+69>
0xc01d77ea <strncpy_from_user+49>:      mov    %ecx,%edx
0xc01d77ec <strncpy_from_user+51>:      test   %ecx,%ecx
0xc01d77ee <strncpy_from_user+53>:      je     0xc01d77fb <strncpy_from_user+66>
0xc01d77f0 <strncpy_from_user+55>:      lods   %ds:(%esi),%al
0xc01d77f1 <strncpy_from_user+56>:      stos   %al,%es:(%edi)
0xc01d77f2 <strncpy_from_user+57>:      test   %al,%al
0xc01d77f4 <strncpy_from_user+59>:      je     0xc01d77f9 <strncpy_from_user+64>
0xc01d77f6 <strncpy_from_user+61>:      dec    %ecx
0xc01d77f7 <strncpy_from_user+62>:      jne    0xc01d77f0 <strncpy_from_user+55>
0xc01d77f9 <strncpy_from_user+64>:      sub    %ecx,%edx
0xc01d77fb <strncpy_from_user+66>:      mov    %edx,0xffffffec(%ebp)
0xc01d77fe <strncpy_from_user+69>:      mov    0xffffffec(%ebp),%eax
0xc01d7801 <strncpy_from_user+72>:      add    $0x8,%esp
0xc01d7804 <strncpy_from_user+75>:      pop    %ebx
0xc01d7805 <strncpy_from_user+76>:      pop    %esi
0xc01d7806 <strncpy_from_user+77>:      pop    %edi
0xc01d7807 <strncpy_from_user+78>:      leave
0xc01d7808 <strncpy_from_user+79>:      ret
End of assembler dump.

The only difference apart from addresses is:

cmp    %ebx,0xc(%eax)   -->    cmp    %ebx,0x18(%eax)

It corresponds to:

57 #define __range_ok(addr,size) ({ \
58         unsigned long flag,sum; \
59         __chk_user_ptr(addr); \
60         asm("addl %3,%1 ; sbbl %0,%0; cmpl %1,%4; sbbl $0,%0" \
                                                 ^^
61                 :"=&r" (flag), "=r" (sum) \
62                 :"1" (addr),"g" ((int)(size)),"g" (current_thread_info()->addr_limit.seg)); \
                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
63         flag; })

addr_limit.seg must have different offset in 2.6

I did longer profiling runs, with 16x100000 open/close iterations,
twice for each kernel (wanted to see how much variability there is):

2.4_____________________________________ 2.6__________________________
11613 11331 total                        13046 12819 total
 2477  2300 link_path_walk                3465  3418 link_path_walk
 1276  1107 d_lookup                      1470  1293 __d_lookup
  546   561 dput                           793   629 get_empty_filp
  518   360 fput                           581   386 find_trylock_page
  468   415 strncpy_from_user              541   483 dput
  451   382 system_call                    473   409 do_lookup
  367   353 page_follow_link               401   528 strncpy_from_user
  366   383 vfs_permission                 378   451 system_call
  337   368 kmem_cache_free                318   256 follow_mount
  334   333 open_namei                     280   339 may_open
  324   338 __constant_c_and_count_memset  264   269 path_lookup
  304   341 get_unused_fd                  229   207 read_cache_page

(test script and unabridged results are attached)

strncpy_from_user difference is below variability. Maybe there is no
real problem with it.

However, link_path_walk did took ~50% more CPU.
--
vda

--Boundary-00=_sVqTBKCojj6AA75
Content-Type: application/x-tbz;
  name="z.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="z.tar.bz2"

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
yRThQkO7A2k0

--Boundary-00=_sVqTBKCojj6AA75--

