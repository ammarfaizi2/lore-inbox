Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbVHONOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbVHONOV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 09:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVHONOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 09:14:21 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:941 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932305AbVHONOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 09:14:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Jw9DggJCnazYRnZeSoMaQOhH4hl/C/gOIOKsxvrTpVCoY5g4cH6Q2ch7BAZCelYMB0PwsX9QaSFI8EqVn7FciT62dn8soLMoeYs2dSGJf5pIHVCqUk+bFxSEgya9Ewb0EXscR7QZQn2tgum/mlHOQqww+ipAfQPX4zaMhj17fV8=
Message-ID: <6c58e319050815061437bc278f@mail.gmail.com>
Date: Mon, 15 Aug 2005 16:14:17 +0300
From: Dror Cohen <dror.xiv@gmail.com>
To: e1000-devel@lists.sourceforge.net
Subject: e1000 6.0.60 problems
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       linville@tuxdriver.com
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3691_4299884.1124111657207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_3691_4299884.1124111657207
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello all,
we've (XIV ltd.) encountered a problem with the e1000 driver.  the basic
problem was that we'd see every few hours a NETDEV message notifying us
that the NIC has been reset. Our enviroment is a cluster of linux
based (2.4.27) dual xeon on super micro board with the e1000 onboard
(82546GB). There is a very high load of traffic on the e1000 (mainly due
to iSCSI operations, ssh to the machines and sometimes we also use iperf
to really exhaust the network bandwidth). This happend with version 4 of th=
e
driver. We've upgraded to the version 6.0.54 and turned on NAPI (in
hope that this will resolve the problem). here's our modules.conf
file:

"options e1000
RxDescriptors=3D1024,1024,1024,1024,1024,1024,1024,1024,1024,1024
TxDescriptors=3D1024,1024,1024,1024,1024,1024,1024,1024,1024,1024
InterruptThrottleRate=3D2000,2000,2000,2000,2000,2000,2000,2000,2000,2000"

This made the NETDEV messages disaapear but the machines started getting
stuck totally (no console, no kdb). the var log messages would show
allocation problems and after enabling some debug info we'd see
something of this sort:

"Jul 29 12:40:06 mnfc-150-101 kernel: __alloc_pages: 2-order allocation
failed (gfp=3D0x20/0)
Jul 29 12:40:06 mnfc-150-101 kernel: b1cb1be0 b1cb1c2c 8013aee1 8034b8a0
00000002 00000020 00000000 00001180
Jul 29 12:40:06 mnfc-150-101 kernel:        00000004 00000000 0000000c
80446abc 80446c74 00000002 00000020 000000
02
Jul 29 12:40:06 mnfc-150-101 kernel:        00000020 81b0f9b8 00000000
b1cb1c34 8013aa66 b1cb1c3c 8013af45 b1cb1c
6c
Jul 29 12:40:06 mnfc-150-101 kernel: Call Trace:
Jul 29 12:40:06 mnfc-150-101 kernel:  [<8013aee1>]
__alloc_pages+0x271/0x290 [kernel]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<8013aa66>]
_alloc_pages+0x16/0x20 [kernel]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<8013af45>]
__get_free_pages+0x45/0x50 [kernel]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<80137ce6>]
kmem_cache_grow+0xc6/0x280 [kernel]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<80138239>] kmalloc+0xa9/0x170
[kernel]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<802c8d04>] alloc_skb+0xc4/0x1e0
[kernel]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<c080e4ff>]
e1000_alloc_rx_buffers+0x5b/0x358 [e1000]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<c080de64>]
e1000_clean_rx_irq+0x1f0/0x44c [e1000]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<c080d7dc>] e1000_clean+0x44/0xe4
[e1000]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<802cda50>]
net_rx_action+0xa0/0x140 [kernel]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<80122609>] do_softirq+0xe9/0xf0
[kernel]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<8010b366>] do_IRQ+0xf6/0x100
[kernel]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<8010dcb8>] call_do_IRQ+0x5/0xd
[kernel]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<8032532c>]
__generic_copy_to_user+0x3c/0x60 [kernel]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<802ca91c>]
memcpy_toiovec+0x5c/0x70 [kernel]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<802cafb8>]
skb_copy_datagram_iovec+0x48/0x200 [kernel]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<802e9ee3>]
tcp_recvmsg+0x753/0x990 [kernel]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<80153414>]
poll_freewait+0x44/0x50 [kernel]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<803098da>]
inet_recvmsg+0x4a/0x60 [kernel]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<802c548e>]
sock_recvmsg+0x3e/0xe0 [kernel]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<802c55cc>] sock_read+0x9c/0xb0
[kernel]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<8014216c>] sys_read+0x9c/0x150
[kernel]
Jul 29 12:40:06 mnfc-150-101 kernel:  [<80109163>] system_call+0x33/0x38
[kernel]"

