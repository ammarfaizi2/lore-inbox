Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268258AbUHXUE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268258AbUHXUE3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268262AbUHXUE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:04:28 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:25761 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S268263AbUHXUEW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:04:22 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 24 Aug 2004 13:04:15 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Andy Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] lazy I/O bitmap copy for i386 (ver 2) ...
In-Reply-To: <Pine.LNX.4.58.0408241113370.2026@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0408241246040.3219@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0408241113370.2026@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004, Davide Libenzi wrote:

> The following patch implements the lazy I/O bitmap copy for the i386 
> architecture. It uses an invalid bitmap offset inside the TSS to eventually 
> handle the correct bitmap update in the GPF handler. The logic is the same 
> of the first version, plus the usage of get/put_cpu() (thx Brian) and the 
> nesting over the latest Ingo variable bitmap bits.

As followup, I instrumented the switchto code to do something like:

        if (prev->io_bitmap_ptr) {                                                                                      
                if (tss->io_bitmap_base == INVALID_IO_BITMAP_OFFSET_LAZY)                                               
                        no_hit_gpf++;                                                                                   
                else                                                                                                    
                        hit_gpf++;                                                                                      
        }

After a couple of minutes of light X usage I get:

Hit:       1017
NoHit:    29541

This is FC1 up-to-date (yesterday's ~60% rate was due an incorrect test 
performed in the instrumentation code). Did not run any perf test, but for 
sure updating an unsigned long should result faster than memcpy/memset 
memory regions, during context switches.



- Davide

