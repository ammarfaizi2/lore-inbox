Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBHUy5>; Thu, 8 Feb 2001 15:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbRBHUys>; Thu, 8 Feb 2001 15:54:48 -0500
Received: from d216.as5200.mesatop.com ([208.164.122.216]:5512 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S129031AbRBHUyl>; Thu, 8 Feb 2001 15:54:41 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
Date: Thu, 8 Feb 2001 13:57:19 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_J7IGKFEMIQT5H80WXTFU"
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] modify ver_linux to check e2fsprogs and more.
MIME-Version: 1.0
Message-Id: <01020813571906.04066@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_J7IGKFEMIQT5H80WXTFU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

I have modified the scripts/ver_linux script to provide the following:

1) The order of version checks is now the same as the list in the
   Current Minimal Requirements section of Documentation/Changes
   for easier comparison.
2) Made capitalization  consistent with the list in Changes.
3) Added version check for ext2 utils (e2fsprogs).
4) Added version check for pcmcia utils (pcmcia-cs).
5) Added version check for pppd (PPP).
6) Added version check for isdn utils (isdn4k-utils).
7) Added whitespace for better readability.

Due to the extensive rewriting, the patch against 2.4.1-ac6 is
larger than the ver_linux script itself.  I will include the proposed
new version of ver_linux here inline, and I will attach the patch itself,
which isn't as readable. This patch should apply against -ac5 and -ac7 also.

Here is the output of the current ver_linux for my system:

[root@localhost scripts]# ./ver_linux.orig
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux localhost.localdomain 2.4.1-ac6 #1 Thu Feb 8 06:30:46 MST 2001 i686 unknown
Kernel modules         2.4.2
Gnu C                  2.95.3
Gnu Make               3.79.1
Binutils               2.10.0.24
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.7
Mount                  2.10o
Net-tools              1.57
Console-tools          0.2.3
Reiserfsprogs          3.x.0b
Sh-utils               2.0
Modules Loaded

Here is the output of the new ver_linux:

[root@localhost scripts]# ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux localhost.localdomain 2.4.1-ac6 #1 Thu Feb 8 06:30:46 MST 2001 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.0.24
util-linux             2.10o
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0b
pcmcia-cs              3.1.24
PPP                    2.4.0
isdn4k-utils           3.1beta7
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded

This output can be compared with the list in Documentation/Changes:

o  Gnu C                  2.91.66                 # gcc --version
o  Gnu make               3.77                    # make --version
o  binutils               2.9.1.0.25              # ld -v
o  util-linux             2.10o                   # fdformat --version
o  modutils               2.4.2                   # insmod -V
o  e2fsprogs              1.19                    # tune2fs
o  reiserfsprogs          3.x.0b                  # reiserfsck 2>&1|grep reiserfsprogs
o  pcmcia-cs              3.1.21                  # cardmgr -V
o  PPP                    2.4.0                   # pppd --version
o  isdn4k-utils           3.1pre1                 # isdnctrl 2>&1|grep version

Here is the proposed new version of ver_linux, patch against 2.4.1-ac6 attached.

#!/bin/sh
# Before running this script please ensure that your PATH is
# typical as you use for compilation/istallation. I use
# /bin /sbin /usr/bin /usr/sbin /usr/local/bin, but it may
# differ on your system.
#
PATH=/sbin:/usr/sbin:/bin:/usr/bin:$PATH
echo 'If some fields are empty or look unusual you may have an old version.'
echo 'Compare to the current minimal requirements in Documentation/Changes.'
echo ' '

uname -a
echo ' '

echo "Gnu C                 " `gcc --version`

make --version 2>&1 | awk -F, '{print $1}' | awk \
      '/GNU Make/{print "Gnu make              ",$NF}'

ld -v 2>&1 | awk -F\) '{print $1}' | awk \
      '/BFD/{print "binutils              ",$NF}'

mount --version | awk -F\- '{print "util-linux            ", $NF}'

insmod -V  2>&1 | awk 'NR==1 {print "modutils              ",$NF}'

tune2fs 2>&1 | grep tune2fs | sed 's/,//' |  awk \
'NR==1 {print "e2fsprogs             ", $2}'

reiserfsck 2>&1 | grep reiserfsprogs | awk \
'NR==1{print "reiserfsprogs         ", $NF}'

cardmgr -V 2>&1| grep version | awk \
'NR==1{print "pcmcia-cs             ", $3}'

pppd --version 2>&1| grep version | awk \
'NR==1{print "PPP                   ", $3}'

isdnctrl 2>&1 | grep version | awk \
'NR==1{print "isdn4k-utils          ", $NF}'

ls -l `ldd /bin/sh | awk '/libc/{print $3}'` | sed \
-e 's/\.so$//' | awk -F'[.-]'   '{print "Linux C Library        " \
$(NF-2)"."$(NF-1)"."$NF}'

ldd -v > /dev/null 2>&1 && ldd -v || ldd --version |head -1 | awk \
'NR==1{print "Dynamic linker (ldd)  ", $NF}'

