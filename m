Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUJRMU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUJRMU0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 08:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266427AbUJRMUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 08:20:25 -0400
Received: from relay.snowman.net ([66.92.160.56]:3091 "EHLO relay.snowman.net")
	by vger.kernel.org with ESMTP id S266366AbUJRMT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 08:19:58 -0400
Date: Mon, 18 Oct 2004 08:20:25 -0400
From: Stephen Frost <sfrost@snowman.net>
To: LKML <linux-kernel@vger.kernel.org>,
       Vserver <vserver@list.linux-vserver.org>
Subject: Re: [Vserver] PROBLEM: Oops in log_do_checkpoint, using vserver
Message-ID: <20041018122025.GA28813@ns.snowman.net>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	Vserver <vserver@list.linux-vserver.org>
References: <20041018032511.GY21419@ns.snowman.net> <20041018115523.GA2352@mail.13thfloor.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20041018115523.GA2352@mail.13thfloor.at>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.4.24ns.3.0 (i686)
X-Uptime: 08:05:13 up 261 days,  7:04, 12 users,  load average: 0.51, 1.69, 1.07
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Herbert Poetzl (herbert@13thfloor.at) wrote:
> have seen that too, once in a while, but there where
> some changes in 2.6.9, so maybe trying 2.6.9-rc4
> (or soon final) with vs1.9.3-rc3 (not much changed
> here, see delta for details) would be a good check

Ok.  I had been planning on moving to 2.6.9 and 1.9.3 as soon as both
were final.  Guess I can try the RC releases though. :)

> >   If any other information would be useful, please don't hesitate to as=
k.
>=20
> yeah, this first line of the oops seems missing
> (would expect something like: pagefault, bug at
> or kernel NULL pointer dereference)

