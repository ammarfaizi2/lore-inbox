Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161142AbWJKQuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161142AbWJKQuy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbWJKQuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:50:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10186 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161143AbWJKQux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:50:53 -0400
Date: Wed, 11 Oct 2006 09:21:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/5] mm: fault vs invalidate/truncate race fix
In-Reply-To: <20061010230042.3d4e4df1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0610110916540.3952@g5.osdl.org>
References: <20061010121314.19693.75503.sendpatchset@linux.site>
 <20061010121332.19693.37204.sendpatchset@linux.site> <20061010213843.4478ddfc.akpm@osdl.org>
 <452C838A.70806@yahoo.com.au> <20061010230042.3d4e4df1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Oct 2006, Andrew Morton wrote:
>
> On Wed, 11 Oct 2006 15:39:22 +1000
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > But I see that it does read twice. Do you want that behaviour retained? It
> > seems like at this level it would be logical to read it once and let lower
> > layers take care of any retries?
> 
> argh.  Linus has good-sounding reasons for retrying the pagefault-path's
> read a single time, but I forget what they are.  Something to do with
> networked filesystems?  (adds cc)

Indeed. We _have_ to re-try a failed IO that we didn't start ourselves.

The original IO could have been started by a person who didn't have 
permissions to actually carry it out successfully, so if you enter with 
the page locked (because somebody else started the IO), and you wait for 
the page and it's not up-to-date afterwards, you absolutely _have_ to try 
the IO, and can only return a real IO error after your _own_ IO has 
failed.

There is another issue too: even if the page was marked as having an error 
when we entered (and no longer locked - maybe the IO failed last time 
around), we should _still_ re-try. It might be a temporary error that has 
since gone away, and if we don't re-try, we can end up in the totally 
untenable situation where the kernel makes a soft error into a hard one. 

Neither case simply isn't acceptable. End result: only things like 
read-ahead should actually honor the "page exists but is not up-to-date" 
as a "don't even try".

		Linus
