Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269441AbUIYXof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269441AbUIYXof (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 19:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269442AbUIYXoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 19:44:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24277 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269441AbUIYXoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 19:44:22 -0400
Date: Sat, 25 Sep 2004 19:44:05 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@novell.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: ptep_establish/establish_pte needs set_pte_atomic and all set_pte
 must be written in asm
In-Reply-To: <20040925155404.GL3309@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0409251941590.28582-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2004, Andrea Arcangeli wrote:

> set_pte), while something like this should be fine:
> 
> 	ptep_get_and_clear
> 	set_pte
> 	flush_tlb

Almost.  Think of software TLB refills, especially HPTE.
The order needs to be:

	ptep_get_and_clear
	flush_tlb
	set_pte

Any page faults happening "in the middle" will end up as
virtual no-ops once they grab the page_table_lock.

Luckily the PPC64 code in 2.6 seems to have a fix for the
race already.  Martin's race is a 2.4 thing only and needs
a 2-line change to establish_pte(), to make the code do what
I described above.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


