Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbUCaSqg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 13:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbUCaSqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 13:46:35 -0500
Received: from mail1.slu.se ([130.238.96.11]:1190 "EHLO mail1.slu.se")
	by vger.kernel.org with ESMTP id S262293AbUCaSqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 13:46:30 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sc9I7wnJ8F"
Content-Transfer-Encoding: 7bit
Message-ID: <16491.4593.718724.277551@robur.slu.se>
Date: Wed, 31 Mar 2004 20:46:09 +0200
To: dipankar@in.ibm.com
Cc: Andrea Arcangeli <andrea@suse.de>, "David S. Miller" <davem@redhat.com>,
       kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Robert.Olsson@data.slu.se, paulmck@us.ibm.com, akpm@osdl.org
Subject: Re: route cache DoS testing and softirqs
In-Reply-To: <20040331171023.GA4543@in.ibm.com>
References: <20040329222926.GF3808@dualathlon.random>
	<200403302005.AAA00466@yakov.inr.ac.ru>
	<20040330211450.GI3808@dualathlon.random>
	<20040330133000.098761e2.davem@redhat.com>
	<20040330213742.GL3808@dualathlon.random>
	<20040331171023.GA4543@in.ibm.com>
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sc9I7wnJ8F
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit


Dipankar Sarma writes:
 > And I am not. I am still on 2.6.0 and there seems to be no NAPI support
 > for the e100 there. Should I try 2.6.4 where e100 has NAPI support ?
 > 
 > Anyway, even without softirqs on the back of hardirqs, there are
 > other ways of softirq overload as seen in Robert's setup.


Well I see some hardirq's most from TX and timer interrups and HZ=1000 can
can change the way softirq's are run a bit.

I hacked do_softirq() sources so we can understand how things work a bit 
better.  (Use fastroute stats from /proc/net/softnet_stat). 


ksoftird == softirq's sourced from ksofttirq
irqexit  == softirq's sourced from interrupt exit
bh_enbl  == softirq's sourced local_bh_enable

Before run

total    droppped tsquz    throttl  bh_enbl  ksoftird irqexit  other   
00000000 00000000 00000000 00000000 000000e8 0000017e 00030411 00000000
00000000 00000000 00000000 00000000 000000ae 00000277 00030349 00000000

After DoS (See description from previous mail)

total    droppped tsquz    throttl  bh_enbl  ksoftird irqexit  other    
00164c55 00000000 000021de 00000000 000000fc 0000229f 0003443c 00000000
001695e7 00000000 0000224d 00000000 00000162 0000236f 000342f7 00000000

So the major part of softirq's are run from irqexit and therefor out of 
scheduler control. This even with RX polling (eth0, eth2) We still have 
some TX interrupts plus timer interrupts now at 1000Hz. Which probably 
reduces the number of softirq's that ksoftirqd runs.

          CPU0       CPU1       
  0:     297156          0    IO-APIC-edge  timer
  1:        431          0    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          0          0    IO-APIC-edge  rtc
 14:      34527          0    IO-APIC-edge  ide0
 26:        131          0   IO-APIC-level  eth0
 27:      22910          0   IO-APIC-level  eth1
 28:          8        124   IO-APIC-level  eth2
 29:          9      23197   IO-APIC-level  eth3
NMI:          0          0 
LOC:     297060     297059 


--sc9I7wnJ8F
Content-Type: application/octet-stream
Content-Disposition: attachment;
	filename="softirq_monitor.pat"
Content-Transfer-Encoding: base64