ls -l /usr/lib/lib{g,stdc}++.so  2>/dev/null | awk -F. \
       '{print "Linux C++ Library      " $4"."$5"."$6}'

ps --version 2>&1 | awk 'NR==1{print "Procps                ", $NF}'

hostname -V 2>&1 | awk 'NR==1{print "Net-tools             ", $NF}'

# Kbd needs 'loadkeys -h',
loadkeys -h 2>&1 | awk \
'(NR==1 && ($3 !~ /option/)) {print "Kbd                   ", $3}'

# while console-tools needs 'loadkeys -V'.
loadkeys -V 2>&1 | awk \
'(NR==1 && ($2 ~ /console-tools/)) {print "Console-tools         ", $3}'

expr --v 2>&1 | awk 'NR==1{print "Sh-utils              ", $NF}'

X=`cat /proc/modules | sed -e "s/ .*$//"`
echo "Modules Loaded         "$X

--------------Boundary-00=_J7IGKFEMIQT5H80WXTFU
Content-Type: text/english;
  name="patch-ver_linux"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch-ver_linux"

LS0tIGxpbnV4L3NjcmlwdHMvdmVyX2xpbnV4Lm9yaWcJVGh1IEZlYiAgOCAwNjozMzo1MiAyMDAx
CisrKyBsaW51eC9zY3JpcHRzL3Zlcl9saW51eAlUaHUgRmViICA4IDEzOjM4OjIzIDIwMDEKQEAg
LTUsMzIgKzUsNjMgQEAKICMgZGlmZmVyIG9uIHlvdXIgc3lzdGVtLgogIwogUEFUSD0vc2Jpbjov
dXNyL3NiaW46L2JpbjovdXNyL2JpbjokUEFUSAotZWNobyAnLS0gVmVyc2lvbnMgaW5zdGFsbGVk
OiAoaWYgc29tZSBmaWVsZHMgYXJlIGVtcHR5IG9yIGxvb2snCi1lY2hvICctLSB1bnVzdWFsIHRo
ZW4gcG9zc2libHkgeW91IGhhdmUgdmVyeSBvbGQgdmVyc2lvbnMpJworZWNobyAnSWYgc29tZSBm
aWVsZHMgYXJlIGVtcHR5IG9yIGxvb2sgdW51c3VhbCB5b3UgbWF5IGhhdmUgYW4gb2xkIHZlcnNp
b24uJworZWNobyAnQ29tcGFyZSB0byB0aGUgY3VycmVudCBtaW5pbWFsIHJlcXVpcmVtZW50cyBp
biBEb2N1bWVudGF0aW9uL0NoYW5nZXMuJworZWNobyAnICcKKwogdW5hbWUgLWEKLWluc21vZCAt
ViAgMj4mMSB8IGF3ayAnTlI9PTEge3ByaW50ICJLZXJuZWwgbW9kdWxlcyAgICAgICAgIiwkTkZ9
JworZWNobyAnICcKKwogZWNobyAiR251IEMgICAgICAgICAgICAgICAgICIgYGdjYyAtLXZlcnNp
b25gCisKIG1ha2UgLS12ZXJzaW9uIDI+JjEgfCBhd2sgLUYsICd7cHJpbnQgJDF9JyB8IGF3ayBc
Ci0gICAgICAnL0dOVSBNYWtlL3twcmludCAiR251IE1ha2UgICAgICAgICAgICAgICIsJE5GfScK
KyAgICAgICcvR05VIE1ha2Uve3ByaW50ICJHbnUgbWFrZSAgICAgICAgICAgICAgIiwkTkZ9Jwor
CiBsZCAtdiAyPiYxIHwgYXdrIC1GXCkgJ3twcmludCAkMX0nIHwgYXdrIFwKLSAgICAgICcvQkZE
L3twcmludCAiQmludXRpbHMgICAgICAgICAgICAgICIsJE5GfScKLWxzIC1sIGBsZGQgL2Jpbi9z
aCB8IGF3ayAnL2xpYmMve3ByaW50ICQzfSdgIHwgc2VkIC1lICdzL1wuc28kLy8nIFwKLSAgfCBh
d2sgLUYnWy4tXScgICAne3ByaW50ICJMaW51eCBDIExpYnJhcnkgICAgICAgICIgJChORi0yKSIu
IiQoTkYtMSkiLiIkTkZ9JwotZWNobyAtbiAiRHluYW1pYyBsaW5rZXIgICAgICAgICAiCi1sZGQg
LXYgPiAvZGV2L251bGwgMj4mMSAmJiBsZGQgLXYgfHwgbGRkIC0tdmVyc2lvbiB8aGVhZCAtMQor
ICAgICAgJy9CRkQve3ByaW50ICJiaW51dGlscyAgICAgICAgICAgICAgIiwkTkZ9JworCittb3Vu
dCAtLXZlcnNpb24gfCBhd2sgLUZcLSAne3ByaW50ICJ1dGlsLWxpbnV4ICAgICAgICAgICAgIiwg
JE5GfScKKworaW5zbW9kIC1WICAyPiYxIHwgYXdrICdOUj09MSB7cHJpbnQgIm1vZHV0aWxzICAg
ICAgICAgICAgICAiLCRORn0nCisKK3R1bmUyZnMgMj4mMSB8IGdyZXAgdHVuZTJmcyB8IHNlZCAn
cy8sLy8nIHwgIGF3ayBcCisnTlI9PTEge3ByaW50ICJlMmZzcHJvZ3MgICAgICAgICAgICAgIiwg
JDJ9JworCityZWlzZXJmc2NrIDI+JjEgfCBncmVwIHJlaXNlcmZzcHJvZ3MgfCBhd2sgXAorJ05S
PT0xe3ByaW50ICJyZWlzZXJmc3Byb2dzICAgICAgICAgIiwgJE5GfScKKworY2FyZG1nciAtViAy
PiYxfCBncmVwIHZlcnNpb24gfCBhd2sgXAorJ05SPT0xe3ByaW50ICJwY21jaWEtY3MgICAgICAg
ICAgICAgIiwgJDN9JworCitwcHBkIC0tdmVyc2lvbiAyPiYxfCBncmVwIHZlcnNpb24gfCBhd2sg
XAorJ05SPT0xe3ByaW50ICJQUFAgICAgICAgICAgICAgICAgICAgIiwgJDN9JworCitpc2RuY3Ry
bCAyPiYxIHwgZ3JlcCB2ZXJzaW9uIHwgYXdrIFwKKydOUj09MXtwcmludCAiaXNkbjRrLXV0aWxz
ICAgICAgICAgICIsICRORn0nCisKK2xzIC1sIGBsZGQgL2Jpbi9zaCB8IGF3ayAnL2xpYmMve3By
aW50ICQzfSdgIHwgc2VkIFwKKy1lICdzL1wuc28kLy8nIHwgYXdrIC1GJ1suLV0nICAgJ3twcmlu
dCAiTGludXggQyBMaWJyYXJ5ICAgICAgICAiIFwKKyQoTkYtMikiLiIkKE5GLTEpIi4iJE5GfScK
KworbGRkIC12ID4gL2Rldi9udWxsIDI+JjEgJiYgbGRkIC12IHx8IGxkZCAtLXZlcnNpb24gfGhl
YWQgLTEgfCBhd2sgXAorJ05SPT0xe3ByaW50ICJEeW5hbWljIGxpbmtlciAobGRkKSAgIiwgJE5G
fScKKwogbHMgLWwgL3Vzci9saWIvbGlie2csc3RkY30rKy5zbyAgMj4vZGV2L251bGwgfCBhd2sg
LUYuIFwKICAgICAgICAne3ByaW50ICJMaW51eCBDKysgTGlicmFyeSAgICAgICIgJDQiLiIkNSIu
IiQ2fScKKwogcHMgLS12ZXJzaW9uIDI+JjEgfCBhd2sgJ05SPT0xe3ByaW50ICJQcm9jcHMgICAg
ICAgICAgICAgICAgIiwgJE5GfScKLW1vdW50IC0tdmVyc2lvbiB8IGF3ayAtRlwtICd7cHJpbnQg
Ik1vdW50ICAgICAgICAgICAgICAgICAiLCAkTkZ9JworCiBob3N0bmFtZSAtViAyPiYxIHwgYXdr
ICdOUj09MXtwcmludCAiTmV0LXRvb2xzICAgICAgICAgICAgICIsICRORn0nCisKICMgS2JkIG5l
ZWRzICdsb2Fka2V5cyAtaCcsCiBsb2Fka2V5cyAtaCAyPiYxIHwgYXdrIFwKICcoTlI9PTEgJiYg
KCQzICF+IC9vcHRpb24vKSkge3ByaW50ICJLYmQgICAgICAgICAgICAgICAgICAgIiwgJDN9Jwor
CiAjIHdoaWxlIGNvbnNvbGUtdG9vbHMgbmVlZHMgJ2xvYWRrZXlzIC1WJy4KIGxvYWRrZXlzIC1W
IDI+JjEgfCBhd2sgXAogJyhOUj09MSAmJiAoJDIgfiAvY29uc29sZS10b29scy8pKSB7cHJpbnQg
IkNvbnNvbGUtdG9vbHMgICAgICAgICAiLCAkM30nCi1yZWlzZXJmc2NrIC0tYm9ndXNhcmcgMj4m
MSB8IGdyZXAgcmVpc2VyZnNwcm9ncyB8IGF3ayBcCi0nTlI9PTF7cHJpbnQgIlJlaXNlcmZzcHJv
Z3MgICAgICAgICAiLCAkTkZ9JworCiBleHByIC0tdiAyPiYxIHwgYXdrICdOUj09MXtwcmludCAi
U2gtdXRpbHMgICAgICAgICAgICAgICIsICRORn0nCisKIFg9YGNhdCAvcHJvYy9tb2R1bGVzIHwg
c2VkIC1lICJzLyAuKiQvLyJgCiBlY2hvICJNb2R1bGVzIExvYWRlZCAgICAgICAgICIkWAo=

--------------Boundary-00=_J7IGKFEMIQT5H80WXTFU--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
