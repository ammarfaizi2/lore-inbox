Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267205AbUHYMTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267205AbUHYMTM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 08:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267223AbUHYMTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 08:19:12 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:21008 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267205AbUHYMSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 08:18:51 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Greg KH <greg@kroah.com>
Subject: devfs -> udev transition: vcsN are not created
Date: Wed, 25 Aug 2004 15:17:31 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_7T403EECYGPUFX7JTTYB"
Message-Id: <200408251517.31608.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_7T403EECYGPUFX7JTTYB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am migrating my 2.6 systems from devfs to udev.
Versions:

# uname -a
Linux firebird 2.6.7-bk20 #6 Mon Jul 12 01:23:31 EEST 2004 i686 unknown
# ls -d udev* hotplug*
hotplug-2004_04_01  udev-030

In early boot, when root fs is readonly yet, I start udev this way:

mount -t ramfs none /dev
env - udevd & sleep 1
udevstart

and then continue as normal. Things mostly work.
However, I noticed that vcsN device nodes are missing
(I tried to start Midnight Commander and it failed).
This can be due to the fact that I start agettys very
late in boot sequence, and thus all ttyN's were not
open at the time of udevstart, only first one was (tty1).

I logged in and did:

# ls -l /udev >before
# strace -o us.log udevstart
# ls -l /udev >after
# diff -u before after >diff

This worked, vcsN's appeared:

--- before      Wed Aug 25 14:52:42 2004
+++ after       Wed Aug 25 14:53:10 2004
@@ -1,4 +1,6 @@
 total 0
+crw-------    1 root     root      10, 175 Aug 25 14:53 agpgart
+lrwxrwxrwx    1 root     root            3 Aug 25 14:53 cdrom -> hdb
 crw-------    1 root     root       5,   1 Aug 25  2004 console
 brw-------    1 root     root       2,   0 Aug 25  2004 fd0
 crw-------    1 root     root       1,   7 Aug 25  2004 full
@@ -10,6 +12,7 @@
 brw-------    1 root     root       3,   4 Aug 25  2004 hda4
 brw-------    1 root     root       3,  64 Aug 25  2004 hdb
 crw-------    1 root     root      10, 183 Aug 25  2004 hw_random
+drwxr-xr-x    2 root     root            0 Aug 25 14:53 input
 crw-------    1 root     root       1,   2 Aug 25  2004 kmem
 crw-------    1 root     root       1,  11 Aug 25  2004 kmsg
 srw-rw-rw-    1 root     root            0 Aug 25 14:52 log
@@ -52,7 +55,7 @@
 crw-------    1 root     root       4,   1 Aug 25  2004 tty1
 crw-------    1 root     root       4,  10 Aug 25  2004 tty10
 crw-------    1 root     root       4,  11 Aug 25 14:52 tty11
-crw-------    1 root     root       4,  12 Aug 25 14:52 tty12
+crw-------    1 root     root       4,  12 Aug 25 14:53 tty12
 crw-------    1 root     root       4,  13 Aug 25  2004 tty13
 crw-------    1 root     root       4,  14 Aug 25  2004 tty14
 crw-------    1 root     root       4,  15 Aug 25  2004 tty15
@@ -60,7 +63,7 @@
 crw-------    1 root     root       4,  17 Aug 25  2004 tty17
 crw-------    1 root     root       4,  18 Aug 25  2004 tty18
 crw-------    1 root     root       4,  19 Aug 25  2004 tty19
-crw--w----    1 root     tty        4,   2 Aug 25 14:52 tty2
+crw-------    1 root     tty        4,   2 Aug 25 14:53 tty2
 crw-------    1 root     root       4,  20 Aug 25  2004 tty20
 crw-------    1 root     root       4,  21 Aug 25  2004 tty21
 crw-------    1 root     root       4,  22 Aug 25  2004 tty22
@@ -163,6 +166,24 @@
 crw-------    1 root     root       1,   9 Aug 25  2004 urandom
 crw-------    1 root     root       7,   0 Aug 25  2004 vcs
 crw-------    1 root     root       7,   1 Aug 25  2004 vcs1
+crw-------    1 root     root       7,  11 Aug 25 14:53 vcs11
+crw-------    1 root     root       7,  12 Aug 25 14:53 vcs12
+crw-------    1 root     root       7,   2 Aug 25 14:53 vcs2
+crw-------    1 root     root       7,   3 Aug 25 14:53 vcs3
+crw-------    1 root     root       7,   4 Aug 25 14:53 vcs4
+crw-------    1 root     root       7,   5 Aug 25 14:53 vcs5
+crw-------    1 root     root       7,   6 Aug 25 14:53 vcs6
+crw-------    1 root     root       7,   7 Aug 25 14:53 vcs7
+crw-------    1 root     root       7,   8 Aug 25 14:53 vcs8
 crw-------    1 root     root       7, 128 Aug 25  2004 vcsa
 crw-------    1 root     root       7, 129 Aug 25  2004 vcsa1
+crw-------    1 root     root       7, 139 Aug 25 14:53 vcsa11
+crw-------    1 root     root       7, 140 Aug 25 14:53 vcsa12
+crw-------    1 root     root       7, 130 Aug 25 14:53 vcsa2
+crw-------    1 root     root       7, 131 Aug 25 14:53 vcsa3
+crw-------    1 root     root       7, 132 Aug 25 14:53 vcsa4
+crw-------    1 root     root       7, 133 Aug 25 14:53 vcsa5
+crw-------    1 root     root       7, 134 Aug 25 14:53 vcsa6
+crw-------    1 root     root       7, 135 Aug 25 14:53 vcsa7
+crw-------    1 root     root       7, 136 Aug 25 14:53 vcsa8
 crw-------    1 root     root       1,   5 Aug 25  2004 zero

Strace and syslog are in attached tarball.

