Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266853AbUGLOnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266853AbUGLOnB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 10:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266855AbUGLOnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 10:43:01 -0400
Received: from mail004.syd.optusnet.com.au ([211.29.132.145]:8634 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266853AbUGLOmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 10:42:13 -0400
Message-ID: <40F2A339.6050206@kolivas.org>
Date: Tue, 13 Jul 2004 00:42:01 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Instrumenting high latency
References: <cone.1089613755.742689.28499.502@pc.kolivas.org> <75270000.1089642258@[10.10.2.4]> <40F29FCF.3070302@kolivas.org> <78220000.1089642803@[10.10.2.4]>
In-Reply-To: <78220000.1089642803@[10.10.2.4]>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9C023AEB440675AA1A441193"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9C023AEB440675AA1A441193
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Martin J. Bligh wrote:
> --Con Kolivas <kernel@kolivas.org> wrote (on Tuesday, July 13, 2004 00:27:27 +1000):
> 
> 
>>Martin J. Bligh wrote:
>>
>>>>Because of the recent discussion about latency in the kernel I asked 
>>>>William Lee Irwin III to help create some instrumentation to determine 
>>>>where in the kernel there were still sustained periods of non-preemptible 
>>>>code. He hacked together this simple patch which times periods according 
>>>>to the preempt count. Hopefully we can use this patch in the advice of 
>>>>Linus to avoid the "mental masturbation" at guessing where latency is 
>>>>and track down real problem areas.
>>>
>>>
>>>Is this much different from Rick's schedstat's work, which was itself based
>>>on some earlier patches by Bill? I'd hate to end up with two sets of patches,
>>>and schedstats seemed pretty comprehensive to me. He's on vacation, but his
>>>stuff is here, if you want to take a look:
>>>
>>>http://eaglet.rain.com/rick/linux/schedstats/
>>
>>No I remember his work and this is tackling it via a different area if I 
>>recall correctly. He was looking at scheduler latencies as opposed to 
>>non-preemptible kernel code.
> 
> 
> Fair enough ... is it worth adding it to the same harness though? He had lots
> of nice analysis tools set up to do comparisons and graphing, etc.

This works very nicely standalone getting us this for example with the 
fixed patch:

6ms non-preemptible critical section violated 1 ms preempt threshold 
starting at exit_mmap+0x1c/0x188 and ending at exit_mmap+0x118/0x188
  [<c011d769>] dec_preempt_count+0x14f/0x151
  [<c014d0d4>] exit_mmap+0x118/0x188
  [<c014d0d4>] exit_mmap+0x118/0x188
  [<c011df0a>] mmput+0x61/0x7b
  [<c01226fa>] do_exit+0x142/0x510
  [<c014c928>] unmap_vma_list+0xe/0x17
  [<c0122b8a>] do_group_exit+0x41/0xf9
  [<c0105fd5>] sysenter_past_esp+0x52/0x71

which then an objdump of the inlined code has allowed us to track it 
down to this:

          profile_exit_mmap(mm);
          lru_add_drain();
c014cfce:       e8 18 72 ff ff          call   c01441eb <lru_add_drain>
          spin_lock(&mm->page_table_lock);
c014cfd3:       e8 16 06 fd ff          call   c011d5ee <inc_preempt_count>


That's pretty specific. I dont think this comes under the umbrella of 
statistics as such. Sure it can be modified to do it but I was looking 
for a tool to find where specific latency hotspots still exist. Of 
course I'm not capable myself of tackling the actual hotspots but those 
who code those areas certainly can tackle them knowing what firm data shows.

Cheers,
Con

--------------enig9C023AEB440675AA1A441193
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA8qM5ZUg7+tp6mRURAorfAJ99jBRCVd6DzrJTygPdEgynZLVFFgCeOKpM
qR5EnwOOi0Bt5/jIRPefNqE=
=nnBM
-----END PGP SIGNATURE-----

--------------enig9C023AEB440675AA1A441193--
