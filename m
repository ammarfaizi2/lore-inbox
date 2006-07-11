Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWGKQbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWGKQbZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWGKQbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:31:25 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:57302 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750767AbWGKQbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:31:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=fk1B2YEGXg8Cp5UseWAVRkhWSXJkA2RRTqGhswt8XQ7mZpZ9MoLHAeKBeaNlw8sQbkV3hZ5MYy4pOoJowHuqywO+An8r9qZ6RMwIvAnlfQXXBFIUV+kL7iXNkiQPZSNvqyoJxLGOceQ6UlzIs4b/+hmJHTEi7ytUYKVJgrSSLKA=
Message-ID: <b0943d9e0607110931n4ce1c569x83aa134e2889926c@mail.gmail.com>
Date: Tue, 11 Jul 2006 17:31:23 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0607110902u4e24a4f2jc6acf2eb4c3bae93@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_67269_14642138.1152635483659"
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <6bffcb0e0607110527x4520d5bbne8b9b3639a821a18@mail.gmail.com>
	 <b0943d9e0607110556v50185b9i5443dabedba46152@mail.gmail.com>
	 <6bffcb0e0607110617g36f7123dm2b5f0e88b10cbcaa@mail.gmail.com>
	 <b0943d9e0607110628w60a436f7t449714eb4a3200ca@mail.gmail.com>
	 <6bffcb0e0607110649s464840a9sf04c7537809436b1@mail.gmail.com>
	 <b0943d9e0607110702p60f5bf3fg910304bfe06ec168@mail.gmail.com>
	 <6bffcb0e0607110802w4f423854rb340227331084596@mail.gmail.com>
	 <b0943d9e0607110844m6278da6crdc03bccce420da1d@mail.gmail.com>
	 <6bffcb0e0607110902u4e24a4f2jc6acf2eb4c3bae93@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_67269_14642138.1152635483659
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 11/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> On 11/07/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > Looking at the call trace, the pointer to the memory allocated in
> > context_struct_to_string() is stored in the "cb" variable in struct
> > sk_buff (argument passed to selinux_socket_getpeersec_dgram from
> > unix_get_peersec_dgram).
> >
> > This pointer should be found when scanning the "struct sk_buff"
> > blocks, unless you also get a comparable number of "struct sk_buff"
> > reports (from __alloc_skb). If not, it might be a real leak.
>
> So if we got 3970
> orphan pointer 0xf5a6fd60 (size 39):
>   c0173822: <__kmalloc>
>   c01df500: <context_struct_to_string>
[...]
> and 4673
> orphan pointer 0xf4249488 (size 29):
>   c0173822: <__kmalloc>
>   c01df500: <context_struct_to_string>
[...]
> It's not a memleak?

Not exactly. What I meant is that if you have a corresponding number
of reports from __alloc_skb, maybe they were false positives and the
block wasn't scanned leading to other false positive reports

It looks like there are some reports in __alloc_skb. Please try the
attached patch.

Thanks.

-- 
Catalin

------=_Part_67269_14642138.1152635483659
Content-Type: text/x-patch; name="alloc_skb-false-positive.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="alloc_skb-false-positive.patch"
X-Attachment-Id: f_epihe32h

Q2xlYXIgdGhlIGZhbHNlIHBvc2l0aXZlIGluIF9fYWxsb2Nfc2tiCgpGcm9tOiBDYXRhbGluIE1h
cmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPgoKVGhpcyBoYXBwZW5zIHdoZW4gZmNsb25l
IGlzIDEgYmVjYXVzZSB0aGUgYWxsb2NhdGVkIHNpemUgaXMgZGlmZmVyZW50IGZyb20KdGhlIHN0
cnVjdCBza19idWZmIG9uZSBhbmQgdGhlcmVmb3JlIHRoZSBwb2ludGVyIGFsaWFzZXMgYXJlIG5v
dCBjb3JyZWN0bHkKZGV0ZXJtaW5lZC4KClNpZ25lZC1vZmYtYnk6IENhdGFsaW4gTWFyaW5hcyA8
Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+Ci0tLQoKIG5ldC9jb3JlL3NrYnVmZi5jIHwgICAgMyAr
KysKIDEgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL25ldC9jb3JlL3NrYnVmZi5jIGIvbmV0L2NvcmUvc2tidWZmLmMKaW5kZXggNDRm
NmExOC4uZWU0ZmQ5YiAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvc2tidWZmLmMKKysrIGIvbmV0L2Nv
cmUvc2tidWZmLmMKQEAgLTE1OCw2ICsxNTgsOSBAQCBzdHJ1Y3Qgc2tfYnVmZiAqX19hbGxvY19z
a2IodW5zaWduZWQgaW50CiAKIAkvKiBHZXQgdGhlIEhFQUQgKi8KIAlza2IgPSBrbWVtX2NhY2hl
X2FsbG9jKGNhY2hlLCBnZnBfbWFzayAmIH5fX0dGUF9ETUEpOworCS8qIHRoZSBza2J1ZmZfZmNs
b25lX2NhY2hlIGNvbnRhaW5zIG9iamVjdHMgbGFyZ2VyIHRoYW4KKwkgKiAic3RydWN0IHNrX2J1
ZmYiIGFuZCBrbWVtbGVhayBjYW5ub3QgZ3Vlc3MgdGhlIHR5cGUgKi8KKwltZW1sZWFrX3R5cGVp
ZChza2IsIHN0cnVjdCBza19idWZmKTsKIAlpZiAoIXNrYikKIAkJZ290byBvdXQ7CiAK
------=_Part_67269_14642138.1152635483659--
