Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWCMXf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWCMXf6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 18:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWCMXf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 18:35:58 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:60620 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750767AbWCMXf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 18:35:57 -0500
Date: Mon, 13 Mar 2006 15:35:50 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <npiggin@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: A lockless pagecache for Linux
In-Reply-To: <20060207021822.10002.30448.sendpatchset@linux.site>
Message-ID: <Pine.LNX.4.64.0603131528180.13687@schroedinger.engr.sgi.com>
References: <20060207021822.10002.30448.sendpatchset@linux.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2006, Nick Piggin wrote:

> I'm writing some stuff about these patches, and I've uploaded a
> **draft** chapter on the RCU radix-tree, 'radix-intro.pdf' in above
> directory (note the bibliography didn't make it -- but thanks Paul
> McKenney!)

Ah thanks. I had a look at it. Note that the problem with the radix tree 
tags is that these are inherited from the lower layer. How is the 
consistency of these guaranteed? Also you may want to add a more elaborate 
intro and conclusion. Typically these summarize other sections of the 
paper.

What you are proposing is to allow lockless read operations right? No 
lockless write? The concurrency issue that we currently have is multiple 
processes faulting in pages in different ranges from the same file. I 
think this is a rather typical usage scenario. Faulting in a page from a 
file for reading requires a write operation on the radix tree. The 
approach with a lockless read path does not help us. This proposed scheme 
would only help if pages are already faulted in and another process starts
using the same pages as an earlier process.

Would it not be better to handle the radix tree in the same way as a page 
table? Have a lock at the lowest layer so that different sections of the 
radix tree can be locked by different processes? That would enable 
concurrent writes.
