Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTGBRyh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 13:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTGBRyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 13:54:36 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:48681 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264231AbTGBRyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 13:54:33 -0400
Date: Wed, 2 Jul 2003 14:05:49 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
In-Reply-To: <20030702174700.GJ23578@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0307021401570.31191-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jul 2003, Andrea Arcangeli wrote:

> So ether we declare 32bit archs obsolete in production with 2.6, or we
> drop rmap behind remap_file_pages.

> Something has to change since IMHO in the current 2.5.73 remap_file_pages
> is nearly useless.

Agreed.  What we did for a certain unspecified kernel tree
at Red Hat was the following:

1) limit sys_remap_file_pages functionality to shared memory
   segments on ramfs (unswappable) and tmpfs (mostly unswappable;))

2) have the VMAs with remapped pages in them marked VM_LOCKED

3) do not set up pte chains for the pages that get mapped with
   install_page

4) remove said pages from the LRU list, in the ramfs case, they're
   unswappable anyway so we shouldn't have the VM scan them

The only known user of sys_remap_file_pages was more than happy
to have the functionality limited to just what they actually need, 
in order to get simpler code with less overhead.

Lets face it, nobody is going to use sys_remap_file_pages for
anything but a database shared memory segment anyway. You don't
need to care about truncate or the other corner cases.

