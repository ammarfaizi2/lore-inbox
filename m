Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265944AbUG0QKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265944AbUG0QKM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 12:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266203AbUG0QKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 12:10:11 -0400
Received: from nacho.alt.net ([207.14.113.18]:48343 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S265944AbUG0QJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 12:09:04 -0400
Date: Tue, 27 Jul 2004 09:08:57 -0700 (PDT)
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Arjan van de Ven <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
In-Reply-To: <20040727141935.GB17456@logos.cnet>
Message-ID: <Pine.LNX.4.44.0407270837180.24755-200000@nacho.alt.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="248451697-915697917-1090944041=:24755"
Content-ID: <Pine.LNX.4.44.0407270900430.24755@nacho.alt.net>
X-Delivery-Agent: TMDA/1.0.2 (Bold Forbes)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--248451697-915697917-1090944041=:24755
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0407270900431.24755@nacho.alt.net>

On Tue, 27 Jul 2004, Marcelo Tosatti wrote:
> On Mon, Jul 26, 2004 at 10:41:24AM -0700, Chris Caputo wrote:
> > On Sat, 3 Jul 2004, Arjan van de Ven wrote:
> > > On Fri, Jul 02, 2004 at 01:00:19PM -0700, Chris Caputo wrote:
> > > > On Fri, 25 Jun 2004, Marcelo Tosatti wrote:
> > > > > On Wed, Jun 23, 2004 at 06:50:48PM -0700, Chris Caputo wrote:
> > > > > > Is it safe to assume that the x86 version of atomic_dec_and_lock(), which
> > > > > > iput() uses, is well trusted?  I figure it's got to be, but doesn't hurt
> > > > > > to ask.
> > > > > 
> > > > > Pretty sure it is, used all over. You can try to use non-optimize version 
> > > > > at lib/dec_and_lock.c for a test.
> > > > 
> > > > My current theory is that occasionally when irqbalance changes CPU
> > > > affinities that the resulting set_ioapic_affinity() calls somehow cause
> > > > either inter-CPU locking or cache coherency or ??? to fail.
> > > 
> > > or.... some spinlock is just incorrect and having the irqbalance irqlayout
> > > unhides that.. irqbalance only balances very very rarely so I doubt it's the
> > > cause of anything...
> 
> Hi Chris,
> 
> > It has been a while since I have been able to follow up on this but I want
> > to let you know that I _have been able_ to reproduce the problem (believed
> > to be IRQ twiddling resulting in failed spinlock protection) with a stock
> > kernel.
> 
> Well, no manipulation of the inode lists are done under IRQ context. 
> 
> What you think might be happening is that an IRQ comes in __refile_inode() 
> (and other paths) and that causes a problem? 
> 
> Thats perfectly fine. Again, no manipulation of the lists are done in 
> IRQ context.

I may have phrased the question poorly.  I am trying to get at whether the
x86 "lock ; dec $x" operation can somehow be affected by changes to IRQ
affinity, since that is what appears to happen.  I assume SMP inter-cpu
locking doesn't generate IRQs at the linux kernel level (right?), but
there seems to be something at a low level which gets affected by changes
to which CPU handles which IRQs.

> > I would like to come up with a more reliable way to reproduce the problem
> > with a stock kernel (2.4.26), since it is presently very rare (less than
> > once per week) in the way I presently get it to happen, but as yet have
> > not done so. 
> 
> What is your workload? I'm more than willing to use the SMP boxes I have 
> access to try to reproduce this. 

Here is the basic repro so far:

-1) SMP x86 machine (PIII or PIV), 4 gigs of RAM, kernel 2.4.26.  Here are 
    some possibly relevant configs:

CONFIG_X86=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_HIGHIO=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_X86_TSC=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y

0) Start irqbalance.
1) Have 10+ gigs of space available for testing preferably on two separate
   filesystems, mounted on say /test_0 and /test_1.
2) As root do a "find /" to fill up the dcache/inode caches with a bunch 
   of data.
3) Compile the attached writer2.c: "gcc -O2 -o writer2 writer2.c"
4) Run "writer2 /test_0 0" and "writer2 /test_1 0" in the background.
5) Run "emerge sync" a few times per day.
6) Wait for crash.

