Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133071AbRD3KBj>; Mon, 30 Apr 2001 06:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133091AbRD3KBa>; Mon, 30 Apr 2001 06:01:30 -0400
Received: from ns.tulsyan.com ([216.5.0.102]:65028 "EHLO tuls1.tulsyan.com")
	by vger.kernel.org with ESMTP id <S133071AbRD3KBR>;
	Mon, 30 Apr 2001 06:01:17 -0400
Date: Mon, 30 Apr 2001 15:42:45 +0530 (IST)
From: Hanish Menon C <hanishkvc@fedtec.com>
To: linux-kernel@vger.kernel.org
cc: akale@users.sourceforge.net
Subject: Patch to gdbstub++ taking care of possible stale data in Recieve
 buffers and qOffsets cmd for x86.
Message-ID: <Pine.LNX.4.21.0104301426260.1474-200000@hanishkvc.fedtec.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463769086-2108580470-988625565=:1474"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463769086-2108580470-988625565=:1474
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi

This patch takes care of 2 things related to remote debuging of Linux
kernel using Gdb

Problem and Solution (1)
------------------------

When trying out Remote Debugging of Linux kernel using GDB, I found a
possible protocol synchronisation issue between gdb (in host) and gdbstub
(on RemoteTarget) in the current gdb remote protocol implementation (i.e
which don't use the SequenceNumber mechanism of the protocol).

The situation unfolds as follows
1) HostGdb sends a command to the RemoteTargetStub.
2) Before the RemoteTargetStub can process the command a exception or
breakpoint occurs. Or the RemoteTargetStub is getting activated only now
during booting of the RemoteTarget m/c.
3) RemoteTargetStub sends Sxx to HostGDB. HostGDB takes this as response
to command from 1 above (or ignores the command from 1 due to this) 
4) HostGDB sends a new gdb command.
5) RemoteTargetStub picks up the old gdb command (from 1), and responds
to it.
6) HostGDB assumes its the response to the new command from 4 above, but
actually its response to the old (now stale or no longer valid) command
from 1 above.

Thus the RemoteTargetGdbStub and the HostGDB go out of sync.

I faced this problem when trying out remote debuging between a Linux Host
and a PC Emulation software (vmware or so) using /dev/ptyq0 and /dev/ttyq0
for communication. On looking into this I found this possible
synchronisation problem between the Host and Remote in GDB protocol, if
there is any content or old command in the Recieve buffers (s/w buffer in
gdbserial.c and or h/w buffer of uart) due to what ever reason.

To solve this problem I have implemented a clearRecieveDataBufferGDB in
gdbserail which when invoked will clear all buffered contents associated 
with recieving ((a) the s/w buffer in gdbserial and (b) the buffer in
uart). It uses the existing read_char implementation of gdbserial in a
loop to accomplish this. 

INTURN I call this from with in handle_exception of gdbstub just before
sending SXX signal(to notify of the exception) to HostGDB, So that
handle_exception won't respond to any old (and no longer valid)command or
invalid data in the Recieve buffer.


Problem and Solution (2)
------------------------

Also I noticed that HostGDB was sending a qOffsets query to the
RemoteTargetStub, but x86 gdbstub doesn't currently provide a
implementation for qOffset. So I implemented one which uses the following
symbols to provide the required offsets

  stext for Text
  gdt_table for Data (currently corresponds to .data or sdata)
  __bss_start for Bss.

However once Implemented I did find that HostGDBs symbol info was getting
corrupted and I was forced to reload the symbols using symbol_file. On
looking into gdb source casualy it felt as if I can ignore qOffsets
command. Either way I already had a implementation (which is very
simple) for qOffsets command, so I have retained it in the patch __as the
bug__ seems to be __in the HostGDB code__. On looking into other gdbstub
implementations in the linux kernel Even the PPC arch's gdbstub talks
about this bug in HostGDB. 

Also I picked up the elegent sprintf solution to create the response
string for qOffset from the PPC guys. Earlier I had tried a solution with
mem2hex which retains the Bytes of the address in the Target Byte order,
but for qOffset one requires to represent the address (in Hex) in the
normal reading order (varified by looking into remote.c in gdb
source) which automaticaly suites the sprintf solution.


These problem seems to be universal as far as gdb remote debug protocols  
current implementations are concerned, so may be even the GDB guys need to
be informed about these possible problems. But I am not in the GDB devel
list, so someone on the list can inform them also.
  
