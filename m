Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWGELOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWGELOU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 07:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWGELOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 07:14:20 -0400
Received: from usea-naimss2.unisys.com ([192.61.61.104]:59406 "EHLO
	usea-naimss2.unisys.com") by vger.kernel.org with ESMTP
	id S964810AbWGELOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 07:14:19 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6A024.25992764"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: [PATCH 2.6.17.3] Memory Management: High-Memory Scalability Issue
Date: Wed, 5 Jul 2006 16:44:13 +0530
Message-ID: <88299102B8C1F54BB5C8E47F30B2FBE2034D019F@inblr-exch1.eu.uis.unisys.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.17.3] Memory Management: High-Memory Scalability Issue
Thread-Index: AcagJCVgeYkLZGwFRoGkP8iuq+XlpQ==
From: "Satapathy, Soumendu Sekhar" <Soumendu.Satapathy@in.unisys.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Jul 2006 11:14:15.0610 (UTC) FILETIME=[26C131A0:01C6A024]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6A024.25992764
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


From: Soumendu Sekhar Satapathy <Soumendu.Satapathy@in.unisys.com>


top - 07:04:46 up=A0 5:49,=A0 3 users,=A0 load average: 4.85, 4.77, 4.66
Mem:=A0 65883624k total, 65721200k used,=A0=A0 162424k free,=A0=A0=A0=A0 =
6100k buffers
Swap:=A0 1049576k total,=A0 1049576k used,=A0=A0=A0=A0=A0=A0=A0 0k =
free,=A0=A0 666144k cached

The test case to reproduce the issue, eats up most of the memory and =
performs disk I/O. Given above is the "top" o/p which denotes the state =
of the system.

When this test case is run in a low RAM system ( less than 4G ),=A0 the =
disk I/O rate is very much acceptable and the test case completes in a =
normal time but in a high RAM system of more than 32G, we get low I/O =
rates and the completion time of the test case is much greater than the =
completion time of a low RAM machine.=20

It could be a linux scalability issue with High-Memory. When the memory =
is more with application data,it takes more time for the test case to =
complete.


File : mm/vmscan.c and routine: shrink_active_list( )

Swap tendency is calculated as follows as per version 2.6.17.3.
       swap_tendency =3D mapped_ratio / 2 + distress +=A0 vm_swappiness =
;
      =20
When the swap space is zero lets say, the total exercise of scanning =
pages to reclaim goes in vain since there are no free slots available =
hence the =A0swap tendency should also depend on the number of free slot =
available in the swap device.=20

swap tendency =3D A + B + C ,=20

where A =3D mapped_ratio / 2, B =3D distress=20

and C =3D ( vm_swappiness * nr_swap_pages ) / 32

This third quantity C, is calculated by multiplying vm_swappiness with a =
ratio=A0 of nr_swap_pages =A0divided by 32. The static quantity 32, is =
the number of pages reclaimed per invocation and=A0 nr_swap_pages is the =
number=20
of free slots available in the swap device. When the swap device have =
more free slots, =A0the swap tendency should proportionately increase. =
At the same time when the free slots in the swap device approaches zero =
the swap tendency should proportionately decrease

These analysis has been use to modify the current formula and the result =
is as follows....

swap_tendency =3D mapped_ratio / 2 + distress + ( vm_swappiness * =
nr_swap_pages ) / 32 ;


The test case took 6 hours to complete in a 4G machine and the I/O rates =
were preety fast but the same test case took more than 8 hours to =
complete in version 2.6.17.3 in a 64G system=A0 and the I/O rates were =
preety slower as compared to the former. After the patch was applied, =
the test case completed in a time quite close to a 4G RAM system i.e 6 =
hours and the I/O rates were also much better.=20

The following are the Test Results:-
#########################################################################=
###

Kernel version Tested : 2.6.17.3
System Memory:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 64G
State: Without patch
Time Taken for Completion of the Test Case : 11 Hours approx.
The following are the I/O rates

Doing 50 times: /usr/bin/bonnie -s 1024 -m M1135- -v 3 ...=20

              ---Sequential Output (nosync)--- ---Sequential Input-- =
