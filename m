Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbUANSND (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 13:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbUANSND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 13:13:03 -0500
Received: from intra.cyclades.com ([64.186.161.6]:61371 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262128AbUANSMl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 13:12:41 -0500
Date: Wed, 14 Jan 2004 15:56:13 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Simon Kirby <sim@netnation.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: 2.4.24 SMP lockups
In-Reply-To: <20040114170753.GB8467@netnation.com>
Message-ID: <Pine.LNX.4.58L.0401141552410.14071@logos.cnet>
References: <20040109210450.GA31404@netnation.com> <Pine.LNX.4.58L.0401101719400.1310@logos.cnet>
 <20040114170753.GB8467@netnation.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-220363116-1074102869=:14071"
Content-ID: <Pine.LNX.4.58L.0401141554460.14071@logos.cnet>
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-220363116-1074102869=:14071
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.58L.0401141554461.14071@logos.cnet>



On Wed, 14 Jan 2004, Simon Kirby wrote:

> On Sat, Jan 10, 2004 at 05:32:55PM -0200, Marcelo Tosatti wrote:
>
> > This sounds like a deadlock. I wonder why the NMI watchdog is not
> > triggering.
>
> Well, with the NMI watchdog working (nmi_watchdog=2), we just had another
> occurrence.  This time, I had the serial console ready. :)
>
> I'm guessing this is the same as the previous cases; however, this time
> sysrq-P was able to print information from both CPUs.  I assume the NMI
> watchdog unlocked interrupts from what would have been the stuck CPU?
>
> NMI Watchdog detected LOCKUP on CPU0, eip c011c7cb, registers:
> CPU:    0
> EIP:    0010:[<c011c7cb>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00000086
> eax: ddadf5d0   ebx: d8a2e000   ecx: 00000000   edx: d8a2fe50
> esi: d8a2fe50   edi: 00000286   ebp: 00020690   esp: d8a2fe30
> ds: 0018   es: 0018   ss: 0018
> Process php4 (pid: 19197, stackpage=d8a2f000)
> Stack: d8a2e000 d8a2fe50 ddadf5d0 c015a8e4 00000000 d8a2e000 00000000 00000000
>        00000000 d8a2e000 ddadf5d4 ddadf5d4 ddadf520 ddadf520 c1ce4178 c015b40b
>        ddadf520 0000c82f 00000018 0000ffff c1ce4178 00020690 f7b73c00 c015b881
> Call Trace:    [<c015a8e4>] [<c015b40b>] [<c015b881>] [<c0176e68>] [<c014e792>]
>   [<c014ec7c>] [<c014f259>] [<c014f81e>] [<c01418ce>] [<c0141cf3>] [<c010926f>]
> Code: f3 90 7e f9 e9 8d e9 ff ff 80 3d c0 a3 31 c0 00 f3 90 7e f5
>
> >>EIP; c011c7ca <.text.lock.fork+1a/120>   <=====
> Trace; c015a8e4 <__wait_on_freeing_inode+74/a0>
> Trace; c015b40a <find_inode+6a/80>
> Trace; c015b880 <iget4+60/110>
> Trace; c0176e68 <ext3_lookup+78/a0>
> Trace; c014e792 <real_lookup+f2/140>
> Trace; c014ec7c <link_path_walk+31c/6f0>
> Trace; c014f258 <path_lookup+38/40>
> Trace; c014f81e <open_namei+6e/690>
> Trace; c01418ce <filp_open+3e/70>
> Trace; c0141cf2 <sys_open+52/c0>
> Trace; c010926e <system_call+32/38>

Thanks so much for this Simon.

I'm not still sure why it is deadlocking. David Woodhouse and myself are
taking a closer look.

Anyway, please revert the attached patch and retry. It removes the
"__wait_on_freeing_inode" logic.

--8323328-220363116-1074102869=:14071
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=livio
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58L.0401141554290.14071@logos.cnet>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=livio

IyBUaGlzIGlzIGEgQml0S2VlcGVyIGdlbmVyYXRlZCBwYXRjaCBmb3IgdGhl
IGZvbGxvd2luZyBwcm9qZWN0Og0KIyBQcm9qZWN0IE5hbWU6IExpbnV4IGtl
cm5lbCB0cmVlDQojIFRoaXMgcGF0Y2ggZm9ybWF0IGlzIGludGVuZGVkIGZv
ciBHTlUgcGF0Y2ggY29tbWFuZCB2ZXJzaW9uIDIuNSBvciBoaWdoZXIuDQoj
IFRoaXMgcGF0Y2ggaW5jbHVkZXMgdGhlIGZvbGxvd2luZyBkZWx0YXM6DQoj
CSAgICAgICAgICAgQ2hhbmdlU2V0CTEuMTEzNi42Ni4yIC0+IDEuMTEzNi42
Ny4xDQojCSAgICAgICAgICBmcy9pbm9kZS5jCTEuNDEgICAgLT4gMS40MiAg
IA0KIw0KIyBUaGUgZm9sbG93aW5nIGlzIHRoZSBCaXRLZWVwZXIgQ2hhbmdl
U2V0IExvZw0KIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KIyAwMy8xMS8xNQljYXR0ZWxhbkBsaXBzLnRoZWJhcm4u
Y29tCTEuMTE5OQ0KIyBNZXJnZSBsaXBzLnRoZWJhcm4uY29tOi9leHBvcnQv
aG9zZS9ia3Jvb3QvbGludXgtMi40DQojIGludG8gbGlwcy50aGViYXJuLmNv
bTovZXhwb3J0L2hvc2UvYmtyb290L2xpbnV4LTIuNCtqdXN0WEZTDQojIC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoj
IDAzLzExLzE2CXBtZWRhQGFrYW1haS5jb20JMS4xMTM2LjY2LjMNCiMgW25l
dGRydnIgdHVsaXBdIGZpeCBoYXNoZWQgc2V0dXAgZnJhbWUgY29kZQ0KIyAN
CiMgSXQgaXMgdXNpbmcgbG9jYWwgdmFyaWFibGUgYGknIGluIGJvdGggdGhl
IGlubmVyIGFuZCBvdXRlciBsb29wLg0KIyANCiMgTmVlZCB0byBicmluZyB0
aGUgZm9yIGxvb3Agb3V0c2lkZSB0aGUgbG9vcC4gIE90aGVyd2lzZSB3ZSBu
ZWVkIHRvIHJlc2V0IHRoZQ0KIyBzZXR1cF9mcmFtZSB0byB0cC0+c2V0dXBf
ZnJhbWUgYWZ0ZXIgZXZlcnkgbG9vcC4gIFlvdSBkbyBub3QgbmVlZCB0byBz
ZXQgdGhlDQojIHNldHVwX2ZybSBmb3IgZXZlcnkgbWMgYWRkcmVzcywgd2Ug
Y2FuIHNldCBvbmNlIGFmdGVyIHRoZSBjb21wbGV0ZSBoYXNfdGFibGUNCiMg
aXMgcmVhZHkuDQojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQojIDAzLzExLzE3CWxpdmlvQGltZS51c3AuYnIJMS4x
MTM2LjY3LjENCiMgW1BBVENIXSBCYWNrcG9ydCBpbm9kZV9oYXNoIHJhY2Ug
Zml4DQojIA0KIyAgIEhlbGxvLA0KIyANCiMgICBBZnRlciAgdHJ5aW5nIHRv
ICAiZ2V0IGFyb3VuZCIgIHRoZSAgaW5vZGVfaGFzaCByYWNlcyAgd2hlbiBy
ZW1vdmluZyAgYW5kDQojIGlnZXQoKWluZyB0aGUgIHNhbWUgaW5vZGUsIG15
IGNvZGUgIGdvdCByZWFsbHkgdWdseSwgIGFuZCBJIGdvdCBmZWQgIHVwLiBT
bw0KIyB5ZXN0ZXJkYXkgSSBnb3QgTmVpbCdzIDIuNSBwYXRjaCBhbmQgYmFj
a3BvcnR0ZWQgaXQgdG8gMi40LjIyLXJjMi4NCiMgDQojICAgVGhlIHBhdGNo
ICBpcyB2ZXJ5IHNpbWlsYXIgdG8gIE5laWwncywgZXhjZXB0IGZvciBvbmUg
ICh2ZXJ5IGltcG9ydGFudCB0bw0KIyBtZSkgICBjYXNlLiAgTmVpbCdzICAg
cGF0Y2ggIG9ubHkgICBjb3ZlcmVkICB0aGUgICByZW1vdmFsICBvZiAgIGlu
b2RlcyAgaW4NCiMgZ2VuZXJpY19kZWxldGVfaW5vZGUoKSAod2hpY2ggaW4g
IDIuNCBpcyB0aGUgY2FzZSB3aGVyZSAgaV9ubGluayBpcyB6ZXJvIGluDQoj
IGlwdXQoKSkuICBCdXQsIGFzIEkgZGVzY3JpYmVkIGluIGEgcHJldmlvdXMg
cG9zdDoNCiMgaHR0cDovL21hcmMudGhlYWltc2dyb3VwLmNvbS8/bD1saW51
eC1mc2RldmVsJm09MTA1NTQ3NTk1NTE5NzQ1Jnc9Mg0KIyANCiMgICAsIEkg
ZnJlcXVlbnRseSBnZXQgYnVzdGVkIGluIHBydW5lX2ljYWNoZSgpLiBJbiBO
ZWlsJ3MgcGF0Y2ggcHJ1bmVfaWNhY2hlDQojIGlzIG5vdCAgY292ZXJlZC4g
SW4gbXkgIG9waW5pb24sIHRoaXMgY2FzZSAgKGluIHBydW5lX2ljYWNoZSgp
KSwgaGFzICB0byBiZQ0KIyBmaXhlZCBpbiAyLjYgIHRvby4gRGVwZW5kaW5n
IG9uIHlvdXIgIGNvbW1lbnRzLCBJIG1heSBtYWtlIGEgIHBhdGNoIGZvciAy
LjYNCiMgbGF0ZXIuDQojIA0KIyAgIFBsZWFzZSAgY29tbWVudCBpZiAgeW91
IGNhbiwgIHNvIHRoYXQgIEkgbWF5ICBzZW5kIHRoaXMgIHRvICBNYXJjZWxv
IHRoZW4NCiMgMi40LjIzLXByZSBvcGVucyAod2hpY2ggc2hvdWxkIGJlIHNv
b24sIEkgdGhpbmspLg0KIyANCiMgICBiZXN0IHJlZ2FyZHMsDQojIA0KIyAt
LQ0KIyAgIExpdmlvIEIuIFNvYXJlcw0KIyAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIw0KZGlmZiAtTnJ1IGEvZnMv
aW5vZGUuYyBiL2ZzL2lub2RlLmMNCi0tLSBhL2ZzL2lub2RlLmMJV2VkIEph
biAxNCAxNTo1MjoyMyAyMDA0DQorKysgYi9mcy9pbm9kZS5jCVdlZCBKYW4g
MTQgMTU6NTI6MjMgMjAwNA0KQEAgLTIwNiw3ICsyMDYsOCBAQA0KIAlpZiAo
KGlub2RlLT5pX3N0YXRlICYgZmxhZ3MpICE9IGZsYWdzKSB7DQogCQlpbm9k
ZS0+aV9zdGF0ZSB8PSBmbGFnczsNCiAJCS8qIE9ubHkgYWRkIHZhbGlkIChp
ZSBoYXNoZWQpIGlub2RlcyB0byB0aGUgZGlydHkgbGlzdCAqLw0KLQkJaWYg
KCEoaW5vZGUtPmlfc3RhdGUgJiBJX0xPQ0spICYmICFsaXN0X2VtcHR5KCZp
bm9kZS0+aV9oYXNoKSkgew0KKwkJaWYgKCEoaW5vZGUtPmlfc3RhdGUgJiAo
SV9MT0NLfElfRlJFRUlOR3xJX0NMRUFSKSkgJiYNCisJCSAgICAhbGlzdF9l
bXB0eSgmaW5vZGUtPmlfaGFzaCkpIHsNCiAJCQlsaXN0X2RlbCgmaW5vZGUt
PmlfbGlzdCk7DQogCQkJbGlzdF9hZGQoJmlub2RlLT5pX2xpc3QsICZzYi0+
c19kaXJ0eSk7DQogCQl9DQpAQCAtMjM1LDYgKzIzNiwzMCBAQA0KIAkJX193
YWl0X29uX2lub2RlKGlub2RlKTsNCiB9DQogDQorLyoNCisgKiBJZiB3ZSB0
cnkgdG8gZmluZCBhbiBpbm9kZSBpbiB0aGUgaW5vZGUgaGFzaCB3aGlsZSBp
dCBpcyBiZWluZyBkZWxldGVkLCB3ZQ0KKyAqIGhhdmUgdG8gd2FpdCB1bnRp
bCB0aGUgZmlsZXN5c3RlbSBjb21wbGV0ZXMgaXRzIGRlbGV0aW9uIGJlZm9y
ZSByZXBvcnRpbmcNCisgKiB0aGF0IGl0IGlzbid0IGZvdW5kLiAgVGhpcyBp
cyBiZWNhdXNlIGlnZXQgd2lsbCBpbW1lZGlhdGVseSBjYWxsDQorICogLT5y
ZWFkX2lub2RlLCBhbmQgd2Ugd2FudCB0byBiZSBzdXJlIHRoYXQgZXZpZGVu
Y2Ugb2YgdGhlIGRlbGV0aW9uIGlzIGZvdW5kDQorICogYnkgLT5yZWFkX2lu
b2RlLg0KKyAqDQorICogVGhpcyBjYWxsIG1pZ2h0IHJldHVybiBlYXJseSBp
ZiBhbiBpbm9kZSB3aGljaCBzaGFyZXMgdGhlIHdhaXRxIGlzIHdva2VuIHVw
Lg0KKyAqIFRoaXMgaXMgbW9zdCBlYXNpbHkgaGFuZGxlZCBieSB0aGUgY2Fs
bGVyIHdoaWNoIHdpbGwgbG9vcCBhcm91bmQgYWdhaW4NCisgKiBsb29raW5n
IGZvciB0aGUgaW5vZGUuDQorICoNCisgKiBUaGlzIGlzIGNhbGxlZCB3aXRo
IGlub2RlX2xvY2sgaGVsZC4NCisgKi8NCitzdGF0aWMgdm9pZCBfX3dhaXRf
b25fZnJlZWluZ19pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlKQ0KK3sNCisg
ICAgICAgIERFQ0xBUkVfV0FJVFFVRVVFKHdhaXQsIGN1cnJlbnQpOw0KKw0K
KyAgICAgICAgYWRkX3dhaXRfcXVldWUoJmlub2RlLT5pX3dhaXQsICZ3YWl0
KTsNCisgICAgICAgIHNldF9jdXJyZW50X3N0YXRlKFRBU0tfVU5JTlRFUlJV
UFRJQkxFKTsNCisgICAgICAgIHNwaW5fdW5sb2NrKCZpbm9kZV9sb2NrKTsN
CisgICAgICAgIHNjaGVkdWxlKCk7DQorICAgICAgICByZW1vdmVfd2FpdF9x
dWV1ZSgmaW5vZGUtPmlfd2FpdCwgJndhaXQpOw0KKyAgICAgICAgc3Bpbl9s
b2NrKCZpbm9kZV9sb2NrKTsNCit9DQogDQogc3RhdGljIGlubGluZSB2b2lk
IHdyaXRlX2lub2RlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGludCBzeW5jKQ0K
IHsNCkBAIC01OTYsNiArNjIxLDExIEBADQogCQlpZiAoaW5vZGUtPmlfZGF0
YS5ucnBhZ2VzKQ0KIAkJCXRydW5jYXRlX2lub2RlX3BhZ2VzKCZpbm9kZS0+
aV9kYXRhLCAwKTsNCiAJCWNsZWFyX2lub2RlKGlub2RlKTsNCisJCXNwaW5f
bG9jaygmaW5vZGVfbG9jayk7DQorCQlsaXN0X2RlbCgmaW5vZGUtPmlfaGFz
aCk7DQorCQlJTklUX0xJU1RfSEVBRCgmaW5vZGUtPmlfaGFzaCk7DQorCQlz
cGluX3VubG9jaygmaW5vZGVfbG9jayk7DQorCQl3YWtlX3VwKCZpbm9kZS0+
aV93YWl0KTsNCiAJCWRlc3Ryb3lfaW5vZGUoaW5vZGUpOw0KIAkJbnJfZGlz
cG9zZWQrKzsNCiAJfQ0KQEAgLTcwNyw2ICs3MzcsMTQgQEANCiAgKg0KICAq
IFdlIGRvbid0IGV4cGVjdCB0byBoYXZlIHRvIGNhbGwgdGhpcyB2ZXJ5IG9m
dGVuLg0KICAqDQorICogV2UgbGVhdmUgdGhlIGlub2RlIGluIHRoZSBpbm9k
ZSBoYXNoIHRhYmxlIHVudGlsICphZnRlciogDQorICogdGhlIGZpbGVzeXN0
ZW0ncyAtPmRlbGV0ZV9pbm9kZSAoaW4gZGlzcG9zZV9saXN0KSBjb21wbGV0
ZXMuDQorICogVGhpcyBlbnN1cmVzIHRoYXQgYW4gaWdldCAoc3VjaCBhcyBu
ZnNkIG1pZ2h0IGluc3RpZ2F0ZSkgd2lsbCANCisgKiBhbHdheXMgZmluZCB1
cC10by1kYXRlIGluZm9ybWF0aW9uIGVpdGhlciBpbiB0aGUgaGFzaCBvciBv
biBkaXNrLg0KKyAqDQorICogSV9GUkVFSU5HIGlzIHNldCBzbyB0aGF0IG5v
LW9uZSB3aWxsIHRha2UgYSBuZXcgcmVmZXJlbmNlDQorICogdG8gdGhlIGlu
b2RlIHdoaWxlIGl0IGlzIGJlaW5nIGRlbGV0ZWQuDQorICoNCiAgKiBOLkIu
IFRoZSBzcGlubG9jayBpcyByZWxlYXNlZCBkdXJpbmcgdGhlIGNhbGwgdG8N
CiAgKiAgICAgIGRpc3Bvc2VfbGlzdC4NCiAgKi8NCkBAIC03MzksOCArNzc3
LDYgQEANCiAJCWlmIChhdG9taWNfcmVhZCgmaW5vZGUtPmlfY291bnQpKQ0K
IAkJCWNvbnRpbnVlOw0KIAkJbGlzdF9kZWwodG1wKTsNCi0JCWxpc3RfZGVs
KCZpbm9kZS0+aV9oYXNoKTsNCi0JCUlOSVRfTElTVF9IRUFEKCZpbm9kZS0+
aV9oYXNoKTsNCiAJCWxpc3RfYWRkKHRtcCwgZnJlZWFibGUpOw0KIAkJaW5v
ZGUtPmlfc3RhdGUgfD0gSV9GUkVFSU5HOw0KIAkJY291bnQrKzsNCkBAIC03
OTMsNiArODI5LDcgQEANCiAJc3RydWN0IGxpc3RfaGVhZCAqdG1wOw0KIAlz
dHJ1Y3QgaW5vZGUgKiBpbm9kZTsNCiANCityZXBlYXQ6DQogCXRtcCA9IGhl
YWQ7DQogCWZvciAoOzspIHsNCiAJCXRtcCA9IHRtcC0+bmV4dDsNCkBAIC04
MDYsNiArODQzLDEwIEBADQogCQkJY29udGludWU7DQogCQlpZiAoZmluZF9h
Y3RvciAmJiAhZmluZF9hY3Rvcihpbm9kZSwgaW5vLCBvcGFxdWUpKQ0KIAkJ
CWNvbnRpbnVlOw0KKwkJaWYgKGlub2RlLT5pX3N0YXRlICYgKElfRlJFRUlO
R3xJX0NMRUFSKSkgew0KKwkJCV9fd2FpdF9vbl9mcmVlaW5nX2lub2RlKGlu
b2RlKTsNCisJCQlnb3RvIHJlcGVhdDsNCisJCX0NCiAJCWJyZWFrOw0KIAl9
DQogCXJldHVybiBpbm9kZTsNCkBAIC0xMDc2LDggKzExMTcsNiBAQA0KIAkJ
CXJldHVybjsNCiANCiAJCWlmICghaW5vZGUtPmlfbmxpbmspIHsNCi0JCQls
aXN0X2RlbCgmaW5vZGUtPmlfaGFzaCk7DQotCQkJSU5JVF9MSVNUX0hFQUQo
Jmlub2RlLT5pX2hhc2gpOw0KIAkJCWxpc3RfZGVsKCZpbm9kZS0+aV9saXN0
KTsNCiAJCQlJTklUX0xJU1RfSEVBRCgmaW5vZGUtPmlfbGlzdCk7DQogCQkJ
aW5vZGUtPmlfc3RhdGV8PUlfRlJFRUlORzsNCkBAIC0xMDk1LDYgKzExMzQs
MTEgQEANCiAJCQkJZGVsZXRlKGlub2RlKTsNCiAJCQl9IGVsc2UNCiAJCQkJ
Y2xlYXJfaW5vZGUoaW5vZGUpOw0KKwkJCXNwaW5fbG9jaygmaW5vZGVfbG9j
ayk7DQorCQkJbGlzdF9kZWwoJmlub2RlLT5pX2hhc2gpOw0KKwkJCUlOSVRf
TElTVF9IRUFEKCZpbm9kZS0+aV9oYXNoKTsNCisJCQlzcGluX3VubG9jaygm
aW5vZGVfbG9jayk7DQorCQkJd2FrZV91cCgmaW5vZGUtPmlfd2FpdCk7DQog
CQkJaWYgKGlub2RlLT5pX3N0YXRlICE9IElfQ0xFQVIpDQogCQkJCUJVRygp
Ow0KIAkJfSBlbHNlIHsNCg==

--8323328-220363116-1074102869=:14071--
