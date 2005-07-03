Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVGCLsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVGCLsp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 07:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVGCLso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 07:48:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:204 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261393AbVGCLpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 07:45:54 -0400
Subject: function ordering (was: Re: [RFC] exit_thread() speedups in x86
	process.c)
From: Arjan van de Ven <arjan@infradead.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       "cutaway@bellsouth.net" <cutaway@bellsouth.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Coywolf Qi Hunt <coywolf@gmail.com>
In-Reply-To: <200507021456.40667.vda@ilport.com.ua>
References: <200507012258_MC3-1-A340-3A81@compuserve.com>
	 <200507021456.40667.vda@ilport.com.ua>
Content-Type: text/plain
Date: Sun, 03 Jul 2005 13:45:39 +0200
Message-Id: <1120391140.3164.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-02 at 14:56 +0300, Denis Vlasenko wrote:
> On Saturday 02 July 2005 05:57, Chuck Ebbert wrote:
> > On Wed, 22 Jun 2005 at 04:41:47 -0400, cutaway wrote:
> > 
> > > The compilers got tweaked to be able to emit
> > > function code to different text sections and a massive system wide code
> > > triage was undertaken based on "common usage scenario" profiling run data
> > > from the perf analysis group.
> > 
> >   Linux scheduler code is in its own text section already, but
> > that might be for profiling the code instead of for performance.
> > (Look for "__sched" in the source code.)
> > 
> >   The gains may not be as much as you think since on X86 and at least
> > some other archs the entire kernel is in one large page.  Still, it's
> > got to make some kind of sense to put infrequently-used code in its
> > own section just to reduce cache pollution.
> > 
> >   I came up with this
> 
> Nice.
> 
> > but only the "__slow" part really makes sense:


hmm. I wonder if a slightly different approach (based on the __slow)
idea would make sense
1) Use -ffunction-sections option from gcc to put each function in it's
own section
2) Use readprofile/oprofile data to collect an (external to the code)
list of hot/cold functions (we can put a default list in the kernel
source somewhere and allow people to measure their own if they want)
3) Use this list to make a linker script to order the functions

this way we don't need to put a lot of __slow's in the code *and* it's
based on measurements not assumptions, and can be tuned for a specific
situation in addition.


