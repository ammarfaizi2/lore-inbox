Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264545AbUAPCfu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 21:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbUAPCfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 21:35:50 -0500
Received: from tantale.fifi.org ([216.27.190.146]:45716 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S264545AbUAPCet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 21:34:49 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: 2.4.24 SMP lockups
References: <20040109210450.GA31404@netnation.com>
	<Pine.LNX.4.58L.0401101719400.1310@logos.cnet>
	<20040114170753.GB8467@netnation.com>
	<Pine.LNX.4.58L.0401141552410.14071@logos.cnet>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 15 Jan 2004 18:34:40 -0800
In-Reply-To: <Pine.LNX.4.58L.0401141552410.14071@logos.cnet>
Message-ID: <8765fc62pr.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:

> On Wed, 14 Jan 2004, Simon Kirby wrote:
> 
> > On Sat, Jan 10, 2004 at 05:32:55PM -0200, Marcelo Tosatti wrote:
> >
> > > This sounds like a deadlock. I wonder why the NMI watchdog is not
> > > triggering.
> >
> > Well, with the NMI watchdog working (nmi_watchdog=2), we just had another
> > occurrence.  This time, I had the serial console ready. :)
> >
> > I'm guessing this is the same as the previous cases; however, this time
> > sysrq-P was able to print information from both CPUs.  I assume the NMI
> > watchdog unlocked interrupts from what would have been the stuck CPU?

I also experienced a deadlock with 2.4.24: the machine was still
responsive (TCP connections being established, etc), but all fs
accesses were locking up. The machine was broadcasting a load of 50+
via rwhod. I was able to capture the result of SysRq-T and pass it
through ksymoops.

According to my (deficient?) reading of the various backtrace, this is
a different problem than the one reported in this thread. It looks
like a jbd/ext3 issue.

Any takers?

Phil.

ksymoops 2.4.5 on i686 2.4.24.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.24/ (default)
     -m /boot/System.map-2.4.24 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

init          S C12D5F2C  4588     1      0 32513               (NOTLB)
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace:    [<c011602a>] [<c0115f50>] [<c014943e>] [<c01497ca>] [<c0107353>]
keventd       S C13A8664  5256     2      1             3       (L-TLB)
Call Trace:    [<c0126045>] [<c0105a64>]
ksoftirqd_CPU S C13A6000  4948     3      1             4     2 (L-TLB)
Call Trace:    [<c011e04b>] [<c0105a64>]
ksoftirqd_CPU S C13A4000  4944     4      1             5     3 (L-TLB)
Call Trace:    [<c011e04b>] [<c0105a64>]
kswapd        S C1394000  4388     5      1             6     4 (L-TLB)
Call Trace:    [<c0132686>] [<c0105a64>]
bdflush       S 00000286  6312     6      1             7     5 (L-TLB)
Call Trace:    [<c011697b>] [<c013de57>] [<c0105a64>]
kupdated      D 00000286  4268     7      1             8     6 (L-TLB)
Call Trace:    [<c0116a7b>] [<c016c6dc>] [<c016c85d>] [<c0165a68>] [<c0165984>]
  [<c012a2ba>] [<c014e765>] [<c013dc57>] [<c013dfa5>] [<c0107306>] [<c013de5c>]
  [<c0105a64>]
ahc_dv_0      S C139EE0C  6124     8      1             9     7 (L-TLB)
Call Trace:    [<c01060b5>] [<c010619f>] [<c01d6fea>] [<c0105a64>]
scsi_eh_0     S C1323FDC  6192     9      1            10     8 (L-TLB)
Call Trace:    [<c01060b5>] [<c010619f>] [<c01cc200>] [<c0105a64>]
kjournald     S 00000286  4288    10      1           130     9 (L-TLB)
Call Trace:    [<c010bbfd>] [<c011697b>] [<c01715b9>] [<c0171440>] [<c0105a64>]
kjournald     D 00000286  4168   130      1           131    10 (L-TLB)
Call Trace:    [<c0116a7b>] [<c016e9f9>] [<c0116532>] [<c0171596>] [<c0171440>]
  [<c0105a64>]
kjournald     S 00000286  4152   131      1           132   130 (L-TLB)
Call Trace:    [<c011697b>] [<c01715b9>] [<c0171440>] [<c0105a64>]
kjournald     S 00000286  4328   132      1           133   131 (L-TLB)
Call Trace:    [<c011697b>] [<c01715b9>] [<c0171440>] [<c0105a64>]
kjournald     S 00000286  4192   133      1           134   132 (L-TLB)
Call Trace:    [<c011697b>] [<c01715b9>] [<c0171440>] [<c0105a64>]
kjournald     S 00000286  4168   134      1           384   133 (L-TLB)
Call Trace:    [<c011697b>] [<c01715b9>] [<c0171440>] [<c0105a64>]
devfsd        S CF244000  4468   384      1           389   134 (NOTLB)
Call Trace:    [<c0176446>] [<c01398ab>] [<c0107353>]
syslogd       D 00000286  4248   389      1           393   384 (NOTLB)
Call Trace:    [<c0116a7b>] [<c016c6dc>] [<c016c85d>] [<c0167688>] [<c014e2da>]
  [<c012cff3>] [<c012d5c4>] [<c0162e77>] [<c0139bd6>] [<c0162e54>] [<c0139d29>]
  [<c0107353>]
watchdog      S CF1C9F8C  4844   393      1   886     397   389 (NOTLB)
Call Trace:    [<c011602a>] [<c0115f50>] [<c0121e3a>] [<c0107353>]
klogd         S 7FFFFFFF  4908   397      1           404   393 (NOTLB)
Call Trace:    [<c0115fc7>] [<c01f6677>] [<c0240fc2>] [<c02419e7>] [<c0116532>]
  [<c01f3ff5>] [<c01f421e>] [<c01399b6>] [<c0107353>]
named         S 00000000  5744   404      1   406     408   397 (NOTLB)
Call Trace:    [<c01f4f12>] [<c011cd25>] [<c0107353>]
named         S CF129FB0     0   406    404   420               (NOTLB)
Call Trace:    [<c0106484>] [<c0107353>]
portmap       S 7FFFFFFF     0   408      1           415   404 (NOTLB)
Call Trace:    [<c0115fc7>] [<c0149a1a>] [<c0149a4f>] [<c0149c5d>] [<c0107353>]
ypserv        D 00000286  4332   415      1 32543     418   408 (NOTLB)
Call Trace:    [<c0116a7b>] [<c016c6dc>] [<c016c85d>] [<c0167688>] [<c014e2da>]
  [<c014fb6b>] [<c012b202>] [<c012b5bb>] [<c012b49c>] [<c0139508>] [<c01398ab>]
  [<c0107353>]
rpc.yppasswdd S 7FFFFFFF  4692   418      1           426   415 (NOTLB)
Call Trace:    [<c0115fc7>] [<c0149a1a>] [<c0149a4f>] [<c0149c5d>] [<c0139369>]
  [<c0107353>]
named         S CEB59F28  4948   420    406   424               (NOTLB)
Call Trace:    [<c011602a>] [<c0115f50>] [<c0149a4f>] [<c0149c5d>] [<c010b2a8>]
  [<c0107353>]
