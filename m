Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264152AbTFDWYi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 18:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264207AbTFDWYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 18:24:38 -0400
Received: from holomorphy.com ([66.224.33.161]:29619 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264152AbTFDWYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 18:24:38 -0400
Date: Wed, 4 Jun 2003 15:37:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove page_table_lock from vma manipulations
Message-ID: <20030604223759.GD15692@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave McCracken <dmccr@us.ibm.com>,
	Linux Memory Management <linux-mm@kvack.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <133290000.1054765825@baldur.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <133290000.1054765825@baldur.austin.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 05:30:25PM -0500, Dave McCracken wrote:
> After more careful consideration, I don't see any reasons why
> page_table_lock is necessary for dealing with vmas.  I found one spot in
> swapoff, but it was easily changed to mmap_sem.  I've beat on this code and
> mjb has beat on this code with no problems.  Here's the patch to remove it.
> Feel free to poke holes in it.

shrink_list() calls try_to_unmap() under pte_chain_lock(page), and
hence try_to_unmap() cannot sleep. Furthermore try_to_unmap() calls
find_vma() under the sole protection of
spin_trylock(&mm->page_table_lock), which I don't see changed to a
read_trylock(&mm->mmap_sem) here.

Hence, this is racy.


-- wli
