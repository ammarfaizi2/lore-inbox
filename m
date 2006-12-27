Return-Path: <linux-kernel-owner+w=401wt.eu-S932793AbWL0Mc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932793AbWL0Mc2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 07:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932796AbWL0Mc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 07:32:28 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:27150 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932793AbWL0Mc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 07:32:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=PlS86GSJEWzukRnS2JciQTTK2iGN3AcJb2lDq3oY8cwdahjiTn0Qt/RlzuPI9EtGUUDpEJSUWCcBqYKKBgRQ0VSf4OJBjD9L0CmRb2CkEgEcf6d62ugajFwewvRiNiA3VxpT3dV6g9XP1gcSCwKnQOjbVqz/biQg0Cov6fejyYg=
Message-ID: <b3f268590612270432j23fdfabdx69979d987d039822@mail.gmail.com>
Date: Wed, 27 Dec 2006 21:32:27 +0900
From: "Jari Sundell" <sundell.software@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Andrei Popa" <andrei.popa@i-neo.ro>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "David S. Miller" <davem@davemloft.net>,
       "Andrew Morton" <akpm@osdl.org>,
       "Gordon Farquharson" <gordonfarquharson@gmail.com>,
       "Martin Michlmayr" <tbm@cyrius.com>, "Hugh Dickins" <hugh@veritas.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612261007100.3671@woody.osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_77864_20917843.1167222747010"
References: <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
	 <20061224005752.937493c8.akpm@osdl.org>
	 <1166962478.7442.0.camel@localhost>
	 <20061224043102.d152e5b4.akpm@osdl.org>
	 <1166978752.7022.1.camel@localhost>
	 <Pine.LNX.4.64.0612240907180.3671@woody.osdl.org>
	 <Pine.LNX.4.64.0612241029460.3671@woody.osdl.org>
	 <Pine.LNX.4.64.0612241115130.3671@woody.osdl.org>
	 <4590F9E5.4060300@yahoo.com.au>
	 <Pine.LNX.4.64.0612261007100.3671@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_77864_20917843.1167222747010
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/27/06, Linus Torvalds <torvalds@osdl.org> wrote:
<snip>
>  - It never uses mprotect on the shared mappings, but it _does_ do:
>         "mincore()" - but the return values don't much matter (it's used
>                       as a heuristic on which parts to hash, apparently)
>
>                       I double- and triple-checked this one, because I
>                       did make changes to "mincore()", but those didn't go
>                       into the affected kernels anyway (ie they are not in
>                       plain 2.6.19, nor in 2.6.18.3 either)

Correct, mincore is only used to check if it should delay the hash checking.

>         "madvise(MADV_WILLNEED)"
>         "msync(MS_ASYNC)" (or MS_SYNC if you use a command line flag)
>         "munmap()" of course
>
>  - it never seems to mix mmap() and write() - it does _only_ mmap.
>
>  - it seems to mmap/munmap the shared files in nice 64-page chunks, all
>    64-page aligned in the file (ie it does NOT create one big mapping, it
>    has some kind of LRU of thse 64-page chunks). The only exception being
>    the last chunk, which it maps byte-accurate to the size.

The length of the chunks is only page aligned on single file torrents,
not so on multi-file torrents. I've attached a patch for rtorrent that
will extend the length to the page boundary.

>  - I haven't checked whether it only ever has the same chunk mapped once
>    at a time.

This should be the case, but two mapped chunks may share a page,
sometimes with different r/w permissions.

Jari Sundell

------=_Part_77864_20917843.1167222747010
Content-Type: application/octet-stream; name=extend_mapping.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ew7q7zfl
Content-Disposition: attachment; filename="extend_mapping.diff"