named         S 7FFFFFFF     0   421    420           422       (NOTLB)
Call Trace:    [<c0115fc7>] [<c01f6677>] [<c0240fc2>] [<c02419e7>] [<c01f3ff5>]
  [<c01f4ed5>] [<c011522a>] [<c01150ac>] [<c01f4f12>] [<c01f56b1>] [<c0107353>]
named         S CEB57FB0  4208   422    420           423   421 (NOTLB)
Call Trace:    [<c0106484>] [<c0107353>]
named         S CEB51F8C  2404   423    420           424   422 (NOTLB)
Call Trace:    [<c011602a>] [<c0115f50>] [<c0121e3a>] [<c0107353>]
named         S 7FFFFFFF  4492   424    420                 423 (NOTLB)
Call Trace:    [<c0216162>] [<c0115fc7>] [<c014943e>] [<c01497ca>] [<c0107353>]
rpc.ypxfrd    S 7FFFFFFF  5316   426      1           433   418 (NOTLB)
Call Trace:    [<c0216162>] [<c0115fc7>] [<c014943e>] [<c01497ca>] [<c0107353>]
ypbind        S 7FFFFFFF     4   433      1   434     446   426 (NOTLB)
Call Trace:    [<c0115fc7>] [<c0149a1a>] [<c0149a4f>] [<c0149c5d>] [<c0139369>]
  [<c0107353>]
ypbind        S CEA29F28  4836   434    433   437               (NOTLB)
Call Trace:    [<c011602a>] [<c0115f50>] [<c0149a4f>] [<c0149c5d>] [<c0107353>]
ypbind        S CEAC3FB0     0   435    434           437       (NOTLB)
Call Trace:    [<c0106484>] [<c0107353>]
ypbind        S CEA6DF8C     0   437    434                 435 (NOTLB)
Call Trace:    [<c011602a>] [<c0115f50>] [<c0121e3a>] [<c0107353>]
amd           D 00000286  4180   446      1 32546     451   433 (NOTLB)
Call Trace:    [<c0116a7b>] [<c016c6dc>] [<c016c85d>] [<c0167688>] [<c014e2da>]
  [<c014fb6b>] [<c012b202>] [<c012b5bb>] [<c012b49c>] [<c0139bd6>] [<c012b528>]
  [<c0139cd5>] [<c0107353>]
rpciod        S 00000001  5200   449      1           457   451 (L-TLB)
Call Trace:    [<d089c371>] [<d08a5f2c>] [<d08a5f2c>] [<d08a5f24>] [<d08a5f24>]
  [<c0105a64>] [<d08a5f2c>]
lockd         S 7FFFFFFF     4   451      1           449   446 (L-TLB)
Call Trace:    [<c0115fc7>] [<d089fc7e>] [<d08aac44>] [<c0105a64>]
rpc.rquotad   S 7FFFFFFF  2444   457      1           470   449 (NOTLB)
Call Trace:    [<c0115fc7>] [<c0149a1a>] [<c0149a4f>] [<c0149c5d>] [<c01f577c>]
  [<c0107353>]
rpc.bootparam S 7FFFFFFF     0   470      1           478   457 (NOTLB)
Call Trace:    [<c0115fc7>] [<c0149a1a>] [<c0149a4f>] [<c0149c5d>] [<c0139369>]
  [<c0107353>]
conserver     S 7FFFFFFF  2404   478      1   479     482   470 (NOTLB)
Call Trace:    [<c0216162>] [<c0115fc7>] [<c014943e>] [<c01497ca>] [<c0107353>]
conserver     S 7FFFFFFF  3832   479    478                     (NOTLB)
Call Trace:    [<c0115fc7>] [<c014943e>] [<c01497ca>] [<c0107353>]
dhcpd-2.2.x   S 7FFFFFFF  3528   482      1           492   478 (NOTLB)
Call Trace:    [<c0115fc7>] [<c01f6677>] [<c0240fc2>] [<c02419e7>] [<c01f3ff5>]
  [<c01f4ed5>] [<c01f73bc>] [<c01f90ad>] [<d0805575>] [<c01f4051>] [<c0121657>]
  [<c0121872>] [<c01f4f12>] [<c01f56b1>] [<c0107353>]
inetd         S 7FFFFFFF     0   492      1   887    1068   482 (NOTLB)
Call Trace:    [<c0216162>] [<c0115fc7>] [<c014943e>] [<c01497ca>] [<c0107353>]
icmplog       D 00000286     0  1068      1          1070   492 (NOTLB)
Call Trace:    [<c0116a7b>] [<c016c6dc>] [<c016c85d>] [<c0167688>] [<c014e2da>]
  [<c014fb6b>] [<c012b202>] [<c012b5bb>] [<c012b49c>] [<c0139bd6>] [<c012b528>]
  [<c0139cd5>] [<c0107353>]
tcplog        S 7FFFFFFF   892  1070      1          1083  1068 (NOTLB)
Call Trace:    [<c0115fc7>] [<c01f6677>] [<c0240fc2>] [<c02419e7>] [<c01f3ff5>]
  [<c01f4ed5>] [<c0128725>] [<c01298dd>] [<c012919d>] [<c01291af>] [<c01f4f12>]
  [<c01f56b1>] [<c0107353>]
lpd           S 7FFFFFFF    12  1083      1          1098  1070 (NOTLB)
Call Trace:    [<c0115fc7>] [<c014943e>] [<c01497ca>] [<c0107353>]
safe_mysqld   S 00000000     0  1098      1  1133    1168  1083 (NOTLB)
Call Trace:    [<c011cd25>] [<c0107353>]
mysqld        S 7FFFFFFF  1376  1133   1098  1139               (NOTLB)
Call Trace:    [<c0115fc7>] [<c014943e>] [<c01497ca>] [<c0107353>]
mysqld        S CA69FF28  4892  1139   1133  1148               (NOTLB)
Call Trace:    [<c011602a>] [<c0115f50>] [<c0149a4f>] [<c0149c5d>] [<c0107353>]
mysqld        S CA69BFB0  6124  1140   1139          1141       (NOTLB)
Call Trace:    [<c0106484>] [<c0107353>]
mysqld        S CA699FB0  2404  1141   1139          1142  1140 (NOTLB)
Call Trace:    [<c0106484>] [<c0107353>]
mysqld        S CA695FB0  5596  1142   1139          1143  1141 (NOTLB)
Call Trace:    [<c0106484>] [<c0107353>]
mysqld        S CA691FB0  6336  1143   1139          1144  1142 (NOTLB)
Call Trace:    [<c0106484>] [<c0107353>]
mysqld        S C9F3BFB0  6180  1144   1139          1145  1143 (NOTLB)
Call Trace:    [<c0106484>] [<c0107353>]
mysqld        S C9E8FF2C  2404  1145   1139          1146  1144 (NOTLB)
Call Trace:    [<c011602a>] [<c0115f50>] [<c014943e>] [<c01497ca>] [<c0107353>]
mysqld        S C9EEFFB0  5844  1146   1139          1147  1145 (NOTLB)
Call Trace:    [<c011db2d>] [<c0106484>] [<c0107353>]
mysqld        S C9F13FB0  5460  1147   1139          1148  1146 (NOTLB)
Call Trace:    [<c0106484>] [<c0107353>]
mysqld        S C9D1DFB0  6324  1148   1139                1147 (NOTLB)
Call Trace:    [<c0106484>] [<c0107353>]
nfsd          D CFA2D6DC   112  1157      1          1171  1158 (L-TLB)
Call Trace:    [<c0105fe5>] [<c0106194>] [<d08cc15d>] [<d08cb807>] [<d08d1df9>]
  [<d08d8ca4>] [<d08c95b3>] [<d08d8ca4>] [<d089df27>] [<d08d8638>] [<d08d8658>]
  [<d08c9390>] [<d08d8620>] [<c0105a64>]