Ah, right, didn't show up in messages but was in syslog:
Assertion failure in log_do_checkpoint() at fs/jbd/checkpoint.c:361: "drop_=
count !=3D 0 || cleanup_ret !=3D 0"
kernel BUG at fs/jbd/checkpoint.c:361!
invalid operand: 0000 [#1]
[...]

> please try to disassemble (with objdump) the kernel
> function log_do_checkpoint() around the location
> of the oops

Well, log_do_checkpoint doesn't appear to be very long..  Here's the
objdump -d from it (I also wasn't 100% sure where the location of the
oops was in the objdump..):

c01aa085 <log_do_checkpoint>:
c01aa085:       55                      push   %ebp
c01aa086:       57                      push   %edi
c01aa087:       56                      push   %esi
c01aa088:       53                      push   %ebx
c01aa089:       81 ec 24 01 00 00       sub    $0x124,%esp
c01aa08f:       8b 84 24 38 01 00 00    mov    0x138(%esp),%eax
c01aa096:       c7 44 24 1c 00 00 00    movl   $0x0,0x1c(%esp)
c01aa09d:       00=20
c01aa09e:       89 04 24                mov    %eax,(%esp)
c01aa0a1:       e8 aa 01 00 00          call   c01aa250 <cleanup_journal_ta=
il>
c01aa0a6:       85 c0                   test   %eax,%eax
c01aa0a8:       89 c2                   mov    %eax,%edx
c01aa0aa:       0f 8e ce 00 00 00       jle    c01aa17e <log_do_checkpoint+=
0xf9>
c01aa0b0:       8b 94 24 38 01 00 00    mov    0x138(%esp),%edx
c01aa0b7:       f0 fe 8a c0 00 00 00    lock decb 0xc0(%edx)
c01aa0be:       0f 88 64 08 00 00       js     c01aa928 <.text.lock.checkpo=
int+0x4e>
c01aa0c4:       8b 42 38                mov    0x38(%edx),%eax
c01aa0c7:       85 c0                   test   %eax,%eax
c01aa0c9:       0f 84 92 00 00 00       je     c01aa161 <log_do_checkpoint+=
0xdc>
c01aa0cf:       89 44 24 18             mov    %eax,0x18(%esp)
c01aa0d3:       c7 44 24 20 00 00 00    movl   $0x0,0x20(%esp)
c01aa0da:       00=20
c01aa0db:       8b 40 04                mov    0x4(%eax),%eax
c01aa0de:       8b 54 24 18             mov    0x18(%esp),%edx
c01aa0e2:       89 44 24 14             mov    %eax,0x14(%esp)
c01aa0e6:       8b 5a 28                mov    0x28(%edx),%ebx
c01aa0e9:       8b 6b 2c                mov    0x2c(%ebx),%ebp
c01aa0ec:       89 df                   mov    %ebx,%edi
c01aa0ee:       89 fb                   mov    %edi,%ebx
c01aa0f0:       8b 7f 28                mov    0x28(%edi),%edi
c01aa0f3:       8b 13                   mov    (%ebx),%edx
c01aa0f5:       f0 0f ba 2a 11          lock btsl $0x11,(%edx)
c01aa0fa:       19 c0                   sbb    %eax,%eax
c01aa0fc:       85 c0                   test   %eax,%eax
c01aa0fe:       0f 85 1b 01 00 00       jne    c01aa21f <log_do_checkpoint+=
0x19a>
c01aa104:       8d 44 24 20             lea    0x20(%esp),%eax
c01aa108:       8d 54 24 1c             lea    0x1c(%esp),%edx
c01aa10c:       89 5c 24 04             mov    %ebx,0x4(%esp)
c01aa110:       89 44 24 10             mov    %eax,0x10(%esp)
c01aa114:       89 54 24 0c             mov    %edx,0xc(%esp)
c01aa118:       8d 44 24 24             lea    0x24(%esp),%eax
c01aa11c:       8b 94 24 38 01 00 00    mov    0x138(%esp),%edx
c01aa123:       89 44 24 08             mov    %eax,0x8(%esp)
c01aa127:       89 14 24                mov    %edx,(%esp)
c01aa12a:       e8 fb fd ff ff          call   c01a9f2a <__flush_buffer>
c01aa12f:       39 eb                   cmp    %ebp,%ebx
c01aa131:       89 c6                   mov    %eax,%esi
c01aa133:       74 04                   je     c01aa139 <log_do_checkpoint+=
0xb4>
c01aa135:       85 c0                   test   %eax,%eax
c01aa137:       74 b5                   je     c01aa0ee <log_do_checkpoint+=
0x69>
c01aa139:       8b 7c 24 1c             mov    0x1c(%esp),%edi
c01aa13d:       85 ff                   test   %edi,%edi
c01aa13f:       0f 85 b6 00 00 00       jne    c01aa1fb <log_do_checkpoint+=
0x176>
c01aa145:       8b 94 24 38 01 00 00    mov    0x138(%esp),%edx
c01aa14c:       8b 42 38                mov    0x38(%edx),%eax
c01aa14f:       3b 44 24 18             cmp    0x18(%esp),%eax
c01aa153:       75 0c                   jne    c01aa161 <log_do_checkpoint+=
0xdc>
c01aa155:       85 f6                   test   %esi,%esi
c01aa157:       74 32                   je     c01aa18b <log_do_checkpoint+=
0x106>
c01aa159:       85 c0                   test   %eax,%eax
c01aa15b:       0f 85 6e ff ff ff       jne    c01aa0cf <log_do_checkpoint+=
0x4a>
c01aa161:       8b 84 24 38 01 00 00    mov    0x138(%esp),%eax
c01aa168:       c6 80 c0 00 00 00 01    movb   $0x1,0xc0(%eax)
c01aa16f:       89 04 24                mov    %eax,(%esp)
c01aa172:       e8 d9 00 00 00          call   c01aa250 <cleanup_journal_ta=
il>
c01aa177:       31 d2                   xor    %edx,%edx
c01aa179:       85 c0                   test   %eax,%eax
c01aa17b:       0f 48 d0                cmovs  %eax,%edx
c01aa17e:       81 c4 24 01 00 00       add    $0x124,%esp
c01aa184:       89 d0                   mov    %edx,%eax
c01aa186:       5b                      pop    %ebx
c01aa187:       5e                      pop    %esi
c01aa188:       5f                      pop    %edi
c01aa189:       5d                      pop    %ebp
c01aa18a:       c3                      ret   =20
c01aa18b:       8b 54 24 14             mov    0x14(%esp),%edx
c01aa18f:       39 50 04                cmp    %edx,0x4(%eax)
c01aa192:       75 c5                   jne    c01aa159 <log_do_checkpoint+=
0xd4>
c01aa194:       89 44 24 04             mov    %eax,0x4(%esp)
c01aa198:       8b 84 24 38 01 00 00    mov    0x138(%esp),%eax
c01aa19f:       89 04 24                mov    %eax,(%esp)
c01aa1a2:       e8 96 fb ff ff          call   c01a9d3d <__cleanup_transact=
ion>
c01aa1a7:       8b 5c 24 20             mov    0x20(%esp),%ebx
c01aa1ab:       85 db                   test   %ebx,%ebx
c01aa1ad:       75 04                   jne    c01aa1b3 <log_do_checkpoint+=
0x12e>
c01aa1af:       85 c0                   test   %eax,%eax
c01aa1b1:       74 12                   je     c01aa1c5 <log_do_checkpoint+=
0x140>
c01aa1b3:       8b 94 24 38 01 00 00    mov    0x138(%esp),%edx
c01aa1ba:       8b 42 38                mov    0x38(%edx),%eax
c01aa1bd:       3b 44 24 18             cmp    0x18(%esp),%eax
c01aa1c1:       74 96                   je     c01aa159 <log_do_checkpoint+=
0xd4>
c01aa1c3:       eb 9c                   jmp    c01aa161 <log_do_checkpoint+=
0xdc>
c01aa1c5:       c7 44 24 10 00 52 33    movl   $0xc0335200,0x10(%esp)
c01aa1cc:       c0=20
c01aa1cd:       c7 44 24 0c 69 01 00    movl   $0x169,0xc(%esp)
c01aa1d4:       00=20
c01aa1d5:       c7 44 24 08 f7 01 33    movl   $0xc03301f7,0x8(%esp)
c01aa1dc:       c0=20
c01aa1dd:       c7 44 24 04 9d be 31    movl   $0xc031be9d,0x4(%esp)
c01aa1e4:       c0=20
c01aa1e5:       c7 04 24 c0 23 33 c0    movl   $0xc03323c0,(%esp)
c01aa1ec:       e8 16 19 f7 ff          call   c011bb07 <printk>
c01aa1f1:       0f 0b                   ud2a  =20
c01aa1f3:       69 01 f7 01 33 c0       imul   $0xc03301f7,(%ecx),%eax
c01aa1f9:       eb b8                   jmp    c01aa1b3 <log_do_checkpoint+=
0x12e>
c01aa1fb:       8d 44 24 1c             lea    0x1c(%esp),%eax
c01aa1ff:       8d 54 24 24             lea    0x24(%esp),%edx
c01aa203:       89 44 24 08             mov    %eax,0x8(%esp)
c01aa207:       89 54 24 04             mov    %edx,0x4(%esp)
c01aa20b:       8b 84 24 38 01 00 00    mov    0x138(%esp),%eax
c01aa212:       89 04 24                mov    %eax,(%esp)
c01aa215:       e8 a8 fc ff ff          call   c01a9ec2 <__flush_batch>
c01aa21a:       e9 26 ff ff ff          jmp    c01aa145 <log_do_checkpoint+=
0xc0>
c01aa21f:       8b 84 24 38 01 00 00    mov    0x138(%esp),%eax
c01aa226:       89 54 24 04             mov    %edx,0x4(%esp)
c01aa22a:       89 04 24                mov    %eax,(%esp)
c01aa22d:       e8 b7 fa ff ff          call   c01a9ce9 <jbd_sync_bh>
c01aa232:       8b 94 24 38 01 00 00    mov    0x138(%esp),%edx
c01aa239:       f0 fe 8a c0 00 00 00    lock decb 0xc0(%edx)
c01aa240:       0f 88 f2 06 00 00       js     c01aa938 <.text.lock.checkpo=
int+0x5e>
c01aa246:       be 01 00 00 00          mov    $0x1,%esi
c01aa24b:       e9 e9 fe ff ff          jmp    c01aa139 <log_do_checkpoint+=
0xb4>


> 	v
> > Code: 0f 0b 69 01 f7 01 33 c0 eb b8 8d 44 24 1c 8d 54 24 24 89 44=20

If I can help further, please let me know.

Thanks,

	Stephen

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBc7UJrzgMPqB3kigRAswvAJ9OItddcMPoo5JhoxYwUqmmvbsoNgCfUHBV
EN/SB2mHFOIBb6kpqaP3uGY=
=tGPm
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