after upgrading to 6.0.60 there was no change. comparing the version
with the one coming with the 2.6 kernel proved that one major change
wasn't backported to the 6.0.60 (the watch dog change). We've ported
this back to the 6.0.60 (attached is the diff between the 6.0.60 from
the site to the one with our backporting). now we're seeing back the
NETDEV (less frequent and the whole reset process is little faster, but
still very annoying) along with the "e1000_clean_tx_irq: Detected Tx
Unit Hang" messages. The allocations problems (?) also seem to exists as
well. here's what it looks like:

"Aug 13 06:03:39 14.10.140.6 kernel: e1000: eth1: e1000_clean_tx_irq:
Detected Tx Unit Hang
Aug 13 06:03:39 14.10.140.6 kernel:   TDH                  <242>
Aug 13 06:03:39 14.10.140.6 kernel:   TDT                  <1d>
Aug 13 06:03:39 14.10.140.6 kernel:   next_to_use          <1d>
Aug 13 06:03:39 14.10.140.6 kernel:   next_to_clean        <242>
Aug 13 06:03:39 14.10.140.6 kernel: buffer_info[next_to_clean]
Aug 13 06:03:39 14.10.140.6 kernel:   dma                  <6ea1c06a>
Aug 13 06:03:39 14.10.140.6 kernel:   time_stamp           <160b24f>
Aug 13 06:03:39 14.10.140.6 kernel:   next_to_watch        <245>
Aug 13 06:03:39 14.10.140.6 kernel:   jiffies              <160b310>
Aug 13 06:03:39 14.10.140.6 kernel:   next_to_watch.status <0>
Aug 13 06:03:41 14.10.140.6 kernel: e1000: eth1: e1000_clean_tx_irq:
Detected Tx Unit Hang
Aug 13 06:03:41 14.10.140.6 kernel:   TDH                  <242>
Aug 13 06:03:41 14.10.140.6 kernel:   TDT                  <1d>
Aug 13 06:03:41 14.10.140.6 kernel:   next_to_use          <1d>
Aug 13 06:03:41 14.10.140.6 kernel:   next_to_clean        <242>
Aug 13 06:03:41 14.10.140.6 kernel: buffer_info[next_to_clean]
Aug 13 06:03:41 14.10.140.6 kernel:   dma                  <6ea1c06a>
Aug 13 06:03:41 14.10.140.6 kernel:   time_stamp           <160b24f>
Aug 13 06:03:41 14.10.140.6 kernel:   next_to_watch        <245>
Aug 13 06:03:41 14.10.140.6 kernel:   jiffies              <160b3d8>
Aug 13 06:03:41 14.10.140.6 kernel:   next_to_watch.status <0>
Aug 13 06:03:43 14.10.140.6 kernel: e1000: eth1: e1000_clean_tx_irq:
Detected Tx Unit Hang
Aug 13 06:03:43 14.10.140.6 kernel:   TDH                  <242>
Aug 13 06:03:43 14.10.140.6 kernel:   TDT                  <1d>
Aug 13 06:03:43 14.10.140.6 kernel:   next_to_use          <1d>
Aug 13 06:03:43 14.10.140.6 kernel:   next_to_clean        <242>
Aug 13 06:03:43 14.10.140.6 kernel: buffer_info[next_to_clean]
Aug 13 06:03:43 14.10.140.6 kernel:   dma                  <6ea1c06a>
Aug 13 06:03:43 14.10.140.6 kernel:   time_stamp           <160b24f>
Aug 13 06:03:43 14.10.140.6 kernel:   next_to_watch        <245>
Aug 13 06:03:43 14.10.140.6 kernel:   jiffies              <160b4a0>
Aug 13 06:03:43 14.10.140.6 kernel:   next_to_watch.status <0>
Aug 13 06:03:45 14.10.140.6 kernel: e1000: eth1: e1000_clean_tx_irq:
Detected Tx Unit Hang
Aug 13 06:03:45 14.10.140.6 kernel:   TDH                  <242>
Aug 13 06:03:45 14.10.140.6 kernel:   TDT                  <1d>
Aug 13 06:03:45 14.10.140.6 kernel:   next_to_use          <1d>
Aug 13 06:03:45 14.10.140.6 kernel:   next_to_clean        <242>
Aug 13 06:03:45 14.10.140.6 kernel: buffer_info[next_to_clean]
Aug 13 06:03:45 14.10.140.6 kernel:   dma                  <6ea1c06a>
Aug 13 06:03:45 14.10.140.6 kernel:   time_stamp           <160b24f>
Aug 13 06:03:45 14.10.140.6 kernel:   next_to_watch        <245>
Aug 13 06:03:45 14.10.140.6 kernel:   jiffies              <160b568>
Aug 13 06:03:45 14.10.140.6 kernel:   next_to_watch.status <0>
Aug 13 06:03:47 14.10.140.6 kernel: e1000: eth1: e1000_clean_tx_irq:
Detected Tx Unit Hang
Aug 13 06:03:47 14.10.140.6 kernel:   TDH                  <242>
Aug 13 06:03:47 14.10.140.6 kernel:   TDT                  <1d>
Aug 13 06:03:47 14.10.140.6 kernel:   next_to_use          <1d>
Aug 13 06:03:47 14.10.140.6 kernel:   next_to_clean        <242>
Aug 13 06:03:47 14.10.140.6 kernel: buffer_info[next_to_clean]
Aug 13 06:03:47 14.10.140.6 kernel:   dma                  <6ea1c06a>
Aug 13 06:03:47 14.10.140.6 kernel:   time_stamp           <160b24f>
Aug 13 06:03:47 14.10.140.6 kernel:   next_to_watch        <245>
Aug 13 06:03:47 14.10.140.6 kernel:   jiffies              <160b630>
Aug 13 06:03:47 14.10.140.6 kernel:   next_to_watch.status <0>
Aug 13 06:03:47 14.10.140.6 kernel: NETDEV WATCHDOG: eth1: transmit
timed out
Aug 13 06:03:50 14.10.140.6 kernel: e1000: eth1: e1000_watchdog_task:
NIC Link is Up 1000 Mbps Full Duplex"