Step 5 is unique to Gentoo, so it would be nice to have another test
program which does the equivalent in terms of opening/created/deleting a
bunch of times.  Intent to be inspiring that a bunch of items are added to
and removed from the inode_unused list regularly.

> You said you also reproduced the same inode_unused corruption with
> 2.4.24, yes?

I have reproduced the same symptoms (inode_unused list corruption) on
2.4.24 with a modified kernel (tux patches plus my filesystem) but I have
not tried to do so with a stock 2.4.24.  So far only stock kernel I have
tried has been 2.4.26.

> > My plan of attack is to remove irqbalance from the equation and repeatedly
> > change with random intervals /proc/irq entries directly from one user mode
> > program while another user mode program does things which inspire a lot of
> > fs/inode.c spinlock activity (since that is where I continue to see list
> > corruption).
> > 
> > A few questions which could help me with this:
> > 
> >   - Which IRQ (if any) is used by CPU's to coordinate inter-CPU locking?
> 
> None as far as spinlocks are concerned. On x86 spinlock just does "lock
> ; dec $x"  operation which guarantees the atomicity of the "dec".
> 
> I feel I'm not answering your question, still. What do you mean?

What I seem to be seeing is that changes in IRQ affinity are at some level
screwing up the guaranteed atomicity of the "lock ; dec $x".  I realize
that might be crazy to think, but maybe it is something known about the
x86 spec.  The two CPU's I have seen this with, by the way, are a PIV-Xeon
(CPUID F29) and a PIII (CPUID 06B1), so I don't imagine a microcode-type
bug unique to a certain CPU release.

> >   - What does it mean if a stack trace is incomplete?  For example, one I 
> >     have gotten is simply the tail end of the code snippet:
> > 
> >          0b 9a 00 5d c8
> > 
> >     And so I have wondered if the failure to make a full stack trace 
> >     indicates something in of itself.
> 
> Dont know the answer. I also usually see incomplete stack traces
> that I can make no sense of. 
> 
> > Thanks for any assistance.  I hope to find more time to work on this in
> > the coming weeks.
> 
> I'm willing to help. Just please do not mix report data which includes
> your own filesystem/modified kernel. Lets work with stock kernels and 
> only that, to make it as simple as possible.

Agreed.

Chris








--248451697-915697917-1090944041=:24755
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="writer2.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0407270900410.24755@nacho.alt.net>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="writer2.c"

