Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWFMSJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWFMSJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 14:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWFMSJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 14:09:59 -0400
Received: from smtp-out.google.com ([216.239.45.12]:39467 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932199AbWFMSJ6
	(ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 14:09:58 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=H7k7oZarZKp96S93V/5vPO+J6K0Jp3lrPgudMb6hx7adsv2zjgMBcsC40jbz+pjOe
	xHsmX1Urc6wPuo0zN6E5A==
Subject: Re: [PATCH]: Adding a counter in vma to indicate the number of
	physical pages backing it
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, Linux-mm@kvack.org,
       Linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606131814110.4501@blonde.wat.veritas.com>
References: <1149903235.31417.84.camel@galaxy.corp.google.com>
	 <200606121958.41127.ak@suse.de>
	 <1150141369.9576.43.camel@galaxy.corp.google.com>
	 <200606130551.23825.ak@suse.de>
	 <1150217948.9576.67.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0606131814110.4501@blonde.wat.veritas.com>
Content-Type: text/plain
Organization: Google Inc
Date: Tue, 13 Jun 2006 11:09:28 -0700
Message-Id: <1150222169.17423.21.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 18:28 +0100, Hugh Dickins wrote:
> On Tue, 13 Jun 2006, Rohit Seth wrote:
> > On Tue, 2006-06-13 at 05:51 +0200, Andi Kleen wrote:
> > > 
> > > I think we first need to identify the basic need.
> > > Don't see why we even need per VMA information so far.
> > 
> > This information is for user land applications to have the knowledge of
> > which virtual ranges are getting actively used and which are not.
> > This information then can be fed into a new system call
> > sys_change_page_activation(pid, start_va, len, flag).  The purpose of
> > this system call would be to give hints to kernel that certain physical
> > pages are okay to be inactivated (or vice versa).   
> 
> Then perhaps you want a sys_report_page_activation(pid, start_va, len, ...)
> which would examine and report on the range in question, instead of adding
> your count to so many vmas on which this will never be used.
> 

That will reduce the cost of not traversing the whole process address
space.  But still for a given length, we will need to traverse the PTs.
On a positive side, this interface can give more specific information to
user in terms of page attributes.  I'm fine with this interface if
others are okay.  Andi?

> Though your syscall sounds like pid_madvise: perhaps the call name
> should be less specific and left to the flags (come, gentle syscall
> multiplexing flames, and warm me).
> 

Agreed.  

> Looking through the existing fields of a vma, it seems a vm_area_struct
> would commonly be on clean cachelines: your count making one of them
> now commonly and bouncily dirty.

The additional cost of this counter will be long size of extra memory
per segment, an atomic operation when ptl is used and dirtying an
additional cache line.  I overlooked the last two cost factors earlier.


-rohit

