Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUCRXFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbUCRXFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:05:19 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:63428 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262927AbUCRXFH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:05:07 -0500
Subject: [PATCH] Introduce nodemask_t ADT [0/7]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1079651064.8149.158.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 18 Mar 2004 15:04:24 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a fairly good size patch set to implement an ADT (Abstract Data
Type) for nodemasks, which follows the path blazed by wli with the
cpumask_t code.  The basic idea is to create a generic,
platform/arch-agnostic nodemask data type, complete with operations to
do most anything you'd want to do with a nodemask.  This stops us from
open-coding nodemask operations, allows non-consecutive node numbering
(ie: nodes don't have to be numbered 0...numnodes-1), gets rid of
numnodes entirely (replaced with num_online_nodes()), and will
facilitate the hotplugging of whole nodes.

As I mentioned, the code is heavily based on Bill Irwin's cpumask_t
code.  The changes are broken into seven patches:

nodemask_t-01-definitions.patch
	The basic definitions of the nodemask_t type: include/linux/nodemask.h,
include/asm-generic/{nodemask.h, nodemask_arith.h, nodemask_array.h,
nodemask_const_reference.h, nodemask_const_value.h, nodemask_nonuma.h},
and some small changes to include/linux/mmzone.h (removing extistant
definition of node_online_map and helper functions).

nodemask_t-02-core.patch
	Changes to arch-independent code.  Surprisingly few references to
numnodes, open-coded node loops, etc.  Most important result of this
patch is that no generic code assumes anything about node numbering. 
This allows individual arches to use sparse numbering if they care to.

nodemask_t-03-i386.patch
	Changes to i386 specific code.  As with most arch changes, it involves
close-coding loops (ie: for_each_online_node(nid) rather than
for(nid=0;nid<numnodes;nid++)) and replacing the use of numnodes with
num_online_nodes() and node_set_online(nid).

nodemask_t-04-ppc64.patch
	Changes to ppc64 specific code.  Untested.  Code review & testing
requested.

nodemask_t-05-x86_64.patch
	Changes to x86_64 specific code.  Untested.  Code review & testing
requested.

nodemask_t-06-ia64.patch
	Changes to ia64 specific code.  Untested.  Code review & testing
requested.

nodemask_t-07-other.patch
	Changes to other arch-specific code (alpha, arm, mips, sparc64 & sh). 
Untested.  Code review & testing requested.


