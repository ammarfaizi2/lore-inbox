Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265229AbUETWcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbUETWcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 18:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265251AbUETWcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 18:32:11 -0400
Received: from palrel13.hp.com ([156.153.255.238]:3772 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265229AbUETWcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 18:32:05 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16557.12770.576039.306562@napali.hpl.hp.com>
Date: Thu, 20 May 2004 15:32:02 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, davidm@hpl.hp.com, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixing sendfile on 64bit architectures
In-Reply-To: <20040520152510.02de52a1.akpm@osdl.org>
References: <26879984$108499340940abaf81679ba6.07529629@config22.schlund.de>
	<16557.4709.694265.314748@napali.hpl.hp.com>
	<20040520145658.3a7bf7df.akpm@osdl.org>
	<200405201810.48141.jbarnes@engr.sgi.com>
	<20040520152510.02de52a1.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 20 May 2004 15:25:10 -0700, Andrew Morton <akpm@osdl.org> said:

  Andrew> Jesse Barnes <jbarnes@engr.sgi.com> wrote:
  >>  On Thursday, May 20, 2004 5:56 pm, Andrew Morton wrote: > An
  >> alternative might be to remove all the ifdefs, build with >
  >> -ffunction-sections and let the linker drop any unreferenced
  >> code...

  >> That would probably be even more confusing than the #ifdefs.  At
  >> least with those you know that you need to check whether the
  >> current code will be called...

  Andrew> Me no understand Jesse.

  Andrew> Removing the ifdefs and letting the linker do the job has
  Andrew> the advantage that the compiler gets to check more code for
  Andrew> you.

I think he meant that it's easier to see who (what platform) is
relying on the code.

Another disadvantage of -ffunction-sections is that the compiler won't
be able to do proper inlining.  There are several cases where you
have:

static
do_the_work ()
{
  ...
}

asmlinkage long
sys_one_variant ()
{
  do_the_work(some args...);
}

asmlinkage long
sys_other_variant ()
{
  do_the_work(other args...);
}

If only one variant is needed, GCC 3.4 will automatically inline
"do_the_work()" (since there is only one call-site), which is exactly
what you want.  You won't get that with -ffunction-sections.

	--david