when using the latest 6.1.16 version of the driver (which doesn't seem
to have the watch dog fix, but a lot of other fixes) we see similar
results to our modified version - there are still NETDEV events with
the "Detected Tx Unit Hang" message followed by the output of the
registers.

more information can be supplied if needed.

our questions:
* Is anyone experiencing similar problems (looks to us alot like: "[
955064 ] e1000 freezes Linux with 82544GC (similar to a year-old bug)") ?

* Was the watch dog change forgotten, or left out deliberetly ? Does our
patch seems to be OK ? it is also not present in the latest version (6.1.6)=
.

* are the allocation problems related in anyway to e1000 problem ?

thanks,


--=20
Dror Cohen
XIV ltd.

email: dror at xiv.co.il
phone: +972-3-6074726

------=_Part_3691_4299884.1124111657207
Content-Type: text/x-patch; name="6060vsXIV.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="6060vsXIV.diff"

ZGlmZiAtdXByTiAtWCBkb250ZGlmZiBzcmMvZTEwMDAuaCBtb2RpZmllZF9zcmMvZTEwMDAuaAot
LS0gc3JjL2UxMDAwLmgJMjAwNS0wNS0xOCAwMDozMTo0NC4wMDAwMDAwMDAgKzAzMDAKKysrIG1v
ZGlmaWVkX3NyYy9lMTAwMC5oCTIwMDUtMDgtMTUgMDk6MDk6NDAuNzkyNjk2OTAzICswMzAwCkBA
IC0yMzIsNiArMjMyLDcgQEAgc3RydWN0IGUxMDAwX2FkYXB0ZXIgewogCXNwaW5sb2NrX3Qgc3Rh
dHNfbG9jazsKIAlhdG9taWNfdCBpcnFfc2VtOwogCXN0cnVjdCB3b3JrX3N0cnVjdCB0eF90aW1l
b3V0X3Rhc2s7CisJc3RydWN0IHdvcmtfc3RydWN0IHdhdGNoZG9nX3Rhc2s7CiAJdWludDhfdCBm
Y19hdXRvbmVnOwogCiAjaWZkZWYgRVRIVE9PTF9QSFlTX0lECmRpZmYgLXVwck4gLVggZG9udGRp
ZmYgc3JjL2UxMDAwX21haW4uYyBtb2RpZmllZF9zcmMvZTEwMDBfbWFpbi5jCi0tLSBzcmMvZTEw
MDBfbWFpbi5jCTIwMDUtMDUtMTggMDA6MzE6NDQuMDAwMDAwMDAwICswMzAwCisrKyBtb2RpZmll
ZF9zcmMvZTEwMDBfbWFpbi5jCTIwMDUtMDgtMTUgMDk6MDk6NDAuODgzNjk1MjgwICswMzAwCkBA
IC0xNzYsNiArMTc2LDcgQEAgc3RhdGljIHZvaWQgZTEwMDBfY2xlYW5fcnhfcmluZyhzdHJ1Y3Qg
ZQogc3RhdGljIHZvaWQgZTEwMDBfc2V0X211bHRpKHN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYp
Owogc3RhdGljIHZvaWQgZTEwMDBfdXBkYXRlX3BoeV9pbmZvKHVuc2lnbmVkIGxvbmcgZGF0YSk7
CiBzdGF0aWMgdm9pZCBlMTAwMF93YXRjaGRvZyh1bnNpZ25lZCBsb25nIGRhdGEpOworc3RhdGlj
IHZvaWQgZTEwMDBfd2F0Y2hkb2dfdGFzayhzdHJ1Y3QgZTEwMDBfYWRhcHRlciAqYWRhcHRlcik7
CiBzdGF0aWMgdm9pZCBlMTAwMF84MjU0N190eF9maWZvX3N0YWxsKHVuc2lnbmVkIGxvbmcgZGF0
YSk7CiBzdGF0aWMgaW50IGUxMDAwX3htaXRfZnJhbWUoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3Ry
dWN0IG5ldF9kZXZpY2UgKm5ldGRldik7CiBzdGF0aWMgc3RydWN0IG5ldF9kZXZpY2Vfc3RhdHMg
KiBlMTAwMF9nZXRfc3RhdHMoc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldik7CkBAIC03MTUsNiAr
NzE2LDkgQEAgZTEwMDBfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsCiAJYWRhcHRlci0+d2F0
Y2hkb2dfdGltZXIuZnVuY3Rpb24gPSAmZTEwMDBfd2F0Y2hkb2c7CiAJYWRhcHRlci0+d2F0Y2hk
b2dfdGltZXIuZGF0YSA9ICh1bnNpZ25lZCBsb25nKSBhZGFwdGVyOwogCisJSU5JVF9XT1JLKCZh
ZGFwdGVyLT53YXRjaGRvZ190YXNrLAorCQkodm9pZCAoKikodm9pZCAqKSllMTAwMF93YXRjaGRv
Z190YXNrLCBhZGFwdGVyKTsKKwogCWluaXRfdGltZXIoJmFkYXB0ZXItPnBoeV9pbmZvX3RpbWVy
KTsKIAlhZGFwdGVyLT5waHlfaW5mb190aW1lci5mdW5jdGlvbiA9ICZlMTAwMF91cGRhdGVfcGh5
X2luZm87CiAJYWRhcHRlci0+cGh5X2luZm9fdGltZXIuZGF0YSA9ICh1bnNpZ25lZCBsb25nKSBh
ZGFwdGVyOwpAQCAtODEyLDYgKzgxNiw4IEBAIGUxMDAwX3JlbW92ZShzdHJ1Y3QgcGNpX2RldiAq
cGRldikKIAlzdHJ1Y3QgZTEwMDBfYWRhcHRlciAqYWRhcHRlciA9IG5ldGRldl9wcml2KG5ldGRl
dik7CiAJdWludDMyX3QgbWFuYywgc3dzbTsKIAorCWZsdXNoX3NjaGVkdWxlZF93b3JrKCk7CisK
IAlpZihhZGFwdGVyLT5ody5tYWNfdHlwZSA+PSBlMTAwMF84MjU0MCAmJgogCSAgIGFkYXB0ZXIt
Pmh3Lm1lZGlhX3R5cGUgPT0gZTEwMDBfbWVkaWFfdHlwZV9jb3BwZXIpIHsKIAkJbWFuYyA9IEUx
MDAwX1JFQURfUkVHKCZhZGFwdGVyLT5odywgTUFOQyk7CkBAIC0xODI5LDYgKzE4MzUsMTQgQEAg
c3RhdGljIHZvaWQKIGUxMDAwX3dhdGNoZG9nKHVuc2lnbmVkIGxvbmcgZGF0YSkKIHsKIAlzdHJ1
Y3QgZTEwMDBfYWRhcHRlciAqYWRhcHRlciA9IChzdHJ1Y3QgZTEwMDBfYWRhcHRlciAqKSBkYXRh
OworCisJLyogRG8gdGhlIHJlc3Qgb3V0c2lkZSBvZiBpbnRlcnJ1cHQgY29udGV4dCAqLworCXNj
aGVkdWxlX3dvcmsoJmFkYXB0ZXItPndhdGNoZG9nX3Rhc2spOworfQorCitzdGF0aWMgdm9pZAor
ZTEwMDBfd2F0Y2hkb2dfdGFzayhzdHJ1Y3QgZTEwMDBfYWRhcHRlciAqYWRhcHRlcikKK3sKIAlz
dHJ1Y3QgbmV0X2RldmljZSAqbmV0ZGV2ID0gYWRhcHRlci0+bmV0ZGV2OwogCXN0cnVjdCBlMTAw
MF9kZXNjX3JpbmcgKnR4ZHIgPSAmYWRhcHRlci0+dHhfcmluZzsKIAl1aW50MzJfdCBsaW5rOwpA
QCAtMjM5Miw2ICsyNDA2LDkgQEAgZTEwMDBfeG1pdF9mcmFtZShzdHJ1Y3Qgc2tfYnVmZiAqc2ti
LCBzdAogCXRzbyA9IGUxMDAwX3RzbyhhZGFwdGVyLCBza2IpOwogCWlmKHRzbyA8IDApIHsKIAkJ
ZGV2X2tmcmVlX3NrYl9hbnkoc2tiKTsKKyNpZmRlZiBORVRJRl9GX0xMVFgKKyAgICAgICAgc3Bp
bl91bmxvY2tfaXJxcmVzdG9yZSgmYWRhcHRlci0+dHhfbG9jaywgZmxhZ3MpOworI2VuZGlmCiAJ
CXJldHVybiBORVRERVZfVFhfT0s7CiAJfQogCg==
------=_Part_3691_4299884.1124111657207--