-----------
Keep :-)
HanishKVC



---1463769086-2108580470-988625565=:1474
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.4.3-kgdb-hankvc-30Apr2001-p1.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0104301542450.1474@hanishkvc.fedtec.com>
Content-Description: 
Content-Disposition: attachment; filename="linux-2.4.3-kgdb-hankvc-30Apr2001-p1.patch"

ZGlmZiAtTmF1ciBsaW51eC0yLjQuMy1rZ2RiL2FyY2gvaTM4Ni9rZXJuZWwv
Z2Ric3R1Yi5jIGxpbnV4LTIuNC4zLWtnZGItaGFua3ZjL2FyY2gvaTM4Ni9r
ZXJuZWwvZ2Ric3R1Yi5jDQotLS0gbGludXgtMi40LjMta2dkYi9hcmNoL2kz
ODYva2VybmVsL2dkYnN0dWIuYwlTdW4gQXByIDI5IDIxOjI1OjIwIDIwMDEN
CisrKyBsaW51eC0yLjQuMy1rZ2RiLWhhbmt2Yy9hcmNoL2kzODYva2VybmVs
L2dkYnN0dWIuYwlNb24gQXByIDMwIDAxOjUzOjEyIDIwMDENCkBAIC0xMTYs
NiArMTE2LDcgQEANCiAvKiBUaHJlYWQgcmVmZXJlbmNlICovDQogdHlwZWRl
ZiB1bnNpZ25lZCBjaGFyIHRocmVhZHJlZls4XTsNCiANCitleHRlcm4gdm9p
ZCBjbGVhclJlY2lldmVEYXRhQnVmZmVyR0RCKHZvaWQpOyAvKiBjbGVhciB0
aGUgUmVjaWV2ZSBzb2Z0d2FyZSBhbmQgaGFyZHdhcmUgZGF0YSBidWZmZXJz
ICovDQogZXh0ZXJuIGludCBwdXREZWJ1Z0NoYXIoaW50KTsgICAvKiB3cml0
ZSBhIHNpbmdsZSBjaGFyYWN0ZXIgICAgICAqLw0KIGV4dGVybiBpbnQgZ2V0
RGVidWdDaGFyKHZvaWQpOyAgIC8qIHJlYWQgYW5kIHJldHVybiBhIHNpbmds
ZSBjaGFyICovDQogDQpAQCAtNzY1LDYgKzc2Niw3IEBADQogCWludAkJCWk7
DQogCWludAkJCWRyNjsNCiAJc3RydWN0IHB0X3JlZ3MJCXRlbXByZWdzOw0K
KwlleHRlcm4gaW50CQlzdGV4dCxnZHRfdGFibGUsX19ic3Nfc3RhcnQ7DQog
I2RlZmluZQlyZWdzCSgqbGludXhfcmVncykNCiANCiAJLyoNCkBAIC04MzAs
NiArODMyLDEwIEBADQogCWdkYl9pMzg2dmVjdG9yICA9IGV4Y2VwdGlvblZl
Y3RvcjsNCiAJZ2RiX2kzODZlcnJjb2RlID0gZXJyX2NvZGUgOw0KIA0KKwkv
KiBjbGVhciBleGlzdGluZyAocG9zc2libHkgc3RhbGUpIGNvbnRlbnRzIGlu
IHRoZSBSZWNpZXZlIGJ1ZmZlcnMgDQorCSAgIChzL3coZ2Ric2VyaWFsKSBh
bmQgaC93KSBvZiB0aGUgdGVybWluYWwvU2VyaWFsUG9ydCB1c2VkIGZvciAN
CisJICAgcmVtb3RlIGRlYnVnZ2luZywgc28gdGhhdCB3ZSBzdGFydCB3aXRo
IGEgY2xlYW4gc2xhdGUgKi8NCisJY2xlYXJSZWNpZXZlRGF0YUJ1ZmZlckdE
QigpOw0KIAkvKiByZXBseSB0byBob3N0IHRoYXQgYW4gZXhjZXB0aW9uIGhh
cyBvY2N1cnJlZCAqLw0KIAlyZW1jb21PdXRCdWZmZXJbMF0gPSAnUyc7DQog
CXJlbWNvbU91dEJ1ZmZlclsxXSA9ICBoZXhjaGFyc1tzaWdubyA+PiA0XTsN
CkBAIC0xMDQzLDYgKzEwNDksMTcgQEANCiAJCQljYXNlICdFJzoNCiAJCQkJ
LyogUHJpbnQgZXhjZXB0aW9uIGluZm8gKi8NCiAJCQkJcHJpbnRleGNlcHRp
b25pbmZvKGV4Y2VwdGlvblZlY3RvciwgZXJyX2NvZGUsIHJlbWNvbU91dEJ1
ZmZlcik7DQorCQkJCWJyZWFrOw0KKw0KKwkJCWNhc2UgJ08nOg0KKwkJCQkv
KiBnZXQgU2VjdGlvbiBvZmZzZXRzICovDQorCQkJCS8qIGdkYidzIHN5bWJv
bCBpbmZvIHNlZW1zIHRvIGJlIGdldHRpbmcgY29ycnVwdGVkIGFmdGVyIA0K
KwkJCQkgICB0aGlzIGNvbW1hbmQsIGV2ZW4gcHBjIGd1eXMgaGF2ZSBtZW50
aW9uZWQgdGhpcy4gDQorCQkJCSAgIE9uZSBpcyByZXF1aXJlZCB0byByZWxv
YWQgdXNpbmcgc3ltYm9sLWZpbGUgY21kICovDQorCQkJCS8qIC5kYXRhIChv
ciBzZGF0YSkgY3VycmVudGx5IGNvcnJlc3BvbmQgdG8gZ2R0X3RhYmxlICov
DQorCQkJCXNwcmludGYocmVtY29tT3V0QnVmZmVyLCANCisJCQkJICAiVGV4
dD0lOC44eDtEYXRhPSU4Ljh4O0Jzcz0lOC44eCIsDQorCQkJCSAgKGludCkm
c3RleHQsIChpbnQpJmdkdF90YWJsZSwgKGludCkmX19ic3Nfc3RhcnQpOw0K
IAkJCQlicmVhazsNCiAJCQl9DQogCQkJYnJlYWs7DQpkaWZmIC1OYXVyIGxp
bnV4LTIuNC4zLWtnZGIvZHJpdmVycy9jaGFyL2dkYnNlcmlhbC5jIGxpbnV4
LTIuNC4zLWtnZGItaGFua3ZjL2RyaXZlcnMvY2hhci9nZGJzZXJpYWwuYw0K
LS0tIGxpbnV4LTIuNC4zLWtnZGIvZHJpdmVycy9jaGFyL2dkYnNlcmlhbC5j
CVN1biBBcHIgMjkgMjE6MjU6MjAgMjAwMQ0KKysrIGxpbnV4LTIuNC4zLWtn
ZGItaGFua3ZjL2RyaXZlcnMvY2hhci9nZGJzZXJpYWwuYwlNb24gQXByIDMw
IDAyOjE0OjE1IDIwMDENCkBAIC0yNzgsMyArMjc4LDI1IEBADQogDQogfSAv
KiBwdXREZWJ1Z0NoYXIgKi8NCiANCisvKg0KKyAqIENsZWFyIHRoZSBSZWNp
ZXZlIHNvZnR3YXJlIGFuZCBoYXJkd2FyZSBidWZmZXJzDQorICovDQordm9p
ZCBjbGVhclJlY2lldmVEYXRhQnVmZmVyR0RCKHZvaWQpDQorew0KKyAgaW50
IGlDdXI7DQorDQorI2lmZGVmIFBSTlQNCisgIHByaW50aygiY2xlYXJSZWNp
ZXZlRGF0YUJ1ZmZlckdEQjogRW50ZXJpbmcgXG4iKTsNCisjZW5kaWYNCisg
IC8qIHdoaWxlKChpQ3VyPXJlYWRfZGF0YV9iZnIoKSkgIT0gLTEpICovDQor
ICB3aGlsZSgoaUN1cj1yZWFkX2NoYXIoKSkgIT0gLTEpIA0KKyNpZmRlZiBQ
Uk5UDQorICAgIHByaW50aygiY2xlYXJSZWNpZXZlRGF0YUJ1ZmZlckdEQjog
cmVhZCAlYyBcbiIsaUN1cik7DQorI2Vsc2UNCisgICAgOw0KKyNlbmRpZg0K
KyNpZmRlZiBQUk5UDQorICBwcmludGsoImNsZWFyUmVjaWV2ZURhdGFCdWZm
ZXJHREI6IExlYXZpbmcgXG4iKTsNCisjZW5kaWYNCit9DQorDQo=
---1463769086-2108580470-988625565=:1474--