SW5kZXg6IGxpYnRvcnJlbnQvc3JjL2RhdGEvc29ja2V0X2ZpbGUuY2MKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0g
bGlidG9ycmVudC9zcmMvZGF0YS9zb2NrZXRfZmlsZS5jYwkocmV2aXNpb24gODI3KQorKysgbGli
dG9ycmVudC9zcmMvZGF0YS9zb2NrZXRfZmlsZS5jYwkod29ya2luZyBjb3B5KQpAQCAtMTYyLDIw
ICsxNjIsMjcgQEAKIE1lbW9yeUNodW5rCiBTb2NrZXRGaWxlOjpjcmVhdGVfY2h1bmsodWludDY0
X3Qgb2Zmc2V0LCB1aW50MzJfdCBsZW5ndGgsIGludCBwcm90LCBpbnQgZmxhZ3MpIGNvbnN0IHsK
ICAgaWYgKCFpc19vcGVuKCkpCi0gICAgdGhyb3cgaW50ZXJuYWxfZXJyb3IoIlNvY2tldEZpbGU6
OmdldF9jaHVuaygpIGNhbGxlZCBvbiBhIGNsb3NlZCBmaWxlIik7CisgICAgdGhyb3cgaW50ZXJu
YWxfZXJyb3IoIlNvY2tldEZpbGU6OmdldF9jaHVuaygpIGNhbGxlZCBvbiBhIGNsb3NlZCBmaWxl
LiIpOwogCiAgIGlmICgoKHByb3QgJiBNZW1vcnlDaHVuazo6cHJvdF9yZWFkKSAmJiAhaXNfcmVh
ZGFibGUoKSkgfHwKICAgICAgICgocHJvdCAmIE1lbW9yeUNodW5rOjpwcm90X3dyaXRlKSAmJiAh
aXNfd3JpdGFibGUoKSkpCi0gICAgdGhyb3cgc3RvcmFnZV9lcnJvcigiU29ja2V0RmlsZTo6Z2V0
X2NodW5rKCkgcGVybWlzc2lvbiBkZW5pZWQiKTsKKyAgICB0aHJvdyBzdG9yYWdlX2Vycm9yKCJT
b2NrZXRGaWxlOjpnZXRfY2h1bmsoKSBwZXJtaXNzaW9uIGRlbmllZC4iKTsKIAorICB1aW50NjRf
dCBmaWxlU2l6ZSA9IHNpemUoKTsKKwogICAvLyBGb3Igc29tZSByZWFzb24gbWFwcGluZyBiZXlv
bmQgdGhlIGV4dGVudCBvZiB0aGUgZmlsZSBkb2VzIG5vdAogICAvLyBjYXVzZSBtbWFwIHRvIGNv
bXBsYWluLCBzbyB3ZSBuZWVkIHRvIGNoZWNrIG1hbnVhbGx5IGhlcmUuCi0gIGlmIChvZmZzZXQg
PCAwIHx8IGxlbmd0aCA9PSAwIHx8IG9mZnNldCA+IHNpemUoKSB8fCBvZmZzZXQgKyBsZW5ndGgg
PiBzaXplKCkpCisgIGlmIChvZmZzZXQgPCAwIHx8IGxlbmd0aCA9PSAwIHx8IG9mZnNldCA+IGZp
bGVTaXplIHx8IG9mZnNldCArIGxlbmd0aCA+IGZpbGVTaXplKQogICAgIHJldHVybiBNZW1vcnlD
aHVuaygpOwogCi0gIHVpbnQ2NF90IGFsaWduID0gb2Zmc2V0ICUgTWVtb3J5Q2h1bms6OnBhZ2Vf
c2l6ZSgpOworICB1aW50NjRfdCBhbGlnbiAgICAgPSBvZmZzZXQgJSBNZW1vcnlDaHVuazo6cGFn
ZV9zaXplKCk7CisgIHVpbnQ2NF90IG1hcExlbmd0aCA9IHN0ZDo6bWluKCgobGVuZ3RoICsgYWxp
Z24gKyBNZW1vcnlDaHVuazo6cGFnZV9zaXplKCkgLSAxKSAvIE1lbW9yeUNodW5rOjpwYWdlX3Np
emUoKSkgKiBNZW1vcnlDaHVuazo6cGFnZV9zaXplKCksCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGZpbGVTaXplIC0gKG9mZnNldCAtIGFsaWduKSk7CiAKLSAgY2hhciogcHRyID0g
KGNoYXIqKW1tYXAoTlVMTCwgbGVuZ3RoICsgYWxpZ24sIHByb3QsIGZsYWdzLCBtX2ZkLCBvZmZz
ZXQgLSBhbGlnbik7CisgIGlmIChvZmZzZXQgLSBhbGlnbiArIG1hcExlbmd0aCAhPSBmaWxlU2l6
ZSAmJiAob2Zmc2V0IC0gYWxpZ24gKyBtYXBMZW5ndGgpICUgTWVtb3J5Q2h1bms6OnBhZ2Vfc2l6
ZSgpICE9IDApCisgICAgdGhyb3cgaW50ZXJuYWxfZXJyb3IoIlNvY2tldEZpbGU6OmNyZWF0ZV9j
aHVuayguLi4pIExlbmd0aCBub3QgcGFnZSBhbGlnbmVkLiIpOworCisgIGNoYXIqIHB0ciA9IChj
aGFyKiltbWFwKE5VTEwsIG1hcExlbmd0aCwgcHJvdCwgZmxhZ3MsIG1fZmQsIG9mZnNldCAtIGFs
aWduKTsKICAgCiAgIGlmIChwdHIgPT0gTUFQX0ZBSUxFRCkKICAgICByZXR1cm4gTWVtb3J5Q2h1
bmsoKTsK
------=_Part_77864_20917843.1167222747010--
