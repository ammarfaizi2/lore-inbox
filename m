Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264293AbUDNQyu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 12:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbUDNQyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 12:54:50 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:49055 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264293AbUDNQxV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 12:53:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Mingming Cao <cmm@us.ibm.com>
Subject: Re: [PATCH 0/4] ext3 block reservation patch set
Date: Wed, 14 Apr 2004 09:42:29 -0700
User-Agent: KMail/1.4.1
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
References: <200403190846.56955.pbadari@us.ibm.com> <1081903949.3548.6837.camel@localhost.localdomain> <20040413194734.3a08c80f.akpm@osdl.org>
In-Reply-To: <20040413194734.3a08c80f.akpm@osdl.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200404140942.29648.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 April 2004 07:47 pm, Andrew Morton wrote:

> - You're performing ext3_discard_reservation() in ext3_release_file().
>   Note that the file may still have pending allocations at this stage: say,
>   open a file, map it MAP_SHARED, dirty some pages which lie over file
>   holes then close the file again.
>
>   Later, the VM will come along and write those dirty pages into the
>   file, at which point allocations need to be performed.  But we have no
>   reservation data and, later, we may have no inode->write_state at all.
>
>   What will happen?

Block allocations happen after ext3_release_file()  ? In that case,
we would have dropped all our reservations at the time of last file close.
But if allocations happen later, the current code will start new reservation
window and start allocations from there.

> - Have you tested and profiled this with a huge number of open files?  At
>   what stage do we get into search complexity problems?

Come to think of it, the current code has pretty bad search algorithm. We need
to fix that. We hold the spinlock for entire search, thats why our CPU 
utilization is pretty high.

Thanks,
Badari
