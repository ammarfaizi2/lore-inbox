Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbTCLQjV>; Wed, 12 Mar 2003 11:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261756AbTCLQjV>; Wed, 12 Mar 2003 11:39:21 -0500
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:42744 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id <S261664AbTCLQjM>; Wed, 12 Mar 2003 11:39:12 -0500
Subject: Re: Linux BUG: Memory Leak
From: Disconnect <lkml@sigkill.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <F44Bre5NuYqYYDleNlx00025ecc@hotmail.com>
References: <F44Bre5NuYqYYDleNlx00025ecc@hotmail.com>
Content-Type: multipart/mixed; boundary="=-5qL0SXmvFizzJwqs5D++"
Organization: 
Message-Id: <1047487752.1340.33.camel@sparky>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 12 Mar 2003 11:49:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5qL0SXmvFizzJwqs5D++
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

For starters, read (and apply!) everyone else's comments re politeness,
proper information to include, etc.

But to add some info in a "Me too":

System has 1G lowmem (the AA vm patches) and showed almost the same
symptoms last night after 1wk of uptime.  Its now been up for about 14
hours with several large processes, agp, etc all going and is - yet
again - running out of memory. (After booting and logging in, 130 megs
was used.. and that was it.)

Kernel: 2.4.20 + patches (see list below)
Memory: PC133 @ 133 - 1024M lowmem, 0M highmem, 2048M swap
Disk: AIC7xxx + LVM1 (raid0)
CPU: Tbird 1.2G non-overclocked
Added modules: lm-sensors, alsa, gatos radeon hardware-gl for X 4.2.0 (X
ver 4.2.1)
Config: Attached

