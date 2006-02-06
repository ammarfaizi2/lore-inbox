Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWBFOqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWBFOqZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 09:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWBFOqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 09:46:25 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:64137 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932130AbWBFOqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 09:46:24 -0500
Message-ID: <43E7613B.5060706@us.ibm.com>
Date: Mon, 06 Feb 2006 08:46:19 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: hugh@veritas.com, James.Bottomley@SteelEye.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] ipr: don't doublefree pages from scatterlist
References: <Pine.LNX.4.61.0602040004020.5406@goblin.wat.veritas.com>	<43E66FB6.6070303@us.ibm.com>	<Pine.LNX.4.61.0602060909180.6827@goblin.wat.veritas.com> <20060206.014608.22328385.davem@davemloft.net>
In-Reply-To: <20060206.014608.22328385.davem@davemloft.net>
Content-Type: multipart/mixed;
 boundary="------------040008040005060309090303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040008040005060309090303
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

David S. Miller wrote:
> From: Hugh Dickins <hugh@veritas.com>
> Date: Mon, 6 Feb 2006 09:32:54 +0000 (GMT)
> 
>> From looking at the source, the architectures I found to be doing
>> scatterlist coalescing in some cases were alpha, ia64, parisc (some
>> code under drivers), powerpc, sparc64 and x86_64.
>>
>> I agree with you that it would be possible for them to do the coalescing
>> by just adjusting dma_address and dma_length (though it's architecture-
>> dependent whether there are such fields at all), not interfering with
>> the input page and length; and maybe some of them do proceed that way.
>> I didn't find the coalescing code in any of them very easy to follow.
>>
>> So please examine arch/x86_64/kernel/pci_gart.c gart_map_sg (and
>> dma_map_cont which it calls): x86_64 was the architecture on which
>> the problem was really found with drivers/scsi/st.c, and avoided
>> by that boot option iommu=nomerge.
>>
>> Lines like "*sout = *s;" and "*sout = sg[start];" are structure-
>> copying whole scallerlist entries from one position in the list
>> to another, without explicit mention of the page and length fields.
> 
> That's a bug, frankly.  Sparc64 doesn't need to do anything like
> that.  Spamming the page pointers is really really bogus and I'm
> surprised this doesn't make more stuff explode.
> 
> It was never the intention to allow the DMA mapping support code
> to modify the page, offset, and length members of the scatterlist.
> Only the DMA components.
> 
> I'd really prefer that those assignments get fixed and an explicit
> note added to Documentation/DMA-mapping.txt about this.

How about this for a documentation fix?

Brian


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

--------------040008040005060309090303
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
QS1tYXBwaW5nLnR4dCB8ICAgIDUgKysrKy0KIDEgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC1wdU4gRG9jdW1lbnRhdGlvbi9ETUEtbWFw
cGluZy50eHR+ZG1hX21hcHBpbmdfY2xhcmlmaWNhdGlvbiBEb2N1bWVudGF0aW9uL0RNQS1t
YXBwaW5nLnR4dAotLS0gbGludXgtMi42L0RvY3VtZW50YXRpb24vRE1BLW1hcHBpbmcudHh0
fmRtYV9tYXBwaW5nX2NsYXJpZmljYXRpb24JMjAwNi0wMi0wNiAwODoyMzoxMC4wMDAwMDAw
MDAgLTA2MDAKKysrIGxpbnV4LTIuNi1iamtpbmcxL0RvY3VtZW50YXRpb24vRE1BLW1hcHBp
bmcudHh0CTIwMDYtMDItMDYgMDg6Mzg6NDMuMDAwMDAwMDAwIC0wNjAwCkBAIC01MTMsNyAr
NTEzLDEwIEBAIGNvbnNlY3V0aXZlIHNnbGlzdCBlbnRyaWVzIGNhbiBiZSBtZXJnZWQKIGVu
ZHMgYW5kIHRoZSBzZWNvbmQgb25lIHN0YXJ0cyBvbiBhIHBhZ2UgYm91bmRhcnkgLSBpbiBm
YWN0IHRoaXMgaXMgYSBodWdlCiBhZHZhbnRhZ2UgZm9yIGNhcmRzIHdoaWNoIGVpdGhlciBj
YW5ub3QgZG8gc2NhdHRlci1nYXRoZXIgb3IgaGF2ZSB2ZXJ5CiBsaW1pdGVkIG51bWJlciBv
ZiBzY2F0dGVyLWdhdGhlciBlbnRyaWVzKSBhbmQgcmV0dXJucyB0aGUgYWN0dWFsIG51bWJl
cgotb2Ygc2cgZW50cmllcyBpdCBtYXBwZWQgdGhlbSB0by4gT24gZmFpbHVyZSAwIGlzIHJl
dHVybmVkLgorb2Ygc2cgZW50cmllcyBpdCBtYXBwZWQgdGhlbSB0by4gVGhlIGltcGxlbWVu
dGF0aW9uIGlzIGZyZWUgdG8gZG8gdGhpcworYnkgbW9kaWZ5aW5nIHRoZSBzY2F0dGVybGlz
dCBmaWVsZHMgc3BlY2lmaWVkIGZvciBETUEuIFRoZSBzY2F0dGVybGlzdAorZmllbGRzIHVz
ZWQgYXMgYW4gaW5wdXQgdG8gdGhpcyBmdW5jdGlvbiAoaS5lLiBwYWdlLCBvZmZzZXQsIGFu
ZCBsZW5ndGgpCit3aWxsIE5PVCBiZSBtb2RpZmllZC4gT24gZmFpbHVyZSAwIGlzIHJldHVy
bmVkLgogCiBUaGVuIHlvdSBzaG91bGQgbG9vcCBjb3VudCB0aW1lcyAobm90ZTogdGhpcyBj
YW4gYmUgbGVzcyB0aGFuIG5lbnRzIHRpbWVzKQogYW5kIHVzZSBzZ19kbWFfYWRkcmVzcygp
IGFuZCBzZ19kbWFfbGVuKCkgbWFjcm9zIHdoZXJlIHlvdSBwcmV2aW91c2x5Cl8K
--------------040008040005060309090303--