nfsd          D CFA2D6DC  2520  1158      1          1157  1159 (L-TLB)
Call Trace:    [<c0105fe5>] [<c0106194>] [<d08cc15d>] [<d08cb807>] [<d08d1df9>]
  [<d08d8ca4>] [<d08c95b3>] [<d08d8ca4>] [<d089df27>] [<d08d8638>] [<d08d8658>]
  [<d08c9390>] [<c0105a64>]
nfsd          D CFA2D6DC     0  1159      1          1158  1160 (L-TLB)
Call Trace:    [<c0105fe5>] [<c0106194>] [<d08cc15d>] [<d08cb807>] [<d08d1df9>]
  [<d08d8ca4>] [<d08c95b3>] [<d08d8ca4>] [<d089df27>] [<d08d8638>] [<d08d8658>]
  [<d08c9390>] [<c0105a64>]
nfsd          D CFA2D6DC     8  1160      1          1159  1161 (L-TLB)
Call Trace:    [<c0105fe5>] [<c0106194>] [<d08cc15d>] [<d08cb807>] [<d08d1df9>]
  [<d08d8ca4>] [<d08c95b3>] [<d08d8ca4>] [<d089df27>] [<d08d8638>] [<d08d8658>]
  [<d08c9390>] [<c0105a64>]
nfsd          D CFA2D6DC     0  1161      1          1160  1162 (L-TLB)
Call Trace:    [<c0105fe5>] [<c0106194>] [<d08cc15d>] [<d08cb807>] [<d08d1df9>]
  [<d08d8ca4>] [<d08c95b3>] [<d08d8ca4>] [<d089df27>] [<d08d8638>] [<d08d8658>]
  [<d08c9390>] [<c0105a64>]
nfsd          D CFA2D6DC     0  1162      1          1161  1163 (L-TLB)
Call Trace:    [<c0105fe5>] [<c0106194>] [<d08cc15d>] [<d08cb807>] [<d08d1df9>]
  [<d08d8ca4>] [<d08c95b3>] [<d08d8ca4>] [<d089df27>] [<d08d8638>] [<d08d8658>]
  [<d08c9390>] [<c0105a64>]
nfsd          D CFA2D6DC     0  1163      1          1162  1164 (L-TLB)
Call Trace:    [<c0105fe5>] [<c0106194>] [<d08cc15d>] [<d08cb807>] [<d08d1df9>]
  [<d08d8ca4>] [<d08c95b3>] [<d08d8ca4>] [<d089df27>] [<d08d8638>] [<d08d8658>]
  [<d08c9390>] [<c0105a64>]
nfsd          D CFA2D6DC     0  1164      1          1163  1165 (L-TLB)
Call Trace:    [<c0105fe5>] [<c0106194>] [<d08cc15d>] [<d08cb807>] [<d08d1df9>]
  [<d08d8ca4>] [<d08c95b3>] [<d08d8ca4>] [<d089df27>] [<d08d8638>] [<d08d8658>]
  [<d08c9390>] [<c0105a64>]
nfsd          D CFA2D6DC     0  1165      1          1164  1166 (L-TLB)
Call Trace:    [<c0105fe5>] [<c0106194>] [<d08cc15d>] [<d08cb807>] [<d08d1df9>]
  [<d08d8ca4>] [<d08c95b3>] [<d08d8ca4>] [<d089df27>] [<d08d8638>] [<d08d8658>]
  [<d08c9390>] [<c0105a64>]
nfsd          D CFA2D6DC     0  1166      1          1165  1167 (L-TLB)
Call Trace:    [<c0105fe5>] [<c0106194>] [<d08cc15d>] [<d08cb807>] [<d08d1df9>]
  [<d08d8ca4>] [<d08c95b3>] [<d08d8ca4>] [<d089df27>] [<d08d8638>] [<d08d8658>]
  [<d08c9390>] [<c0105a64>]
nfsd          D 00000286     0  1167      1          1166  1168 (L-TLB)
Call Trace:    [<c0116a7b>] [<c016c6dc>] [<c016c85d>] [<c0167688>] [<c014e2da>]
  [<d08cab90>] [<c014fb6b>] [<c0162e00>] [<d082c63a>] [<c01488b4>] [<d08cab90>]
  [<d08cac85>] [<d08cab90>] [<d08cb0a8>] [<c013b7d8>] [<c013b7ff>] [<c013ba34>]
  [<c0166a94>] [<c0166b52>] [<c0166d9e>] [<c014f6f1>] [<c014f866>] [<d08cadbb>]
  [<d08cae3d>] [<d08cb33d>] [<d08cb37a>] [<d08cb807>] [<d08d1df9>] [<d08d8ca4>]
  [<d08c95b3>] [<d08d8ca4>] [<d089df27>] [<d08d8638>] [<d08d8658>] [<d08c9390>]
  [<c0105a64>]
nfsd          D CFA2D6DC  2400  1168      1          1167  1098 (L-TLB)
Call Trace:    [<c0105fe5>] [<c0106194>] [<d08cc15d>] [<d08cb807>] [<d08d1df9>]
  [<d08d8ca4>] [<d08c95b3>] [<d08d8ca4>] [<d089df27>] [<d08d8638>] [<d08d8658>]
  [<d08c9390>] [<d08d8620>] [<c0105a64>]
rpc.mountd    S 7FFFFFFF  4644  1171      1          1175  1157 (NOTLB)
Call Trace:    [<c0115fc7>] [<c01f6677>] [<c0240fc2>] [<c02419e7>] [<c01f3ff5>]
  [<c01f4ed5>] [<c0133368>] [<c0133796>] [<c0126ab0>] [<c012707b>] [<c01290b2>]
  [<c01f4f12>] [<c01f56b1>] [<c0107353>]
omniNames     S C9FB3F8C  1024  1175      1  1185    1179  1171 (NOTLB)
Call Trace:    [<c011dec0>] [<c011602a>] [<c0115f50>] [<c0121e3a>] [<c0107353>]
powstatd      S CA0C5F8C  4472  1179      1          1182  1175 (NOTLB)
Call Trace:    [<c01f7551>] [<c011602a>] [<c0115f50>] [<c0121e3a>] [<c0107353>]
rarpd         S 7FFFFFFF  5812  1182      1          1189  1179 (NOTLB)
Call Trace:    [<c0115fc7>] [<c0149a1a>] [<c0149a4f>] [<c0149c5d>] [<c0107353>]
omniNames     S C9C47F28  4792  1185   1175  1188               (NOTLB)
Call Trace:    [<c011602a>] [<c0115f50>] [<c0149a4f>] [<c0149c5d>] [<c0107353>]
omniNames     S C9C43FB0  6124  1186   1185          1187       (NOTLB)
Call Trace:    [<c0106484>] [<c0107353>]
omniNames     S C9C3FF8C  5004  1187   1185          1188  1186 (NOTLB)
Call Trace:    [<c011602a>] [<c0115f50>] [<c0121e3a>] [<c0107353>]
Warning (Oops_read): Code line not seen, dumping what data is available

