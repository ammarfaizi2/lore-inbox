Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265816AbTGDHL6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 03:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265818AbTGDHL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 03:11:58 -0400
Received: from [66.212.224.118] ([66.212.224.118]:55308 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265816AbTGDHLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 03:11:54 -0400
Date: Fri, 4 Jul 2003 03:15:10 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, Helge Hafting <helgehaf@aitel.hist.no>,
       zboszor@freemail.hu, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.74-mm1
In-Reply-To: <20030704055315.GW26348@holomorphy.com>
Message-ID: <Pine.LNX.4.53.0307040307090.24383@montezuma.mastecende.com>
References: <3F0407D1.8060506@freemail.hu> <3F042AEE.2000202@freemail.hu>
 <20030703122243.51a6d581.akpm@osdl.org> <20030703200858.GA31084@hh.idb.hist.no>
 <20030703141508.796e4b82.akpm@osdl.org> <20030704055315.GW26348@holomorphy.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811798-110258112-1057302910=:24383"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811798-110258112-1057302910=:24383
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 3 Jul 2003, William Lee Irwin III wrote:

> On Thu, Jul 03, 2003 at 02:15:08PM -0700, Andrew Morton wrote:
> > ok.  If you're feeling keen could you please revert the cpumask_t patch.
> > And please send the .config, thanks.
> 
> Zwane reproduced this and when I compiled an identical kernel for him
> it went away; the only difference wsa the compiler version.

This is definitely a compiler issue, i rebuilt with;

zwane@montezuma linux-2.5.74-cpumask {0:0} gcc296 -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux7/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-118)

And that works with NR_CPUS = 3 (it also explains why my 8way test box 
with RH7.3 worked)

Also i ended up writing a userspace test case. I then narrowed it down to 
-O2 with gcc 3.2 (native RH9 compiler) which causes failure;

e.g.

zwane@montezuma linux-2.5.74-cpumask {0:0} gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/3.2.2/specs
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man 
--infodir=/usr/share/info --enable-shared --enable-threads=posix 
--disable-checking --with-system-zlib --enable-__cxa_atexit 
--host=i386-redhat-linux
Thread model: posix
gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)

zwane@montezuma linux-2.5.74-cpumask {0:0} gcc -O2 test.c -o test-gcc3.2
zwane@montezuma linux-2.5.74-cpumask {0:0} ./test-gcc3.2
main: tmp 1
main: phys_cpu_present_map before 0
main: phys_cpu_present_map after 0
main: tmp 8
main: phys_cpu_present_map before 0
main: phys_cpu_present_map after 0
main: tmp 10
main: phys_cpu_present_map before 0
main: phys_cpu_present_map after 0

zwane@montezuma linux-2.5.74-cpumask {0:0} gcc -O1 test.c -o test-gcc3.2
zwane@montezuma linux-2.5.74-cpumask {0:0} ./test-gcc3.2
main: tmp 1
main: phys_cpu_present_map before 0
main: phys_cpu_present_map after 1
main: tmp 8
main: phys_cpu_present_map before 1
main: phys_cpu_present_map after 9
main: tmp 10
main: phys_cpu_present_map before 9
main: phys_cpu_present_map after 19

The second one is correct. So one definite failing piece of code was in 
the cpus_or() path, i'm not so sure about the others. I have attached the 
test case. Bill says his gcc 3.3 works...

Andrew?

