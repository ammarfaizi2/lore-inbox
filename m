Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268623AbTBYWxU>; Tue, 25 Feb 2003 17:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268624AbTBYWxU>; Tue, 25 Feb 2003 17:53:20 -0500
Received: from cs666873-16.austin.rr.com ([66.68.73.16]:59144 "EHLO
	raptor.int.mccr.org") by vger.kernel.org with ESMTP
	id <S268623AbTBYWxN>; Tue, 25 Feb 2003 17:53:13 -0500
Date: Tue, 25 Feb 2003 17:02:54 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: zilvinas@gemtek.lt, helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: [PATCH 2.5.62-mm3] objrmap fix for X
Message-ID: <453440000.1046214174@[10.1.1.5]>
In-Reply-To: <359700000.1046209586@[10.1.1.5]>
References: <20030223230023.365782f3.akpm@digeo.com>
 <3E5A0F8D.4010202@aitel.hist.no><20030224121601.2c998cc5.akpm@digeo.com>
 <20030225094526.GA18857@gemtek.lt><20030225015537.4062825b.akpm@digeo.com>
 <131360000.1046195828@[10.1.1.5]> <20030225132755.241e85ac.akpm@digeo.com>
 <359700000.1046209586@[10.1.1.5]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========2135142778=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========2135142778==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--On Tuesday, February 25, 2003 15:46:26 -0600 Dave McCracken
<dmccr@us.ibm.com> wrote:

>> Keep the flag for now, find the escaped page under X, remove the flag
>> later?
> 
> It occurred to me I'm already using (abusing?) the flag for nonlinear
> pages, so I have to keep it.  I'll chase solutions for X.

Ok, the vm_ops->nopage function is set in drivers like drm and agp.  I
don't think it's reasonable to require all of them to set PageAnon.  So
here's a patch that tests the page on do_no_page and sets the flag
appropriately.

Dave McCracken

--==========2135142778==========
Content-Type: text/plain; charset=us-ascii; name="objfix-2.5.62-mm3-1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="objfix-2.5.62-mm3-1.diff"; size=362

--- 2.5.62-mm3/mm/memory.c	2003-02-25 11:40:38.000000000 -0600
+++ 2.5.62-mm3-new/mm/memory.c	2003-02-25 15:54:51.000000000 -0600
@@ -1325,6 +1325,10 @@
 	if (!pte_chain)
 		goto oom;
 
+	/* See if nopage returned an anon page */
+	if (!new_page->mapping || PageSwapCache(new_page))
+		SetPageAnon(new_page);
+
 	/*
 	 * Should we do an early C-O-W break?
 	 */

--==========2135142778==========--