Proc;  init

>>EIP; c12d5f2c <_end+f83500/104b15d4>   <=====

Trace; c011602a <schedule_timeout+7a/9c>
Trace; c0115f50 <process_timeout+0/60>
Trace; c014943e <do_select+1ca/204>
Trace; c01497ca <sys_select+32a/46c>
Trace; c0107353 <system_call+33/38>
Proc;  keventd

>>EIP; c13a8664 <_end+1055c38/104b15d4>   <=====

Trace; c0126045 <context_thread+115/1d0>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  ksoftirqd_CPU

>>EIP; c13a6000 <_end+10535d4/104b15d4>   <=====

Trace; c011e04b <ksoftirqd+93/c8>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  ksoftirqd_CPU

>>EIP; c13a4000 <_end+10515d4/104b15d4>   <=====

Trace; c011e04b <ksoftirqd+93/c8>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  kswapd

>>EIP; c1394000 <_end+10415d4/104b15d4>   <=====

Trace; c0132686 <kswapd+82/b4>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  bdflush

>>EIP; 00000286 Before first symbol   <=====

Trace; c011697b <interruptible_sleep_on+4b/7c>
Trace; c013de57 <bdflush+c7/cc>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  kupdated

>>EIP; 00000286 Before first symbol   <=====

Trace; c0116a7b <sleep_on+4b/7c>
Trace; c016c6dc <start_this_handle+d0/170>
Trace; c016c85d <journal_start+95/c4>
Trace; c0165a68 <ext3_writepage+e4/2f4>
Trace; c0165984 <ext3_writepage+0/2f4>
Trace; c012a2ba <filemap_fdatasync+6a/b8>
Trace; c014e765 <sync_unlocked_inodes+ad/1bc>
Trace; c013dc57 <sync_old_buffers+2b/a4>
Trace; c013dfa5 <kupdate+149/180>
Trace; c0107306 <ret_from_fork+6/20>
Trace; c013de5c <kupdate+0/180>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  ahc_dv_0

>>EIP; c139ee0c <_end+104c3e0/104b15d4>   <=====

Trace; c01060b5 <__down_interruptible+6d/f4>
Trace; c010619f <__down_failed_interruptible+7/c>
Trace; c01d6fea <.text.lock.aic7xxx_osm+125/2ab>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  scsi_eh_0

>>EIP; c1323fdc <_end+fd15b0/104b15d4>   <=====

Trace; c01060b5 <__down_interruptible+6d/f4>
Trace; c010619f <__down_failed_interruptible+7/c>
Trace; c01cc200 <.text.lock.scsi_error+e5/f5>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  kjournald

>>EIP; 00000286 Before first symbol   <=====

Trace; c010bbfd <call_apic_timer_interrupt+5/10>
Trace; c011697b <interruptible_sleep_on+4b/7c>
Trace; c01715b9 <kjournald+169/21c>
Trace; c0171440 <commit_timeout+0/c>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  kjournald

>>EIP; 00000286 Before first symbol   <=====

Trace; c0116a7b <sleep_on+4b/7c>
Trace; c016e9f9 <journal_commit_transaction+165/fcc>
Trace; c0116532 <schedule+45a/520>
Trace; c0171596 <kjournald+146/21c>
Trace; c0171440 <commit_timeout+0/c>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  kjournald

>>EIP; 00000286 Before first symbol   <=====

Trace; c011697b <interruptible_sleep_on+4b/7c>
Trace; c01715b9 <kjournald+169/21c>
Trace; c0171440 <commit_timeout+0/c>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  kjournald

>>EIP; 00000286 Before first symbol   <=====

Trace; c011697b <interruptible_sleep_on+4b/7c>
Trace; c01715b9 <kjournald+169/21c>
Trace; c0171440 <commit_timeout+0/c>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  kjournald

>>EIP; 00000286 Before first symbol   <=====

Trace; c011697b <interruptible_sleep_on+4b/7c>
Trace; c01715b9 <kjournald+169/21c>
Trace; c0171440 <commit_timeout+0/c>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  kjournald

>>EIP; 00000286 Before first symbol   <=====

Trace; c011697b <interruptible_sleep_on+4b/7c>
Trace; c01715b9 <kjournald+169/21c>
Trace; c0171440 <commit_timeout+0/c>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  devfsd

>>EIP; cf244000 <_end+eef15d4/104b15d4>   <=====

Trace; c0176446 <devfsd_read+10a/3f8>
Trace; c01398ab <sys_read+8f/104>
Trace; c0107353 <system_call+33/38>
Proc;  syslogd

>>EIP; 00000286 Before first symbol   <=====

Trace; c0116a7b <sleep_on+4b/7c>
Trace; c016c6dc <start_this_handle+d0/170>
Trace; c016c85d <journal_start+95/c4>
Trace; c0167688 <ext3_dirty_inode+74/10c>
Trace; c014e2da <__mark_inode_dirty+32/a8>
Trace; c012cff3 <do_generic_file_write+d3/3c8>
Trace; c012d5c4 <generic_file_write+10c/12c>
Trace; c0162e77 <ext3_file_write+23/bc>
Trace; c0139bd6 <do_readv_writev+1aa/268>
Trace; c0162e54 <ext3_file_write+0/bc>
Trace; c0139d29 <sys_writev+41/54>
Trace; c0107353 <system_call+33/38>
Proc;  watchdog

>>EIP; cf1c9f8c <_end+ee77560/104b15d4>   <=====

Trace; c011602a <schedule_timeout+7a/9c>
Trace; c0115f50 <process_timeout+0/60>
Trace; c0121e3a <sys_nanosleep+102/178>
Trace; c0107353 <system_call+33/38>
Proc;  klogd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0115fc7 <schedule_timeout+17/9c>
Trace; c01f6677 <sock_alloc_send_pskb+73/1d0>
Trace; c0240fc2 <unix_wait_for_peer+a6/cc>
Trace; c02419e7 <unix_dgram_sendmsg+327/3f8>
Trace; c0116532 <schedule+45a/520>
Trace; c01f3ff5 <sock_sendmsg+69/88>
Trace; c01f421e <sock_write+b2/bc>
Trace; c01399b6 <sys_write+96/10c>
Trace; c0107353 <system_call+33/38>
Proc;  named

>>EIP; 00000000 Before first symbol

Trace; c01f4f12 <sys_send+1e/24>
Trace; c011cd25 <sys_wait4+395/3cc>
Trace; c0107353 <system_call+33/38>
Proc;  named

>>EIP; cf129fb0 <_end+edd7584/104b15d4>   <=====

