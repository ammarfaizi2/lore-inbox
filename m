Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbTENRaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 13:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbTENRaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 13:30:21 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:1953 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id S262645AbTENRaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 13:30:20 -0400
Date: Wed, 14 May 2003 12:42:32 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: mika.penttila@kolumbus.fi, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Race between vmtruncate and mapped areas?
Message-ID: <82240000.1052934152@baldur.austin.ibm.com>
In-Reply-To: <20030514103421.197f177a.akpm@digeo.com>
References: <154080000.1052858685@baldur.austin.ibm.com>
 <3EC15C6D.1040403@kolumbus.fi><199610000.1052864784@baldur.austin.ibm.com>
 <20030513181018.4cbff906.akpm@digeo.com>
 <18240000.1052924530@baldur.austin.ibm.com>
 <20030514103421.197f177a.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Wednesday, May 14, 2003 10:34:21 -0700 Andrew Morton <akpm@digeo.com>
wrote:

> How so?  Truncate will chop the page off the mapping - it doesn't
> miss any pages.
> 
> Truncate has to wait for the page lock, so the page may be removed from
> the mapping shortly after the major fault's IO has completed.  Maybe
> that's what you are seeing.

My guess on the order is this:

task 1 waits for IO in the page fault.

task 2 calls truncate, which does zap_page_range() on the range that page
is in.

task 1 wakes up and maps the page.

task 2 calls truncate_inode_pages which removes the newly mapped page from
the page cache.

Now the state is that the page has been disconnected from the file, but
it's still mapped in task 1's address space.  That task thinks it has valid
data from the file in that page, and may continue to read/write there, and
assume any changes will get written back..

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

