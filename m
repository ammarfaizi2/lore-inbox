Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264324AbTFDXmf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 19:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbTFDXmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 19:42:35 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:46967 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264324AbTFDXm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 19:42:28 -0400
Message-ID: <3EDE870C.1EFA566C@digeo.com>
Date: Wed, 04 Jun 2003 16:55:56 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.70-mm3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Torrey Hoffman <thoffman@arnor.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Another must-fix: sbp2 and firewire hard disk crashes hard.
References: <1054770509.1198.79.camel@torrey.et.myrio.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jun 2003 23:55:57.0704 (UTC) FILETIME=[D7C71080:01C32AF4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Torrey Hoffman wrote:
> 
> as soon as the SBP2 driver in
> 2.5.(recent) sees my firewire drive, either during kernel boot or later
> if I turn on / plug in the drive, the system crashes and dumps a
> seemingly endless stack trace.

Please apply the below patch, which should prevent the info
from scrolling away.  Then send a full report to
linux1394-devel@lists.sourceforge.net


diff -puN arch/i386/kernel/traps.c~stop-trace arch/i386/kernel/traps.c
--- 25/arch/i386/kernel/traps.c~stop-trace	Wed Jun  4 16:48:41 2003
+++ 25-akpm/arch/i386/kernel/traps.c	Wed Jun  4 16:50:13 2003
@@ -96,6 +96,7 @@ void show_trace(unsigned long * stack)
 {
 	int i;
 	unsigned long addr;
+	int count = 0;
 
 	if (!stack)
 		stack = (unsigned long*)&stack;
@@ -111,6 +112,8 @@ void show_trace(unsigned long * stack)
 			printk(" [<%08lx>] ", addr);
 			print_symbol("%s\n", addr);
 		}
+		if (count++ > 12)
+			break;
 	}
 	printk("\n");
 }
@@ -146,6 +149,8 @@ void show_stack(unsigned long * esp)
 	}
 	printk("\n");
 	show_trace(esp);
+	for ( ; ; )
+		;
 }
 
 /*

_