Trace; c0106484 <sys_rt_sigsuspend+fc/118>
Trace; c0107353 <system_call+33/38>
Proc;  portmap

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0115fc7 <schedule_timeout+17/9c>
Trace; c0149a1a <do_poll+86/dc>
Trace; c0149a4f <do_poll+bb/dc>
Trace; c0149c5d <sys_poll+1ed/2f4>
Trace; c0107353 <system_call+33/38>
Proc;  ypserv

>>EIP; 00000286 Before first symbol   <=====

Trace; c0116a7b <sleep_on+4b/7c>
Trace; c016c6dc <start_this_handle+d0/170>
Trace; c016c85d <journal_start+95/c4>
Trace; c0167688 <ext3_dirty_inode+74/10c>
Trace; c014e2da <__mark_inode_dirty+32/a8>
Trace; c014fb6b <update_atime+4b/50>
Trace; c012b202 <do_generic_file_read+486/494>
Trace; c012b5bb <generic_file_read+93/194>
Trace; c012b49c <file_read_actor+0/8c>
Trace; c0139508 <generic_file_llseek+0/94>
Trace; c01398ab <sys_read+8f/104>
Trace; c0107353 <system_call+33/38>
Proc;  rpc.yppasswdd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0115fc7 <schedule_timeout+17/9c>
Trace; c0149a1a <do_poll+86/dc>
Trace; c0149a4f <do_poll+bb/dc>
Trace; c0149c5d <sys_poll+1ed/2f4>
Trace; c0139369 <filp_close+9d/a8>
Trace; c0107353 <system_call+33/38>
Proc;  named

>>EIP; ceb59f28 <_end+e8074fc/104b15d4>   <=====

Trace; c011602a <schedule_timeout+7a/9c>
Trace; c0115f50 <process_timeout+0/60>
Trace; c0149a4f <do_poll+bb/dc>
Trace; c0149c5d <sys_poll+1ed/2f4>
Trace; c010b2a8 <call_do_IRQ+5/d>
Trace; c0107353 <system_call+33/38>
Proc;  named

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0115fc7 <schedule_timeout+17/9c>
Trace; c01f6677 <sock_alloc_send_pskb+73/1d0>
Trace; c0240fc2 <unix_wait_for_peer+a6/cc>
Trace; c02419e7 <unix_dgram_sendmsg+327/3f8>
Trace; c01f3ff5 <sock_sendmsg+69/88>
Trace; c01f4ed5 <sys_sendto+d9/f8>
Trace; c011522a <do_page_fault+17e/49a>
Trace; c01150ac <do_page_fault+0/49a>
Trace; c01f4f12 <sys_send+1e/24>
Trace; c01f56b1 <sys_socketcall+119/200>
Trace; c0107353 <system_call+33/38>
Proc;  named

>>EIP; ceb57fb0 <_end+e805584/104b15d4>   <=====

Trace; c0106484 <sys_rt_sigsuspend+fc/118>
Trace; c0107353 <system_call+33/38>
Proc;  named

>>EIP; ceb51f8c <_end+e7ff560/104b15d4>   <=====

Trace; c011602a <schedule_timeout+7a/9c>
Trace; c0115f50 <process_timeout+0/60>
Trace; c0121e3a <sys_nanosleep+102/178>
Trace; c0107353 <system_call+33/38>
Proc;  named

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0216162 <tcp_poll+2e/158>
Trace; c0115fc7 <schedule_timeout+17/9c>
Trace; c014943e <do_select+1ca/204>
Trace; c01497ca <sys_select+32a/46c>
Trace; c0107353 <system_call+33/38>
Proc;  rpc.ypxfrd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0216162 <tcp_poll+2e/158>
Trace; c0115fc7 <schedule_timeout+17/9c>
Trace; c014943e <do_select+1ca/204>
Trace; c01497ca <sys_select+32a/46c>
Trace; c0107353 <system_call+33/38>
Proc;  ypbind

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0115fc7 <schedule_timeout+17/9c>
Trace; c0149a1a <do_poll+86/dc>
Trace; c0149a4f <do_poll+bb/dc>
Trace; c0149c5d <sys_poll+1ed/2f4>
Trace; c0139369 <filp_close+9d/a8>
Trace; c0107353 <system_call+33/38>
Proc;  ypbind

>>EIP; cea29f28 <_end+e6d74fc/104b15d4>   <=====

Trace; c011602a <schedule_timeout+7a/9c>
Trace; c0115f50 <process_timeout+0/60>
Trace; c0149a4f <do_poll+bb/dc>
Trace; c0149c5d <sys_poll+1ed/2f4>
Trace; c0107353 <system_call+33/38>
Proc;  ypbind

>>EIP; ceac3fb0 <_end+e771584/104b15d4>   <=====

Trace; c0106484 <sys_rt_sigsuspend+fc/118>
Trace; c0107353 <system_call+33/38>
Proc;  ypbind

>>EIP; cea6df8c <_end+e71b560/104b15d4>   <=====

Trace; c011602a <schedule_timeout+7a/9c>
Trace; c0115f50 <process_timeout+0/60>
Trace; c0121e3a <sys_nanosleep+102/178>
Trace; c0107353 <system_call+33/38>
Proc;  amd

>>EIP; 00000286 Before first symbol   <=====

Trace; c0116a7b <sleep_on+4b/7c>
Trace; c016c6dc <start_this_handle+d0/170>
Trace; c016c85d <journal_start+95/c4>
Trace; c0167688 <ext3_dirty_inode+74/10c>
Trace; c014e2da <__mark_inode_dirty+32/a8>
Trace; c014fb6b <update_atime+4b/50>
Trace; c012b202 <do_generic_file_read+486/494>
Trace; c012b5bb <generic_file_read+93/194>
Trace; c012b49c <file_read_actor+0/8c>
Trace; c0139bd6 <do_readv_writev+1aa/268>
Trace; c012b528 <generic_file_read+0/194>
Trace; c0139cd5 <sys_readv+41/54>
Trace; c0107353 <system_call+33/38>
Proc;  rpciod

>>EIP; 00000001 Before first symbol   <=====