--Rnd Seek-
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- =
--04k (03)-    Iteration
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU   =
/sec %CPU    Start Date&Time

M1135- 3*1024 23779 95.2 20222 95.3 17248 54.7 26313 84.6 28849 58.9  =
343.9  3.2
M1135- 3*1024 18897 94.1 12698 83.1 11408 72.1 27800 84.7 35135 53.2  =
329.9  3.6
M1135- 3*1024 16945 87.1 12787 91.9 14282 59.6 24895 79.6 27435 62.6  =
339.3  3.4
#########################################################################=
###

Kernel version Tested : =A0 2.6.17.3
System Memory:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 64G
State: =A0 Patch was applied
Time Taken for Completion of the Test Case : =A0=A0=A0=A0=A0 6 Hours and =
30 minutes.
The following are the I/O rates

Doing 50 times: /usr/bin/bonnie -s 1024 -m M1135- -v 3 ...=20

              ---Sequential Output (nosync)--- ---Sequential Input-- =
--Rnd Seek-
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- =
--04k (03)-    Iteration
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU   =
/sec %CPU    Start Date&Time

M1135- 3*1024 25746 93.9 44001 93.6 25134 29.5 40780 81.9 63560 24.0  =
388.0  2.4
M1135- 3*1024 25655 92.7 39142 91.2 24959 28.6 40366 81.3 61830 27.0  =
356.6  3.2
M1135- 3*1024 28122 93.0 30958 97.7 23702 33.2 41839 84.2 66231 24.3  =
388.8  3.1
#########################################################################=
###

Kernel version Tested : =A0 2.6.17.3
System Memory:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4G
State: =A0 No Patch was applied
Time Taken for Completion of the Test Case : 6 Hours approx.

#########################################################################=
###


Signed-off-by: Soumendu Sekhar Satapathy =
<Soumendu.Satapathy@in.unisys.com>

=A0



=A0


------_=_NextPart_001_01C6A024.25992764
Content-Type: application/octet-stream;
	name="mem_scal.patch"
Content-Transfer-Encoding: base64
Content-Description: mem_scal.patch
Content-Disposition: attachment;
	filename="mem_scal.patch"

CgotLS0KCgpkaWZmIC1wdU4gbW0vdm1zY2FuLmN+bWVtX3NjYWwgbW0vdm1zY2FuLmMKLS0tIGxp
bnV4LTIuNi4xNy4zL21tL3Ztc2Nhbi5jfm1lbV9zY2FsCTIwMDYtMDctMDUgMDY6MjM6NTkuMDAw
MDAwMDAwIC0wNDAwCisrKyBsaW51eC0yLjYuMTcuMy1yb290L21tL3Ztc2Nhbi5jCTIwMDYtMDct
MDUgMDY6MjQ6NTYuMDAwMDAwMDAwIC0wNDAwCkBAIC03NDEsNyArNzQxLDcgQEAgc3RhdGljIHZv
aWQgc2hyaW5rX2FjdGl2ZV9saXN0KHVuc2lnbmVkIAogCQkgKiBBIDEwMCUgdmFsdWUgb2Ygdm1f
c3dhcHBpbmVzcyBvdmVycmlkZXMgdGhpcyBhbGdvcml0aG0KIAkJICogYWx0b2dldGhlci4KIAkJ
ICovCi0JCXN3YXBfdGVuZGVuY3kgPSBtYXBwZWRfcmF0aW8gLyAyICsgZGlzdHJlc3MgKyB2bV9z
d2FwcGluZXNzOworCQlzd2FwX3RlbmRlbmN5ID0gbWFwcGVkX3JhdGlvIC8gMiArIGRpc3RyZXNz
ICsgKHZtX3N3YXBwaW5lc3MgKiBucl9zd2FwX3BhZ2VzKS8zMjsKIAogCQkvKgogCQkgKiBOb3cg
dXNlIHRoaXMgbWV0cmljIHRvIGRlY2lkZSB3aGV0aGVyIHRvIHN0YXJ0IG1vdmluZyBtYXBwZWQK
Xwo=

------_=_NextPart_001_01C6A024.25992764--