I2RlZmluZSBfTEFSR0VGSUxFNjRfU09VUkNFDQojZGVmaW5lIF9GSUxFX09G
RlNFVF9CSVRTIDY0DQoNCiNpbmNsdWRlIDxzdGRpby5oPg0KI2luY2x1ZGUg
PHN0ZGxpYi5oPg0KI2luY2x1ZGUgPHN0cmluZy5oPg0KI2luY2x1ZGUgPHVu
aXN0ZC5oPg0KI2luY2x1ZGUgPGZjbnRsLmg+DQojaW5jbHVkZSA8ZXJybm8u
aD4NCiNpbmNsdWRlIDxzeXMvdGltZS5oPg0KI2luY2x1ZGUgPHN5cy9zdGF0
Lmg+DQojaW5jbHVkZSA8c3lzL3R5cGVzLmg+DQojaW5jbHVkZSA8c3lzL3N0
YXR2ZnMuaD4NCiNpbmNsdWRlIDxzeXMvcmVzb3VyY2UuaD4NCiNpbmNsdWRl
IDxzaWduYWwuaD4NCg0KI2RlZmluZSBOVU1fRElGRl9TVEFSVF9MT0NTIDEw
MDAwDQojZGVmaW5lIE1BWF9XUklURV9MRU4gKDEwICogMTA0ODU3NikgIC8v
IDEwIG1lZ3MNCg0KI2RlZmluZSBOVU1fRklMRVMgMQ0KI2RlZmluZSBGSUxF
X1NJWkUgKDEwICogMTAyNCAqIDEwNDg1NzZMTCkgIC8vIDEwIGdpZ3MNCg0K
dHlwZWRlZiBzaWduZWQgbG9uZyBsb25nIHM2NDsNCg0KaW50IGdfZlNpZ1Rl
cm1SZWNlaXZlZCA9IDA7DQoNCg0Kc3RhdGljIHZvaWQgc2lnX3Rlcm0oaW50
IHNpZ25vKQ0Kew0KICBnX2ZTaWdUZXJtUmVjZWl2ZWQgPSAxOw0KfQ0KDQoN
CmludCB3cml0ZV93cmFwcGVyKGludCBmZCwNCgkJICB2b2lkICpidWYsDQoJ
CSAgaW50IGxlbikNCnsNCiAgaW50IHRvdGFsID0gMDsNCiAgaW50IHN1YnRv
dGFsID0gMDsNCiAgY2hhciAqdGFyZ2V0QnVmID0gYnVmOw0KDQogIHdoaWxl
ICh0b3RhbCA8IGxlbikNCiAgICB7DQogICAgICBzdWJ0b3RhbCA9IHdyaXRl
KGZkLCB0YXJnZXRCdWYsIGxlbiAtIHRvdGFsKTsNCg0KICAgICAgaWYgKDAg
PiBzdWJ0b3RhbCkNCgl7DQoJICByZXR1cm4gLTE7DQoJfQ0KICAgICAgZWxz
ZQ0KCXsNCgkgIHRvdGFsICs9IHN1YnRvdGFsOw0KCSAgdGFyZ2V0QnVmICs9
IHN1YnRvdGFsOw0KCX0NCiAgICB9DQoNCiAgcmV0dXJuIHRvdGFsOw0KfQ0K
CQkgDQoNCmludCBtYWluKGludCBhcmdjLA0KCSBjaGFyICphcmd2W10pDQp7
DQogIHVuc2lnbmVkIGludCB1SXRlcmF0aW9uQ291bnQsIHVDdXJJdGVyYXRp
b247DQogIHVuc2lnbmVkIGludCB1TGVuZ3RoOw0KICBjaGFyICpzcmNCdWZm
ZXI7DQogIHN0cnVjdCB0aW1ldmFsIHR2U3RhcnQsIHR2RW5kOw0KICBzNjQg
czY0X3VzZWM7DQogIGNoYXIgc3pEaXJlY3RvcnlbMjU2XTsNCiAgY2hhciBz
ekZpbGVuYW1lWzI1Nl07DQogIGludCBmZHNbTlVNX0ZJTEVTXSwgZmQ7DQog
IHVuc2lnbmVkIGludCBpOw0KICBvZmZfdCBsc2Vla1JlczsNCg0KICAvLw0K
ICAvLyBVc2FnZS4NCiAgLy8NCg0KICBpZiAoMiAhPSBhcmdjICYmDQogICAg
ICAzICE9IGFyZ2MpDQogICAgew0KICAgICAgZnByaW50ZihzdGRlcnIsDQoJ
ICAgICAgIlVzYWdlOiAlcyA8dGVzdCBkaXI+IFsjIG9mIGl0ZXJhdGlvbnNd
XG4iLA0KCSAgICAgIGFyZ3ZbMF0pOw0KICAgICAgZnByaW50ZihzdGRlcnIs
DQoJICAgICAgIiAtaWYgaXRlcmF0aW9uIGNvdW50IGlzIG5vdCBzcGVjaWZp
ZWQsIGRlZmF1bHRzIHRvIDEuICBJZiAwXG4iKTsNCiAgICAgIGZwcmludGYo
c3RkZXJyLA0KCSAgICAgICIgICAgIGl0IG1lYW5zIHJ1biBmb3IgYSBsb25n
IGxvbmcgdGltZSAoMl4zMiAtIDEpLlxuIik7DQogICAgICBleGl0KDEpOw0K
ICAgIH0NCg0KICAvLw0KICAvLyBDb25zdW1lIHBhcmFtZXRlcnMuDQogIC8v
DQogIGFyZ2MtLTsgIC8vIGVhdCBwcm9ncmFtIG5hbWUNCiAgc3RybmNweShz
ekRpcmVjdG9yeSwgYXJndlsxXSwgc2l6ZW9mKHN6RGlyZWN0b3J5KSk7DQog
IGFyZ2MtLTsgIC8vIGVhdCB0ZXN0IGRpcmVjdG9yeQ0KICBpZiAoMCA8IGFy
Z2MpDQogICAgew0KICAgICAgdUl0ZXJhdGlvbkNvdW50ID0gc3RydG91bChh
cmd2WzJdLCBOVUxMLCAxMCk7DQogICAgfQ0KICBlbHNlDQogICAgew0KICAg
ICAgdUl0ZXJhdGlvbkNvdW50ID0gMTsNCiAgICB9DQoNCiAgLy8gbWFrZSBp
dCBzbyBhIHN1cHBsaWVkIGl0ZXJhdGlvbiBjb3VudCBvZiAwIHJ1bnMgZm9y
IGEgbG9uZyBsb25nIHRpbWUuDQogIGlmICgwID09IHVJdGVyYXRpb25Db3Vu
dCkNCiAgICB7DQogICAgICB1SXRlcmF0aW9uQ291bnQtLTsNCiAgICB9DQoN
CiAgLy8gc2VlZCByYW5kb20oKQ0KICBzcmFuZG9tKGdldHBpZCgpKTsNCg0K
ICAvLyBhbGxvY2F0ZSBzcGFjZSBmb3IgdGhlIHNyY0J1ZmZlcg0KICAvLyBh
ZGQgbG9uZyBpbnQgZXh0cmEgc28gd2UgY2FuIGRvIGEgcmFwaWQgcmFuZG9t
IGZpbGwgYmVsb3cNCiAgc3JjQnVmZmVyID0gbWFsbG9jKE1BWF9XUklURV9M
RU4gKw0KCQkgICAgIE5VTV9ESUZGX1NUQVJUX0xPQ1MgKw0KCQkgICAgIHNp
emVvZihsb25nIGludCkpOw0KICBpZiAoTlVMTCA9PSBzcmNCdWZmZXIpDQog
ICAgew0KICAgICAgZnByaW50ZihzdGRlcnIsDQoJICAgICAgIiVzOiB3YXMg
dW5hYmxlIHRvIG1hbGxvYyAldSBieXRlcy4gIEV4aXRpbmcuXG4iLA0KCSAg
ICAgIGFyZ3ZbMF0sDQoJICAgICAgTUFYX1dSSVRFX0xFTiArDQoJICAgICAg
TlVNX0RJRkZfU1RBUlRfTE9DUyArDQoJICAgICAgc2l6ZW9mKGxvbmcgaW50
KSk7DQogICAgICBleGl0KDEpOw0KICAgIH0NCg0KICAvLyBmaWxsIHNyY0J1
ZmZlciB3aXRoIHJhbmRvbSBkYXRhDQogIHsNCiAgICBsb25nIGludCAqcGxp
Ow0KICAgIGxvbmcgaW50ICplbmQ7DQogICAgaW50IGxlbiA9IChNQVhfV1JJ
VEVfTEVOICsNCgkgICAgICAgTlVNX0RJRkZfU1RBUlRfTE9DUyArDQoJICAg
ICAgIHNpemVvZihsb25nIGludCkpIC8gc2l6ZW9mKGxvbmcgaW50KTsNCg0K
ICAgIGVuZCA9IChsb25nIGludCAqKXNyY0J1ZmZlciArIGxlbjsNCiAgICAN
CiAgICBmb3IgKHBsaSA9IChsb25nIGludCAqKXNyY0J1ZmZlcjsgcGxpIDwg
ZW5kOyBwbGkrKykNCiAgICAgIHsNCgkqcGxpID0gcmFuZG9tKCk7DQogICAg
ICB9DQogIH0NCg0KICAvLyBjcmVhdGUgdGhlIGZpbGVzDQogIGZvciAoaSA9
IDA7IGkgPCBOVU1fRklMRVM7IGkrKykNCiAgICB7DQogICAgICBpZiAoMCA+
IHNucHJpbnRmKHN6RmlsZW5hbWUsDQoJCSAgICAgICBzaXplb2Yoc3pGaWxl
bmFtZSksDQoJCSAgICAgICAiJXMvJXUiLA0KCQkgICAgICAgc3pEaXJlY3Rv
cnksDQoJCSAgICAgICBpKSkNCgl7DQoJICBmcHJpbnRmKHN0ZGVyciwgInNu
cHJpbnRmKHN6RmlsZW5hbWUpIGZhaWxlZFxuIik7DQoJICBleGl0KDEpOw0K
CX0NCiAgICAgIGZkc1tpXSA9IG9wZW4oc3pGaWxlbmFtZSwgT19DUkVBVCB8
IE9fV1JPTkxZIHwgT19MQVJHRUZJTEUsIDA2NjYpOw0KICAgICAgaWYgKC0x
ID09IGZkc1tpXSkNCgl7DQoJICBwZXJyb3IoIm9wZW4iKTsNCgkgIGdvdG8g
ZXhpdDsNCgl9DQogICAgICBpZiAoLTEgPT0gbHNlZWsoZmRzW2ldLCBGSUxF
X1NJWkUgLSAxLCBTRUVLX1NFVCkpDQoJew0KCSAgcGVycm9yKCJsc2VlayIp
Ow0KCSAgZ290byBleGl0Ow0KCX0NCiAgICAgIGlmICgtMSA9PSB3cml0ZShm
ZHNbaV0sICJ4IiwgMSkpDQoJew0KCSAgcGVycm9yKCJ3cml0ZSIpOw0KCSAg
Z290byBleGl0Ow0KCX0NCiAgICAgIGlmICgtMSA9PSBsc2VlayhmZHNbaV0s
IDAsIFNFRUtfU0VUKSkgIC8vIHNldCBiYWNrIHRvIHN0YXJ0DQoJew0KCSAg
cGVycm9yKCJsc2VlayIpOw0KCSAgZ290byBleGl0Ow0KCX0NCiAgICB9DQog
IA0KICBzaWduYWwoU0lHSU5ULCBzaWdfdGVybSk7DQoNCiAgLy8NCiAgLy8g
TWFpbiBsb29wLg0KICAvLw0KICBmb3IgKHVDdXJJdGVyYXRpb24gPSAxOw0K
ICAgICAgIHVDdXJJdGVyYXRpb24gPD0gdUl0ZXJhdGlvbkNvdW50ICYmIDAg
PT0gZ19mU2lnVGVybVJlY2VpdmVkOw0KICAgICAgIHVDdXJJdGVyYXRpb24r
KykNCiAgICB7DQogICAgICBwcmludGYoIiV1Olc6IiwNCgkgICAgIHVDdXJJ
dGVyYXRpb24pOw0KDQogICAgICB1TGVuZ3RoID0gcmFuZG9tKCkgJSBNQVhf
V1JJVEVfTEVOOw0KICAgICAgcHJpbnRmKCJsZW4gPSAldSIsDQoJICAgICB1
TGVuZ3RoKTsNCiAgICAgIA0KICAgICAgZmQgPSBmZHNbcmFuZG9tKCkgJSBO
VU1fRklMRVNdOw0KDQogICAgICBsc2Vla1JlcyA9IGxzZWVrKGZkLA0KCQkg
ICAgICAgMCwNCgkJICAgICAgIFNFRUtfQ1VSKTsNCg0KICAgICAgaWYgKC0x
ID09IGxzZWVrUmVzKQ0KCXsNCgkgIHBlcnJvcigibHNlZWsiKTsNCgkgIGdv
dG8gZXhpdDsNCgl9DQogICAgICANCiAgICAgIGlmIChsc2Vla1JlcyArIHVM
ZW5ndGggPj0gRklMRV9TSVpFKQ0KCXsNCgkgIGlmICgtMSA9PSBsc2Vlayhm
ZCwgMCwgU0VFS19TRVQpKSAgLy8gc2V0IGJhY2sgdG8gc3RhcnQNCgkgICAg
ew0KCSAgICAgIHBlcnJvcigibHNlZWsiKTsNCgkgICAgICBnb3RvIGV4aXQ7
DQoJICAgIH0NCgl9DQoNCiAgICAgIGdldHRpbWVvZmRheSgmdHZTdGFydCwg
TlVMTCk7DQoNCiAgICAgIC8vIERvIG5ldHdvcmtpbmcuDQogICAgICBpZiAo
LTEgPT0gd3JpdGVfd3JhcHBlcihmZCwNCgkJCSAgICAgIHNyY0J1ZmZlciAr
IHJhbmRvbSgpICUgTlVNX0RJRkZfU1RBUlRfTE9DUywNCgkJCSAgICAgIHVM
ZW5ndGgpKQ0KCXsNCgkgIHBlcnJvcigid3JpdGVfd3JhcHBlciIpOw0KCSAg
Z290byBleGl0Ow0KCX0NCg0KICAgICAgZ2V0dGltZW9mZGF5KCZ0dkVuZCwg
TlVMTCk7DQoNCiAgICAgIHM2NF91c2VjICA9IChzNjQpdHZFbmQudHZfc2Vj
ICAgKiAxMDAwMDAwICsgdHZFbmQudHZfdXNlYzsNCiAgICAgIHM2NF91c2Vj
IC09IChzNjQpdHZTdGFydC50dl9zZWMgKiAxMDAwMDAwICsgdHZTdGFydC50
dl91c2VjOw0KICAgICAgcHJpbnRmKCIgJUxkIHVzZWNzICUuMmYgbWJpdHMv
c2VjIiwNCgkgICAgIHM2NF91c2VjLA0KCSAgICAgNy42MjkzOTQ1MzEyNSAq
IChmbG9hdCl1TGVuZ3RoIC8NCgkgICAgIChmbG9hdClzNjRfdXNlYyk7DQoN
CiAgICAgIHByaW50ZigiXG4iKTsNCiAgICAgIGZmbHVzaChzdGRvdXQpOw0K
ICAgICAgdXNsZWVwKHJhbmRvbSgpICUgMTAwMDAwKTsNCiAgICB9DQoNCiBl
eGl0Og0KICBmcmVlKHNyY0J1ZmZlcik7DQogIA0KICBpZiAoMSA9PSBnX2ZT
aWdUZXJtUmVjZWl2ZWQpDQogICAgew0KICAgICAgcHJpbnRmKCJTSUdJTlQg
cmVjZWl2ZWQhXG4iKTsNCiAgICB9DQoNCiNpZiAwDQogIHByaW50ZigiY2xl
YW5pbmcgdXAgJXUgZmlsZXMuLi5cbiIsIE5VTV9GSUxFUyk7DQogIGZmbHVz
aChzdGRvdXQpOw0KDQogIC8vIGNsb3NlL3VubGluayB0aGUgZmlsZXMNCiAg
Zm9yIChpID0gMDsgaSA8IE5VTV9GSUxFUzsgaSsrKQ0KICAgIHsNCiAgICAg
IHByaW50ZigiJXUgIiwgaSk7DQogICAgICBmZmx1c2goc3Rkb3V0KTsNCiAg
ICAgIGlmICgwID4gc25wcmludGYoc3pGaWxlbmFtZSwNCgkJICAgICAgIHNp
emVvZihzekZpbGVuYW1lKSwNCgkJICAgICAgICIlcy8ldSIsDQoJCSAgICAg
ICBzekRpcmVjdG9yeSwNCgkJICAgICAgIGkpKQ0KCXsNCgkgIGZwcmludGYo
c3RkZXJyLCAic25wcmludGYoc3pGaWxlbmFtZSkgZmFpbGVkXG4iKTsNCgkg
IGV4aXQoMSk7DQoJfQ0KICAgICAgY2xvc2UoZmRzW2ldKTsNCiAgICAgIHVu
bGluayhzekZpbGVuYW1lKTsNCiAgICB9DQoNCiAgcHJpbnRmKCJcbiIpOw0K
I2VuZGlmDQoNCiAgZXhpdCgwKTsNCn0NCg==
--248451697-915697917-1090944041=:24755--
