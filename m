Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131219AbRCWQYJ>; Fri, 23 Mar 2001 11:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131224AbRCWQX7>; Fri, 23 Mar 2001 11:23:59 -0500
Received: from lowell.missioncriticallinux.com ([208.51.139.16]:2738 "EHLO
	jerrell.lowell.mclinux.com") by vger.kernel.org with ESMTP
	id <S131219AbRCWQXr>; Fri, 23 Mar 2001 11:23:47 -0500
Date: Fri, 23 Mar 2001 11:32:41 -0500 (EST)
From: Richard Jerrell <jerrell@missioncriticallinux.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory.c, 2.4.1 : memory leak with swap cache (updated)
In-Reply-To: <Pine.LNX.4.33.0103222014510.24040-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0103231042380.20061-200000@jerrell.lowell.mclinux.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="17458952-220300107-985365014=:20061"
Content-ID: <Pine.LNX.4.21.0103231130160.20061@jerrell.lowell.mclinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--17458952-220300107-985365014=:20061
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.21.0103231130161.20061@jerrell.lowell.mclinux.com>

> Your idea is nice, but the patch lacks a few things:
> 
> - SMP locking, what if some other process faults in this page
>   between the atomic_read of the page count and the test later?

It can't happen.  free_pte is called with the page_table_lock held in 
addition to having the mmap_sem downed.

> - testing if our process is the _only_ user of this swap page,
>   for eg. apache you'll have lots of COW-shared pages .. it would
>   be good to keep the page in memory for our siblings

This is already done in free_page_and_swap_cache.

There is a problem with a possible kernel panic in that
try_to_free_buffers is called with a wait of 1 (thanks to Andrew Morton
for pointing that out) and we might reschedule while we wait on io.  So,
to fix it, here is an even newer (and simpler) patch.  Everything is
handled in free_page_and_swap_cache, so we just call that if we can
successfully look up the entry.

Rich


--17458952-220300107-985365014=:20061
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="2.4.1-paging-fix-23.03.01.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0103231130140.20061@jerrell.lowell.mclinux.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="2.4.1-paging-fix-23.03.01.patch"

ZGlmZiAtLXJlY3Vyc2l2ZSAtdSAtTiBsaW51eC0yLjQuMS9tbS9tZW1vcnku
YyBsaW51eC0yLjQuMS1wYWdpbmctZml4L21tL21lbW9yeS5jDQotLS0gbGlu
dXgtMi40LjEvbW0vbWVtb3J5LmMJU2F0IEphbiAyNyAyMjoxMjozNSAyMDAx
DQorKysgbGludXgtMi40LjEtcGFnaW5nLWZpeC9tbS9tZW1vcnkuYwlUaHUg
RmViIDE1IDEzOjM2OjA2IDIwMDENCkBAIC0yODEsNyArMjgxLDE2IEBADQog
CQlyZXR1cm4gMTsNCiAJfQ0KIAlzd2FwX2ZyZWUocHRlX3RvX3N3cF9lbnRy
eShwdGUpKTsNCi0JcmV0dXJuIDA7DQorCXsNCisJCXN0cnVjdCBwYWdlICpw
YWdlID0gbG9va3VwX3N3YXBfY2FjaGUocHRlX3RvX3N3cF9lbnRyeShwdGUp
KTsNCisJCS8qIHJldHVybnMgdGhlIHBhZ2UgYW5kIHRha2VzIGEgcmVmZXJl
bmNlICovDQorDQorCQlpZiAoIXBhZ2UgfHwgKCFWQUxJRF9QQUdFKHBhZ2Up
KSB8fCBQYWdlUmVzZXJ2ZWQocGFnZSkpDQorCQlyZXR1cm4gMDsNCisNCisJ
CWZyZWVfcGFnZV9hbmRfc3dhcF9jYWNoZShwYWdlKTsgLyogRXhwZWN0cyB0
aGUgcGFnZSB0byBiZSBtYXBwZWQsIHNvIHdpbGwgKi8NCisJCXJldHVybiAx
OyAgICAgICAgICAgICAgICAgICAgICAgLyogYWNjb3VudCBmb3IgdGhlIHJl
ZmVyZW5jZSB3ZSBoYXZlICAgICAgKi8NCisJfQ0KIH0NCiANCiBzdGF0aWMg
aW5saW5lIHZvaWQgZm9yZ2V0X3B0ZShwdGVfdCBwYWdlKQ0K
--17458952-220300107-985365014=:20061--
