Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267535AbUBSUNS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267544AbUBSUNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:13:18 -0500
Received: from mail.inter-page.com ([12.5.23.93]:40718 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S267535AbUBSUNM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:13:12 -0500
From: "Robert White" <rwhite@casabyte.com>
To: <tridge@samba.org>, "'Theodore Ts'o'" <tytso@mit.edu>
Cc: "'Pascal Schmidt'" <der.eremit@email.de>, <linux-kernel@vger.kernel.org>
Subject: RE: UTF-8 and case-insensitivity
Date: Thu, 19 Feb 2004 12:12:53 -0800
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAbPwgm2TzqEOBzzQJdkcBxAEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <16436.11148.231014.822067@samba.org>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I may, of course, be overly naive... but a thought occurs... 8-)

It would seem that the there is a moment of opportunity at the
dentry_operations invocation point to harvest all the information you would
need to maintain a specialized dcache in a separate module.  Unfortunately,
since the individual file systems get to tweak their own pointer(s) to
this/these struct-of-calls it could get hard to hijack things at that level.

With two changes to core Linux behavior, which could easily be implemented
as a configurable kernel option, you could create an advisory hook.

1) add a usually-null pointer(*) to dentry_operations structure to the
superblock data structure in vfs (and, of course, an install/remove
structure call pair) as a look-aside mechanism, and

2) if-not-null "parallel" invocations of these "advisory" calls are then
added to the fixed vfs invocation points along side the normal dentry
notices...

You could then add any imaginable advisory behavior to any file system.  A
well crafted module could then attach to file systems, flag directories (+),
and get low-level advisory service at core dentry action time.

A module so attached could answer all your negative enquiries quickly and
yet remain nicely segregated.  You could probably create the magic_open
dream logic of your choice and net near, if not absolute, race elimination.


You still might have to readdir a whole dirctory from time to time just to
clean-up a partily aged cache, but there would be no need for the stepwise
transfer of this information into the user context.

100% of the native function of each file system is preserved and there are
probably other applications for this look-aside feature like low-level
security auditing or semantic mirroring (a-la real-time rdist). 

But, you know, just a thought...

Rob.





(*) this should, if enabled, be arranged as a linked list of structures so
that multiple modules could be installed for different purposes.

(+) flagging and un-flagging directories of interest ad-hoc is needed to
prevent saturation of resources.



