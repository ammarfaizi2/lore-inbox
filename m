Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161107AbWBYUpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbWBYUpp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 15:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbWBYUpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 15:45:45 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:1745 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161107AbWBYUpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 15:45:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=ufNflJ2KNgiyiZd2F6NYVxD69sCdT+ZMGCVXhOHLv32zHGZwpfzYBVaYs0er+VmdzoEq8XUD9LG2MuiiiffYeYUa1Wrd8WZ4S9y17VpPMRjkY8Plzkm8Y9arKVOo7EyqKYGQiQPTjCqPIEcJF/Yd18XiUEE5f+i0mX62yBhp258=
Message-ID: <d6fe45ba0602251245h32b9ac5dw65246ed6e1bba607@mail.gmail.com>
Date: Sat, 25 Feb 2006 21:45:43 +0100
From: "matteo brancaleoni" <mbrancaleoni@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Bio & Biovec-1 increasing cache size, never freed during disk IO
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_52_30075676.1140900343813"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_52_30075676.1140900343813
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

I'm experiencing a problem with 2.6.15.4 / 2.6.16-rc4, noticed during
high disk IO (copying a lot of data between 2 machines): the system
memory get filled up, until the full swap is used and the system must
be rebooted (or is unusable). Stopping the process does not free the
memory, and happens not only copying via network, but also with a
simple
cp -a dirwithmanybigfiles testdir.

The system is running on athlon64:
Linux morgor 2.6.16-rc4 #2 SMP Sat Feb 25 19:55:36 CET 2006 x86_64
x86_64 x86_64 GNU/Linux
Same issue with 2.6.15.4

The box has a single soft-raid1 device made by 2 sata disk on promise
controller.
Attached slabinfo dump and dmesg dump.

Some system informations:
* This is the modules list:
Linux morgor 2.6.16-rc4 #2 SMP Sat Feb 25 19:55:36 CET 2006 x86_64
x86_64 x86_64 GNU/Linux
[root@morgor ~]# lsmod
Module                  Size  Used by
ipv6                  399008  18
ppdev                  42888  0
autofs4                55560  1
nfs                   251224  2
lockd                  97424  2 nfs
nfs_acl                37120  1 nfs
sunrpc                191944  4 nfs,lockd,nfs_acl
rfcomm                105376  0
l2cap                  92160  5 rfcomm
bluetooth             117252  4 rfcomm,l2cap
dm_mirror              54912  0
dm_mod                 90192  1 dm_mirror
video                  50952  0
button                 41120  0
battery                43912  0
ac                     38920  0
lp                     48208  0
parport_pc             63144  1
parport                74636  3 ppdev,lp,parport_pc
nvram                  42888  0
ohci1394               67272  0
ehci_hcd               65160  0
sg                     69672  0
ieee1394              392216  1 ohci1394
uhci_hcd               65952  0
snd_via82xx            63784  0
gameport               50832  1 snd_via82xx
snd_ac97_codec        136536  1 snd_via82xx
snd_ac97_bus           36224  1 snd_ac97_codec
snd_seq_dummy          37508  0
snd_seq_oss            66688  0
snd_seq_midi_event     41472  1 snd_seq_oss
snd_seq                90144  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_even=
t
snd_pcm_oss            85632  0
snd_mixer_oss          51328  1 snd_pcm_oss
snd_pcm               126728  3 snd_via82xx,snd_ac97_codec,snd_pcm_oss
snd_timer              59656  2 snd_seq,snd_pcm
snd_page_alloc         44816  2 snd_via82xx,snd_pcm
snd_mpu401_uart        42112  1 snd_via82xx
snd_rawmidi            61696  1 snd_mpu401_uart
snd_seq_device         43280  4 snd_seq_dummy,snd_seq_oss,snd_seq,snd_rawmi=
di
i2c_viapro             43160  0
snd                    97320  11
snd_via82xx,snd_ac97_codec,snd_seq_oss,snd_seq,snd_pcm_oss,snd_mixer_oss,sn=
d_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
i2c_core               57728  1 i2c_viapro
skge                   72720  0
soundcore              44576  1 snd
raid1                  54912  2
ext3                  163984  2
jbd                    93480  1 ext3
sata_promise           45700  6
sata_via               42500  0
libata                 93592  2 sata_promise,sata_via
sd_mod                 50688  8
scsi_mod              180688  4 sg,sata_promise,libata,sd_mod

