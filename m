Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269475AbUJLGIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269475AbUJLGIF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 02:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269473AbUJLGIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 02:08:05 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:14210 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269475AbUJLGGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 02:06:49 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
       davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: __init dependencies 
In-reply-to: Your message of "Mon, 11 Oct 2004 21:04:46 MST."
             <416B57DE.4070605@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 12 Oct 2004 16:06:02 +1000
Message-ID: <24112.1097561162@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2004 21:04:46 -0700, 
"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>Randy.Dunlap wrote:
>> Andrew Morton wrote:
>> 
>>> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>
>>>> I guess it's about time for a tool to autodetect __init dependencies?
>>>
>>> `make buildcheck' does this.  Looks like nobody is using it.
>
>John Cherry has been running 'make buildcheck' regularly,
>but apparently nobody has been looking.
>
>Latest (2.6.9-rc4) is here:
>http://developer.osdl.org/cherry/compile/2.6/linux-2.6.9-rc4.results/2.6.9-rc4.reference_init26.bzImage.txt
>
>My experience with output of buildcheck is that it's verbose and has
>lots of false positives.  (Yes, I have used it and generated patches
>from it.)  First thing I do is delete all lines that match
>"data.*init" or "data.*exit".  These are (usually -- famous word) OK.

They may only be OK because the code is never run more than once.
Normal code that refers to data.*init and is run more than once is a
bug just waiting to bite you.

Andrew - small fix for reference_init.pl, against 2.6.9-rc4.

------------------------------------------------------------

Treat .pci_fixup entries the same as .init code/data.

Signed off by: Keith Owens <kaos@ocs.com.au>

Index: linux/scripts/reference_init.pl
===================================================================
--- linux.orig/scripts/reference_init.pl	Sat Aug 14 15:37:37 2004
+++ linux/scripts/reference_init.pl	Tue Oct 12 15:59:39 2004
@@ -93,6 +93,8 @@ foreach $object (sort(keys(%object))) {
 		     $from !~ /\.stab$/ &&
 		     $from !~ /\.rodata$/ &&
 		     $from !~ /\.text\.lock$/ &&
+		     $from !~ /\.pci_fixup_header$/ &&
+		     $from !~ /\.pci_fixup_final$/ &&
 		     $from !~ /\.debug_/)) {
 			printf("Error: %s %s refers to %s\n", $object, $from, $line);
 		}

