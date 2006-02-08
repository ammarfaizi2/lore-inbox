Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWBHJ6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWBHJ6V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 04:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWBHJ6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 04:58:21 -0500
Received: from iona.labri.fr ([147.210.8.143]:46295 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S932435AbWBHJ6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 04:58:20 -0500
Date: Wed, 8 Feb 2006 10:58:23 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: christophe.lameter@sgi.com
Cc: linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Direct Migration and "Affinity on next touch" ?
Message-ID: <20060208095823.GD5752@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	christophe.lameter@sgi.com, linux-mm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Direct Migration support is quite great, but some "migration on next
touch" (aka affinity on next touch) would be quite useful too.

A bunch of parallel applications have an sequential part that
initializes all data. Then threads are launched for achieving the actual
computation in parallel. However, with a simple affinity on first touch
policy, all data is allocated on the node which initialization ran
on. Manually migrating data where threads will eventually run on may
really not be easy.

A "simple" (from the userland point of view) solution is to have
an "affinity on next touch" policy that would be set _after_
initialization, for instance the application would:
- initialize data, which gets allocated on some node ;
- call mbind(data, size, MPOL_DEFAULT, NULL, 0, MPOL_MF_NEXTTOUCH), that
  records the new policy and invalidates pages ;
- run threads ;
- threads start computing, hence they touch data pages; the page fault
  handler migrates these pages to the node on which the fault occured,
  i.e. hopefully the node on which it will be mostly used (this is
  generally true with such applications) ;
- after very little time, data pages are distributed as appropriate, and
  then the computation runs fast.

The cost of page fault + migration is quickly compensated by the
resulting better data distribution. Being able to ask for bigger page
sizes would also reduce page fault cot.

Solaris implements this solution through madvise(data, size,
MADV_ACCESS_LWP); (see Solaris' madvise() manpage
http://docs.sun.com/app/docs/doc/817-0677/6mgf9b66i?a=view ). Using this
facility can bring quite interesting performance improvements:
(for instance "affinity-on-next-touch: increasing the
performance of an industrial PDE solver on a cc-NUMA system":
http://portal.acm.org/ft_gateway.cfm%3Fid=1088201%26type=pdf )

Could such facility be implemented?

Regards,
Samuel
