Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbVDAHIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbVDAHIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 02:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbVDAHIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 02:08:10 -0500
Received: from mx1.elte.hu ([157.181.1.137]:53184 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262648AbVDAHIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 02:08:04 -0500
Date: Fri, 1 Apr 2005 08:59:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@engr.sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, kenneth.w.chen@intel.com,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Industry db benchmark result on recent 2.6 kernels
Message-ID: <20050401065955.GB26203@elte.hu>
References: <200503312214.j2VMEag23175@unix-os.sc.intel.com> <424C8956.7070108@yahoo.com.au> <20050331220526.3719ed7f.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331220526.3719ed7f.pj@engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@engr.sgi.com> wrote:

> Nick wrote:
> > Ingo had a cool patch to estimate dirty => dirty cacheline transfer latency
> > ... Unfortunately ... and it is an O(cpus^2) operation.
> 
> Yes - a cool patch.
> 
> If we had an arch-specific bit of code, that for any two cpus, could 
> give a 'pseudo-distance' between them, where the only real 
> requirements were that (1) if two pairs of cpus had the same 
> pseudo-distance, then that meant they had the same size, layout, kind 
> and speed of bus amd cache hardware between them (*), and (2) it was 
> cheap - hardly more than a few lines of code and a subroutine call to 
> obtain, then Ingo's code could be:

yeah. The search can be limited quite drastically if all duplicate 
constellations of CPUs (which is a function of the topology) are only 
measured once.

but can be 'pseudo-distance' be calculated accurately enough? If it's a 
scalar, how do you make sure that unique paths for data to flow have 
different distances? The danger is 'false sharing' in the following 
scenario: lets say CPUs #1 and #2 are connected via hardware H1,H2,H3, 
CPUs #3 and #4 are connected via H4,H5,H6. Each hardware component is 
unique and has different characteristics. (e.g. this scenario can happen 
when different speed CPUs are mixed into the same system - or if there 
is some bus assymetry)

It has to be made sure that H1+H2+H3 != H4+H5+H6, otherwise false 
sharing will happen. For that 'uniqueness of sum' to be guaranteed, one 
has to assign power-of-two values to each separate type of hardware 
component.

[ or one has to assing very accurate 'distance' values to hardware 
components. (adding another source for errors - i.e. false sharing of 
the migration value) ]

and even the power-of-two assignment method has its limitations: it 
obviously runs out at 32/64 components (i'm not sure we can do that), 
and if a given component type can be present in the same path _twice_, 
that component will have to take two bits.

or is the 'at most 64 different hardware component types' limit ok? (it 
feels like a limit we might regret later.)

	Ingo
