Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWBFTQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWBFTQF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWBFTQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:16:05 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:6312 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932282AbWBFTQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:16:02 -0500
Message-ID: <43E7A06D.80901@us.ibm.com>
Date: Mon, 06 Feb 2006 13:15:57 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Hugh Dickins <hugh@veritas.com>, "David S. Miller" <davem@davemloft.net>,
       Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org,
       Linux Arch list <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ipr: don't doublefree pages from scatterlist
References: <Pine.LNX.4.61.0602040004020.5406@goblin.wat.veritas.com>	 <43E66FB6.6070303@us.ibm.com>	 <Pine.LNX.4.61.0602060909180.6827@goblin.wat.veritas.com>	 <20060206.014608.22328385.davem@davemloft.net>	 <43E7613B.5060706@us.ibm.com>	 <Pine.LNX.4.61.0602061621450.3560@goblin.wat.veritas.com> <1139247516.3022.6.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1139247516.3022.6.camel@mulgrave.il.steeleye.com>
Content-Type: multipart/mixed;
 boundary="------------050306050202070909020808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050306050202070909020808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

James Bottomley wrote:
> On Mon, 2006-02-06 at 16:45 +0000, Hugh Dickins wrote:
>> But I'd also want James or someone to clarify the paragraph
>> "Please note that the sg cannot be mapped again if it has been mapped once.
>>  The mapping process is allowed to destroy information in the sg."
>> which I took as explicitly allowing what x86_64 does in gart_map_sg.
>> I thought James had a scenario in mind which demands this wholesale
>> destruction, but it seems not; and I now read that first sentence as
>> saying the sg must be unmapped before it can be mapped a second time,
>> not that it can only be mapped once.
>>
>> And add a paragraph explaining that really the one array of scatterlist
>> entries should be regarded as two arrays of possibly different lengths,
>> the page,offset,length array and the dma_address,dma_length array:
>> because entries of the latter may be coalesced, so that in the end
>> the dma_address in a scatterlength entry may bear no relation to the
>> page pointer in that same entry, but to the page pointer in a later entry.
>> Though it gets hard to explain given that not all architectures coalesce,
>> so may not even have a separate dma_length field; or use different naming.
>> If you can express this better than I, please do!
> 
> Yes, I added that piece after the x86_64 problem.  The original x86_64
> bug was that you couldn't do dma_map_sg() then dma_unmap_sg() then
> dma_map_sg() on the same scatterlist (the map was destroying information
> which wasn't restored on the unmap, so the second map produced an
> incorrect scatterlist), which was causing a bug in all SCSI drivers
> (because that's the way SCSI requeueing works).

Here is a second try at a documentation update. Any takers to fixup x86_64?

Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

--------------050306050202070909020808
Content-Type: text/x-patch;
 name="dma_mapping_clarification.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dma_mapping_clarification.patch"

ClRoZSBjdXJyZW50IHBjaV9tYXBfc2cgQVBJIGlzIGEgYml0IHVuY2xlYXIgd2hhdCBpdCBp
cyBhbGxvd2VkCnRvIG1vZGlmeSBpbiB0aGUgcGFzc2VkIHNjYXR0ZXJsaXN0IHdoZW4gY29h
bGVzY2luZyBlbnRyaWVzLgpDbGFyaWZ5IHRoZSBwY2lfbWFwX3NnIEFQSSB0byBwcmV2ZW50
IGl0IGZyb20gbW9kaWZ5aW5nCnRoZSBwYWdlLCBvZmZzZXQsIGFuZCBsZW5ndGggZmllbGRz
IGluIHRoZSBzY2F0dGVybGlzdC4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIEtpbmcgPGJya2lu
Z0B1cy5pYm0uY29tPgotLS0KCiBsaW51eC0yLjYtYmpraW5nMS9Eb2N1bWVudGF0aW9uL0RN
QS1BUEkudHh0ICAgICB8ICAgIDUgKysrLS0KIGxpbnV4LTIuNi1iamtpbmcxL0RvY3VtZW50
YXRpb24vRE1BLW1hcHBpbmcudHh0IHwgICAgNSArKysrLQogMiBmaWxlcyBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC1wdU4gRG9jdW1lbnRhdGlv
bi9ETUEtbWFwcGluZy50eHR+ZG1hX21hcHBpbmdfY2xhcmlmaWNhdGlvbiBEb2N1bWVudGF0
aW9uL0RNQS1tYXBwaW5nLnR4dAotLS0gbGludXgtMi42L0RvY3VtZW50YXRpb24vRE1BLW1h
cHBpbmcudHh0fmRtYV9tYXBwaW5nX2NsYXJpZmljYXRpb24JMjAwNi0wMi0wNiAxMzowNTo1
Mi4wMDAwMDAwMDAgLTA2MDAKKysrIGxpbnV4LTIuNi1iamtpbmcxL0RvY3VtZW50YXRpb24v
RE1BLW1hcHBpbmcudHh0CTIwMDYtMDItMDYgMTM6MDU6NTIuMDAwMDAwMDAwIC0wNjAwCkBA
IC01MTMsNyArNTEzLDEwIEBAIGNvbnNlY3V0aXZlIHNnbGlzdCBlbnRyaWVzIGNhbiBiZSBt
ZXJnZWQKIGVuZHMgYW5kIHRoZSBzZWNvbmQgb25lIHN0YXJ0cyBvbiBhIHBhZ2UgYm91bmRh
cnkgLSBpbiBmYWN0IHRoaXMgaXMgYSBodWdlCiBhZHZhbnRhZ2UgZm9yIGNhcmRzIHdoaWNo
IGVpdGhlciBjYW5ub3QgZG8gc2NhdHRlci1nYXRoZXIgb3IgaGF2ZSB2ZXJ5CiBsaW1pdGVk
IG51bWJlciBvZiBzY2F0dGVyLWdhdGhlciBlbnRyaWVzKSBhbmQgcmV0dXJucyB0aGUgYWN0
dWFsIG51bWJlcgotb2Ygc2cgZW50cmllcyBpdCBtYXBwZWQgdGhlbSB0by4gT24gZmFpbHVy
ZSAwIGlzIHJldHVybmVkLgorb2Ygc2cgZW50cmllcyBpdCBtYXBwZWQgdGhlbSB0by4gVGhl
IGltcGxlbWVudGF0aW9uIGlzIGZyZWUgdG8gZG8gdGhpcworYnkgbW9kaWZ5aW5nIHRoZSBz
Y2F0dGVybGlzdCBmaWVsZHMgc3BlY2lmaWVkIGZvciBETUEuIFRoZSBzY2F0dGVybGlzdAor
ZmllbGRzIHVzZWQgYXMgYW4gaW5wdXQgdG8gdGhpcyBmdW5jdGlvbiAoaS5lLiBwYWdlLCBv
ZmZzZXQsIGFuZCBsZW5ndGgpCit3aWxsIE5PVCBiZSBtb2RpZmllZC4gT24gZmFpbHVyZSAw
IGlzIHJldHVybmVkLgogCiBUaGVuIHlvdSBzaG91bGQgbG9vcCBjb3VudCB0aW1lcyAobm90
ZTogdGhpcyBjYW4gYmUgbGVzcyB0aGFuIG5lbnRzIHRpbWVzKQogYW5kIHVzZSBzZ19kbWFf
YWRkcmVzcygpIGFuZCBzZ19kbWFfbGVuKCkgbWFjcm9zIHdoZXJlIHlvdSBwcmV2aW91c2x5
CmRpZmYgLXB1TiBEb2N1bWVudGF0aW9uL0RNQS1BUEkudHh0fmRtYV9tYXBwaW5nX2NsYXJp
ZmljYXRpb24gRG9jdW1lbnRhdGlvbi9ETUEtQVBJLnR4dAotLS0gbGludXgtMi42L0RvY3Vt
ZW50YXRpb24vRE1BLUFQSS50eHR+ZG1hX21hcHBpbmdfY2xhcmlmaWNhdGlvbgkyMDA2LTAy
LTA2IDEzOjA2OjE3LjAwMDAwMDAwMCAtMDYwMAorKysgbGludXgtMi42LWJqa2luZzEvRG9j
dW1lbnRhdGlvbi9ETUEtQVBJLnR4dAkyMDA2LTAyLTA2IDEzOjA3OjQwLjAwMDAwMDAwMCAt
MDYwMApAQCAtMzE4LDggKzMxOCw5IEBAIHRoYW4gPG5lbnRzPiBwYXNzZWQgaW4gaWYgdGhl
IGJsb2NrIGxheWUKIGVsZW1lbnRzIG9mIHRoZSBzY2F0dGVyL2dhdGhlciBsaXN0IGFyZSBw
aHlzaWNhbGx5IGFkamFjZW50IGFuZCB0aHVzCiBtYXkgYmUgbWFwcGVkIHdpdGggYSBzaW5n
bGUgZW50cnkpLgogCi1QbGVhc2Ugbm90ZSB0aGF0IHRoZSBzZyBjYW5ub3QgYmUgbWFwcGVk
IGFnYWluIGlmIGl0IGhhcyBiZWVuIG1hcHBlZCBvbmNlLgotVGhlIG1hcHBpbmcgcHJvY2Vz
cyBpcyBhbGxvd2VkIHRvIGRlc3Ryb3kgaW5mb3JtYXRpb24gaW4gdGhlIHNnLgorUGxlYXNl
IG5vdGUgdGhhdCB0aGUgc2cgY2FuIGJlIG1hcHBlZCBhZ2FpbiwgYXMgbG9uZyBhcyBpdCBp
cyB1bm1hcHBlZAorZmlyc3QuIFRoZSBtYXBwaW5nIHByb2Nlc3MgaXMgb25seSBhbGxvd2Vk
IHRvIG1vZGlmeSB0aGUgc2NhdHRlcmxpc3QKK2ZpZWxkcyByZWxhdGVkIHRvIERNQS4KIAog
QXMgd2l0aCB0aGUgb3RoZXIgbWFwcGluZyBpbnRlcmZhY2VzLCBkbWFfbWFwX3NnIGNhbiBm
YWlsLiBXaGVuIGl0CiBkb2VzLCAwIGlzIHJldHVybmVkIGFuZCBhIGRyaXZlciBtdXN0IHRh
a2UgYXBwcm9wcmlhdGUgYWN0aW9uLiBJdCBpcwpfCg==
--------------050306050202070909020808--
