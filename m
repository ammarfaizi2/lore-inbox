Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbVEMN7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVEMN7I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 09:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVEMN7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 09:59:08 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:43970 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262371AbVEMN5G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 09:57:06 -0400
Subject: Re: NUMA aware slab allocator V2
From: Dave Hansen <haveblue@us.ibm.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shai@scalex86.org, steiner@sgi.com, Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <Pine.LNX.4.58.0505130436380.4500@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>
	 <20050512000444.641f44a9.akpm@osdl.org>
	 <Pine.LNX.4.58.0505121252390.32276@schroedinger.engr.sgi.com>
	 <20050513000648.7d341710.akpm@osdl.org>
	 <Pine.LNX.4.58.0505130411300.4500@schroedinger.engr.sgi.com>
	 <20050513043311.7961e694.akpm@osdl.org>
	 <Pine.LNX.4.58.0505130436380.4500@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Fri, 13 May 2005 06:56:53 -0700
Message-Id: <1115992613.7129.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-13 at 04:37 -0700, Christoph Lameter wrote:
> On Fri, 13 May 2005, Andrew Morton wrote:
> > > The definition for the number of NUMA nodes is dependent on
> > > CONFIG_FLATMEM instead of CONFIG_NUMA in mm.
> > > CONFIG_FLATMEM is not set on ppc64 because CONFIG_DISCONTIG is set! And
> > > consequently nodes exist in a non NUMA config.
> >
> > I was testing 2.6.12-rc4 base.
> 
> There we still have the notion of nodes depending on CONFIG_DISCONTIG and
> not on CONFIG_NUMA. The node stuff needs to be
> 
> #ifdef CONFIG_FLATMEM
> 
> or
> 
> #ifdef CONFIG_DISCONTIG

I think I found the problem.  Could you try the attached patch?

As I said before FLATMEM is really referring to things like the
mem_map[] or max_mapnr.

CONFIG_NEED_MULTIPLE_NODES is what gets turned on for DISCONTIG or for
NUMA.  We'll slowly be removing all of the DISCONTIG cases, so
eventually it will merge back to be one with NUMA.

-- Dave

--- clean/include/linux/numa.h.orig	2005-05-13 06:44:56.000000000 -0700
+++ clean/include/linux/numa.h	2005-05-13 06:52:05.000000000 -0700
@@ -3,7 +3,7 @@
 
 #include <linux/config.h>
 
-#ifndef CONFIG_FLATMEM
+#ifdef CONFIG_NEED_MULTIPLE_NODES
 #include <asm/numnodes.h>
 #endif
 