PS. Also mouse doesn't paste in console, but let's handle
it one at a time.
--
vda
--------------Boundary-00=_7T403EECYGPUFX7JTTYB
Content-Type: application/x-tbz;
  name="info.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="info.tar.bz2"

QlpoOTFBWSZTWVMYLdsA6ZD/1P/8EUV/////f/////////4ECEAAAACACGBC3vn28HpZ8Dh4MfXh
3zedpW3b0c3wr3C9A1XvYPvbLijvi9k3vt69pnuzfQu++8+wPvj7PNfA7eo+a226MHe9rz74Cg97
vQX3O7OdqBaBh2z2NOzXZ0dR7PThCHO57wxdq7K+ABfRyU6DSkql8Nn2vncrJlvR3V8w+uMd559H
31Tzj7gzvZXDRk2akpR3c7y17auvOZRZracAYTNJDIgQZqEyACAAygnknqao/UaT1D9KPaoGQHpP
UDag9QaZDQaIYaRCASaBGSmyaJpoHpMmI0AABoAaB6gHqGQCSaEImhATQTTaqemTynpI0eoANMgA
AAAAAAAEnqpIinoTU9U9PVNo1PU9Twpk000yYj1NBoAAAyAANGgANAiSQTQATEJkxAI0nkTVPT0m
aU9pppqaemKjPKempo1AbIIMj0ESQgTQRNI8RJ40pPDUn6T0pvVMaTNR6h6nkjQ9QaAGgAABn/gv
9v3z/D937vT6n8Ef5Z5JnWUQELaARD15ANkqJYD1FAaez1+zOxgDxAewc6HIymWdeCIg3t7Kzt34
NhIbrWVIWWCDYD2EsSIbVk2ilG29mtqs5trFaqkAAiskSAxVBiEQ5cf4/4O+78nD+/n+LRf868r9
OxbxLPFHd/weysmk1fy9G+4cO7u7h9uLzMzGMF8fZvfe94ziDjElmw8ze94iImIiSWZmZiSSSS7u
7u5JJJLu7u7kkkkl3d3dySSSS7u7u5JJJLv6Hd3qqJolmZmYkkkl3d3dyTe1iSSZJJLu7u7tGPnj
iPH6PphaWnsO35yIPg+iaU0yEf8buvP26JaOjM6dsPktUEcr8yw31ZQwlGULn2JKH7uvL5Bhf+HY
/MdBRNl8zd8X2x9/4fDaiVg2b8HZdSse5EDxj6G3YVSve7e7qY6WH339/v9Da9Bun8Hbr7duzg7W
5c7dWiAf4fs8eYVMiMlg2o9Hush+TWXSisnrdjCr90Akkdr09z+NWmclZDipJCSEgLmqpEAxpd8B
JFZACRWQTykOReXm4scTwOkzmYhmMxo7j0nQwYMGD2miyyyzg4MIBC9B9JyJ+g5lHUjFjOvOT4hR
9YkkDoaMmSyDqWdTqdTRowaNDNGjRo0aLNGjRJo0aNGijRo0aKNGjRok0aNGjRZo0aGaNGjYkgWD
JgZkyYIMmxsaNGjRg0aGaNGjRo0WaNGiTRo0aNFGjRo0UaNHxM9e86Hibm+9VtpNuwkTMzMjgfja
4AAQJ9fOc5znbJ0aAd3d3qqokk0kREREVVEkmkiIiIiqokkmkiIiIiqo2mZmkiKiIiqokk0kR5RE
RnOSck5Ad3DNVVUzNUkREREVYlBir1VVRmiSaSIiI8eblWuW1a71XlX33KgCQAAAAAADwsTZ6Fxk
BOc4kAHHIAQCIAcXACAQBxxACABAAttqXh36upZZEeJCWINQ8QMiEWx4b5MZCptNtNtNtNtNtNtN
tNtNtNtNtNtNtNtNtNtNtNtNtNtNtNtNiuEBUKYQCURQkAyt2naduOPJTPXlrdXbGLK554sAc73s
Ac6qUlrsuUlre7oS23xIjF522tJVVSl9q4gqboqJFgKgA8FiAgq+sRAeZgwvLFHD6d3q9hzFBG+K
KpXaFgBGyE++CiqY6f6QD7/roRHIS7z1QBPtpEuQGIEeaAiQEoGCkRgI2laVNWbStKlabK15d9r8
F4zoN2xc4/BRFN6VE39nS/JEbb/ffde049XZ3AdYAJI/CcHQDhFdVkHejsQASRt+4gkH276sh3VW
uyu7nv2Hf9N548/w/wo81xXn6A5Z+03nDS5ZVVfqldR38gFT7RUfKfhMQk9JzN/xY8DMQR7uHhw9
hyHKvTWmFRG5EUUKzAN/et6vRXPUKgCpHecpp8fPOQv5fe7rqb2tzoAIBeZXw/Bz1e7f5eF2+Lv8
z4KeFj/oWcRVB2km5/fru6kvvLWICAxirtJVtaTWlmpLJZLJZLJZLJZpZSpTKtVz5Pjz1+ANXf5W
0KEu585/pN/iM9Zk8NZlrUKICQimjnl49rXU1pK0laStJWKkhIQEzEzsWBIRUCQAZAbwB0y09uYD
DEaSCF1JQe0UVdlkyVcLWK+5K/oUUjE1lD0UcbHnLrzVPIAWYsDjb9tfv+FnPn3VkAImvOnWJ7Yd
FQEYYh2wkMWooID/WdNK5jszgi2ZgLlmoFUBEEJIIQtO5Hck+zcC8GBDnc9livi4ZCgl1KIGhpQG
sJAD3IjIaQxVGcDpFNMUF0FCC1BOJ9+9ify0Y2ysWgv50Xth8kG8DSG8Hj4a8elFGoqoN8FU74gg
nkMKT9Hwfhh69BrQ/H1ensn5Jfvk8NVk80wex1MKMDymwY02biFElHwOwyYLMEGAkkyMggZRRkkk
kkyIHqH3AowCAUVJSUwkiUhJSElChBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBGAQQoUE
EEMCCCCIBBFgQQQQQQQ4IIIuCCCCCCGBBBBFGxsbDGM2NilSpWpWlSKWAwbFmxsbHswHBEgEKBcE
MCCCKBAIIIIIIr63TkLDWSLlQrDzVnjT98K68o+mngHA/UEOuKjDmX26l8UFEGisiur9PRh3w1RO
Pscxf0ZYWM1FhUYGzHnzuOSqD+X02965VBpc8x7uyxd0PonHZoMAwk35zRUx+XBO8nbEzcLbPXfl
Aj7e7MXDhVXp293n8vswbWo29tJmAFTlXwf36LIaZ5f++ZVUKt4TpJDrvsh5uHC0ggB6xEFct7I/
f93ChG19tnFeDgMggGzYpciISBg40cvZ8oCpw/NjthsbVguUcfhoMp6IdhAMTlL78HsoWQu2/ouB
+SDzGkgkGurNUNTvyfREVVYeY23lweMqVUXw+T3+r5+biu+uWjtGtg9nXSXr+QGYW+WXuMzE6QOv
/m7x0SHzUX4V/mMtkNHkvzaD/1vO7bX9Hunf2HHenUNBgNyr8dC+t6rwc0IAZw6Ow/PADwQgEkbS
SF6nBSNeXTZwjkg8axfrfIAEkd8trxEcACakIAIbZq7ev1j8r7kSlrtEPSOqWyc/ZgH5BdawbFAK
q6xUCX16uFoAJI86hvIozn5afJmfN+TyxQEzEFXst8VsLE9mYFGwAnBkN/he7niPxxzdsQq6Rrz6
hkfY+si8dN23tExm7dCDDxQ69+1S3AGvfhKNMnfv6J8cxcHr+invv6+J079gcTsyA3XeK9GqlVU7
+AtH80d3ZrsWIGgW4dYyxe93PCx8AKg7ZJJ1LhIBLw855CkxYdTUjYTvy131uuNp/O68wBPYe/x9
QoygiB93jWK9vMC0AkfW8q+bpAjIr++/wrIAJIaehzyNKWAK7vQYfCnOnrEJuTpm/dAbm8MuqdfK
rZUCqAUxGfx+qrlprssH7f0Q/TojoFRDAaEBAG8DvxxtjXV0WAXR7/SsBZxEauL57SSQAdoQGEfi
mAcB5+PlWOHEZsrDcJ3AHp7Vhv3Bc/1X7KB499hABB8oDlXz7szTdmTcKaxVbMG7yq6akj3b+YVT
hZ7aZ9/QI8Khqm9ARM0REUDXOfHznW2krSVpK0lSlfLWym/UCqY+SqLnmYdc09tm31GzEdQhBghf
+awLtdhqx4viGCbW7nr8MQ7/K89vT16sCACDh46LRaur6ybdXERERERERERERERERET4fi69Pve/
8vw+89jeLt8Pf7PLzblTobPdCEIQh+L2V111Skl6cHYdVfZlCVtfVAXU3rg+ymiXKYmbLp9o6b9B
yFlV7l6VQUPXvmc5znOc5JJJJJJJJJJve9ySSSSSSSSSSSSSSSSSSSSSSSSSSSSSefTwqRERjpF/
8QAAEHq+xIL+HkHog8UL0Ce+71r9o+mPRckt27mRblHMqjHmrXVXnRfHl6PP0+r1+yCbEkklyTck
kliScEknBJJYkm5JMRDuqu5JJME2JJJLkm5JJLEk4JNrWJ9pBBJJPwSJEzMzOSSeVd/dMRD61qIk
xxxxta1scdOvWGjdpNnDmiA9svpVUPLvAVLX5gKlkVLWsIJ+Dr0lgUEyVE+DLMNMDa91QsKhahQS
gUEoRUzzaFR73ahCQDKCTfUrf46tI/N07Zxh1zUyu5/Nd1io/Y+6qg+L7QFS9PxwEkVkADbG17F5
XfblzhUtYVFApILIieq6KkAVP18fscQFT0m6KP/Wm0lxGjwIwljS/nqS3gEykuhcPjvSoBpqtb2/
K8V38omU8PYAwFrjrzXOrm2puly2rTmJFprUrQWJGMYJIxWQBl80ft+30S75/yVC7hl2fP2a5m93
2dXf8h9PHhXx/F6qyJEkeo7RzjOLBkHFS8KHjaEEC4vJTLGUElEEhIyVBISMGhjBjGUwhRRQUUUU
RIxI0UUFFFMIwiCWIKsIRgCE8j6j5dFUHPTzZZmp6AFTHb66PawUgRCMIBEhFBYFm2qjVmyoxGlt
I8EpAA8QGAgEIgkNhFQpSigpq5W5tykiIiIiIiIiIiIiJuTlv2lr56rx8vZqsCAQ0wcD9VZ5hJyy
9t3yd+j3dWhVB0ZbIyqUCgQThp/THD2bXWAqcQFTkqqHDLPorCJOkuNQp7AsJP6Pd579veMJX1iF
4ufgAAQUbpzBxJAuKCUdup8Gu9sVytM7+bP5xQEPkfsg0IqQiqqkgqAwBU8wCp/K4AQf2+/t1B0Q
zCo/L7aIAqQO/2fF0FyfhPL93nDrOXl4nqJG2wr+PSD5/q4gR0Ab+3gOkD2jo09Zd9eTrPPO5OSz
TwfOv1w16fL/TP17/oQRoL5tSj+fkNroAO5cfY254X8hw6hACD5VEgEGHiNnNkrP1Ho7YujHj763
QPtgrkSXC10bHiJDxU7yUOiIrFPCOZw9O7cO7GE6nwzVga89uux0BX8QLPd3TFT6gQCDKsfHd5TG
ivPuOzB/8iInhFU6xfXu3YgWvd6/4vkLP69GrZqzv7FIAIGYISCCHeEef26tebsy0dOZnwhBm8fS
JJJJH7PwLttz7+zuP2ALdlQeB8V7XsoQTZVVVWpB9w0s9u+ZaT6dayqqOHHGem2cSRJEkSRIhEQi
IDqb700FkC6saorlGKCpxb9UY5enrzGjRo0aNGjRo0aMEQhEIRCEQCpYPguGbHLPo0ykiSlKTnOd
KWrXfQjMJkMyszMzNKSJKUpOc50pM3Kyc1nOc5znKSJKUsbWtbHHTp5gqh16Dq2nHfSgtVJJJJJJ
JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB8q9zba+9pq1Xzvb7+b1+W2vHsAAAAAAB2+h4deW3
o1tb4PL5Xb1/J6dnfx4x4y7u5MeX+nnHS/2ar5dvTPMYXFhYWCoqoqBAnYdD4y5cgqDmdh5DI4Gx
wPEdh8BkZGRkbICN73vl2bmWWVstdPHpWISKhJJJAEIEgAJISMYCEKoZFqIiF7+5tjFuqVu2Dzy7
8oGQEKlwcGDc4ORuaODdf1JbG4qpHbfpyocLMbePJuy1MXtbXTHjxk7zz55flrk7u/iTa+GeJLu7
1nT5rQ6e+wQBB9tAiIPWAOYG5DoiIPDgfgQUDKSAtXtEYWKW0oVQYhDGEAVLVfN3AwlpfWO7WHX4
jPo7IlSs2uERxBr5zxrx4o82XV9gVVVMzPmbISE49MJCRURErRRaJCPd7xY2XCCXBFARk6LlUQEk
HLeIFOCa7t0ap62z489LkDBgwZmZmZmZmZmZmZmZma1mZzMzMzMzMzMzMzMzMzMzMJKKUeznzttr
spOlKW0o1K3PZq7JUqrtttttlSjKzMzMzNazUac5znOc7WnatKMzPe+c3UW1rn3SVVfpS99UIwnS
c6NdeLwwYMGZmZmZmZmZmZmZmZmYMzMzMzMzMzMzMzMzMzMzM1gJJAMhW/0faIWWWWPxa+Mg6wq8
YEiYaff1AVUP0c+muGNsftWvPPAsqIj+FrVQYQaP8rrCyLddDk9HBsSFrUMkJEREnyRb+MKAM/CB
3d4abOXnx19t7TSUQhpN1jNj9R/NPu+C7hMWosPHGnPGG9qMF8YQNTrwWuUVIy4KNHVag1gpiLYk
kjhATFCPz5lBMVJCRgQERJ58d9aWtjB4gop6o3LUjyg5EvHXgZWuIAD12tIlgZlvBcJUJUJYyWMl
jJYyWMlo3XOavZVpzlRvTzt5K8cM9UWkDByCzTGMYxjYf9rZQua5WbLMzMzu5anJXEzMzMzMxm2Q
AjTZ2CmmqaYwCb5VZDVg1GeEuLU6isGx1BZpjGMYxjGMYEY6K3MzPBy1c4buuszMzMzMzeeqZTTG
MY9RWJZbZfe1U899/f1UrW8t4I8Ke/G2eTl3f4pomxOeYhhXkAE6ANVPm2179gA6AOgUa2sBBOVx
FQscD0mLJNuHu5SQ9UT0MqCgj55IT8dVJV/IXvcwHH68WFQjIQkhigUExYuVlYRBvEAGQRRI20RG
0VFRUVFRUVG0lpKybJkiIiIiIiIiIiIiIiIiIskREREREREREREREREREEhISEhIyuEtIAeUHgcu
Bxt7Nvqtwm/Nmthw12Y6q4xjXKuqu+5LODr1UcoT8RULxxCYhwwERgMBgPWHDhw47YU2DM0dO3V2
y/aHxex6IFRQAoVJShkYmRkZzIyM5naTI+idYqNYFrRO3f6URBJFp7LK8cz06N16dZh37H3Wvhni
S7u9YpV22v/b0VERgip3T3uo9nifWSSETu1N963qVVVVVw7NrXLHWXv5NkozzyzJX0mAfSUh00wG
DSz6PM+jv7/N5/Cqc1rBjFXj6EkkC/tPD1/RyIIIIIlnyksiDq3ORE9XzV1XS+HbnIiIiInW5XER
GxERE5uVxERERETnddb5y7IiIiLtzkTtuVxERERETnXm5dq525ERERETrcvSukREYiInXb3OXauy
IiIiInNyuIiIiIic9v2uex7u+Z1vf67e77kvdru+OEaIRq8Z0Q5q92GST5wUHOCIIgiCERETquVx
ERERefnInVzbiIiIiInN49XbXbly5yIi5zkRE7b0bq6RiIiIidblxERF25yInW9PbtdkyIi5zlzn
MTtuXERGLrnXVxFISmi61EhISEhISzRPJf1mG/ftNmnHLt0bCBzEzMoPC7AoApeJIW18e9QJH92b
FUHNFCR0sL2c2KFCheL1GO7K63fBJ1Jrt3Ri8EPHkDBmDMoCiJCMIw1NbeuFww0FEQhKkFxtE1ko
2Ku0XVkO+Wz+j3emcBBsQIzCY8hIBIkJJbvk3yr19dijmYzlHu1nGSGjIGAAgW8I5+xoNG751zeS
7183BwV2YwFWRZ3wIz8MEraFcteqA9kIJN3u3JJuVVLPW8Ee3BiPGAOooXa+akLIAoPe0uI3b+qT
kVXhpXwTYtgk3ZIBTZQWmq4WXRJby3vfTQg50ixAAJhAJKvSbLNVgsFq1DjyAMYAYapZgKQ6CvTi
PHfeHf2zMzOV6dH0w9WL4a7Wta75xcNYeKF8jGEN72rfO+reFHuXN9Nxp971XHKIgmIwvgdoUbWt
tCEg9pRZ8BlmxyOpwdTB6jBgwV2xv2PF659nbnnntvnnAUMNpBkAZe0tr72DWWOtciFiApcYEDIo
SMjIoUFChQoIwfX7Zj6v5kAIgTYUqT2+kMDCIB4wU117cdW79ql3fwbWvhnh5d3wVIsW1SO44zgn
G7WmilcrFVVVVVcMnVOGAe/367SyCMgkoRg2WuFb0Vz3ornwPJDeEAIBogJIJoMeAdr6eRySHk6d
syztJnSmiNp1jEb3omtLRM6U0Q2EeyPePR7OjMQRe9D4EwwXIxsPJ0yhOltQoWF/juTVkO8x4cc+
MfDp3WUa6Z0TXBwOeaBAhTQvXOVZYij1vihQteU54YLiN/AvK1VryJFr0l8BfdT8LBxe8CBe+xFk
wwXoOTCYSZPfbGMjIvchUrkzhefu2EVVtaH9SKEQBE+Tl3iF7dG65Mu/iSSSR3tI2xuTg2uh1ZnU
Xtp7K3wvaZ2e2s5zqDJmZnC+wQMj2iBcEdxI2GQwYdwwYcVu+Jrfh8xTvx6EKw9WuGRRAUXChUkO
HEBxAoUKFD7AUE0G+IIAEUSdjYCHx28+nXffHZ2b6xjHbs5mrjKMaoxrrFsrY8ANm/LEhAQCVIIW
2rvx7qdRIgAi5eK9QQzwgIGdI/G6923c2222+b3z5HiXdEE0RPlx38vVq3NXUOavHW5RvF+vsqjg
4J2KPd80IvBFF+rM9RvBgfWshJVkfXrjTzn0N+rY2JrAyaI7f5LxjdvJkc2M6FWRJ3+183qSIwYJ
laIJohraMYcRZZM92RmrwR2Xo1nbWKrRomdE0RVZboombJojqcjWVvmTatojY2JnBBNEVdqREREE
hVx16fKMJiM99mjrTu9Ekk4C4zxh84Js1reBlLZCF39t71l3tbWts7QTERDqvxx6fSLDYXFhsMjq
NxsGDBh1DDkdPieOOOUa1ERB7IiAWEzLV5v8eJSkUOFEhQqYEjAyHGQRoaFASLDWOkbEBNCCIYgq
L19e+/Pprwx1b54xjr0q1VeLu83rRtnfuASR0EkkC7MetJBzPdz7zL646+/qIzeX+Genug4NVeKo
c75OnOqrbbz2223pt6eZtsssTrGYnfaz8oOW3bbJ2rbh99a1pt9a1rWtRxuvHGzZfdz8E94Iqg9g
qEAbdCoaN2bRcqF3jPTz9Lbbbbp+/5D5Cq4IJojpXp8e71eVQ6qm5rcMh1gTNI7HxEcHBM2TRFev
veCLLHPm8kVZHU8KedS9oeTI50TRE7W+wUOyxysE0RK3Xlq05ye2XVfo0NDGHF8BfXreIrV7yJF7
kXwF6M0EUUTNk0Rmy4ihuw6QqOhfKvfExGdMeRuiSZ7AH2hBEpAklEL2435dMZeePHPt1rOMdmuu
uutwANSCgHKsWUAbZ2zhjTJRRO6oFVEAhUXNgMacZ+DjOWmz7YrfO8mZiIbFXW40vhR5j0iw3GQR
1HA7hw4cOOeuTM08uXLnOZmIjtEgRjfeEkAhSSQaGpGaLNGjRubm6DAUSKabfbblfnrfiuH5Zhmb
mtr4wzMzPE1Fb+kIgm/sW3IFBLhQStYAjQoJNfHhvxvjjhtttt+D7yHeSCjp9gOKnp6OdN1Xjczd
2blwlfk1kjht8iHwSNDUeiAqMZc4IAB4O8Bue/4sOUdj/aUZigsvCZlVoXFS5cW+OkliSSIzBGBv
J3UaM3066FsKmGK6VWiHucqLAEL7Xdd8tJvUp3/N9F2ERuRozEld9q4XPot5Dnl6IexJIpgMtyQ6
M0essX4BWLgKrBbOLjlgIJqBGANWHF9r7eJqZh36EknCBsREI5YxKDM9YDO+KwLMJRCUVWsX8mdT
iIp40daMQ7vtd/LNu48xYbDIyNhzHsDhw4cc+eWZjty5c8xDvhnsS0/IIa3YCBAcUMgjIyMjIoCR
HzZzAa1viXMP6x17cc89NT1qHZuy2vhmZmZ4mq+mBbKxaK1uIydlgEfGc0RERFfgEXIKjhzDS8hp
tbSm6qm6q1UBvHqy53G+RJK8c2pcURYxqc5HMDeLG8BJ7p+W13ctrCt4cRsjqegSSBflnjCKhFQg
oJBQTLrx3bd2gTVpwsyRnQkOlFT80sjybohrjwnf3KVgrG3scxFDXEzBJEQzGilrWCckMjJCcVPM
K3jWc7dLvp69tRBJJOEKYsmbNUslmsEVUXERQueu85iLviJeo1qYh7jzHpHmLjIgQMhR6wwYMOOO
GZonXHHExDkkz7UHREpHFChIkZGRQyKAaqW/LnnW/Ezy4iGbmtr4ZmZmeJqtAdwAg3UAIvjwOW77
kqqrEasjB2d2u/vpuaqHVYWSODEzBGiF46zdYh4QkDbBIJglbFPMuYiiBNbNkREls46s3juysYok
iIyQaUhmEAhSRhuIj3YOHSWrfG8yRk3Yeug35e+yogjJzJTl4bIkYFlD23zjGvGzu23Ekk7smshl
fCY2vimT/IKihUUPZLC1gj14fEbWY1p943iIh8d+w29AwJEiRkegMGDDjfGMRGt94iIdUE8KT4J7
AWSwoEQIBGRkZEpQS6w88q5bnbgzDNyW18MzMzxJ+Pr7l+ovZeFCJjUpkgkkpYszYYY5XXXUuuUh
UJW66QlKMpSldddddddddddddcs6AUvAVyJk9ArgGUMzMz0Vz3orn4m4m7lrw+o6QVRdMRHXVCHj
igFZS6qkMatqZzD3bo8SVSRg52zp29htpw4gMEJAltK3/l8rq1DbbiMEM7tt/K8rEb+Dn5G9xpwS
SjoWDK9NyP19jRiFzfIkJZ32ehZyOdMm97phgRaGPSt5iGnkSScIRpXdcJazHCOioqp5hUsMZEVb
NGajJdzEREHHn5j0iBAgZHqEhgwsKW93fWoiIjQ2J5iUkSJDhg4gUKFBkKEKy0gACI+zYxtnTM2y
2vhmZmeMER68y4GRijn2g89VB1d7uhzNUQya0HaQZOGuITkgxKuNiCyE25gZeMeic1hcoiDJY1Wn
EFfPAzMGIU5mTEHOxrfZqTlyiJWY++gs4w5RvGL6Tfdnzz6xEb5JJOEIxYC2XHb28jtmKHzizDNl
2fDznVFJECcqPs+f+zx+386aKIpnDOXF/dnnG+47mzbMvvqTN+M7VAHxO59fz1tPX1NJfsdv7Mhq
DwjlAFow308Z6I9cwi64wxKSEtDGJiZ+H1pdujXRiR27MKOjXLVHKvqRAHnPon0deU2QYg1CiSVC
3jpM4X6+fPiGEgCpEy7qEPrmm4FN8JPmMKOkGHQEMYbZujs2a9sLruAUOGWWfHngboeiVh2Ww8Wz
zfIh4Ao90AE3GfWygv+U54Xeb39bnuiAuA1Tb7ODF9KITtvdUVeHu+fG/bet+u97O3d6faM6IKj7
8gwVQf9CoRSLAXa/z6ujWqy3+9/swAAACYkkkQAAAAAAAAAwAAAAAAAAAABOv1+oAAAQCAAHbnAA
IEAOc4AABAgAAAAECAAAAAQIAAAAECAAAHNc4BAIAAAAQIAABACAAAABAgAHNavj/Q5Wttef3/3P
o+r5/0Xr8Nsg/i9IOWNzlEBHHH/zgdP4PzHZ5PCvOb3/ESKfek+v+m787aMnBPNApxRT9yzHxCAD
7XfWoHo/+4Cr8o/UH0CWiTJC+gVQsH2jBBU/fxBBaVSAqkiPznx5sZ2fP8mwyEIE/QCqEQ+mcz90
HoAEZh+O8KsHUAqWsCaZ0YH9wKoclUG97iZA+5sCqG2V0O4BUiBm9YCpwtl36d6qDw9XfG2DI2RR
5AqhdVByznHzlvmLV2qqhvojrP6KyVQeReLuwD8tx1bBw6NCfeAIwFUIW6kVQsUP6OvhYVGocdk5
gCN1UHswm7uCqFFKoM4qoMVQeeSKoYFzcQ6faBjnvMoAI+/A3ENXHLOAqcd4Koba82Z2m4FW59k5
73Wr164f9duLOzl2e12uXaSmSjIE67NidvNVB4sMQFS/eiqFdWPpv7lSx36q7UERiRVBm4ZT08nU
Qees/zxVuh8ptOgo6rXe/CfpwBVDu5KCpe99qNYKoV+0BU2IqhvvfOoKnIFUM6qDYxYcFVQgfdHX
+qZbpPCMzZzmuY/cETjNXPQ+W/p5UdNvyf2F9Ie2Ltbp96qRVC6ePFlVQ59ERVDAoVG7AAVO9mBA
ahEUfOd7f3HaCqGG6gBGrJLIqhuVVCFjuBVDJU2uijLieg07gRRdUAE29ujQe6FvP12b/Fs3Yl4Z
7o+dgBU4uIkApXkMNcGN/9VkweJEMUPQDd6YjaA48UiKPvnc3DcEBLgqhsZgqh1uw5Q2qMKEySvo
ncCqEQPhI3VQcXH7XcUD33H0oANjVCASc8y5SbzqlblUGdvGkFTJ8zex+9+ggI0Lr6IG/dy7cf88
E3u6ng5oo2bmN6qDbhh8lPZuBVDIxxExXADrYNG6gqcfTkb4A4k0ysPS5pPJOrPOtb+Nn+5Pt+Xf
XoAI0YO/re8FUOZysCqGHT8T6bf0AqnlT5PpwvE9h6yL7Cf3fDVx1UXavm/s+S//MhAmb4M/f2DZ
PvOqhfu/ax/Fd/48y6zM4tb88knGHZ1JLNEQSSSTCrERERBJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
JJJJJJJJJJJJPMkkkk0SSSSSpJJJMkkkkkkm1h2+UbIig++CqHxWPMgI3Lgqh6oCqGKwllVQsnUq
gxsDye6fYdlNvso+Owgju/WPv2QEfJl9vmK7V8nixTWWORURRtKsQsfJ9z1UIvu8/M8+Xn5+djmr
xY5q8fw7BpCRG5CiIG0EgQ+iIgHhC3LBRJLA43L3ISTKzymoIIiDj0Y1T0wMfxU11OeJDlAPc2kM
8oiy4StN71Wtdz4CW1XIMwbXTOQhX6gXIA5RpvtRK757KZVHV37UzkdQQ1fBLh7xI4Dm6EbeFban
oAUif3oc9WCZzj68vegbi8NgVYLyPtMi70AKnb0PJko2VT2+jOWv3WHgaGtOLfk8vE4PpgIB0Nyu
aTYOUdiyvj9tABxOhS5dXTVbXPDsLBo8+fFZfjv3ZSWxCJpXHMabvl3/UXwhJhTThgG066TfLtyi
JoHTxWS9hDVRvEBHmB9vYOhuGtSQyDgASQv3uPoNMxrucAf3N2wCIbF3mgyB7LiMR4dyg48wQAd/
hs1d/GO3tHhxs5eqd9VqV/7XjxQDDC0XpQM66x5arXxgq18b75qJCISIFoDUEOqNRtfPpdGxETEA
4AZQLwGqllHcuG9fTdf2Qe3tDh0ZX7yM03238PqMveYRi6J7IZtrdbyYPUqiNu236zWA3GKAhNOH
z9+F8vKPrBFJAAkEkJBD7FHtj7XYrj30H7kTy/GevflNJ4fJeIoOG/Xw2Wh/DRGPDqjHqsssz39V
MuuTIk5zndSEnrZSqEIVqTHFVrXG/HHHHHHHHHHHHHHHHHHHHHE3LhwsSYes6o11ITvGTuPDNn0p
z6QpQDUCRmAF7DLNqe8K5+nPGIfCPpl3foB+wVkkgETJIlr0T3bYQcqrIgataDWhRVGZAvsGPDsC
QQ7DELr9QU/nQwPflj8+GTdW3SBzzH3rgC6FFFUwRUqD3Qt2lWhDa9xsiV0eb1U2z2E3esj6bNHH
LvHyx0szgSUSZwAQohwoLWr0qInqznuICMyunnVQbYpDxmZp7KdyyOh1Ve2AfkuHEgipuP9UqASL
JJRFFURfA6dIiiIiItraKIuAAA4i4BJJJJJJLT1OiKJeHtoVOJr1I52DNPCuguLEEFkMLVxi4RKg
ciWgfBAkusFVGqlBLAKlFkjJFQW1UFUUVVRaINZoCqUytUsqqf1RC+BIwnvGLpDyF8IRHyfN7fjV
Oan57ZNXBQkfY+Pwrsm6R76bf0cbf6P8dHHlxpmXgdkJBEn1WuO4C9Axu3evlx9ePTMdERnwd8QV
OcYMUEZc3qunKx8Aqg0YDpMy3Z4HwKMVhBCRRRPVcAB9Vym7s5WPzY9vxbcslBecOSvSi1pcWrK6
cn7WuOkIMM5uUvny72PYfk3ggxYCSHM/CabICQX3sY0UQOz4/Tvv6/xCd/TM4qt1sqoNBPL6WXE7
g7C8WTtYCSOycGnwZD2G33YybNdvGeyIiIiIAAAAAAAO3f5Dz8VECo1LEIAIK0gVttEluEFs6krc
F8HByHx6+XLtciufyCQc+GmoVg1IOEu10qIlYj7CRYL9OJUUxxGgPuMFUG6FICPTh9HJmD2hYBU3
IbaVRHNzse7fXTw7dydsTe5OhG/+EDhY7C+1hUbvbz5d8eHK2sjnEOE+1t94R72T6qxOd82Czhfe
4ughQLVcahlAKmTLWvumLswDZ1+bbj8EDxMLcQvPVvxLk04vak4GawFsdTfRTCO6kQXp4YHy5wvt
r4pkH5qGohgfjKbo6ufTr2B0KqhbcB4X3fitIc+XI6zQfmoVQb8qMltu9pazy41NoaE0q4khwuk2
QsU10hZVAR3/m+GSubSx4GQYp+5vIqC6eROW/WZ4lj9+LIk57Kb1065nytYbcJ+rt76C1ceKjVB7
qhZ6GkLeA2NOQjnS+1yD7tm/Z021luVrFE84yhVB7nnoeOoLjGmh+qX5OaKg5+WnaKAPEsFPotg/
i0oBU6S++Qp0AdPl36w9OXLOByLOBBJAXkK/ms9r3q58KCMXwjvHGSdrn2BPbbY0/mjCQcnkiTtp
nFNAA66rhYbFteX4KITT8KqDkHkXgaS3LABh0txb9pAGYAN/MDHqkgqI/smchcsB4ppAVMfRLgPi
jy9XNxQEdPMPyyGLqJnLz0zXCj0WtNksqAmYSTRtat07NcVydTn0Kvi6u980oNyoSBSjnfb9IwHT
qOiqg8gL2z15IVgGXwhqtiTnuaGYHadk9VFQ61loLYK6y+14NRTSGoMIeOiiEIw8VCFHzwaTbRX2
yQ1n3fH+PI4mjoAqZv1QrFHDnka7kNejpkHPPeBoZ/j9GmHbhR+icQ6iGpPdNB/PT22OkMMTse5V
UkIwPfywlxmx7tjhvNn6SGiFz59gUFjDsDtNZqP6ZibDcDoA4PZqe835AKmjEuIPfCwi8T21Ejte
R5JrtVfBpvALg4BikF/+6Pd+z9n/lzc3s8K/KXr7D5fukzbIQJI7vS38r4Ps4V6w3dTcK8HnzDyR
b2FvOQKS0f60o3lpqHNoE66oiSBBIl4XPX5IblUR8FUR5ACxzYvvQmBGO5hgg8hSg6egiAvjE+fU
DHjt0z8aJ+8AVKcdWQCp4JcJpeEBK26t4ArE/Dp1uHYaEPjn3Pu16/vSVeVnReH1OgKKV9f4LWAE
Nz6OltOs9Tfnvl0fRAQWme7QUFiMZjK+UOzu8nAsHEu+uPmZCBCbJKxGVKoKCkyVQYgFooA8jfZR
Eibz7muudieGmsAVPf2Gl3i6BbiRhA+exSJI5cZZdSBfIoNjPgXCntiZaakDq6deWxjLhwHdIbUF
HIkIGeNAzdD28yhBD0eLJK+G1k1GEGEGEGEGEGEGEGfXmII3d9N94fT989nPq7+szO5ek3GnFOPI
17AhMiimoTsbFpoI03UFNSiiqCRKAB3QAP2aUo+vkaSGfr1RLF1rvXdPNvvY7dya8jjXfkQ8Uknj
iFhuOI5MsFtqcHrqxC6eLA9XZ5tu9IY0fjQEZnsuLODhfbCWuXQWudPwOgZsIRtCHBEGomW5cwiP
rMLgloHCyqoVaJVaCyFTLrUvH7CGi8jMcD3gc1iAwkNEYEkDG1i0Vt8eI3rEneXrURFvZIfbt4nt
3Kx1QDRFF4IByo+00meyHjYGyGMrNCFg7dIiphDxwyImHvDqppaXopiyzr1EnfLXvshYktc6lUGB
mQQEdDqMaZrcucm30PEide0uS3w14ZmOqoexb7guYdXTi/h+jz4od8uvSnWfDYUQ1E0p07kFTnKJ
EBGT6NfFNBlkJrmrZeaddTUnLVbnfc3AsRZR9RB6etKnZ0ikOrrpLBImac4r+vMmh+IP45tN4F8P
XmaTVJOH7Ovq6lANqioNcxAPcVVDXoDCvXpOnI09pImEJL9JUudx7L9XvhpZNjPHH75gBUke6ZGA
cjZNEU3w6y6QVGBuEEeQdCCoNHOfImpFGy3OL+ecd8TI29AQdPaatqfS6uJhhE0erSVLdOfj8eXZ
7h7nFTRAJCyQagyABWsOELZOFEzKZGm5XI/wUCmYfmecIIVXzgBI0AAAItuv7QJJP+tuRPb7f3aj
jtKCzdLQaI8iEcwx2EG0S8yDkGW/y5G8zY+mG0G8T49mi54y2ZsYMHZv6juU55nQNrUbasG64oIR
JIyMNKqSBGEkJJBOsJU56asQzeIGkOJPWaIcjNdWSyWSyWSyWSyWSyWSyWSyWS3f0ej195yTvxzn
VdKPdgHgZnzGbWbdpZtCac3GmJIIi1RSqpCwwCEkuDztVmqYWtRPg8/PyAKmiqI10A0ALmMosHb5
SEME4TlpoDrsUB0AoBqDlAtdaZGKgwnkOWIG4e6uoFcBTPQH1BAkIwKEVOAIpB5mToCi6xLaIZMk
HHQZOHzL/+XaqIPzqCDDfvM42JsOI8KB2ScpXPy1IAZYwQjIMkJCEDQ8ZYsQkvzF4eUMAtovR5PW
rwIQjCEIKZMpJkzazatsmTJIQhCEIQgIU9r4w4kCj0GWqE1wEVrz+zxyiub5QKiAk2O85dwmQfW5
g5z575Mxi/fX1THK9qnMuZ4qCUG3q59ClG9jkfPeQ2B+4ElDgq6RRAucEA1FUGAcYneVJrtA2r4P
IaY32yhsnRIgkpmxkbhY3Dyfl/LuYG7sO3dz1M60BGUnhiGotHlYK9O0vNKGkMC5SbSHIdeld12b
gcSwPxO6aob0xhJNtDQTTt0OijPfQEZxz93iXbSc2spheBiW6yQl468c9uAYJoURIEkCB/PWOzdZ
L6YH8kBHMgI1r8eouMl9bhZ1KPYgI7033QC/blddHhwpOEM4KobJT5vNo3i7ei2m1iQuERB49n2i
34bFRZ4Q126Y1mBBeELF9TFbQwaXzlZZKLCUYx6gVVxhIVuKoXLFaWh2taKoYaGfXjGQEkfi6QCF
OYiNaDlnye/JYi8IBG+ICOQG4aqFghIhvIoK5w1CzgGkkgUDxIONFI2eHVgJIuldoMjtOBlDeHmh
dcgnaOXWE4JurznKvJ14Hb86GbDfEN9tsQVKPKcDfdIVCQlFNGZVB5UePAY1DXml7ZB1wygqNvmJ
w20OmnTIIcR8LnSzhtp0z5ZKqDkYOlHxBqKLRCMIyZKTJkySZMmTSZMmSSSSSSSSSSSSSSSSSSSS
SSSSSSSSSSSSSSSSSSSSSSSSSSSSTJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
L1VvV5njvkYUB0RABx6MdT15eYmgwCAqmKKpPq3ml8gV5VQEYB/N1e0/n0hqgHj5kZJ+Lb18DHSe
jLhn7FPF3XZ5czVo+GOV97zPwWTxK4WXuLg8RCBhjS8m60HRTfp/kubCSIQ7XEJJD7u0AF8rza+P
mOq22vC5vPtpkySSSSSSSSSZMkkkkkhCEIQhCfDPQXZ4QseJTMqyBvLWF0pEBxDBBrPycQuGMNyA
iDXi/BnrO0e8BUyw7E4mJ1xOpz7NQvqxPSXhtNlmJC6E31+gE+piAor0JL0C5WQVPn0NTSAXvPny
5D9jw5xKL5Xa+xezaZMFR8DNsCANgggDjfYPFzvtkWRVDqIucfQm9QV5vMpoOmICPd+f6lUGfHxV
VD6wVQ/eCqFg9ogj8wg//i7kinChIKYwW7Y=

--------------Boundary-00=_7T403EECYGPUFX7JTTYB--

