Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbTICK2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 06:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbTICK2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 06:28:12 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:50315 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261756AbTICK2J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 06:28:09 -0400
Date: Wed, 3 Sep 2003 11:28:05 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Gianni Tedesco <giannit@securewave.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmap(MAP_PRIVATE) question
Message-ID: <20030903102804.GA21455@mail.jlokier.co.uk>
References: <1062581651.489.5.camel@lemsip>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062581651.489.5.camel@lemsip>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gianni Tedesco wrote:
> Hi all,
> 
> >From the mmap(2) manpage it says:
> 
> MAP_PRIVATE
> Create a private copy-on-write mapping.  Stores to the region do not
> affect the  original  file.   It  is  unspecified whether changes made
> to the file after the mmap call are visible in the mapped region.
> 
> What is linux behaivour in this area? I am guessing if the page is
> modified between the call to mmap() and fault-in then the modified copy
> is seen by the application? But what about modifications after the page
> is already in page-cache?

The page cache page is mapped into the application just like a shared
mapping, until the application writes to the mapped region and
triggers the copy-on-write fault.

This means that if you write() to the page prior to the copy-on-write
fault, you may see the changes in application memory straight away.
If some other process writes to the page through a writable mapping,
you may see the changes.

On the other hand you may not.  On some of the architectures which
Linux supports, the CPU's cache is not sufficiently coherent to
guarantee that what is written with write(), or by another process,
will be seen in this application's memory.  Indeed, you might see a
mixture of some of the written data and some of the data before it was
written, with no particular guarantee of which bits of data or in what
order.

-- Jamie
