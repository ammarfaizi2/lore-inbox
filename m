Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263177AbTDBXMA>; Wed, 2 Apr 2003 18:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263184AbTDBXMA>; Wed, 2 Apr 2003 18:12:00 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:24855 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S263177AbTDBXL7>; Wed, 2 Apr 2003 18:11:59 -0500
Date: Wed, 02 Apr 2003 17:23:07 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.66-mm2] Fix page_convert_anon locking issues
Message-ID: <102170000.1049325787@baldur.austin.ibm.com>
In-Reply-To: <20030402150903.21765844.akpm@digeo.com>
References: <8910000.1049303582@baldur.austin.ibm.com>
 <20030402132939.647c74a6.akpm@digeo.com>
 <80300000.1049320593@baldur.austin.ibm.com>
 <20030402150903.21765844.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Wednesday, April 02, 2003 15:09:03 -0800 Andrew Morton
<akpm@digeo.com> wrote:

> i_shared_sem won't stop that.  The pte points into thin air, and may now
> point at a value which looks like our page.

Once we find a match in the pte entry, we have the additional protection of
the pte_chain lock.  The pte entry is never cleared without a call to
page_remove_rmap, which will block on the pte_chain lock.

>> Because the page is in transition from !PageAnon to PageAnon.
> 
> These are file-backed pages.  So what does PageAnon really mean?

I suppose PageAnon should be renamed to PageChain, to mean it's using
pte_chains.  It did mean anon pages until I used it for nonlinear pages.

>> We have to
>> hold the pte_chain lock during the entire transition in case someone else
>> tries to do something like page_remove_rmap, which would break.
> 
> How about setting PageAnon at the _start_ of the operation? 
> page_remove_rmap() will cope with that OK.

Hmm... I was gonna say that page_remove_rmap will BUG() if it doesn't find
the entry, but it's only under DEBUG and could easily be changed.  Lemme
think on this one a bit.  I need to assure myself it's safe to go unlocked
in the middle.

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

