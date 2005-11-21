Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbVKULR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbVKULR3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 06:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVKULR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 06:17:29 -0500
Received: from moutvdom.kundenserver.de ([212.227.126.249]:39878 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932247AbVKULR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 06:17:28 -0500
Message-ID: <4381ACC7.70708@anagramm.de>
Date: Mon, 21 Nov 2005 12:17:27 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Massimiliano Hofer <max@bbs.cc.uniud.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.14.2 - Hard link count is wrong
References: <437E2494.6010005@anagramm.de> <4380914C.1010903@gentoo.org> <200511201614.09858.max@bbs.cc.uniud.it> <200511201927.43430.max@bbs.cc.uniud.it>
In-Reply-To: <200511201927.43430.max@bbs.cc.uniud.it>
Content-Type: multipart/mixed;
 boundary="------------020008060801080806020503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020008060801080806020503
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello, Massimiliano, Hi Daniel!

Massimiliano Hofer wrote:
> I'm back. First of all I beg your pardon for blaming 2.6.14.2, I forgot I 
> rebooted with 2.6.13.4.

I'm indeed working on 2.6.14.2 and I get the problem with findutils 4.2.20 and
up. I've checked my system's reiserfs partition... no problems. Otherwise,
the machine is pretty simple:
/$ mount
/dev/hda1 on / type reiserfs (rw)
devpts on /dev/pts type devpts (rw)

/$ find --version
GNU find version 4.2.20
Features enabled: D_TYPE O_NOFOLLOW(enabled)

/$ find |grep smb.conf
./etc/samba/smb.conf.default
./etc/samba/smb.conf
./usr/man/man5/smb.conf.5.gz
find: WARNING: Hard link count is wrong for .: this may be a bug in your filesystem driver.  Automatically turning on find's -noleaf option.  Earlier results may have failed to include directories that should have been searched.

And after an update to stock:

/$ find --version
GNU find version 4.2.26
Features enabled: D_TYPE O_NOFOLLOW(enabled) LEAF_OPTIMISATION

It's still the same:

/$ find |grep smb.conf
./etc/samba/smb.conf.default
./etc/samba/smb.conf
./usr/man/man5/smb.conf.5.gz
find: WARNING: Hard link count is wrong for .: this may be a bug in your filesystem driver.  Automatically turning on find's -noleaf option.  Earlier results may have failed to include directories that should have been searched.

The Patch, Daniel mentioned didn't make it into the latest findutils-4.2.26, but if
I re-apply it manually (attachment), it tells me:

/$ find --version
GNU find version 4.2.26-ck
Features enabled: D_TYPE O_NOFOLLOW(enabled) LEAF_OPTIMISATION

/$ find |grep smb.conf
./etc/samba/smb.conf.default
./etc/samba/smb.conf
./usr/man/man5/smb.conf.5.gz
find: WARNING: Hard link count (44) is wrong for ./proc: this may be a bug in your filesystem driver.  Automatically turning on fid's -noleaf option.  Earlier results may have failed to include directories that should have been searched.

So, I guess that something in /proc is messed up a little.
Anymore checks I can do?

> Anyway I couldn't reproduce the bug in 2.6.14.2, but it is easily reproducible 
> with 2.6.13.4.
> Compiling pcmcia in the kernel (but leaving yenta and 8139too as a module) I 
> never get errors on /proc/bus, but I get the same results on /proc/bus/pci.
> It seems a broader hotplug problem. Of corse it could be already solved in 
> 2.6.14, as I can't reproduce it.

Well, I don't think so. I can easily reproduce that on my machine here:

$ uname -a
Linux zefix 2.6.14.2 #2 Tue Nov 15 19:08:57 CET 2005 i686 unknown unknown GNU/Linux

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 300.715
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 602.39

$ cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Class 0600: PCI device 8086:7180 (rev 3).
      Master Capable.  Latency=64.
      Prefetchable 32 bit memory at 0xe4000000 [0xe7ffffff].
  Bus  0, device   1, function  0:
    Class 0604: PCI device 8086:7181 (rev 3).
      Master Capable.  Latency=64.  Min Gnt=8.
  Bus  0, device   4, function  0:
    Class 0601: PCI device 8086:7110 (rev 2).
  Bus  0, device   4, function  1:
    Class 0101: PCI device 8086:7111 (rev 1).
      Master Capable.  Latency=32.
      I/O at 0xb800 [0xb80f].
  Bus  0, device   4, function  2:
    Class 0c03: PCI device 8086:7112 (rev 1).
      IRQ 5.
      Master Capable.  Latency=32.
      I/O at 0xb400 [0xb41f].
  Bus  0, device   4, function  3:
    Class 0680: PCI device 8086:7113 (rev 2).
      IRQ 9.
  Bus  0, device  10, function  0:
    Class 0200: PCI device 10ec:8139 (rev 16).
      IRQ 10.
      Master Capable.  Latency=33.  Min Gnt=32.Max Lat=64.
      I/O at 0xb000 [0xb0ff].
      Non-prefetchable 32 bit memory at 0xe1800000 [0xe18000ff].
  Bus  0, device  13, function  0:
    Class 0401: PCI device 1274:5880 (rev 2).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=12.Max Lat=128.
      I/O at 0xa800 [0xa83f].
  Bus  1, device   0, function  0:
    Class 0300: PCI device 1002:475a (rev 58).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xe3000000 [0xe3ffffff].
      I/O at 0xd800 [0xd8ff].
      Non-prefetchable 32 bit memory at 0xe2000000 [0xe2000fff].

Hmm, okay, I see, the PCIID's are missing. :-(
That's basically a Intel PIIX4 chipset, RTL8139, and a ATI Rage II card.
Can we narrow down the problem a little? Hmm, do you need more info?

Thanks so far,
best greets,
-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19

--------------020008060801080806020503
Content-Type: text/plain;
 name="be-specific-about-hardlink-counts-4.2.26.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="be-specific-about-hardlink-counts-4.2.26.patch"

LS0tIGZpbmR1dGlscy00LjIuMjYvZmluZC9maW5kLmN+CTIwMDUtMTEtMTEgMDg6NDE6Mzcu
MDAwMDAwMDAwICswMTAwCisrKyBmaW5kdXRpbHMtNC4yLjI2L2ZpbmQvZmluZC5jCTIwMDUt
MTEtMjEgMTE6NDc6MzUuMDAwMDAwMDAwICswMTAwCkBAIC0xOTQ3LDggKzE5NDcsOCBAQCBw
cm9jZXNzX2RpciAoY2hhciAqcGF0aG5hbWUsIGNoYXIgKm5hbWUsCiAJCSAgICogZG9lc24n
dCByZWFsbHkgaGFuZGxlIGhhcmQgbGlua3Mgd2l0aCBVbml4IHNlbWFudGljcy4KIAkJICAg
KiBJbiB0aGUgbGF0dGVyIGNhc2UsIC1ub2xlYWYgc2hvdWxkIGJlIHVzZWQgcm91dGluZWx5
LgogCQkgICAqLwotCQkgIGVycm9yKDAsIDAsIF8oIldBUk5JTkc6IEhhcmQgbGluayBjb3Vu
dCBpcyB3cm9uZyBmb3IgJXM6IHRoaXMgbWF5IGJlIGEgYnVnIGluIHlvdXIgZmlsZXN5c3Rl
bSBkcml2ZXIuICBBdXRvbWF0aWNhbGx5IHR1cm5pbmcgb24gZmluZCdzIC1ub2xlYWYgb3B0
aW9uLiAgRWFybGllciByZXN1bHRzIG1heSBoYXZlIGZhaWxlZCB0byBpbmNsdWRlIGRpcmVj
dG9yaWVzIHRoYXQgc2hvdWxkIGhhdmUgYmVlbiBzZWFyY2hlZC4iKSwKLQkJCXBhcmVudCk7
CisJCSAgZXJyb3IoMCwgMCwgXygiV0FSTklORzogSGFyZCBsaW5rIGNvdW50ICglZCkgaXMg
d3JvbmcgZm9yICVzOiB0aGlzIG1heSBiZSBhIGJ1ZyBpbiB5b3VyIGZpbGVzeXN0ZW0gZHJp
dmVyLiAgQXV0b21hdGljYWxseSB0dXJuaW5nIG9uIGZpbmQncyAtbm9sZWFmIG9wdGlvbi4g
IEVhcmxpZXIgcmVzdWx0cyBtYXkgaGF2ZSBmYWlsZWQgdG8gaW5jbHVkZSBkaXJlY3Rvcmll
cyB0aGF0IHNob3VsZCBoYXZlIGJlZW4gc2VhcmNoZWQuIiksCisJCQlzdGF0cC0+c3Rfbmxp
bmssIHBhdGhuYW1lKTsKIAkJICBzdGF0ZS5leGl0X3N0YXR1cyA9IDE7IC8qIFdlIGtub3cg
dGhlIHJlc3VsdCBpcyB3cm9uZywgbm93ICovCiAJCSAgb3B0aW9ucy5ub19sZWFmX2NoZWNr
ID0gdHJ1ZTsJLyogRG9uJ3QgbWFrZSBzYW1lCiAJCQkJCQkgICBtaXN0YWtlIGFnYWluICov
Cg==
--------------020008060801080806020503--
