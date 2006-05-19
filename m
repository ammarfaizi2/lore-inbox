Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWESA6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWESA6z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 20:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWESA6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 20:58:55 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:54998 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932094AbWESA6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 20:58:55 -0400
Date: Thu, 18 May 2006 17:58:38 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: dgc@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, clameter@sgi.com
Subject: Re: [PATCH 01/03] Cpuset: might sleep checking zones allowed fix
Message-Id: <20060518175838.1c287d60.pj@sgi.com>
In-Reply-To: <20060517222543.600cb20a.akpm@osdl.org>
References: <20060518043556.15898.73616.sendpatchset@jackhammer.engr.sgi.com>
	<20060517222543.600cb20a.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> I'd have thought that if all the callers get their __GFP_HARDWALLS correct
> then that fishy-looking in_interrupt() test in __cpuset_zone_allowed()
> could be removed?

The in_interrupt() is needed because the cpuset code really does give a
different answer for the two cases of being in an interrupt, and being
in the current task context with __GFP_WAIT not set.

    Interrupts get any node they want, totally ignoring cpusets.

    Context code with __GFP_WAIT not set tries every node within
    the current tasks context, before giving up and allowing any
    node.

See my reply to Dave Chinner for a much more long winded answer.

It may well be that this distinction between interrupt code and
interrupts disabled code is not worth it, and should be simplified out,
which would get rid of this fishy in_interrupt() check.

If that's worth doing, it would be a (subtle) semantics change, and
likely separate from this current PATCH's bug fix.

My recommendation is to expedite this current PATCH fix, and allow any
such (minor) design changes to follow along behind as a separate patch,
on a more liesurely track.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
