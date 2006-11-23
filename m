Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756827AbWKWGEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756827AbWKWGEy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 01:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756833AbWKWGEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 01:04:54 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:10638 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1756827AbWKWGEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 01:04:53 -0500
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Jeremy Fitzhardinge <jeremy@goop.org>, eranian@hpl.hp.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] i386 add Intel PEBS and BTS cpufeature bits and detection 
In-reply-to: Your message of "Sat, 18 Nov 2006 09:24:01 BST."
             <200611180924.01979.ak@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 23 Nov 2006 17:03:47 +1100
Message-ID: <6428.1164261827@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen (on Sat, 18 Nov 2006 09:24:01 +0100) wrote:
>On Friday 17 November 2006 23:57, Jeremy Fitzhardinge wrote:
>> Andi Kleen wrote:
>> > I have had private patches for that myself, using the MSRs on AMD
>> > and Intel.
>> >   
>> 
>> Would they be something that could be cleaned up into something
>> mergeable?  
>
>Hmm maybe.
>
>> It would be nice to have something that could be left 
>> enabled all the time, 
>
>That would add considerable latency to all exceptions.
>
>And unfortunately we take more than 16 jumps before
>we figure out an oops, so all the previous data would be gone
>if it was only done in the error path.
>
>If the CPU had a "disable LBR on exceptions" bit that would
>work. Unfortunately it hasn't.

LBR is mainly useful on wild branches to random addresses.  As such,
you really only need to disable LBR in the page fault handler.  For a
long time, KDB had LBR support with this replacement for the i386 page
fault handler.

#if defined(CONFIG_KDB)
ENTRY(page_fault_mca)
       pushl %ecx
       pushl %edx
       pushl %eax
       movl  $473,%ecx
       rdmsr
       andl  $0xfffffffe,%eax          /* Disable last branch recording */
       wrmsr
       popl  %eax
       popl  %edx
       popl  %ecx
       pushl $do_page_fault
       jmp error_code
#endif

Nobody was using the LBR feature of KDB so I removed it in 2.6.17.