Trace; d089c371 <[sunrpc]rpciod+175/234>
Trace; d08a5f2c <[sunrpc]rpciod_killer+0/c>
Trace; d08a5f2c <[sunrpc]rpciod_killer+0/c>
Trace; d08a5f24 <[sunrpc]rpciod_idle+4/c>
Trace; d08a5f24 <[sunrpc]rpciod_idle+4/c>
Trace; c0105a64 <arch_kernel_thread+28/38>
Trace; d08a5f2c <[sunrpc]rpciod_killer+0/c>
Proc;  lockd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0115fc7 <schedule_timeout+17/9c>
Trace; d089fc7e <[sunrpc]svc_recv+25a/4c4>
Trace; d08aac44 <[lockd]lockd+160/2b4>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  rpc.rquotad

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0115fc7 <schedule_timeout+17/9c>
Trace; c0149a1a <do_poll+86/dc>
Trace; c0149a4f <do_poll+bb/dc>
Trace; c0149c5d <sys_poll+1ed/2f4>
Trace; c01f577c <sys_socketcall+1e4/200>
Trace; c0107353 <system_call+33/38>
Proc;  rpc.bootparam

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0115fc7 <schedule_timeout+17/9c>
Trace; c0149a1a <do_poll+86/dc>
Trace; c0149a4f <do_poll+bb/dc>
Trace; c0149c5d <sys_poll+1ed/2f4>
Trace; c0139369 <filp_close+9d/a8>
Trace; c0107353 <system_call+33/38>
Proc;  conserver

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0216162 <tcp_poll+2e/158>
Trace; c0115fc7 <schedule_timeout+17/9c>
Trace; c014943e <do_select+1ca/204>
Trace; c01497ca <sys_select+32a/46c>
Trace; c0107353 <system_call+33/38>
Proc;  conserver

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0115fc7 <schedule_timeout+17/9c>
Trace; c014943e <do_select+1ca/204>
Trace; c01497ca <sys_select+32a/46c>
Trace; c0107353 <system_call+33/38>
Proc;  dhcpd-2.2.x

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0115fc7 <schedule_timeout+17/9c>
Trace; c01f6677 <sock_alloc_send_pskb+73/1d0>
Trace; c0240fc2 <unix_wait_for_peer+a6/cc>
Trace; c02419e7 <unix_dgram_sendmsg+327/3f8>
Trace; c01f3ff5 <sock_sendmsg+69/88>
Trace; c01f4ed5 <sys_sendto+d9/f8>
Trace; c01f73bc <kfree_skbmem+c/68>
Trace; c01f90ad <skb_free_datagram+1d/24>
Trace; d0805575 <[af_packet]packet_recvmsg+11d/12c>
Trace; c01f4051 <sock_recvmsg+3d/bc>
Trace; c0121657 <update_wall_time+b/34>
Trace; c0121872 <timer_bh+36/3d4>
Trace; c01f4f12 <sys_send+1e/24>
Trace; c01f56b1 <sys_socketcall+119/200>
Trace; c0107353 <system_call+33/38>
Proc;  inetd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0216162 <tcp_poll+2e/158>
Trace; c0115fc7 <schedule_timeout+17/9c>
Trace; c014943e <do_select+1ca/204>
Trace; c01497ca <sys_select+32a/46c>
Trace; c0107353 <system_call+33/38>
Proc;  icmplog

>>EIP; 00000286 Before first symbol   <=====

Trace; c0116a7b <sleep_on+4b/7c>
Trace; c016c6dc <start_this_handle+d0/170>
Trace; c016c85d <journal_start+95/c4>
Trace; c0167688 <ext3_dirty_inode+74/10c>
Trace; c014e2da <__mark_inode_dirty+32/a8>
Trace; c014fb6b <update_atime+4b/50>
Trace; c012b202 <do_generic_file_read+486/494>
Trace; c012b5bb <generic_file_read+93/194>
Trace; c012b49c <file_read_actor+0/8c>
Trace; c0139bd6 <do_readv_writev+1aa/268>
Trace; c012b528 <generic_file_read+0/194>
Trace; c0139cd5 <sys_readv+41/54>
Trace; c0107353 <system_call+33/38>
Proc;  tcplog

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0115fc7 <schedule_timeout+17/9c>
Trace; c01f6677 <sock_alloc_send_pskb+73/1d0>
Trace; c0240fc2 <unix_wait_for_peer+a6/cc>
Trace; c02419e7 <unix_dgram_sendmsg+327/3f8>
Trace; c01f3ff5 <sock_sendmsg+69/88>
Trace; c01f4ed5 <sys_sendto+d9/f8>
Trace; c0128725 <__vma_link+61/b0>
Trace; c01298dd <__insert_vm_struct+55/64>
Trace; c012919d <unmap_fixup+14d/16c>
Trace; c01291af <unmap_fixup+15f/16c>
Trace; c01f4f12 <sys_send+1e/24>
Trace; c01f56b1 <sys_socketcall+119/200>
Trace; c0107353 <system_call+33/38>
Proc;  lpd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0115fc7 <schedule_timeout+17/9c>
Trace; c014943e <do_select+1ca/204>
Trace; c01497ca <sys_select+32a/46c>
Trace; c0107353 <system_call+33/38>
Proc;  safe_mysqld

>>EIP; 00000000 Before first symbol

Trace; c011cd25 <sys_wait4+395/3cc>
Trace; c0107353 <system_call+33/38>
Proc;  mysqld

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0115fc7 <schedule_timeout+17/9c>
Trace; c014943e <do_select+1ca/204>
Trace; c01497ca <sys_select+32a/46c>
Trace; c0107353 <system_call+33/38>
Proc;  mysqld

>>EIP; ca69ff28 <_end+a34d4fc/104b15d4>   <=====

Trace; c011602a <schedule_timeout+7a/9c>
Trace; c0115f50 <process_timeout+0/60>
Trace; c0149a4f <do_poll+bb/dc>
Trace; c0149c5d <sys_poll+1ed/2f4>
Trace; c0107353 <system_call+33/38>
Proc;  mysqld

>>EIP; ca69bfb0 <_end+a349584/104b15d4>   <=====

Trace; c0106484 <sys_rt_sigsuspend+fc/118>
Trace; c0107353 <system_call+33/38>
Proc;  mysqld

>>EIP; ca699fb0 <_end+a347584/104b15d4>   <=====

Trace; c0106484 <sys_rt_sigsuspend+fc/118>
Trace; c0107353 <system_call+33/38>
Proc;  mysqld

>>EIP; ca695fb0 <_end+a343584/104b15d4>   <=====

Trace; c0106484 <sys_rt_sigsuspend+fc/118>
Trace; c0107353 <system_call+33/38>
Proc;  mysqld

>>EIP; ca691fb0 <_end+a33f584/104b15d4>   <=====

Trace; c0106484 <sys_rt_sigsuspend+fc/118>
Trace; c0107353 <system_call+33/38>
Proc;  mysqld

>>EIP; c9f3bfb0 <_end+9be9584/104b15d4>   <=====

Trace; c0106484 <sys_rt_sigsuspend+fc/118>
Trace; c0107353 <system_call+33/38>
Proc;  mysqld

>>EIP; c9e8ff2c <_end+9b3d500/104b15d4>   <=====

Trace; c011602a <schedule_timeout+7a/9c>
Trace; c0115f50 <process_timeout+0/60>
Trace; c014943e <do_select+1ca/204>
Trace; c01497ca <sys_select+32a/46c>
Trace; c0107353 <system_call+33/38>
Proc;  mysqld

>>EIP; c9eeffb0 <_end+9b9d584/104b15d4>   <=====

Trace; c011db2d <do_softirq+7d/dc>
Trace; c0106484 <sys_rt_sigsuspend+fc/118>
Trace; c0107353 <system_call+33/38>
Proc;  mysqld

>>EIP; c9f13fb0 <_end+9bc1584/104b15d4>   <=====

Trace; c0106484 <sys_rt_sigsuspend+fc/118>
Trace; c0107353 <system_call+33/38>
Proc;  mysqld

>>EIP; c9d1dfb0 <_end+99cb584/104b15d4>   <=====

Trace; c0106484 <sys_rt_sigsuspend+fc/118>
Trace; c0107353 <system_call+33/38>
Proc;  nfsd

>>EIP; cfa2d6dc <_end+f6dacb0/104b15d4>   <=====

