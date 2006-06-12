Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932624AbWFLW3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbWFLW3M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 18:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbWFLW3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 18:29:12 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:24404 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932624AbWFLW3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 18:29:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=fnAwg2ZKz9bJ1KMqTBstfAl0hSNEuKvZHnA5qkofpueetP8FnihsGs6Fhbnu8JiuTMrJowrFSr+Ic5TryntBEULAV8C1TA1FrbG5gWbyWeEeFKECJsBpoFclrtkhJWzXzkNswi/3JvH2FpOtlnTDh2f7AzluR+7Dk2KbKBr4Rrc=
Message-ID: <b0943d9e0606121529u25c10c6fjf0127df1e850fd5b@mail.gmail.com>
Date: Mon, 12 Jun 2006 23:29:08 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Cc: "Pekka J Enberg" <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <20060612131209.GB17463@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_340_25204261.1150151348876"
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
	 <20060611112156.8641.94787.stgit@localhost.localdomain>
	 <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
	 <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com>
	 <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI>
	 <20060612105345.GA8418@elte.hu>
	 <Pine.LNX.4.58.0606121404080.7129@sbz-30.cs.Helsinki.FI>
	 <20060612113637.GA14136@elte.hu>
	 <Pine.LNX.4.58.0606121446130.7129@sbz-30.cs.Helsinki.FI>
	 <20060612131209.GB17463@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_340_25204261.1150151348876
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/06/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
>
> > > >   - arch/i386/kernel/setup.c:
> > > >     False positive because res pointer is stored in a global instance of
> > > >     struct resource.
> > >
> > > there's no good way around this one but to annotate it in one way or
> > > another.
> >
> > Scanning bss and data sections is too expensive, I guess.  I would
> > prefer we create a separate section for gc roots but what you're
> > suggesting is ok as well.
>
> kmemleak does scan global data sections. I dont know why we dont
> discover this particular pointer though: the resource pointer ought to
> be accessible via the iomem_resource.parent/sibling/child sorted list.
> Hm.

I tested it on my x86 machine and kmemleak is right, this is a leak
because request_resource() returns -EBUSY. Something like the attached
patch fixes it (I'm not sure that's the correct fix, maybe we should
check why the resource overlaps with something else).

-- 
Catalin

------=_Part_340_25204261.1150151348876
Content-Type: text/x-patch; name="setup-leak.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="setup-leak.patch"
X-Attachment-Id: f_eodee9cn

ZGlmZiAtLWdpdCBhL2FyY2gvaTM4Ni9rZXJuZWwvc2V0dXAuYyBiL2FyY2gvaTM4Ni9rZXJuZWwv
c2V0dXAuYwppbmRleCBkZDZiMGUzLi42MGY1ZDk5IDEwMDY0NAotLS0gYS9hcmNoL2kzODYva2Vy
bmVsL3NldHVwLmMKKysrIGIvYXJjaC9pMzg2L2tlcm5lbC9zZXR1cC5jCkBAIC0xMzMyLDcgKzEz
MzIsMTAgQEAgbGVnYWN5X2luaXRfaW9tZW1fcmVzb3VyY2VzKHN0cnVjdCByZXNvdQogCQlyZXMt
PnN0YXJ0ID0gZTgyMC5tYXBbaV0uYWRkcjsKIAkJcmVzLT5lbmQgPSByZXMtPnN0YXJ0ICsgZTgy
MC5tYXBbaV0uc2l6ZSAtIDE7CiAJCXJlcy0+ZmxhZ3MgPSBJT1JFU09VUkNFX01FTSB8IElPUkVT
T1VSQ0VfQlVTWTsKLQkJcmVxdWVzdF9yZXNvdXJjZSgmaW9tZW1fcmVzb3VyY2UsIHJlcyk7CisJ
CWlmIChyZXF1ZXN0X3Jlc291cmNlKCZpb21lbV9yZXNvdXJjZSwgcmVzKSkgeworCQkJa2ZyZWUo
cmVzKTsKKwkJCWNvbnRpbnVlOworCQl9CiAJCWlmIChlODIwLm1hcFtpXS50eXBlID09IEU4MjBf
UkFNKSB7CiAJCQkvKgogCQkJICogIFdlIGRvbid0IGtub3cgd2hpY2ggUkFNIHJlZ2lvbiBjb250
YWlucyBrZXJuZWwgZGF0YSwK
------=_Part_340_25204261.1150151348876--
