Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVEGXdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVEGXdU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 19:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbVEGXdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 19:33:20 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:49364 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S261202AbVEGXdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 19:33:14 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: /proc/cpuinfo format - arch dependent!
To: Stefan Smietanowski <stesmi@stesmi.com>, Willy Tarreau <willy@w.ods.org>,
       Andrew Morton <akpm@osdl.org>, Ricky Beam <jfbeam@bluetronic.net>,
       nico-kernel@schottelius.org, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 08 May 2005 01:33:05 +0200
References: <3UZS7-5ue-17@gated-at.bofh.it> <41ouh-4QE-1@gated-at.bofh.it> <41oXl-5hl-7@gated-at.bofh.it> <41sxX-8cN-11@gated-at.bofh.it> <41BL4-7l7-15@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DUYnC-0001Hd-5g@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Smietanowski <stesmi@stesmi.com> wrote:

>> I personally think that what would be useful is not "the number of CPUs"
>> (which does not make any sense), but an enumeration of :
>> 
>>     - the physical nodes (for NUMA)
>>     - the physical CPUs
>>     - each CPU's cores (for multi-core)
>>     - each core's siblings (for HT/SMT)
>> 
>> each of which would report their respective id for {set,get}_affinity().
>> This way, the application would be able to choose how it needs to spread
>> over available CPUs depending on its workload. But IMHO, this should
>> definitely not be put in cpuinfo. I consider that cpuinfo is for the human.
> 
> When one defines it one way you can be sure there'll come some company
> and figure something out that doesn't fit into that representation.
> 
> Like - Stick a board into the CPU slot of some motherboard. That board
> has two DualCore, SMT chips.

Obviously it must be a tree of CPU groups. CPUs in one NUMA node go into
one group, multi-core CPUs have all cores in one group and HT is a group,
too. This will scale from UP (degenerated tree with just one CPU) to
clusters with multicore HT-capable CPUs on PCI boards.

e.g. if you choose to represent it as a string:

Object            = <Offline-Indicator>? (<CPU>|<Group>) <Details>?
Offline-Indicator = "-"
CPU               = qr/[a-z0-9_]+/ # or more restrictive
Group             = "[" (<Object>)("," <Object>)* "]"
Details           = "{" (<vardef)("," <Vardef>)* "}"
Vardef            = <Key> "=" <Value> # or "=>" if you think perl
Key               = qr/[a-z0-9_]+/
Value             = qr/"([^"\000]|"")*"/

The described board in a UP system might look like:
[cpu0{speed="4.77MHz", RAM="80KB"},
 [[[boardcpu0_0, boardcpu0_0_ht]{group="ht"},
   [boardcpu0_1, boardcpu0_1_ht]{group="ht"}],
  [[boardcpu1_0, boardcpu1_0_ht]{group="ht"},
   [boardcpu1_1, boardcpu1_1_ht]{group="ht"}]{group="numa",RAM="4GB"}]

To count them, do:
#/usr/bin/perl
s/"[^"]*"//g;
s/\{[^}]*\}//g;
$numcpus=s/,/,/g + 1;
-- 
Top 100 things you don't want the sysadmin to say:
43. The backup procedure works fine, but the restore is tricky!