LS0tIGtlcm5lbC9zb2Z0aXJxLmMub3JpZwkyMDA0LTAzLTExIDAzOjU1OjI0LjAwMDAwMDAwMCAr
MDEwMAorKysga2VybmVsL3NvZnRpcnEuYwkyMDA0LTAzLTMxIDE4OjE1OjI2LjAwMDAwMDAwMCAr
MDIwMApAQCAtNjksNyArNjksMTMgQEAKICAqLwogI2RlZmluZSBNQVhfU09GVElSUV9SRVNUQVJU
IDEwCiAKLWFzbWxpbmthZ2Ugdm9pZCBkb19zb2Z0aXJxKHZvaWQpCisKKy8qIFVzZSB0aGUgZmFz
dHJvdXRlIHN0YXRzLiAqLworCisjaW5jbHVkZSA8bGludXgvbmV0ZGV2aWNlLmg+CitERUNMQVJF
X1BFUl9DUFUoc3RydWN0IG5ldGlmX3J4X3N0YXRzLCBuZXRkZXZfcnhfc3RhdCk7CisKK2FzbWxp
bmthZ2Ugdm9pZCBkb19zb2Z0aXJxKGludCBmcm9tKQogewogCWludCBtYXhfcmVzdGFydCA9IE1B
WF9TT0ZUSVJRX1JFU1RBUlQ7CiAJX191MzIgcGVuZGluZzsKQEAgLTg0LDkgKzkwLDQ0IEBACiAK
IAlpZiAocGVuZGluZykgewogCQlzdHJ1Y3Qgc29mdGlycV9hY3Rpb24gKmg7CisJCXN0cnVjdCB0
YXNrX3N0cnVjdCAqdHNrID0gX19nZXRfY3B1X3Zhcihrc29mdGlycWQpOwogCiAJCWxvY2FsX2Jo
X2Rpc2FibGUoKTsKKyNpZiAwCQkKKwkJLyogQXZvaWQgc29mdGlycSdzIGZyb20gRG9TJ2luZyB1
c2VyIGFwcHMgaW5jbC4gUkNVJ3MgZXRjICovCisKKyAgICAgICAgICAgICAgICBpZiAodW5saWtl
bHkoZnJvbSAhPSBTSVJRX0ZST01fS1NPRlRJUlFEICYmIAorCQkJICAgICB0c2sgICYmCisJCQkg
ICAgIHNjaGVkX2Nsb2NrKCkgLSB0c2stPnRpbWVzdGFtcCA+IAorCQkJICAgICAodW5zaWduZWQg
bG9uZyBsb25nKSAyKjEwMDAwMDAwMDAgJiYKKwkJCSAgICAgIShjdXJyZW50LT5zdGF0ZSAmIChU
QVNLX0RFQUQgfCBUQVNLX1pPTUJJRSkpKSkgeworCQkJCisJCQlzZXRfdHNrX25lZWRfcmVzY2hl
ZChjdXJyZW50KTsKKwkJCWxvY2FsX2lycV9kaXNhYmxlKCk7CisJCQlnb3RvIGRvbmU7CisgICAg
ICAgICAgICAgICAgfQorI2VuZGlmCisKIHJlc3RhcnQ6CisJCXN3aXRjaCAoZnJvbSkgeworCQkJ
CisJCWNhc2UgU0lSUV9GUk9NX0JIOgorCQkJX19nZXRfY3B1X3ZhcihuZXRkZXZfcnhfc3RhdCku
ZmFzdHJvdXRlX2hpdCsrOworCQkJYnJlYWs7CisJCQkKKwkJY2FzZSBTSVJRX0ZST01fS1NPRlRJ
UlFEOgorCQkJX19nZXRfY3B1X3ZhcihuZXRkZXZfcnhfc3RhdCkuZmFzdHJvdXRlX3N1Y2Nlc3Mr
KzsKKwkJCWJyZWFrOworCisJCWNhc2UgU0lSUV9GUk9NX0lSUUVYSVQ6CisJCQlfX2dldF9jcHVf
dmFyKG5ldGRldl9yeF9zdGF0KS5mYXN0cm91dGVfZGVmZXIrKzsKKwkJCWJyZWFrOworICAKKwor
CQlkZWZhdWx0OgorCQkJX19nZXRfY3B1X3ZhcihuZXRkZXZfcnhfc3RhdCkuZmFzdHJvdXRlX2Rl
ZmVycmVkX291dCsrOworCQkJCisJCX0KIAkJLyogUmVzZXQgdGhlIHBlbmRpbmcgYml0bWFzayBi
ZWZvcmUgZW5hYmxpbmcgaXJxcyAqLwogCQlsb2NhbF9zb2Z0aXJxX3BlbmRpbmcoKSA9IDA7CiAK
QEAgLTEwNiw2ICsxNDcsNyBAQAogCQlwZW5kaW5nID0gbG9jYWxfc29mdGlycV9wZW5kaW5nKCk7
CiAJCWlmIChwZW5kaW5nICYmIC0tbWF4X3Jlc3RhcnQpCiAJCQlnb3RvIHJlc3RhcnQ7CisgZG9u
ZToKIAkJaWYgKHBlbmRpbmcpCiAJCQl3YWtldXBfc29mdGlycWQoKTsKIAkJX19sb2NhbF9iaF9l
bmFibGUoKTsKQEAgLTEyMiw3ICsxNjQsNyBAQAogCVdBUk5fT04oaXJxc19kaXNhYmxlZCgpKTsK
IAlpZiAodW5saWtlbHkoIWluX2ludGVycnVwdCgpICYmCiAJCSAgICAgbG9jYWxfc29mdGlycV9w
ZW5kaW5nKCkpKQotCQlpbnZva2Vfc29mdGlycSgpOworCQlpbnZva2Vfc29mdGlycShTSVJRX0ZS
T01fQkgpOwogCXByZWVtcHRfY2hlY2tfcmVzY2hlZCgpOwogfQogRVhQT1JUX1NZTUJPTChsb2Nh
bF9iaF9lbmFibGUpOwpAQCAtMzI0LDcgKzM2Niw3IEBACiAJCV9fc2V0X2N1cnJlbnRfc3RhdGUo
VEFTS19SVU5OSU5HKTsKIAogCQl3aGlsZSAobG9jYWxfc29mdGlycV9wZW5kaW5nKCkpIHsKLQkJ
CWRvX3NvZnRpcnEoKTsKKwkJCWRvX3NvZnRpcnEoU0lSUV9GUk9NX0tTT0ZUSVJRRCk7CiAJCQlj
b25kX3Jlc2NoZWQoKTsKIAkJfQogCi0tLSBpbmNsdWRlL2xpbnV4L25ldGRldmljZS5ofgkyMDA0
LTAzLTExIDAzOjU1OjQ0LjAwMDAwMDAwMCArMDEwMAorKysgaW5jbHVkZS9saW51eC9uZXRkZXZp
Y2UuaAkyMDA0LTAzLTMxIDEyOjI0OjU3LjAwMDAwMDAwMCArMDIwMApAQCAtNjY5LDcgKzY2OSw3
IEBACiB7CiAgICAgICAgaW50IGVyciA9IG5ldGlmX3J4KHNrYik7CiAgICAgICAgaWYgKHNvZnRp
cnFfcGVuZGluZyhzbXBfcHJvY2Vzc29yX2lkKCkpKQotICAgICAgICAgICAgICAgZG9fc29mdGly
cSgpOworICAgICAgICAgICAgICAgZG9fc29mdGlycShTSVJRX0ZST01fTkVUSUZfUlhfTkkpOwog
ICAgICAgIHJldHVybiBlcnI7CiB9CiAKLS0tIGluY2x1ZGUvbGludXgvaW50ZXJydXB0Lmgub3Jp
ZwkyMDA0LTAzLTMxIDE4OjI0OjAzLjAwMDAwMDAwMCArMDIwMAorKysgaW5jbHVkZS9saW51eC9p
bnRlcnJ1cHQuaAkyMDA0LTAzLTMxIDE4OjE5OjI4LjAwMDAwMDAwMCArMDIwMApAQCAtOTIsNyAr
OTIsMTcgQEAKIAl2b2lkCSpkYXRhOwogfTsKIAotYXNtbGlua2FnZSB2b2lkIGRvX3NvZnRpcnEo
dm9pZCk7CisvKiBTb2Z0aXJxIG9yaWdpbmF0b3IgKi8KK2VudW0gCit7CisJU0lSUV9GUk9NX0tT
T0ZUSVJRRD0wLAorCVNJUlFfRlJPTV9JUlFFWElULAorCVNJUlFfRlJPTV9CSCwKKwlTSVJRX0ZS
T01fTkVUSUZfUlhfTkksCisJU0lSUV9GUk9NX1BLVEdFTgorfTsKKworYXNtbGlua2FnZSB2b2lk
IGRvX3NvZnRpcnEoaW50IGZyb20pOwogZXh0ZXJuIHZvaWQgb3Blbl9zb2Z0aXJxKGludCBuciwg
dm9pZCAoKmFjdGlvbikoc3RydWN0IHNvZnRpcnFfYWN0aW9uKiksIHZvaWQgKmRhdGEpOwogZXh0
ZXJuIHZvaWQgc29mdGlycV9pbml0KHZvaWQpOwogI2RlZmluZSBfX3JhaXNlX3NvZnRpcnFfaXJx
b2ZmKG5yKSBkbyB7IGxvY2FsX3NvZnRpcnFfcGVuZGluZygpIHw9IDFVTCA8PCAobnIpOyB9IHdo
aWxlICgwKQpAQCAtMTAwLDcgKzExMCw3IEBACiBleHRlcm4gdm9pZCBGQVNUQ0FMTChyYWlzZV9z
b2Z0aXJxKHVuc2lnbmVkIGludCBucikpOwogCiAjaWZuZGVmIGludm9rZV9zb2Z0aXJxCi0jZGVm
aW5lIGludm9rZV9zb2Z0aXJxKCkgZG9fc29mdGlycSgpCisjZGVmaW5lIGludm9rZV9zb2Z0aXJx
KGZyb20pIGRvX3NvZnRpcnEoZnJvbSkKICNlbmRpZgogCiAKLS0tIGluY2x1ZGUvYXNtLWkzODYv
aGFyZGlycS5oLm9yaWcJMjAwNC0wMy0xMSAwMzo1NTozNy4wMDAwMDAwMDAgKzAxMDAKKysrIGlu
Y2x1ZGUvYXNtLWkzODYvaGFyZGlycS5oCTIwMDQtMDMtMzEgMTg6Mjc6MTcuMDAwMDAwMDAwICsw
MjAwCkBAIC04OCw3ICs4OCw3IEBACiBkbyB7CQkJCQkJCQkJXAogCQlwcmVlbXB0X2NvdW50KCkg
LT0gSVJRX0VYSVRfT0ZGU0VUOwkJCVwKIAkJaWYgKCFpbl9pbnRlcnJ1cHQoKSAmJiBzb2Z0aXJx
X3BlbmRpbmcoc21wX3Byb2Nlc3Nvcl9pZCgpKSkgXAotCQkJZG9fc29mdGlycSgpOwkJCQkJXAor
CQkJZG9fc29mdGlycShTSVJRX0ZST01fSVJRRVhJVCk7CQkJXAogCQlwcmVlbXB0X2VuYWJsZV9u
b19yZXNjaGVkKCk7CQkJCVwKIH0gd2hpbGUgKDApCiAKLS0tIG5ldC9jb3JlL3BrdGdlbi5jfgky
MDA0LTAzLTExIDAzOjU1OjM2LjAwMDAwMDAwMCArMDEwMAorKysgbmV0L2NvcmUvcGt0Z2VuLmMJ
MjAwNC0wMy0zMSAxMjoyNDo1Ny4wMDAwMDAwMDAgKzAyMDAKQEAgLTcxMCw3ICs3MTAsNyBAQAog
CQkJCWlmIChuZWVkX3Jlc2NoZWQoKSkKIAkJCQkJc2NoZWR1bGUoKTsKIAkJCQllbHNlCi0JCQkJ
CWRvX3NvZnRpcnEoKTsKKwkJCQkJZG9fc29mdGlycShTSVJRX0ZST01fUEtUR0VOKTsKIAkJCX0g
d2hpbGUgKG5ldGlmX3F1ZXVlX3N0b3BwZWQob2RldikpOwogCQkJaWRsZSA9IGN5Y2xlcygpIC0g
aWRsZV9zdGFydDsKIAkJCWluZm8tPmlkbGVfYWNjICs9IGlkbGU7Cg==
--sc9I7wnJ8F
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit



Cheers.
						--ro

--sc9I7wnJ8F--
