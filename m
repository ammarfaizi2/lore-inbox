Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWFXKz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWFXKz2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 06:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWFXKz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 06:55:28 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:15273 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751288AbWFXKz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 06:55:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=TpvqloPVT4n7XaUNs+OSF0DmJhGPbbMpP5RIyElnxw65suNU2E5SrK2w7kQ7xwJ1PjNWt4rMwmniK/+9zmaZhvQLMue7grWydi88DkmP5MJsSToL/gnoF2w3HcVDEQOt/phGG8Xbw2iQri4LLQBK+AVbFmdl4scjlidDTt8ZwdU=
Message-ID: <b0943d9e0606240355u69818bf8n657af686a0f6a380@mail.gmail.com>
Date: Sat, 24 Jun 2006 11:55:26 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Cc: "Pekka Enberg" <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <20060624102248.GA23277@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3279_18693510.1151146526035"
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
	 <20060611112156.8641.94787.stgit@localhost.localdomain>
	 <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
	 <b0943d9e0606240320h1727639cv36a4fe399dddd767@mail.gmail.com>
	 <20060624102248.GA23277@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_3279_18693510.1151146526035
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 24/06/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > To the other extreme is Ingo's suggestion of using exact type
> > identification but I don't think this would be acceptable for the
> > kernel as it would to modify all the memory alloc calls in the kernel
> > to either pass an additional parameter (the type id) or another
> > post-allocation call to kmemleak to update the id.
>
> passing in the type ID wouldnt be that bad and it would have other
> advantages as well: for example we could do strict type-checking of
> allocation size versus type-we-use-it-for.

There are valid places in the kernel where the allocated size is
different from the type's one. That's why I added the
memleak_padding().

> As long as the conversion is gradual i think we could try this. I.e.
> we'd default to 'no ID passed', and in that case we would fall back to
> the size-based method and generate an ID out of the structure size.

OK, I'll try to add the infrastructure for type ids but default to
sizeof initially.

> > Anyway, the current implementation (I'll update it for 2.6.17) detects
> > real memory leaks. I suspect that a wide range of leaks would be
> > covered if it is used on different platforms and different conditions.
>
> btw., what leaks were found so far? I know about the ACPI one - any
> other ones?

There are two leaks reported in ACPI but I only posted a patch for one
as I didn't have time to track the other (a reference count doesn't
get to zero and the structure not freed).

There is another leak in legacy_init_iomem_resources() in
arch/i386/setup.c (request_resource() fails but the memory is not
freed - see the attached patch). I initially marked this as a false
positive but it wasn't (I have to revisit the false positives).

-- 
Catalin

------=_Part_3279_18693510.1151146526035
Content-Type: text/x-patch; name=i386-setup-leak.patch; charset=ISO-8859-1
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eotur01j
Content-Disposition: attachment; filename="i386-setup-leak.patch"

Rml4IGEgbWVtb3J5IGxlYWsgaW4gdGhlIGkzODYgc2V0dXAgY29kZQoKRnJvbTogQ2F0YWxpbiBN
YXJpbmFzIDxjYXRhbGluLm1hcmluYXNAZ21haWwuY29tPgoKU2lnbmVkLW9mZi1ieTogQ2F0YWxp
biBNYXJpbmFzIDxjYXRhbGluLm1hcmluYXNAZ21haWwuY29tPgotLS0KCiBhcmNoL2kzODYva2Vy
bmVsL3NldHVwLmMgfCAgICA1ICsrKystCiAxIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2kzODYva2VybmVsL3NldHVwLmMg
Yi9hcmNoL2kzODYva2VybmVsL3NldHVwLmMKaW5kZXggZGQ2YjBlMy4uNjBmNWQ5OSAxMDA2NDQK
LS0tIGEvYXJjaC9pMzg2L2tlcm5lbC9zZXR1cC5jCisrKyBiL2FyY2gvaTM4Ni9rZXJuZWwvc2V0
dXAuYwpAQCAtMTMzMiw3ICsxMzMyLDEwIEBAIGxlZ2FjeV9pbml0X2lvbWVtX3Jlc291cmNlcyhz
dHJ1Y3QgcmVzb3UKIAkJcmVzLT5zdGFydCA9IGU4MjAubWFwW2ldLmFkZHI7CiAJCXJlcy0+ZW5k
ID0gcmVzLT5zdGFydCArIGU4MjAubWFwW2ldLnNpemUgLSAxOwogCQlyZXMtPmZsYWdzID0gSU9S
RVNPVVJDRV9NRU0gfCBJT1JFU09VUkNFX0JVU1k7Ci0JCXJlcXVlc3RfcmVzb3VyY2UoJmlvbWVt
X3Jlc291cmNlLCByZXMpOworCQlpZiAocmVxdWVzdF9yZXNvdXJjZSgmaW9tZW1fcmVzb3VyY2Us
IHJlcykpIHsKKwkJCWtmcmVlKHJlcyk7CisJCQljb250aW51ZTsKKwkJfQogCQlpZiAoZTgyMC5t
YXBbaV0udHlwZSA9PSBFODIwX1JBTSkgewogCQkJLyoKIAkJCSAqICBXZSBkb24ndCBrbm93IHdo
aWNoIFJBTSByZWdpb24gY29udGFpbnMga2VybmVsIGRhdGEsCg==
------=_Part_3279_18693510.1151146526035--
