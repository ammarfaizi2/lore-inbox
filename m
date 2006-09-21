Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWIUSCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWIUSCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 14:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWIUSCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 14:02:49 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:35010 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751409AbWIUSCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 14:02:48 -0400
Date: Thu, 21 Sep 2006 11:02:42 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: 2.6.18-rc7-mm1 -- ppc64 crash in slab_node ??
In-Reply-To: <20060921102823.628a2a74.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0609211100350.5959@schroedinger.engr.sgi.com>
References: <20060919012848.4482666d.akpm@osdl.org> <45128F94.1080502@shadowen.org>
 <20060921102823.628a2a74.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006, Andrew Morton wrote:

> I guess the below will fix it.  But Christoph's machine would have oopsed
> too, if it had called fallback_alloc() this early.  So presumably it did
> not.  But yours does.  I wonder why?

Hmmm... Fallback during boot? Any zones that have no ZONE_NORMAL memory?

The right fix though is to check for a NULL memory policy in slab_node. 
This is the way other mempol functions behave.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.18-rc7-mm1/mm/mempolicy.c
===================================================================
--- linux-2.6.18-rc7-mm1.orig/mm/mempolicy.c	2006-09-19 09:27:03.000000000 -0500
+++ linux-2.6.18-rc7-mm1/mm/mempolicy.c	2006-09-21 12:59:09.385528424 -0500
@@ -1136,7 +1136,9 @@ static unsigned interleave_nodes(struct 
  */
 unsigned slab_node(struct mempolicy *policy)
 {
-	switch (policy->policy) {
+	int pol = policy ? policy->policy : MPOL_DEFAULT;
+
+	switch (pol) {
 	case MPOL_INTERLEAVE:
 		return interleave_nodes(policy);
 
