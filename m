Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262712AbVCPRvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbVCPRvs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 12:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbVCPRvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 12:51:46 -0500
Received: from palrel12.hp.com ([156.153.255.237]:11951 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262712AbVCPRvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 12:51:36 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16952.29210.623642.622054@napali.hpl.hp.com>
Date: Wed, 16 Mar 2005 09:51:22 -0800
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
Cc: "Seth, Rohit" <rohit.seth@intel.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, davidm@hpl.hp.com
Subject: Re: Mprotect needs arch hook for updated PTE settings
In-Reply-To: <42382D5C.1030104@bull.net>
References: <01EF044AAEE12F4BAAD955CB75064943032C6020@scsmsx401.amr.corp.intel.com>
	<42382D5C.1030104@bull.net>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 16 Mar 2005 13:58:04 +0100, Zoltan Menyhart <Zoltan.Menyhart@bull.net> said:

  Zoltan> An application should not change the protection of its _own_
  Zoltan> text region without knowing well the requirements of the
  Zoltan> given architecture.

And the rationale being?

  Zoltan> I did see /lib/ld-linux-ia64.so.* changing the protection of
  Zoltan> the text segment of the _victim_ application, when it linked
  Zoltan> the library references.  ld-linux-ia64.so.* changes the
  Zoltan> protection for the whole text segment (otherwise, as the
  Zoltan> protection is per VMA, it would result in a VMA
  Zoltan> fragmentation).  The text segment can be huge. There is no
  Zoltan> reason to flush all the text segment every time when
  Zoltan> ld-linux-ia64.so.* patches an instruction and changes the
  Zoltan> protection.

You're missing the point:

 - ld.so does NOT patch any instructions; it only patches constant
   data which normally is write-protected

 - if the text segment is brought into memory via DMA (which it
   usually is), the only pages that need to be flushed from the cache
   are the ones that were being written to by ld.so; that's usually a
   tiny portion of the text segment

  Zoltan> I think the solution should consist of these two measures:

  Zoltan> 1. Let's say that if an VMA is "executable", then it remains
  Zoltan> "executable" for ever, i.e. the mprotect() keeps the
  Zoltan> PROT_EXEC bit.  As a result, if a page is faulted in for
  Zoltan> this VMA in the mean time, the old good mechanism makes sure
  Zoltan> that the I-caches are flushed.

  Zoltan> 2. Let's modify ld-linux-<arch>.so.*: having patched an
  Zoltan> instruction, it should take the appropriate, architecture
  Zoltan> dependent measure, e.g. for ia64, it should issue an "fc"
  Zoltan> instruction.

Again, ld.so never patches any instructions.

  Zoltan> (Who cares for a debugger ? It should know what it does ;-).)

  Zoltan> I think there is no need for any extra flushes.

There won't be any "extra" flushing, just the flushing that is really
needed (i.e., for pages that were dirtied via CPU stores).

	--david
