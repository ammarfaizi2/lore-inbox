Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbVH3XzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVH3XzN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 19:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbVH3XzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 19:55:13 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:39103 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932270AbVH3XzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 19:55:11 -0400
Date: Tue, 30 Aug 2005 16:54:56 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: "Luck, Tony" <tony.luck@intel.com>, Rusty Lynch <rusty@linux.intel.com>,
       "Lynch, Rusty" <rusty.lynch@intel.com>, linux-mm@kvack.org,
       prasanna@in.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
Subject: Re: [PATCH] Only process_die notifier in ia64_do_page_fault if
 KPROBES is configured.
In-Reply-To: <200508310138.09841.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0508301642570.20548@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0443A9A1@scsmsx401.amr.corp.intel.com>
 <200508310138.09841.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2005, Andi Kleen wrote:

> Also with the inline the test should be essentially a single test of 
> a global variable and jump. Hardly a big performance issue, no? 

There are multiple effects of this code.

- Additional cacheline in use in the page fault handler 
  increasing the cache foot print.

- There are registers in use for checking the global variable.

- The compilers will reserve registers for the code that is never 
  executed which may affect other elements of performance. From the 
  register perspective a function call may be better on ia64.

Certainly not a big effect (if we make sure the compiler knows that 
this test mostly fails and insure that the variable is in 
__mostly_read) but this is a frequently executed code path and the code
is there without purpose if CONFIG_KPROBES is off.

It wont get too bad unless lots of other people have similar ideas about 
fixing their race conditions using similar methods. But we will be setting 
a bad precedent if we allow this.