Trace; c0105fe5 <__down+6d/d0>
Trace; c0106194 <__down_failed+8/c>
Trace; d08cc15d <[nfsd].text.lock.nfsfh+8d/f0>
Trace; d08cb807 <[nfsd]fh_verify+2bf/474>
Trace; d08d1df9 <[nfsd]nfsd3_proc_getattr+95/a0>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d08c95b3 <[nfsd]nfsd_dispatch+d3/19a>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d089df27 <[sunrpc]svc_process+28f/4f0>
Trace; d08d8638 <[nfsd]nfsd_version3+0/10>
Trace; d08d8658 <[nfsd]nfsd_program+0/28>
Trace; d08c9390 <[nfsd]nfsd+204/354>
Trace; d08d8620 <[nfsd]nfsd_list+0/0>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  nfsd

>>EIP; cfa2d6dc <_end+f6dacb0/104b15d4>   <=====

Trace; c0105fe5 <__down+6d/d0>
Trace; c0106194 <__down_failed+8/c>
Trace; d08cc15d <[nfsd].text.lock.nfsfh+8d/f0>
Trace; d08cb807 <[nfsd]fh_verify+2bf/474>
Trace; d08d1df9 <[nfsd]nfsd3_proc_getattr+95/a0>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d08c95b3 <[nfsd]nfsd_dispatch+d3/19a>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d089df27 <[sunrpc]svc_process+28f/4f0>
Trace; d08d8638 <[nfsd]nfsd_version3+0/10>
Trace; d08d8658 <[nfsd]nfsd_program+0/28>
Trace; d08c9390 <[nfsd]nfsd+204/354>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  nfsd

>>EIP; cfa2d6dc <_end+f6dacb0/104b15d4>   <=====

Trace; c0105fe5 <__down+6d/d0>
Trace; c0106194 <__down_failed+8/c>
Trace; d08cc15d <[nfsd].text.lock.nfsfh+8d/f0>
Trace; d08cb807 <[nfsd]fh_verify+2bf/474>
Trace; d08d1df9 <[nfsd]nfsd3_proc_getattr+95/a0>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d08c95b3 <[nfsd]nfsd_dispatch+d3/19a>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d089df27 <[sunrpc]svc_process+28f/4f0>
Trace; d08d8638 <[nfsd]nfsd_version3+0/10>
Trace; d08d8658 <[nfsd]nfsd_program+0/28>
Trace; d08c9390 <[nfsd]nfsd+204/354>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  nfsd

>>EIP; cfa2d6dc <_end+f6dacb0/104b15d4>   <=====

Trace; c0105fe5 <__down+6d/d0>
Trace; c0106194 <__down_failed+8/c>
Trace; d08cc15d <[nfsd].text.lock.nfsfh+8d/f0>
Trace; d08cb807 <[nfsd]fh_verify+2bf/474>
Trace; d08d1df9 <[nfsd]nfsd3_proc_getattr+95/a0>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d08c95b3 <[nfsd]nfsd_dispatch+d3/19a>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d089df27 <[sunrpc]svc_process+28f/4f0>
Trace; d08d8638 <[nfsd]nfsd_version3+0/10>
Trace; d08d8658 <[nfsd]nfsd_program+0/28>
Trace; d08c9390 <[nfsd]nfsd+204/354>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  nfsd

>>EIP; cfa2d6dc <_end+f6dacb0/104b15d4>   <=====

Trace; c0105fe5 <__down+6d/d0>
Trace; c0106194 <__down_failed+8/c>
Trace; d08cc15d <[nfsd].text.lock.nfsfh+8d/f0>
Trace; d08cb807 <[nfsd]fh_verify+2bf/474>
Trace; d08d1df9 <[nfsd]nfsd3_proc_getattr+95/a0>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d08c95b3 <[nfsd]nfsd_dispatch+d3/19a>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d089df27 <[sunrpc]svc_process+28f/4f0>
Trace; d08d8638 <[nfsd]nfsd_version3+0/10>
Trace; d08d8658 <[nfsd]nfsd_program+0/28>
Trace; d08c9390 <[nfsd]nfsd+204/354>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  nfsd

>>EIP; cfa2d6dc <_end+f6dacb0/104b15d4>   <=====

Trace; c0105fe5 <__down+6d/d0>
Trace; c0106194 <__down_failed+8/c>
Trace; d08cc15d <[nfsd].text.lock.nfsfh+8d/f0>
Trace; d08cb807 <[nfsd]fh_verify+2bf/474>
Trace; d08d1df9 <[nfsd]nfsd3_proc_getattr+95/a0>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d08c95b3 <[nfsd]nfsd_dispatch+d3/19a>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d089df27 <[sunrpc]svc_process+28f/4f0>
Trace; d08d8638 <[nfsd]nfsd_version3+0/10>
Trace; d08d8658 <[nfsd]nfsd_program+0/28>
Trace; d08c9390 <[nfsd]nfsd+204/354>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  nfsd

>>EIP; cfa2d6dc <_end+f6dacb0/104b15d4>   <=====

Trace; c0105fe5 <__down+6d/d0>
Trace; c0106194 <__down_failed+8/c>
Trace; d08cc15d <[nfsd].text.lock.nfsfh+8d/f0>
Trace; d08cb807 <[nfsd]fh_verify+2bf/474>
Trace; d08d1df9 <[nfsd]nfsd3_proc_getattr+95/a0>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d08c95b3 <[nfsd]nfsd_dispatch+d3/19a>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d089df27 <[sunrpc]svc_process+28f/4f0>
Trace; d08d8638 <[nfsd]nfsd_version3+0/10>
Trace; d08d8658 <[nfsd]nfsd_program+0/28>
Trace; d08c9390 <[nfsd]nfsd+204/354>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  nfsd

>>EIP; cfa2d6dc <_end+f6dacb0/104b15d4>   <=====

Trace; c0105fe5 <__down+6d/d0>
Trace; c0106194 <__down_failed+8/c>
Trace; d08cc15d <[nfsd].text.lock.nfsfh+8d/f0>
Trace; d08cb807 <[nfsd]fh_verify+2bf/474>
Trace; d08d1df9 <[nfsd]nfsd3_proc_getattr+95/a0>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d08c95b3 <[nfsd]nfsd_dispatch+d3/19a>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d089df27 <[sunrpc]svc_process+28f/4f0>
Trace; d08d8638 <[nfsd]nfsd_version3+0/10>
Trace; d08d8658 <[nfsd]nfsd_program+0/28>
Trace; d08c9390 <[nfsd]nfsd+204/354>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  nfsd

>>EIP; cfa2d6dc <_end+f6dacb0/104b15d4>   <=====

Trace; c0105fe5 <__down+6d/d0>
Trace; c0106194 <__down_failed+8/c>
Trace; d08cc15d <[nfsd].text.lock.nfsfh+8d/f0>
Trace; d08cb807 <[nfsd]fh_verify+2bf/474>
Trace; d08d1df9 <[nfsd]nfsd3_proc_getattr+95/a0>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d08c95b3 <[nfsd]nfsd_dispatch+d3/19a>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d089df27 <[sunrpc]svc_process+28f/4f0>
Trace; d08d8638 <[nfsd]nfsd_version3+0/10>
Trace; d08d8658 <[nfsd]nfsd_program+0/28>
Trace; d08c9390 <[nfsd]nfsd+204/354>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  nfsd

