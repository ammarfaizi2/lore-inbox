Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423987AbWKIPTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423987AbWKIPTN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423986AbWKIPTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:19:13 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:27889 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1423987AbWKIPTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:19:12 -0500
Date: Thu, 9 Nov 2006 10:18:53 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Alexander van Heukelum <heukelum@fastmail.fm>
cc: LKML <linux-kernel@vger.kernel.org>, sct@redhat.com, ak@suse.de,
       herbert@gondor.apana.org.au, xen-devel@lists.xensource.com,
       heukelum@mailshack.com
Subject: Re: [PATCH] shorten the x86_64 boot setup GDT to what the comment
 says
In-Reply-To: <1163084072.31014.275411753@webmail.messagingengine.com>
Message-ID: <Pine.LNX.4.58.0611091016100.6250@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0611082144410.17812@gandalf.stny.rr.com>
 <1163084072.31014.275411753@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Nov 2006, Alexander van Heukelum wrote:

> >  gdt_48:
> > -       .word   0x8000                          # gdt limit=2048,
> > +       .word   0x800                           # gdt limit=2048,
> >  						#  256 GDT entries
> >
> >  	.word	0, 0				# gdt base (filled in later)
>
> The limit should be the offset of the last byte of the gdt table. So
> I think what was meant was really 0x7ff. Comparing this code with the
> i386-version, why does x86_64 need 256 entries here, while i386 is happy
> with just the code-segment and data-segment descriptors?
>


Hmm, Andi,

Should this be more like what is done in x86? Although this isn't a major
bug or anything, would it be cleaner. For example doing:

@@ -836,11 +836,15 @@ gdt:
        .word   0x9200                          # data read/write
        .word   0x00CF                          # granularity = 4096, 386
                                                #  (+5th nibble of limit)
+gdt_end:
+       .align  4
+
+       .word   0                               # alignment byte
 idt_48:
        .word   0                               # idt limit = 0
        .word   0, 0                            # idt base = 0L
 gdt_48:
-       .word   0x8000                          # gdt limit=2048,
+       .word   gdt_end - gdt - 1               # gdt limit=2048,
                                                #  256 GDT entries

        .word   0, 0                            # gdt base (filled in

instead?

If so, I can send you another patch that does this. Will need to test it
first.

-- Steve

