Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbUKJSpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbUKJSpy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 13:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbUKJSpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 13:45:54 -0500
Received: from mail01.hpce.nec.com ([193.141.139.228]:29139 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S262091AbUKJSpm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 13:45:42 -0500
From: Erich Focht <efocht@hpce.nec.com>
To: Mark Goodwin <markgw@sgi.com>
Subject: Re: Externalize SLIT table
Date: Wed, 10 Nov 2004 19:45:33 +0100
User-Agent: KMail/1.6.2
Cc: Matthew Dobson <colpatch@us.ibm.com>, Jack Steiner <steiner@sgi.com>,
       Takayoshi Kochi <t-kochi@bq.jp.nec.com>, linux-ia64@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
References: <20041103205655.GA5084@sgi.com> <1100044724.3980.23.camel@arrakis> <Pine.LNX.4.61.0411101532350.15897@woolami.melbourne.sgi.com>
In-Reply-To: <Pine.LNX.4.61.0411101532350.15897@woolami.melbourne.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411101945.34003.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 November 2004 06:05, Mark Goodwin wrote:
> 
> On Tue, 9 Nov 2004, Matthew Dobson wrote:
> > On Tue, 2004-11-09 at 12:34, Mark Goodwin wrote:
> >> Once again however, it depends on the definition of distance. For nodes,
> >> we've established it's the ACPI SLIT (relative distance to memory). For
> >> cpus, should it be distance to memory? Distance to cache? Registers? Or
> >> what?
> >>
> > That's the real issue.  We need to agree upon a meaningful definition of
> > CPU-to-CPU "distance".  As Jesse mentioned in a follow-up, we can all
> > agree on what Node-to-Node "distance" means, but there doesn't appear to
> > be much consensus on what CPU "distance" means.
> 
> How about we define cpu-distance to be "relative distance to the
> lowest level cache on another CPU".

Several definitions are possible, this is really a source of
confusion. Any of these can be reconstructed if one has access to the
constituents: node-to-node latency (SLIT), cache-to-cache
latencies. The later ones aren't available and would anyhow be better
placed in something like /proc/cpuinfo or similar. They are CPU or
package specific and have nothing to do with NUMA.

> On a system that has nodes with multiple sockets (each supporting
> multiple cores or HT "CPUs" sharing some level of cache), when the
> scheduler needs to migrate a task it would first choose a CPU
> sharing the same cache, then a CPU on the same node, then an
> off-node CPU (i.e. falling back to node distance).

This should be done by correctly setting up the sched domains. It's
not a question of exporting useless or redundant information to user
space.

The need for some (any) cpu-to-cpu metrics initially brought up by
Jack seemed mainly motivated by existing user space tools for
constructing cpusets (maybe in PBS). I think it is a tolerable effort
to introduce in user space an inlined function or macro doing
something like
   cpu_metric(i,j) := node_metric(cpu_node(i),cpu_node(j))

It keeps the kernel free of misleading information which might just
slightly make cpusets construction more comfortable. In user space you
have the full freedom to enhance your metrics when getting more
details about the next generation cpus.

Regards,
Erich