I showed up last night to find it was 900 megs into swap and (relatively
slowly) climbing, but nothing in ps showed a particularly large memory
usage (largest was X, which was - AFAIU - likely to be a mix of "X
leaks" and agp/vidram buffers.. and it was 200M total).  Killed off X
and the other largish apps (apache at 30M, etc..) such that ps showed
well under 300 megs of total VM accounted for.  But free still showed
950 megs of ram and 100 megs of swap in use.  /proc/meminfo showed some
of it (300 megs or so) as buffers, only 16M in cache.

Its been rebooted to the same workload and the same kernel, and happened
again.  That info is attached below.

Basically the patches come from the debian kernel-patch-ck package:

O(1) and batch scheduler (ck)
Author: Ingo Molnar
URL: http://people.redhat.com/mingo/O(1)-scheduler/

Fix for a locking bug in wait_on_page, wait_on_buffer, get_request_wait
(ck)
See the URL below for information on what this patch fixes.
Author: Andrea Arcangeli
URL: http://marc.theaimsgroup.com/?l=linux-kernel&m=103707362523414&w=2
                                                                                Preemptible kernel (ck)
This patch must be enabled via the kernel configuration.
Author: Robert M. Love
URL: http://www.tech9.net/rml/linux/

Low-latency (ck)
This patch must be enabled via the kernel configuration. The "control
low latency with sysctl" configuration option is not needed and will
only disable low latency unless you manually enable it after bootup
(using "echo 1 > /proc/sys/kernel/lowlatency").
Author: Andrew Morton
URL: http://www.zip.com.au/~akpm/linux/schedlat.html

Andrea Arcangeli's VM patches (aa)
Recommended by Con Kolivas for SMP machines.
Author: Andrea Arcangeli
URL: http://www.kernel.org/pub/linux/kernel/people/andrea/

Desktop tuning (tune)
Minor changes to magic numbers benchmarked to improve desktop
responsiveness, and lower disk latency more at the expense of a small
amount of disk throughput.

This patch depends on the (aa) patch, and cannot be used with the (rmap)
patch.

1000Hz timer with autoregulated timeslice duration (vartimeslice)
This patch will adjust the time a process can run for according to the
stress the system is under. If there are many running processes or any
writing to disk the timeslice duration will be decreased. It is
decreased proportionately less in SMP machines. You can see the current
value for timeslice_multiplier by doing 'cat /proc/stat'.

Vairable HZ (varhz)
This patch allows you to configure the frequency the system timer
interrupt pops. Higher tick values provide improved granularity of
timers, improved select() and poll() performance, and lower scheduling
latency. Higher values, however, increase interrupt overhead and will
allow jiffie wraparound sooner.
The default value, which was the value for all of eternity, is 100. If
you are looking to provide better timer granularity or increased desktop
performance, try 500 or 1000. If unsure, go with the default of 100.

Disk read latency update (read_latency)
See the URL below for more information.
URL: http://marc.theaimsgroup.com/?l=linux-kernel&m=101355715821610&w=2

Evidently there is a website about this patcheset:
http://kernel.kolivas.net/

On Wed, 2003-03-12 at 01:49, M. Soltysiak wrote:
> I sent this here because i don't know which author screwed up.
> 
> Basically, it's a massive kernel memory leak or a VM problem.
> 
> System specs:
> 1 GBytes RAM
> duel CPU system; 1 Ghz each.
> IDE disk system, 133 Mhz bus speed, DMA.
> USB mouse.
> PS/2 Keyboard.
> Creative Labs emu10k1-based sound card.  (LIVE!)
> Asus Motherboard.
> 
> Problem:
> 
> When I boot the system, run X11 with KDE--totalling 100 M at most--things 
> are fine.
-- 
Disconnect <lkml@sigkill.net>

--=-5qL0SXmvFizzJwqs5D++
Content-Disposition: attachment; filename=Config.gz
Content-Type: application/x-gzip; name=Config.gz
Content-Transfer-Encoding: base64

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
96hrAAA=

--=-5qL0SXmvFizzJwqs5D++
Content-Disposition: attachment; filename=meminfo.gz
Content-Type: application/x-gzip; name=meminfo.gz
Content-Transfer-Encoding: base64

H4sIAOpjbz4CA3WQTVLDMAyF9z2FjiDZsmx1R5lhygysygVCSEin0DJJSq+PHYf8LKqVrE/PehJA
jv7SF1/blF276mNI6raqYtI1RZsq79e6rtouVsqibGJl81p9xxehU6+szBCsEBkbGIyxEowTHL8H
BIfOWcMk4L11Hp1sDrfiZwsG2QdBbwVAMDYgphoFUrKSprxN5tI4y+oETrtEnrLHHIYCM47kMNqe
YyC7aYscrNEoJ/KYt5r7vWUcNMnmmhriQfNQ9sff2QCwVQqD5vlcrFhUSCb742ezXGj2lshqoYm8
XG53bhDJnRsk1wsRqWoQ/icLUSRWM/kD/ywLig4CAAA=

--=-5qL0SXmvFizzJwqs5D++
Content-Disposition: attachment; filename=ps-aux.gz
Content-Type: application/x-gzip; name=ps-aux.gz
Content-Transfer-Encoding: base64

H4sIAORjbz4CA9WZUW/jNhLH3/Mp+NK3k01SFCUZCIpFsz0s0OwWSXqX9nAwZIm2dZElrUglcT/9
DSU71mgTWza8wMZA7MiifxySw5n/UH/cfrwh7ev3T1fkp19+/4P8dP3xGq7/dfsXITe3t+Tu7s+2
xe3dhzv7dnMHF3efrj+SX75cX3/4fHVRFYUh2xcjhI7o5o1xJuE7X5Kft/dv7dt1VDFoSOiEUpLm
qcEM3mXYZu3bjvHvPuM/D+pR5Sb5Lwa5J4CictXHiIOYz99gdDE3afU1mcKk0h7PO9Is3/KeorJv
lzx+eLNkntV62QP5J8xTXSaRUX2TwuNJOtbpVC2nvVli9HQU66HY8ahVUqm4eFTVujdEdqxTMZis
/xV1lUdZDyVPWMCHZT3DGMZOwbxqEWPBCahKpVpVcw2sJFKrIm9ZArk5c62ZLg32hYKxnqX5uCwq
s4rKrmFcopjAwgAM9V1+GKbXOisWCYbtLIPWLAgljJwNgD00KPgv2aJ83kEx6ooAjPP3o2pdtbg8
WqmEODWxRIx1vw9WfB+s932w8mzY7uoHvbkFV+LUHYjNniqlezxxZp53Zp48M88/K88NuzwiBKcQ
O0QwjBfXJcZ5/Ugh4N2ndBguzZXBOLTBCecQwBjz9o+2iTvLFtv8H83VdLXWX7PkovnYhH+6G7kg
rgxCDsOXYpipLY84zizSKkmrS3sLLiErR83lY1SNs3TWNoQbNQTpy+1FmSbOPM1U26yqt7zNxwju
Qyv9kJZOVsQPab7Algfv1vLwvVrO+HuyvLOHJD9B0OeNnkAU9ywUcRaKdxaKPAvFPwslOAslPAfF
PUGvW7/rY05wmKqM06LPQS7DWWDzSjAwowBwtCpqqE0v8nqn/F0fi2PLFHIPk28kaJPvuiRBMQly
ExEHxKzd6MAYR2WsV1FliBMRXTNBKRq4wKmUQ5KHwCMO62QwEsoAbKbbGzBMqieGs8pCmwVoB8vq
yFhOmKQysKtyOBLaYW85X7NxW2toqDW0URXuobszmU9hZWDN9h5jbH8+IdpERpNZPZ+ripRVEStt
oQT30HUAJpnNqMF+XdHvIS6yTMWm6HaC1g8pP8I9cBXGwoFKrSyeVGWeVPSQXJRV+lg8r1to2IX6
NqAyMVSVb0FNSrEZhbxklM2tTS6x6YdsW4+Vibf3x3GRz1OcX0Kk0YQERcpAqQ0sFFYz6PAKA72e
49vSdagkbXYUEpE+RbudN+7lD5XMWi8xjXkdIUC8AIYrAr7H/dlOit4zNn6ea+K0lTri+mi7c7cZ
9YHtbpkgKZbtGlUxHyXjW06fYbVyYz02fZ7q5XReVDGUY+C3lcF94plmYdPn3pk2Stl4NU7UIwSx
LMM8iXn2nODAykFNvwBnc0qSldUoL0waQweG3JeVmUqB8bhWYU3tIw5HHpj2G9kuQNmE2xj6y+Gz
TlJDBHHmZbehDVR2peZFbvT4bl0q9o83bzNKkzJ9+77v7b29SnVMJr1xBiiPcxthm7k9GK1turPR
CXts2MugNpx6QwORVrkuKtijc7Jx2s4pkx8Gr5wy7Y/UO3TPzoDi02vXeqNkA+2MK7yfAoYmEbJW
0B4mH6JZ2CJZIRYWvz6ze/Vklo3YIysTRj4ENylgYUVIxUvA7LAYZ/b8GcWPezKhEEAUpLdFti6X
GvIXcfIiSyGP5sTEJXk0vnVusyQvhQVYMZ7Q0b39Fpnj9h4ZWIU+ZGgvZ4XgIKaCnAIdY7B3JnCd
YLDoWUxpCzZmzffujoWCJgS0jw1j0BhT+ZtU9xiqi6num1RxDFVgqniT6h1D9TDVe5Mqj6FKTH0l
JQzdOtLUea6gBIbw8xuB7SCl9IkLym4CYZdNOKMTJicTqAftnW6/sKHeHA07ZjTsIkn1y/MVJCUg
QtlTAW9AvGvAebFSjgalmEL4BA1WVwsFGzmL1pfMo6D+uz3h7cObwsIVw+YNNIsTLWD7QC8n97+L
7NIOHJSIP0TVNcHGqkTefiQOFAl4Ejs1E7MPJSAVsXCAvrODUDqxwW6mVKkxlHeqEtAGtipxPTnI
3lkBxAJkgUkfIwOz8+03MG/Vo9Up8N32a9ApTlpUTlGbsjbOPLlkPrapWykRaQsuLvaXrptFWkFN
0Qh1vXJaye2UlZqnz2Q8Qk2cMOC/5bPxpmmWwqo7oOEZi2kUUBrDH2XUBdErqS9p83JDWMn+gnc2
qoQMBT8B5cyDAcbChknzhd6IWrCkiOYvc+SkaXL55cOvnz5dTf75+cv1x+ntpv1Vt7mdRzuBAtsU
oBLKamTG90/gPFohhOciZwO9CGFkv7M967hSIHuiZsHzQpcZaGxE9bc5iAGVC2mfYXErWH5+swjI
IfWmWa1fXdTtTUff/70MgkPLKVgY+NTl7XJS4buUQn51wFirDKI6M85TmifFE7I6PNZq+kNYzd+l
1e67tNrDuwXs5XR/EQq7NzkUFnGkCeX7mxpGO3U/2As/oSA69lVRnKyUieLUrDsnOIxy94c4wekM
jcmur0LmDOxJlew8teubJDahv4xAniGUj2aJ20dVUg6VDTsm1MXPqppGZZkpww+mlGvb+kPTePpr
ZA/l1r28EnTEoXADdGQlhcebYfesBHVp9furJ0K7MQu3fQTNtmneSk/uffPMs0Nz99LQFuQBuAan
oDNLo8f8ddvsY6Vlx8mEDAY5GUC88Hs6GTJJ/BAmdaY6lPhgUNhMAxppN9U3rVNPrJDbnAJrEtXP
mILPQDwrWgT4wB7K4u+0JE548X8e+ZhHAygAAA==

--=-5qL0SXmvFizzJwqs5D++
Content-Disposition: attachment; filename=slabinfo.gz
Content-Type: application/x-gzip; name=slabinfo.gz
Content-Transfer-Encoding: base64

H4sIAPNjbz4CA42Xy5KbOhCG934KljmLnFLrhpxdqs42z0BhEBliGwgXp5KnP7qBLmA7XjQzyN+0
uvvvlma6lZe2a/rsc/aQ49T23ZcM/oXT9S7vRVVWHzILPpybR461BST0A28GTst4KYaxfWTxhxjL
zvZvUPNdb05dMxW/xnaWRV3O5Uah4EEE3X5GnhplWcdQTGF0RA3ld5nsMKQAi5Rq2gsvur6WU0SZ
7wFgGyRO42oHXtTTnKYxN9ZuDc47qqvbqdqn3jkJdxhSczUU86/islRXOf91XJpS5a9jjuWv49JU
P8hOpf/nIqf573y1nZyLQcoxjg1ea6MdCpX84qOcPsJsnN9l/ijxYJ3QMPOhestx2Oddff915i+3
ay0fay6sQIARbh48oBhejaJ+9MvYlbfiQynY1xj03wR+ti6ppjBejaJG+eivspjLy02m2sDMFgB2
2XDUKKt+rI+14XIY1qvu+rltficZwWYCqC2GIg58Ne1NFre+usacsAHZeu0135TT724vehsXshTw
lFra+qheb9Q7XS9L05jEexo4BAPDasM4dF5PkwopSz+YmjRgYShx5uuIzF0Op/a7UsWSThu7NWxF
vN/hte3VFnfeonrx3TystArTdAibciGYp4CtRqv3iFJCfN2V924+yDzQN72sJ2jEAVCipAQCIWQo
qjSP1S/grFWi7OYxEiIAy1WpMMop3jqMn9UGjLHUz6Wfs5dZPJz0tyFFICemL3MadvNm9Mwu73La
ZwT5EUeRUUeGwsmhdKjGYTACgBCklAgM5T4uhlT7K+Piut+LaR6XKo6N2zP2HMZFNgOnx70o1WkZ
oZgyrQICOKDOQp/szlczHTUYt4oFEdQ5nKN6BuxBS7m7AzWzLfPG9IoeiGUcmACnY5MdSk27rcZQ
f+RnIKAS9um/b1//Satsl6IqExxSh9p4QXGmZnvoKlCUWYso4AEVi2p7bGtbr6wUwTkXT3yZtVi9
IqCeaP45BVzdsZ74MmsxRQMqCgvcAegpe6ixgBJqwEauwq4U7mT2vrCnsgNfJKDMKxJSuvGe+oq6
EgWKWhe8K9sRkG+UeWVfrBRGVDz1pRcPfa0LvlOCEe8WzQByJ4XLvBoIT32BmxY7X+uCv9zk/qrh
Fs3JCaEvBkm5oinKAB/6cu/9YWmKox58owhajc8G4y98qdXjHLKku872fxMIKFPC9XSw2cBJud7d
slcqcsVzc6CKkDLXCR5SPKnW2/PcUUlYRgNqelJP5Xw1K0XSchH2+mR2VKz4XFcIM3eFMBQlwhlN
/Q/3kODqPA4AAA==

--=-5qL0SXmvFizzJwqs5D++--

