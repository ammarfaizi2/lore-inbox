Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269107AbUIBW1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269107AbUIBW1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269156AbUIBWZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:25:15 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:41353 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S269107AbUIBWVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:21:01 -0400
Date: Thu, 2 Sep 2004 15:19:38 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
In-Reply-To: <1094159379.14662.322.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0409021512360.28532@schroedinger.engr.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
 <1094159379.14662.322.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2004, john stultz wrote:

> +struct timesource_t {
> +	char* name;
> +	int priority;
> +	cycle_t (*read)(void);
> +	cycle_t (*delta)(cycle_t now, cycle_t then);
> +	nsec_t (*cyc2ns)(cycle_t cycles, cycle_t* remainder);
> +};

This is defining functions to be called for a timesource. Which means that
the functionality for clock_gettime cannot be implemented as a fastcall
anymore on IA64. The delta and the cyc2ns function are always the same.
The compensation for jitter etc is always the same and can also be
implemented generically.

Could we change this to avoid the function calls.

For example.

struct timesource_t {
	char *name;
	int priority;
	int type;
	void *address;
	long long int frequency;
}

The functions are always

delta = (now-then)
cycle2ns = cycles * (NSEC_PER_SEC / frequency) + remainder

types of time sources

#define TIMESOURCE_CPU 0
#define TIMESOURCE_MMIO32 1
#define TIMESOURCE_MMIO64 2
#define TIMESOURCE_FUNCTION 3 	/* To catch odd cases */