* fstab
[root@morgor ~]# cat /etc/fstab
/dev/md1                /                       ext3    defaults        1 1
/dev/md0                /boot                   ext3    defaults        1 2
devpts                  /dev/pts                devpts  gid=3D5,mode=3D620 =
 0 0
tmpfs                   /dev/shm                tmpfs   defaults        0 0
proc                    /proc                   proc    defaults        0 0
sysfs                   /sys                    sysfs   defaults        0 0
LABEL=3DSWAP-sda2         swap                    swap    defaults        0=
 0
LABEL=3DSWAP-sdb2         swap                    swap    defaults        0=
 0

* cpuinfo
[root@morgor ~]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 47
model name      : AMD Athlon(tm) 64 Processor 3200+
stepping        : 0
cpu MHz         : 1800.000
cache size      : 512 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext
fxsr_opt lm 3dnowext 3dnow pni lahf_lm
bogomips        : 3613.48
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc

Thanks a lot,

Matteo Brancaleoni

------=_Part_52_30075676.1140900343813
Content-Type: application/x-gzip; name="slabinfo.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="slabinfo.txt.gz"
X-Attachment-Id: f_ek4e7waf

H4sICInAAEQCA3NsYWJpbmZvLnR4dADdXUtv5LgRPqd/hYBcdg8b8P0IFgEWySWHBEGQILk15G55
rHW/Rmp7ZvLrQ7JKEqmW3JJsz0yvD0NpTIn8VGS9i653+V15uD9mP2XPRVWXx8MfM/YHmv1Qn/Nz
WZ/LTf3j6vfZId8XWfTzc745l8/F+nj3a/2n7OfD07659E35vwKuTu6VbgB3c8o/FHV7+8fs/HTI
73ZFnf28K/fl2fW4y8+bh83x6eBv6oe8Krb3bpRj5bv7x7b5OW8H9v/RjNxcw0P5c17u/DMfdse7
fOdx+EFcu9sdN77fPv+Mk/1QHT8dXFsV+anYuouiqvyAvst9VRR+in6Q47Zon66K/fFc+N/WfpTN
6QmGCB0eApRwuS9r3913hP/1V+E/V/flnVr7l9bxN80k/MtDo1l7TePvlWXc/4Yq/xsTf5oM+sYN
ST8D/EolDXT7nfsJF71/OnzhR/TeDs2qPKn1tj6vN/nmIVom0Jv66bpJk/b6jfGwpJmFxyRvlw2e
w7asN300TTcaaMKMaa/fGA9Pmll4WPJ21uD55y//eVbZxQ/i1f4JIkhz7Z5L8DDRft4leOCdTfMm
6+3ff/nHEB7aPUQJEEC8G32a1b2EPqK33s6f1vVx87j+158TXCRqGAn7x87FQ3rNAH2SLmQWHjLY
rKri41Ph+EEfVNyPSj9tJm8CUI8wzU+0EqgJ2yQbYnAvbiCW7tUhPCZeNchx5m0gXGmqZXD39Xpb
VsUm5dkJfcKEubgJ+ng8n6ryXKy7ibh5Al7gbCZsoGz2ejNJM4QH3t80Zg4e1n97hMfpJNsEDszT
NQGDDvtnPp6EGw/igfc3jZ6FR/beHuEpvcKTClXWbSPKNIuW95sKIB438xg2HRZAHo/XaHv8INk/
QeHh7DYY9mmzvnu6v3f6eYwHl6UN8ieizxwFIfn4w3hs3PBZeOwFI27xnPP6MdWvEQ+lsLxZe/3G
CgJNmln7J1F4qI7xXO4fSjrNlxJ4dja/vk6fVMGeRx/de3trMKydDbTOd2UekQjxvLcBhGyULeEH
pietUzwPef2QXeKBRapEe/3d49nu1+fyeKHvJGxD+Ge1vgn+5vAMwEm7LaTPN8Hz9LAp10/V3fpU
lc99A4gDTYjort9jvaEDgc3RRxvbCd/Q8uvi85lfMDhlVGA7KugHJNBnrn4gGI0azx77eKRVfqpS
+PVMDfBck+DRI3gElcEJYIyfgLA29OGGAp7P+flcjesHt6Rf/3p8qg75zjG4w3bXaj24AoAHLOUH
19abIMJ0ozEh/T9iAh5KuRSSUNBLOdxrKS4wOT270Ucp9aRkDMdcpsMpY6PmApNVSmhvjCjpbWAm
jDEarLMYFBsGRYhVzC07xTXl1N9rpSV191Io6izv5+Nj4XSfu12snAJoyzpDxbL3YwxmuWeEXXgS
Ah5nqR6rbZ/RKVh4UrXXy/HQCzzuswZrxqDnMqgj0xid1MLCljCBw1AJn4et6k1drjf7bc+5GJuB
QrP2+i3p49Y/T9TgqfQRhqOxyaxxd25Htp7F+sPpeNz9RBtDNjG8QyPcgm2Hm2HYxe8YXm+UyKiL
8a8Ragp9jGW4dKzwd5ypHh4lsjE8Sw2hVIse3D+KR6OBIJJTGB0R2rDG/vZ3Wvbw4M5s8SDHBsMB
eN1sz69KfUoDeEw0DA4wZf9QB8AaZMjhzvTpQ1NnXOKxkPD9ZvMDmTplB9Ybjf0v0HESf6PUEtVy
yO6uw2NSvRS/GDTMkFZXekvDzm1mGo822bCjlHiJ4x9xQKi7Zd168/ytPK43x8PZKUGDig9sI3MT
is+///7X/17aDQLYgwD5EOQPeCLY2643tB9FFm3QKXio4LTTmaggPDJU99VFoO52HVfnzWl9Vx62
67unzWPRjIOGxVvqB0P0QaEnFkQeU1HMWkdPeSjO61NRVCmJEthWtd7mt6XPQGSYzqRP76Ot6mJz
ys8P/QWXrLdgf7HbMIQ+31f7gVB33I1r1fp+vns8jh8MBO4ZiRbpUkfpVceiRf5mbecs49PwUI0+
wsA9WaN9klVenS7j9m2sVrxGnl63f1AMUvF29s8/f/lPlo0GHsOHM6CszpY/EwIniWP+NZkIceR+
CE88kAH9+h3w6MQ+HbC5x9cb0dEM27skcj/q6FGm9c6+LT+IHSO4JvhURxxLYmJyLHI/hGehY/E6
HrS6EA+GMyautzQCpKPA/cByQ7ygHanADzIx1/4RacxpPDCM3FRN19+8azFmJaLdP/e746cBBnez
+vXm/qMzFzZrbwV1cLTtFJ3F+uhV+aM5DsOzKHI2CY9AmoLqz62J8aRYwuRE1AQXY8Zmy9Or600x
kYw2Y/8IdMyDByLGUw3gAQmacfEaR3YTvGyDST08nBPw3QqwlsHqnoJHSAv+A8mM8nc2PCssF6tt
kW93Tsleb6uPvwX7J6/XeYLkxvnB3omfp+Iy1k2jVEUaOXi+n1RFMpIaWx+Hcl9i3KjA3YYB9PD0
oTjv7oYw0ViJA93kO1NKR2hUfD6zgfSKCPridNJvQqOA5zcUfdwejufy/ktf76FfJbviNenyI+tt
+/HpeH45GwGy4eiNrLfn4nA+HXe79enTx5HsindzWr0rnuJUjuyf4ORht6EklLh/Aq4xKXRT+S8N
ok++ZuhSBqF/PkRfhbgJnvDorKDz5xd5ArfsdhyLHs/dFR4X2AFVN4HnPq+/HDYvBk5uKiOuftgX
+77SwwmG9QyE1xfp2U1wbNxQ5aAcwjDYcSIehZFs4FPcoHWvV6djXX5en8t9UdVjLO6mamieyu2Q
J1t/lRQ/Q+KU0nkpfiSJa7aehLvd47Z49s6eGI6MPT0wrJhtqV4toVHoUNIRnon0YfgMJsAo3cMT
7NXINUK7PG6qxDLP4vXMCvT0YKPmrDfaqwXq4UEHcN14ekzUcMg0n6v0pJMd8PQ4ZQpyO8MyoCG3
gPFpnh5DwdOjwNNjJKRdidVdeXwuNj/9wKT6sSOPIl2zMDMpeccwfZIueDOPH0Rvb+gDeNJMKwYf
DpqlmUlA3KYZxqOi0cycEieKuUhdMmSKJ820YkCRRgAty0y6LoCkMp1ClWkKa/c6Hs0ER8etg+Xu
KBYAE93SR6V4RNwsizw2PGU8s89ijTUI1GDV02mRIInZhiyMLUWTks0aPKLn+Y0l91IF+1oJmpPT
PHIwzympc58CphNi146x4CCmpU8kezSl3vcmNdNkeW6sYsxzLGwgLSRBRKWiRggGA7k10HadlG2l
NKPcoaJEGZ+L6tacYdJdKCulCoTqKdkemHZ7B4CRLleFz7EdqHXP8qYZAcYI1wjMWcRd30nItBBc
SO23jyFWugEcNq+kKauET5b1QcgLv5yVkcqAK1+8SiQNJvfgsia4gacmY3rXGnLSEF7yiFqd+9HX
2K3vN7vjIYEUp/9K+j7pv5lCkYJ1YgoS2KakLxKLG1GbkJVGTQ+RT6Hv8GACpiKkExp0bp1qWlQ7
HO6y0TBispBVhAkoK/O8TxFqwWRza3F1X+6K9c4vu0T1RjvfvsaImKB062iYWUq3wVpDmGh7R1b5
5lSuj6eiyg9t9jxlIRxGMYq30DPX1CKPKt0UjEnKMEY6Q+mWDDNprA5TMzrBc8qrulhH2aWp7bRQ
KF038rSK9YoZ9OEazZxAH65VUwUV4Rn1krybX45JMByb8p3JeBgVquNw7g5NJLd/Ah7fq/j6kQeK
qpckM/FwJgUYAl7NdXcoxxVdnarjQOEtTh5nKswiCWTjZtBLAjRnqKTa6ek9WiOeIIu1tnhyhFnV
5YeewRr5MVGzXZie8H5eU0qbTGj/kL9r+VuVb73XpyqKcJxSw9+C2cWgPEQqsqAcgGPJDsotdmG0
Ck0CozbasznK8IsneOggHmapCSmPwvvB3J20NJBbOyXVm+AXXh9MD2bxQT2zz0lIwqYv1hHrruNU
o1ViZh1Na3ZW9ZcaThqJQDmFEdnga+QPrmk7qsHh+7mG2dgZXkZBYbcxKJDQvK0Z3B/OA045TLaH
bgxmPdspd/0cGPzIXMx2YrXp5r3jOVYDZ3J4/QFi95DjZGDCM/U3Guc6DRt5hoGfJ+xtAfRJjXAx
gocpeK0Mn4Ixi95QudoWh3PVCxQHU8g7hYBRs9DMjTpwtEibSgrdx+NkhxeklMAwWAA4hR844tgg
cZwgpX4SYPZSLo3XR08XMRQFRq0BRZETNPfnrTcVJ3wN0UdBzTSVGizpgfU2gkcYGabmPon1jNJK
sACMWPljBOvLHRQ5PJeWC05wmtI4XZZikv6E/WON1vioDne2TZfNnzed4OnkKY9tl4WR7+nnPsj5
UUhKh9PNH4sv61/zqp8uK76K/SMX2z+tIZ9oGJ6/bav1Lv/SK6dBX2QQu5kEtjqXX6en9A2Xp7Jo
GDrr3BRkm3gATFszuoIzeuKSdadABA7KtSDL9WunYJGuCYGYBA9zuoqTpG5C1Dh56mw7ia7Z6/xA
ciWt4yWcK+VsM8kl8T4Rx+ec3r3a7529UD1t0nwYzGzHJDK1SMO+WnBLOdbBYmyHXiIateg4aBUi
0Jgr2+yn1fN+nVdFnoCiFs6JsMA4GHi3Z+4grHZuip5dp74E8gmuQR5CwboxUyUQZU7FCVxKOHvE
Wew2SFRuhFzd14P1NDAJIMxSi+6axqMIFqgqOlfjcTJUg8nDQF9oLW7v4bmEBNp7BhqpJYvyMZui
AjmOBzPNwfGCJ5NMOPQhKJW43gREIU0T93YWnT/EogdIxyEdBWE1OjcX89rJd5LjEsOUFDKdYzMB
RZM8qH0MjxdAPP6QkR4gDCIFWAwStGeHubDIn41qCEw00RzTrXE9cb1BiboIC8ltJww0i5U/heyS
w2E8OqxOigVPc0+OxBIRQV/AoyP6QFkin4hHgV89OIccHomqxio/HA/r532e1jeAqDP4bZd5rGhc
pDfIrxVs6uZ7TQ+ruk9sgPX63UkNwYXL6ArOjF6fjrty8yXS5VKX4rK8hG9zFObTPkc4SeAO1t27
HtXTye35FdGNSxG2tRBtxbo/TPwn6nQczX74y99++bH/4eBXzXC8xxAyExmS30fiVYcn0bGb5hV4
JiTPJ13eJHEx4FHSaXkxeSLY4XfNk0Ft+f7p0845+23g4UwrM0Kf8LuWsuZ28KQ+uLZZjmfCUaUi
7jKnYrB/9nePvymnbI/QJ/yuxSNug781c+407NYBuRxP79j0SzwCY3MUPIvEG0NiikvRqQQWXb5B
QWhOhHIGasBjqE2kTwLb/7LFcxvyp5lyJ35M1yzFE79jzCUiIod5UIJlmoIgR/CopuY+GAyKYiw2
GAwOj/cajtJnsUvx29GnmXLnISVdsxRP/I6RkDDqJMH8Z94EoGbSCQnUcvRteBc2tdI2pe+Axx+o
OEqfxUdLfzv6NAdE9kIm5jV5mGmu7WBIi4Dzx4Sd0+RKTsm0slIF25YKt9/cHWTyus2E/M2fHj1K
n8UnxH1D+UNYmlfKMfYjX4EnPRd/iD4WMiFgGOw4CY82AlJsg8NKG9WFuAMeSXviJ4G99MS7CfS5
LIimM0/koIns7vCk2htIX2wW4sH4gRz/0wZ4EFozzPQ/bcAkxQ3vBQ8TpgkJU+QHUr1An6UnDn1D
/iZVGtDSgOA1JyhRKC7CZgiPlkR1w2DHiSF7C0liIsR2BG1OWET6UGZeoM9N/SkasE973PprpcC9
nz33Ip6FJ/h9Szy9gHA4SpgK8poTCa/XAfAQYKDovGUzUqyUAvkTYjlUCtacMNbunyQebHySEJVa
vmL/KMhGx+YixUpYxrjPHOCEWuoTEAwcRGcnRLQU4dIymwmnxDpgivgTYUzGfYhMNlsorWwgQVwz
jqRbtoXwT1fI9nTHCxWBB87E4M/hZVJOFamcNgkZPj2EO0VOC0g2J6tHX8rZD2lRUHmgYYYuMRmS
d4yYdHEXvJm3haK34xb6P9A1EPWUcgAA
------=_Part_52_30075676.1140900343813
Content-Type: application/x-gzip; name="dmesg.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dmesg.txt.gz"
X-Attachment-Id: f_ek4ea7nk

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
qkImry5KWJ8HfJqe5z4AAA==
------=_Part_52_30075676.1140900343813--
