Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWD3Rjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWD3Rjl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 13:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWD3Rjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 13:39:41 -0400
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:9816 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751207AbWD3Rjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 13:39:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:MIME-Version:Content-Disposition:Cc:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=l/Aq9NeAI13r6bmZWN1hV9rxgGezblsWTo1u3F3M8rvvyziSdnKV8SucrSfoGi7f5cH+nTfiVuqH7oGqFuevrsqagF+12aLMulvXh4Hp6ethD4tJEM9nek0OrlqZ3xgCdIG9qTmbWd4d+7YN0dZ5xHoH90eizNiK5xb7kdihBVg=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>, Ingo Molnar <mingo@redhat.com>,
       Hugh Dickins <hugh@veritas.com>, Val Henson <val.henson@intel.com>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Fwd: [patch 00/14] remap_file_pages protection support
Date: Sun, 30 Apr 2006 19:39:36 +0200
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Disposition: inline
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200604301939.37580.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm forwarding to you all the introductory e-mail, while sending the patches 
themselves only to linux-kernel (and Andrew Morton for inclusion in -mm).

Unlike last time (which was last summer), I've been able to work on the 
patches only during spare time; however, I think the work should be good 
anyway.

I've incorporated all suggestions from last review round, and left out (at 
least for now) some patches that aren't needed for base functionality; I'll 
reintroduce them after this chunk is in.

I haven't, instead, yet coded what is useful for general userspace usage; that 
will happen later.

Thanks for the attention.

----------  Forwarded Message  ----------

Again (about 8 month since last time, I have much less time during my academic
year), I'm sending for review (and for possible inclusion into -mm) protection
support for remap_file_pages, i.e. setting per-pte protections (beyond file
offset) through this syscall.

== How it works ==

Protections are set in the page tables when the
page is loaded, are saved into the PTE when the page is swapped out and 
restored
when the page is faulted back in.

Additionally, we modify the fault handler since the VMA protections aren't 
valid
for PTE with modified protections.

Finally, we must also provide, for each arch, macros to store also the
protections into the PTE; to make the kernel compile for any arch, I've added
since last time dummy default macros to keep the same functionality.

== What is this for ==

The first idea is to use this for UML - it must create a lot of single page
mappings, and managing them through separate VMAs is slow.

Additional note: this idea, with some further refinements (which I'll code 
after
this chunk is accepted), will allow to reduce the number of used VMAs for most
userspace programs - in particular, it will allow to avoid creating one VMA 
for
one guard pages (which has PROT_NONE) - forcing PROT_NONE on that page will be
enough.

This will be useful since the VMA lookup at fault time can be a bottleneck for
some programs (I've received a report about this from Ulrich Drepper and I've
been told that also Val Henson from Intel is interested about this). I guess
that since we use RB-trees, the slowness is also due to the poor cache 
locality
of RB-trees (since RB nodes are within VMAs but aren't accessed together with
their content), compared for instance with radix trees where the lookup has 
high
cache locality (but they have however space usage problems, possibly bigger, 
on
64-bit machines).

== Notes ==

Implementations are provided for i386, x86_64 and UML, and for some other 
archs
I have patches I will send, based on the ones which were in -mm when Ingo sent
the first version of this work.

You shouldn't worry for the number of patches, most of them are very little.
I've last tested them in UML against 2.6.16-rc3, but I've seen no big changes 
in
the VM.
--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com
