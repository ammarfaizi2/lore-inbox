Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264195AbTICTsS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTICTrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:47:07 -0400
Received: from holomorphy.com ([66.224.33.161]:22922 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264315AbTICTpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:45:55 -0400
Date: Wed, 3 Sep 2003 12:46:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@work.bitmover.com>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <20030903194658.GC1715@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Larry McVoy <lm@work.bitmover.com>,
	"Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEB@hdsmsx402.hd.intel.com> <20030903111934.GF10257@work.bitmover.com> <20030903180037.GP4306@holomorphy.com> <20030903180547.GD5769@work.bitmover.com> <20030903181550.GR4306@holomorphy.com> <1062613931.19982.26.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062613931.19982.26.camel@dhcp23.swansea.linux.org.uk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-03 at 19:15, William Lee Irwin III wrote:
>> Independent operating system instances running under a hypervisor don't
>> qualify as a cache-coherent cluster that I can tell; it's merely dynamic
>> partitioning, which is great, but nothing to do with clustering or SMP.

On Wed, Sep 03, 2003 at 07:32:12PM +0100, Alan Cox wrote:
> Now add a clusterfs and tell me the difference, other than there being a
> lot less sharing going on...

The sharing matters; e.g. libc and other massively shared bits are
replicated in memory once per instance, which increases memory and
cache footprint(s). A number of other consequences of the sharing loss:

The number of systems to manage proliferates.

Pagecache access suddenly involves cross-instance communication instead
of swift memory access and function calls, with potentially enormous
invalidation latencies.

Userspace IPC goes from shared memory and pipes and sockets inside
a single instance (which are just memory copies) to cross-instance
data traffic, which involves slinging memory around through the
hypervisor's interface, which is slower.

The limited size of a single instance bounds the size of individual
applications, which at various times would like to have larger memory
footprints or consume more cpu time than fits in a single instance.
i.e. something resembling external fragmentation of system resources.

Process migration is confined to within a single instance without
some very ugly bits; things such as forking servers and dynamic task
creation algorithms like thread pools fall apart here.

There's suddenly competition for and a need for dynamic shifting around
of resources not shared across instances, like private disk space and
devices, shares of cpu, IP numbers and other system identifiers, and
even such things as RAM and virtual cpus.

AFAICT this raises more issues than it addresses. Not that the issues
aren't worth addressing, but there's a lot more to do than Larry
saying "I think this is a good idea" before expecting anyone to even
think it's worth thinking about.


-- wli