>>EIP; cfa2d6dc <_end+f6dacb0/104b15d4>   <=====

Trace; c0105fe5 <__down+6d/d0>
Trace; c0106194 <__down_failed+8/c>
Trace; d08cc15d <[nfsd].text.lock.nfsfh+8d/f0>
Trace; d08cb807 <[nfsd]fh_verify+2bf/474>
Trace; d08d1df9 <[nfsd]nfsd3_proc_getattr+95/a0>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d08c95b3 <[nfsd]nfsd_dispatch+d3/19a>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d089df27 <[sunrpc]svc_process+28f/4f0>
Trace; d08d8638 <[nfsd]nfsd_version3+0/10>
Trace; d08d8658 <[nfsd]nfsd_program+0/28>
Trace; d08c9390 <[nfsd]nfsd+204/354>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  nfsd

>>EIP; 00000286 Before first symbol   <=====

Trace; c0116a7b <sleep_on+4b/7c>
Trace; c016c6dc <start_this_handle+d0/170>
Trace; c016c85d <journal_start+95/c4>
Trace; c0167688 <ext3_dirty_inode+74/10c>
Trace; c014e2da <__mark_inode_dirty+32/a8>
Trace; d08cab90 <[nfsd]filldir_one+0/4c>
Trace; c014fb6b <update_atime+4b/50>
Trace; c0162e00 <ext3_readdir+380/390>
Trace; d082c63a <[ipchains]ip_fw_check+3ca/4b4>
Trace; c01488b4 <vfs_readdir+94/e0>
Trace; d08cab90 <[nfsd]filldir_one+0/4c>
Trace; d08cac85 <[nfsd]nfsd_get_name+a9/ec>
Trace; d08cab90 <[nfsd]filldir_one+0/4c>
Trace; d08cb0a8 <[nfsd]splice+24/170>
Trace; c013b7d8 <getblk+1c/4c>
Trace; c013b7ff <getblk+43/4c>
Trace; c013ba34 <bread+18/70>
Trace; c0166a94 <ext3_get_inode_loc+118/174>
Trace; c0166b52 <ext3_read_inode+16/278>
Trace; c0166d9e <ext3_read_inode+262/278>
Trace; c014f6f1 <iget4+4d/f0>
Trace; c014f866 <iput+4e/2c8>
Trace; d08cadbb <[nfsd]nfsd_iget+f3/10c>
Trace; d08cae3d <[nfsd]nfsd_get_dentry+69/78>
Trace; d08cb33d <[nfsd]find_fh_dentry+149/354>
Trace; d08cb37a <[nfsd]find_fh_dentry+186/354>
Trace; d08cb807 <[nfsd]fh_verify+2bf/474>
Trace; d08d1df9 <[nfsd]nfsd3_proc_getattr+95/a0>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d08c95b3 <[nfsd]nfsd_dispatch+d3/19a>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d089df27 <[sunrpc]svc_process+28f/4f0>
Trace; d08d8638 <[nfsd]nfsd_version3+0/10>
Trace; d08d8658 <[nfsd]nfsd_program+0/28>
Trace; d08c9390 <[nfsd]nfsd+204/354>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  nfsd

>>EIP; cfa2d6dc <_end+f6dacb0/104b15d4>   <=====

Trace; c0105fe5 <__down+6d/d0>
Trace; c0106194 <__down_failed+8/c>
Trace; d08cc15d <[nfsd].text.lock.nfsfh+8d/f0>
Trace; d08cb807 <[nfsd]fh_verify+2bf/474>
Trace; d08d1df9 <[nfsd]nfsd3_proc_getattr+95/a0>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d08c95b3 <[nfsd]nfsd_dispatch+d3/19a>
Trace; d08d8ca4 <[nfsd]nfsd_procedures3+24/320>
Trace; d089df27 <[sunrpc]svc_process+28f/4f0>
Trace; d08d8638 <[nfsd]nfsd_version3+0/10>
Trace; d08d8658 <[nfsd]nfsd_program+0/28>
Trace; d08c9390 <[nfsd]nfsd+204/354>
Trace; d08d8620 <[nfsd]nfsd_list+0/0>
Trace; c0105a64 <arch_kernel_thread+28/38>
Proc;  rpc.mountd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0115fc7 <schedule_timeout+17/9c>
Trace; c01f6677 <sock_alloc_send_pskb+73/1d0>
Trace; c0240fc2 <unix_wait_for_peer+a6/cc>
Trace; c02419e7 <unix_dgram_sendmsg+327/3f8>
Trace; c01f3ff5 <sock_sendmsg+69/88>
Trace; c01f4ed5 <sys_sendto+d9/f8>
Trace; c0133368 <__free_pages+1c/20>
Trace; c0133796 <free_page_and_swap_cache+32/34>
Trace; c0126ab0 <__free_pte+40/48>
Trace; c012707b <zap_page_range+30b/374>
Trace; c01290b2 <unmap_fixup+62/16c>
Trace; c01f4f12 <sys_send+1e/24>
Trace; c01f56b1 <sys_socketcall+119/200>
Trace; c0107353 <system_call+33/38>
Proc;  omniNames

>>EIP; c9fb3f8c <_end+9c61560/104b15d4>   <=====

Trace; c011dec0 <bh_action+4c/8c>
Trace; c011602a <schedule_timeout+7a/9c>
Trace; c0115f50 <process_timeout+0/60>
Trace; c0121e3a <sys_nanosleep+102/178>
Trace; c0107353 <system_call+33/38>
Proc;  powstatd

>>EIP; ca0c5f8c <_end+9d73560/104b15d4>   <=====

Trace; c01f7551 <__kfree_skb+139/140>
Trace; c011602a <schedule_timeout+7a/9c>
Trace; c0115f50 <process_timeout+0/60>
Trace; c0121e3a <sys_nanosleep+102/178>
Trace; c0107353 <system_call+33/38>
Proc;  rarpd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0115fc7 <schedule_timeout+17/9c>
Trace; c0149a1a <do_poll+86/dc>
Trace; c0149a4f <do_poll+bb/dc>
Trace; c0149c5d <sys_poll+1ed/2f4>
Trace; c0107353 <system_call+33/38>
Proc;  omniNames

>>EIP; c9c47f28 <_end+98f54fc/104b15d4>   <=====

Trace; c011602a <schedule_timeout+7a/9c>
Trace; c0115f50 <process_timeout+0/60>
Trace; c0149a4f <do_poll+bb/dc>
Trace; c0149c5d <sys_poll+1ed/2f4>
Trace; c0107353 <system_call+33/38>
Proc;  omniNames

>>EIP; c9c43fb0 <_end+98f1584/104b15d4>   <=====

Trace; c0106484 <sys_rt_sigsuspend+fc/118>
Trace; c0107353 <system_call+33/38>
Proc;  omniNames

>>EIP; c9c3ff8c <_end+98ed560/104b15d4>   <=====

Trace; c011602a <schedule_timeout+7a/9c>
Trace; c0115f50 <process_timeout+0/60>
Trace; c0121e3a <sys_nanosleep+102/178>
Trace; c0107353 <system_call+33/38>


2 warnings issued.  Results may not be reliable.