-- 
function.linuxpower.ca
---1463811798-110258112-1057302910=:24383
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="test.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0307040315100.24383@montezuma.mastecende.com>
Content-Description: 
Content-Disposition: attachment; filename="test.c"

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8bGludXgvYml0b3BzLmg+
DQoNCiNkZWZpbmUgQklUU19QRVJfTE9ORwkzMg0KI2RlZmluZSBOUl9DUFVT
IDMNCiNkZWZpbmUgcHJpbnRrKHguLi4pCXByaW50Zih4KQ0KDQojZGVmaW5l
IEJJVFNfVE9fTE9OR1MoYml0cykgXA0KCSgoKGJpdHMpK0JJVFNfUEVSX0xP
TkctMSkvQklUU19QRVJfTE9ORykNCiNkZWZpbmUgREVDTEFSRV9CSVRNQVAo
bmFtZSxiaXRzKSBcDQoJdW5zaWduZWQgbG9uZyBuYW1lW0JJVFNfVE9fTE9O
R1MoYml0cyldDQojZGVmaW5lIENMRUFSX0JJVE1BUChuYW1lLGJpdHMpIFwN
CgltZW1zZXQobmFtZSwgMCwgQklUU19UT19MT05HUyhiaXRzKSpzaXplb2Yo
dW5zaWduZWQgbG9uZykpDQoNCnN0YXRpYyBpbmxpbmUgdm9pZCBiaXRtYXBf
b3Iodm9sYXRpbGUgdW5zaWduZWQgbG9uZyAqZHN0LCBjb25zdCB2b2xhdGls
ZSB1bnNpZ25lZCBsb25nICpiaXRtYXAxLA0KCQkJCWNvbnN0IHZvbGF0aWxl
IHVuc2lnbmVkIGxvbmcgKmJpdG1hcDIsIGludCBiaXRzKQ0Kew0KCWludCBr
Ow0KDQoJZm9yIChrID0gMDsgayA8IEJJVFNfVE9fTE9OR1MoYml0cyk7ICsr
aykNCgkJZHN0W2tdID0gYml0bWFwMVtrXSB8IGJpdG1hcDJba107DQp9DQoN
CiNkZWZpbmUgY3B1X3NldChjcHUsIG1hcCkJc2V0X2JpdChjcHUsIChtYXAp
Lm1hc2spDQojZGVmaW5lIGNwdXNfb3IoZHN0LHNyYzEsc3JjMikJYml0bWFw
X29yKChkc3QpLm1hc2ssIChzcmMxKS5tYXNrLCAoc3JjMikubWFzaywgTlJf
Q1BVUykNCiNkZWZpbmUgY3B1c19jb2VyY2UobWFwKQkoKG1hcCkubWFza1sw
XSkNCg0KI2RlZmluZSBDUFVfQVJSQVlfU0laRQkJQklUU19UT19MT05HUyhO
Ul9DUFVTKQ0KDQojZGVmaW5lIENQVV9NQVNLX0FMTAl7IHtbMCAuLi4gQ1BV
X0FSUkFZX1NJWkUtMV0gPSB+MFVMfSB9DQojZGVmaW5lIENQVV9NQVNLX05P
TkUJeyB7WzAgLi4uIENQVV9BUlJBWV9TSVpFLTFdID0gIDBVTH0gfQ0KDQoj
ZGVmaW5lIGNwdW1hc2tfb2ZfY3B1KGNwdSkJKHsgY3B1bWFza190IF9fY3B1
X21hc2sgPSBDUFVfTUFTS19OT05FO1wNCgkJCQkJY3B1X3NldChjcHUsIF9f
Y3B1X21hc2spOwlcDQoJCQkJCV9fY3B1X21hc2s7CQkJXA0KCQkJCX0pDQoN
CnN0cnVjdCBjcHVtYXNrDQp7DQoJdW5zaWduZWQgbG9uZyBtYXNrW0NQVV9B
UlJBWV9TSVpFXTsNCn07DQoNCnR5cGVkZWYgc3RydWN0IGNwdW1hc2sgY3B1
bWFza190Ow0KDQpzdGF0aWMgaW5saW5lIGNwdW1hc2tfdCBhcGljaWRfdG9f
Y3B1X3ByZXNlbnQoaW50IHBoeXNfYXBpY2lkKQ0Kew0KCXJldHVybiBjcHVt
YXNrX29mX2NwdShwaHlzX2FwaWNpZCk7DQp9DQoNCmludCBtYWluKGludCBh
cmdjLCBjaGFyICoqYXJndikNCnsNCglpbnQgYmlvc19hcGljaWRzW10gPSB7
IDAsIDMsIDQsIC0xfSwgaSwgYXBpY2lkOw0KCWNwdW1hc2tfdCBwaHlzX2Nw
dV9wcmVzZW50X21hcCA9IENQVV9NQVNLX05PTkUsIHRtcDsNCg0KCWZvciAo
aSA9IDA7IGJpb3NfYXBpY2lkc1tpXSAhPSAtMTsgaSsrKSB7DQoJCWFwaWNp
ZCA9IGJpb3NfYXBpY2lkc1tpXTsNCgkJdG1wID0gYXBpY2lkX3RvX2NwdV9w
cmVzZW50KGFwaWNpZCk7DQoJCXByaW50aygiJXM6IHRtcCAlbHhcbiIsIF9f
RlVOQ1RJT05fXywgY3B1c19jb2VyY2UodG1wKSk7DQoJCXByaW50aygiJXM6
IHBoeXNfY3B1X3ByZXNlbnRfbWFwIGJlZm9yZSAlbHhcbiIsDQoJCQlfX0ZV
TkNUSU9OX18sIGNwdXNfY29lcmNlKHBoeXNfY3B1X3ByZXNlbnRfbWFwKSk7
DQoJCWNwdXNfb3IocGh5c19jcHVfcHJlc2VudF9tYXAsIHBoeXNfY3B1X3By
ZXNlbnRfbWFwLCB0bXApOw0KCQlwcmludGsoIiVzOiBwaHlzX2NwdV9wcmVz
ZW50X21hcCBhZnRlciAlbHhcbiIsDQoJCQlfX0ZVTkNUSU9OX18sIGNwdXNf
Y29lcmNlKHBoeXNfY3B1X3ByZXNlbnRfbWFwKSk7DQoJfQ0KCXJldHVybiAw
Ow0KfQ0K

---1463811798-110258112-1057302910=:24383--
