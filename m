Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVGWGlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVGWGlj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 02:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVGWGlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 02:41:39 -0400
Received: from orb.pobox.com ([207.8.226.5]:37269 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261530AbVGWGli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 02:41:38 -0400
Date: Fri, 22 Jul 2005 16:33:16 -0500
From: Nathan Lynch <ntl@pobox.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: colpatch@us.ibm.com, Anton Blanchard <anton@samba.org>
Subject: topology api confusion
Message-ID: <20050722213316.GE17865@otto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We need some clarity on how asm-generic/topology.h is intended to be
used.  I suspect that it's supposed to be unconditionally included at
the end of the architecture's topology.h so that any elements which
are undefined by the arch have sensible default definitions.  Looking
at 2.6.13-rc3, this is what ppc64, ia64, and x86_64 currently do,
however i386 does not (i386 pulls in the generic version only when
!CONFIG_NUMA).

The #ifndef guards around each element of the topology api
cannot serve their apparent intended purpose when the architecture
implements a given bit as a function instead of a macro
(e.g. cpu_to_node in ppc64):

----

asm-generic/topology.h:

#ifndef cpu_to_node
#define cpu_to_node(cpu)        (0)
#endif

----

asm-ppc64/topology.h:

static inline int cpu_to_node(int cpu)
{
        int node;

        node = numa_cpu_lookup_table[cpu];
	....

----

Since ppc64 unconditionally includes asm-generic/topology.h, all uses
of cpu_to_node are preprocessed to (0).  Similar damage occurs with
every other topology function which happens to be a real function
instead of a macro.  I'm surprised my ppc64 numa systems even boot ;)

If the intent is that the architecture is free to define only a subset
of the api and include the generic header for fallback definitions,
then we need to do the #ifndef __HAVE_ARCH_FOO thing, no?  That is,
the code above would look like:

----

asm-generic/topology.h:

#ifndef __HAVE_ARCH_CPU_TO_NODE
#define cpu_to_node(cpu)        (0)
#endif

----

asm-ppc64/topology.h:

#define __HAVE_ARCH_CPU_TO_NODE
static inline int cpu_to_node(int cpu)
{
        int node;

        node = numa_cpu_lookup_table[cpu];
	....

----

Thought I'd ask for input first since this would involve a sweep of
include/asm-*.


Nathan
