Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261607AbTCOWM4>; Sat, 15 Mar 2003 17:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261609AbTCOWMz>; Sat, 15 Mar 2003 17:12:55 -0500
Received: from holomorphy.com ([66.224.33.161]:38099 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261607AbTCOWMv>;
	Sat, 15 Mar 2003 17:12:51 -0500
Date: Sat, 15 Mar 2003 14:23:22 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alex Tomas <bzzz@tmi.comex.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] concurrent inode allocation for ext2 against 2.5.64
Message-ID: <20030315222322.GZ20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alex Tomas <bzzz@tmi.comex.ru>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
References: <m365qk1gzx.fsf@lexa.home.net> <20030315220241.GX20188@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030315220241.GX20188@holomorphy.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 15, 2003 at 02:02:41PM -0800, William Lee Irwin III wrote:
> c01dc9ac 4532033  21.4566     .text.lock.dec_and_lock
> c0169c0b 3835802  18.1603     .text.lock.dcache
> c0106ff4 1741849  8.24666     default_idle

More detailed wrt. atomic_dec_and_lock():

c01dc920 1344198  6.36401     atomic_dec_and_lock
 c01dc920 567      0.0421813
 c01dc921 503      0.0374201
 c01dc923 8        0.00059515
 c01dc924 204      0.0151763
 c01dc925 199      0.0148044
 c01dc928 211      0.0156971
 c01dc92b 335      0.0249219
 c01dc92d 27983    2.08176
 c01dc930 118      0.00877847
 c01dc932 206      0.0153251
 c01dc934 181      0.0134653
 c01dc936 98       0.00729059
 c01dc93a 317972   23.6551
 c01dc93c 5        0.000371969
 c01dc93e 216      0.0160691
 c01dc942 43       0.00319893
 c01dc949 176692   13.1448
 c01dc962 749      0.055721
 c01dc965 809754   60.2407
 c01dc967 4        0.000297575
 c01dc96a 6005     0.446735
 c01dc971 56       0.00416605
 c01dc97f 2        0.000148788
 c01dc9a1 228      0.0169618
 c01dc9a3 217      0.0161435
 c01dc9a6 9        0.000669544
 c01dc9a7 1328     0.098795
 c01dc9a8 141      0.0104895
 c01dc9ab 164      0.0122006

c01dc920 <atomic_dec_and_lock>:
c01dc920:       55                      push   %ebp
c01dc921:       89 e5                   mov    %esp,%ebp
c01dc923:       56                      push   %esi
c01dc924:       53                      push   %ebx
c01dc925:       8b 75 08                mov    0x8(%ebp),%esi
c01dc928:       8b 5d 0c                mov    0xc(%ebp),%ebx
c01dc92b:       8b 16                   mov    (%esi),%edx
c01dc92d:       8d 4a ff                lea    0xffffffff(%edx),%ecx
c01dc930:       85 c9                   test   %ecx,%ecx
c01dc932:       74 0e                   je     c01dc942 <atomic_dec_and_lock+0x2
2>
c01dc934:       89 d0                   mov    %edx,%eax
c01dc936:       f0 0f b1 0e             lock cmpxchg %ecx,(%esi)
c01dc93a:       89 c1                   mov    %eax,%ecx
c01dc93c:       39 d1                   cmp    %edx,%ecx
c01dc93e:       75 eb                   jne    c01dc92b <atomic_dec_and_lock+0xb
>
c01dc940:       eb 5f                   jmp    c01dc9a1 <atomic_dec_and_lock+0x8
1>
c01dc942:       81 7b 04 ad 4e ad de    cmpl   $0xdead4ead,0x4(%ebx)
c01dc949:       74 17                   je     c01dc962 <atomic_dec_and_lock+0x4
2>
c01dc94b:       68 42 c9 1d c0          push   $0xc01dc942
c01dc950:       68 4c d1 2e c0          push   $0xc02ed14c
c01dc955:       e8 4e 28 f4 ff          call   c011f1a8 <printk>
c01dc95a:       0f 0b                   ud2a   
c01dc95c:       7b 00                   jnp    c01dc95e <atomic_dec_and_lock+0x3
e>
c01dc95e:       35 d1 2e c0 f0          xor    $0xf0c02ed1,%eax
c01dc963:       fe 0b                   decb   (%ebx)
c01dc965:       78 45                   js     c01dc9ac <.text.lock.dec_and_lock
>
c01dc967:       f0 ff 0e                lock decl (%esi)
c01dc96a:       0f 94 c0                sete   %al
c01dc96d:       84 c0                   test   %al,%al
c01dc96f:       74 07                   je     c01dc978 <atomic_dec_and_lock+0x5
8>
c01dc971:       b8 01 00 00 00          mov    $0x1,%eax
c01dc976:       eb 2b                   jmp    c01dc9a3 <atomic_dec_and_lock+0x8
3>
c01dc978:       81 7b 04 ad 4e ad de    cmpl   $0xdead4ead,0x4(%ebx)
c01dc97f:       74 0f                   je     c01dc990 <atomic_dec_and_lock+0x7
0>
c01dc981:       0f 0b                   ud2a   
c01dc983:       4a                      dec    %edx
c01dc984:       00 35 d1 2e c0 8d       add    %dh,0x8dc02ed1
c01dc98a:       b4 26                   mov    $0x26,%ah
c01dc98c:       00 00                   add    %al,(%eax)
c01dc98e:       00 00                   add    %al,(%eax)
c01dc990:       8a 03                   mov    (%ebx),%al
c01dc992:       84 c0                   test   %al,%al
c01dc994:       7e 08                   jle    c01dc99e <atomic_dec_and_lock+0x7
e>
c01dc996:       0f 0b                   ud2a   
c01dc998:       4c                      dec    %esp
c01dc999:       00 35 d1 2e c0 c6       add    %dh,0xc6c02ed1
c01dc99f:       03 01                   add    (%ecx),%eax
c01dc9a1:       31 c0                   xor    %eax,%eax
c01dc9a3:       8d 65 f8                lea    0xfffffff8(%ebp),%esp
c01dc9a6:       5b                      pop    %ebx
c01dc9a7:       5e                      pop    %esi
c01dc9a8:       89 ec                   mov    %ebp,%esp
c01dc9aa:       5d                      pop    %ebp
c01dc9ab:       c3                      ret    

