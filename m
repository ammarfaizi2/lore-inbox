Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVBOLxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVBOLxL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 06:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVBOLxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 06:53:11 -0500
Received: from news.suse.de ([195.135.220.2]:46817 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261689AbVBOLxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 06:53:06 -0500
Date: Tue, 15 Feb 2005 12:53:03 +0100
From: Andi Kleen <ak@suse.de>
To: Ray Bryant <raybry@sgi.com>
Cc: Andi Kleen <ak@muc.de>, Ray Bryant <raybry@austin.rr.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, stevel@mvista.com
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
Message-ID: <20050215115302.GB19586@wotan.suse.de>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de> <42114279.5070202@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42114279.5070202@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (1)  You really don't want to migrate the code pages of shared libraries
>      that are mapped into the process address space.  This causes a
>      useless shuffling of pages which really doesn't help system
>      performance.  On the other hand, if a shared library is some
>      private thing that is only used by the processes being migrated,
>      then you should move that.

I think the better solution for this would be to finally integrate Steve L.'s 
file attribute code (and find some solution to make it persistent,
e.g. using xattrs with a new inode flag) and then "lock" the shared 
libraries to their policy using a new attribute flag.

> 
> (2)  You really only want to migrate pages once.  If a file is mapped
>      into several of the pid's that are being migrated, then you want
>      to figure this out and issue one call to have it moved wrt one of
>      the pid's.
>      (The page migration code from the memory hotplug patch will handle
>      updating the pte's of the other processs (thank goodness for
>      rmap...))

I don't get this. Surely the migration code will check if a page
is already in the target node, and when that is the case do nothing.

How could this "double migration" happen? 

> 
> (3)  In the case where a particular file is mapped into different
>      processes at different file offsets (and we are migrating both
>      of the processes), one has to examine the file offsets to figure
>      out if the mappings overlap or not. If they overlap, then you've
>      got to issue two calls, each of which describes a non-overlapping
>      region; both calls taken together would cover the entire range
>      of pages mapped to the file.  Similarly if the ranges do not
>      overlap.

That sounds like a quite obscure corner case which I'm not sure
is worth all the complexity.

-Andi

