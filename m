Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267713AbUH2LVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267713AbUH2LVW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 07:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267721AbUH2LVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 07:21:21 -0400
Received: from ozlabs.org ([203.10.76.45]:8356 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267713AbUH2LVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 07:21:18 -0400
Date: Sun, 29 Aug 2004 21:18:55 +1000
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Cc: nickpiggin@yahoo.com.au, nathanl@austin.ibm.com, jbarnes@sgi.com
Subject: sched_domains + NUMA issue
Message-ID: <20040829111855.GB26072@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We are seeing errors in the sched domains debug code when SMT + NUMA is
enabled. Nathan pointed out that the recent change to limit the number
of nodes in a scheduling group may be causing this - in particular
sched_domain_node_span.

It looks like ia64 are the only ones implementing a reasonable
node_distance, the others just do:

#define node_distance(from,to) (from != to)

On these architectures I wonder if we should disable the
sched_domain_node_span code since we will just get a random grouping of
cpus.

Anton

CPU0:  online
 domain 0: span 00000000,00000000,00000000,00000003
  groups: 00000000,00000000,00000000,00000001 00000000,00000000,00000000,00000002
  domain 1: span 00000000,00000000,00000000,00000003
   groups: 00000000,00000000,00000000,00000003
   domain 2: span 00000000,00000000,00000000,000f0003
    groups: 00000000,00000000,00000000,00000003 00000000,00000000,00000000,000f0000
CPU1:  online
 domain 0: span 00000000,00000000,00000000,00000003
  groups: 00000000,00000000,00000000,00000002 00000000,00000000,00000000,00000001
  domain 1: span 00000000,00000000,00000000,00000003
   groups: 00000000,00000000,00000000,00000003
ERROR parent span is not a superset of domain->span
   domain 2: span 00000000,00000000,00000000,000f0000
ERROR domain->span does not contain CPU1
    groups: 00000000,00000000,00000000,00000003 00000000,00000000,00000000,000f0000
ERROR groups don't span domain->span
CPU16:  online
 domain 0: span 00000000,00000000,00000000,00030000
  groups: 00000000,00000000,00000000,00010000 00000000,00000000,00000000,00020000
  domain 1: span 00000000,00000000,00000000,000f0000
   groups: 00000000,00000000,00000000,00030000 00000000,00000000,00000000,000c0000
   domain 2: span 00000000,00000000,00000000,000f0003
    groups: 00000000,00000000,00000000,000f0000 00000000,00000000,00000000,00000003
CPU17:  online
 domain 0: span 00000000,00000000,00000000,00030000
  groups: 00000000,00000000,00000000,00020000 00000000,00000000,00000000,00010000
  domain 1: span 00000000,00000000,00000000,000f0000
   groups: 00000000,00000000,00000000,00030000 00000000,00000000,00000000,000c0000
   domain 2: span 00000000,00000000,00000000,000f0000
    groups: 00000000,00000000,00000000,000f0000 00000000,00000000,00000000,00000003
ERROR groups don't span domain->span
CPU18:  online
 domain 0: span 00000000,00000000,00000000,000c0000
  groups: 00000000,00000000,00000000,00040000 00000000,00000000,00000000,00080000
  domain 1: span 00000000,00000000,00000000,000f0000
   groups: 00000000,00000000,00000000,000c0000 00000000,00000000,00000000,00030000
ERROR parent span is not a superset of domain->span
   domain 2: span 00000000,00000000,00000000,00000000
ERROR domain->span does not contain CPU18
    groups: 00000000,00000000,00000000,000f0000 00000000,00000000,00000000,00000003
ERROR groups don't span domain->span
CPU19:  online
 domain 0: span 00000000,00000000,00000000,000c0000
  groups: 00000000,00000000,00000000,00080000 00000000,00000000,00000000,00040000
  domain 1: span 00000000,00000000,00000000,000f0000
   groups: 00000000,00000000,00000000,000c0000 00000000,00000000,00000000,00030000
ERROR parent span is not a superset of domain->span
   domain 2: span 00000000,00000000,00000000,00000000
ERROR domain->span does not contain CPU19
    groups: 00000000,00000000,00000000,000f0000 00000000,00000000,00000000,00000003
ERROR groups don't span domain->span
