Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316827AbSGLTDR>; Fri, 12 Jul 2002 15:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316832AbSGLTDQ>; Fri, 12 Jul 2002 15:03:16 -0400
Received: from adsl-65-43-15-209.dsl.clevoh.ameritech.net ([65.43.15.209]:20494
	"EHLO bugs.home.shadowstar.net") by vger.kernel.org with ESMTP
	id <S316827AbSGLTDO>; Fri, 12 Jul 2002 15:03:14 -0400
Date: Fri, 12 Jul 2002 15:05:00 -0400 (EDT)
From: Alec Smith <alec@shadowstar.net>
X-X-Sender: alec@bugs.home.shadowstar.net
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: ext3-users@redhat.com, <linux-kernel@vger.kernel.org>
Subject: Re: ext3 corruption
In-Reply-To: <Pine.LNX.4.33.0207121337500.8654-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.44.0207121503030.9318-100000@bugs.home.shadowstar.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the ksymoops output. Note that the kernel is entirely static --
I'm not using anything as a module. Ksymoops is complaining about the
symbol locations, however the defaults are in fact correct for the system.

[root@host155]~$ ksymoops < oops.txt
ksymoops 2.4.1 on i686 2.4.19-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-rc1/ (default)
     -m /boot/System.map-2.4.19-rc1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod
file?
kernel BUG at transaction.c:611!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c015b12e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000078   ebx: ddadd294   ecx: 00000004   edx: ddb0ff64
esi: ddadd200   edi: dec5d920   ebp: ddadd200   esp: d28dfe70
ds: 0018   es: 0018   ss: 0018
Process sendmail (pid: 21193, stackpage=d28df000)
Stack: c01f7460 c01f5969 c01f58d7 00000263 c01f94a0 00000000 00000000
cbf3b3c0
       ddadd294 ddadd200 dec5d920 d4a82730 c015b506 dec5d920 d4a82730
00000000
       ddd9acc0 ddadd000 dec5d920 c4cbdc20 c015744d dec5d920 ddd9acc0
00000000
Call Trace: [<c015b506>] [<c015744d>] [<c0155b04>] [<c0155b15>]
[<c0155c07>]
   [<c0157a95>] [<c013b5c6>] [<c013b6a9>] [<c0111bc0>] [<c01087eb>]
Code: 0f 0b 63 02 d7 58 1f c0 83 c4 14 8b 4c 24 20 bb e2 ff ff ff

>>EIP; c015b12e <do_get_write_access+1ce/570>   <=====
Trace; c015b506 <journal_get_write_access+36/60>
Trace; c015744d <ext3_orphan_add+8d/1c0>
Trace; c0155b04 <ext3_mark_iloc_dirty+24/50>
Trace; c0155b15 <ext3_mark_iloc_dirty+35/50>
Trace; c0155c07 <ext3_mark_inode_dirty+27/40>
Trace; c0157a95 <ext3_unlink+135/190>
Trace; c013b5c6 <vfs_unlink+106/150>
Trace; c013b6a9 <sys_unlink+99/100>
Trace; c0111bc0 <do_page_fault+0/4cb>
Trace; c01087eb <system_call+33/38>
Code;  c015b12e <do_get_write_access+1ce/570>
00000000 <_EIP>:
Code;  c015b12e <do_get_write_access+1ce/570>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c015b130 <do_get_write_access+1d0/570>
   2:   63 02                     arpl   %ax,(%edx)
Code;  c015b132 <do_get_write_access+1d2/570>
   4:   d7                        xlat   %ds:(%ebx)
Code;  c015b133 <do_get_write_access+1d3/570>
   5:   58                        pop    %eax
Code;  c015b134 <do_get_write_access+1d4/570>
   6:   1f                        pop    %ds
Code;  c015b135 <do_get_write_access+1d5/570>
   7:   c0 83 c4 14 8b 4c 24      rolb   $0x24,0x4c8b14c4(%ebx)
Code;  c015b13c <do_get_write_access+1dc/570>
   e:   20 bb e2 ff ff ff         and    %bh,0xffffffe2(%ebx)


On Fri, 12 Jul 2002, Mark Hahn wrote:

> > Over the last month or so, I've noticed the following error showing up
> > repeatedly in my system logs under kernel 2.4.18-ac3 and more recently
> > under 2.4.19-rc1:
>
> even though you have a nice assertion failure,
> you probably still need to follow the faq on decoding the oops.
>
>
> >
> > EXT3-fs error (device ide0(3,3)) in ext3_new_inode: error 28
> >
> > I've now been able to capture the following Oops before the system went
> > down entirely:
> >
> > Assertion failure in do_get_write_access() at transaction.c:611:
> > "!(((jh2bh(jh))->b_state & (1UL << BH_Lock)) != 0)"
> > kernel BUG at transaction.c:611!
> > invalid operand: 0000
> > CPU:    0
> > EIP:    0010:[<c015b12e>]    Not tainted
> > EFLAGS: 00010282
> > eax: 00000078   ebx: ddadd294   ecx: 00000004   edx: ddb0ff64
> > esi: ddadd200   edi: dec5d920   ebp: ddadd200   esp: d28dfe70
> > ds: 0018   es: 0018   ss: 0018
> > Process sendmail (pid: 21193, stackpage=d28df000)
> > Stack: c01f7460 c01f5969 c01f58d7 00000263 c01f94a0 00000000 00000000
> > cbf3b3c0
> >        ddadd294 ddadd200 dec5d920 d4a82730 c015b506 dec5d920 d4a82730
> > 00000000
> >        ddd9acc0 ddadd000 dec5d920 c4cbdc20 c015744d dec5d920 ddd9acc0
> > 00000000
> > Call Trace: [<c015b506>] [<c015744d>] [<c0155b04>] [<c0155b15>]
> > [<c0155c07>]
> >    [<c0157a95>] [<c013b5c6>] [<c013b6a9>] [<c0111bc0>] [<c01087eb>]
> >
> > Code: 0f 0b 63 02 d7 58 1f c0 83 c4 14 8b 4c 24 20 bb e2 ff ff ff
> >
> >
> > Any help or patches would be greatly appreciated. I'd be glad to provide
> > more information if needed.
> >
> >
> > Alec
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> --
> operator may differ from spokesperson.	            hahn@mcmaster.ca
>                                               http://hahn.mcmaster.ca/~hahn
>

