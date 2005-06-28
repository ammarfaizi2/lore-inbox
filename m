Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVF1UUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVF1UUF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVF1US1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:18:27 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:571 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261374AbVF1UQ4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:16:56 -0400
X-IronPort-AV: i="3.94,147,1118034000"; 
   d="scan'208"; a="259737396:sNHT43915624"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: page allocation/attributes question (i386/x86_64 specific)
Date: Tue, 28 Jun 2005 15:16:51 -0500
Message-ID: <7A8F92187EF7A249BF847F1BF4903C040240AE4E@ausx2kmpc103.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: page allocation/attributes question (i386/x86_64 specific)
Thread-Index: AcV5LZSvZcDXcMWnSP+dBB5CHpL4AAC8JMig
From: <Stuart_Hayes@Dell.com>
To: <ak@suse.de>
Cc: <riel@redhat.com>, <andrea@suse.dk>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Jun 2005 20:16:52.0394 (UTC) FILETIME=[527130A0:01C57C1E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jun 24, 2005 at 01:20:04PM -0500, Stuart_Hayes@Dell.com wrote:
>> Rik Van Riel wrote:
>>> On Wed, 22 Jun 2005 Stuart_Hayes@Dell.com wrote:
>>> 
>>>> My question is this:  when split_large_page() is called, should it
>>>> make the other 511 PTEs inherit the page attributes from the large
>>>> page (with the exception of PAGE_PSE, obviously)?
>>> 
>>> I suspect it should.
>> 
>> (Copying Andi Kleen & Andrea Arcangeli since they were involved in a
>> previous discussion of this.  I'm trying to fix the NX handling when
>> change_page_attr() is called in i386.)
>> 
>> After looking into it further, I agree completely.  I found a thread
>> in which this was discussed
>> (http://marc.theaimsgroup.com/?l=linux-kernel&m=109964359124731&w=2),
>> and discovered that this has been addressed in the X86_64 kernel. 
> 
> You don't say which kernel you were working against. 2.6.11 has some
> fixes in this area (in particular with the reference counts) 

Sorry for the delayed response.

I'm looking at 2.6.12 now.  I was looking at an older kernel, which set
up the bulk of the kernel memory as executable.  That appears to be
fixed in 2.6.12, but the problem I orignally brought up still remains
(see below).

> 
>> However, when I used "change_page_attr()" to change the page to
>> PAGE_KERNEL, it did just that.  But PAGE_KERNEL has the _PAGE_NX bit
>> set and isn't executable.  And, since PAGE_KERNEL (with _PAGE_NX set)
>> didn't match the original pages attributes, the 512 PTEs weren't
>> reverted back into a large page.  (Also, __change_page_attr() did
>> *another* get_page() on the page containing these 512 PTEs, so now
>> the page_count has gone up to 3, instead of going back down to 1 (or
>> staying at 2).)
> 
> That should be already fixed.

It doesn't appear to be fixed (in the i386 arch).  The
change_page_attr()/split_large_page() code will still still set all the
4K PTEs to PAGE_KERNEL (setting the _PAGE_NX bit) when a large page
needs to be split.

This wouldn't be a problem for the bulk of the kernel memory, but there
are pages in the lower 4MB of memory that's free, and are part of large
executable pages that also contain kernel code.  If change_page_attr()
is called on these, it will set the _PAGE_NX bit on the whole 2MB region
that was covered by the large page, causing a large chunk of kernel code
to be non-executable.

I can only think of a few ways to fix this:

(1) Make sure that any free pages that share a large-page-aligned area
with kernel code are not executable.  This would cause a big part of the
kernel code to be in small pages, which might have an effect on
performance.

(2) Make sure that there aren't any free pages in the large-page-aligned
areas that contain kernel executable code, by reserving it somehow.
This seems kind of wasteful of memory--ZONE_DMA memory, at that.

or (3) Allow the free pages in the 2MB large pages that also contain
kernel code to be executable, but somehow fix change_page_attr() so it
doesn't set the _PAGE_NX bit on the whole 2MB large page region when
called.  This would require one of the changes that I suggested earlier,
like ignoring the NX bit in the "prot" that's passed to
change_page_attr(), or just accepting the fact that calling
change_page_attr() on a large executable page will not be reverted back
to a large page if the calling function uses
change_page_attr(page,PAGE_KERNEL) when it is done.  Or changing the
interface, so that there's a change_page_attr() and an
unchange_page_attr() that automatically reverts the page back to
whatever the previous attributes were.

Am I missing something?

>> 
>> Is the function that calls "change_page_attr()" expected to look at
>> the attributes of the page before calling change_page_attr(), so it
>> knows how to un-change the attributes when it is finished with the
>> page (since PAGE_KERNEL isn't always what the page was originally)?
> 
> No, it's not supposed to do such checks on its own.
> 
>> 
>> Or should "change_page_attr()" ignore the NX bit in the "pgprot_t
>> prot" parameter that's passed to it, and just inherit NX from the
>> large/existing page?  Then change_page_attr(page,PAGE_KERNEL) could
>> be used to undo changes, but change_page_attr() couldn't be used to
>> modify the NX bit.
> 
> I don't think that makes sense. It should exactly set the protection
> the caller requested and revert when the protection is exactly like
> it was before.  
> 
> -Andi
