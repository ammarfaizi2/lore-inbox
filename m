Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWDWHMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWDWHMv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 03:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWDWHMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 03:12:51 -0400
Received: from mail.gmx.de ([213.165.64.20]:59322 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751355AbWDWHMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 03:12:50 -0400
X-Authenticated: #14349625
Subject: Re: [RFC][PATCH 5/9] CPU controller - Documents how the controller
	works
From: Mike Galbraith <efault@gmx.de>
To: maeda.naoaki@jp.fujitsu.com
Cc: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
In-Reply-To: <20060421022753.13598.77686.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
References: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
	 <20060421022753.13598.77686.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
Content-Type: text/plain
Date: Sun, 23 Apr 2006 09:13:50 +0200
Message-Id: <1145776430.7990.58.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 11:27 +0900, maeda.naoaki@jp.fujitsu.com wrote:
> +3. Timeslice scaling
> +
> + If there are hungry classes, we need to adjust timeslices to satisfy
> + the share.  To scale timeslices, we introduce a scaling factor
> + used for scaling timeslices.  The scaling factor is associated with
> + the class (stored in the cpu_rc structure) and adaptively adjusted
> + according to the class load and the share.

This all works fine until interactive task requeueing is considered, and
it must be considered.

One simple way to address the requeue problem is to introduce a scaled
class sleep_avg consumption factor.  Remove the scaling exemption for
TASK_INTERACTIVE(p), and if a class's cpu usage doesn't drop to what is
expected by group timeslice scaling, make members consume sleep_avg at a
higher rate such that scaling can take effect.

A better way to achieve the desired group cpu usage IMHO would be to
adjust nice level of members at slice refresh time.  This way, you get
the timeslice scaling and priority adjustment all in one.

(I think I would do both actually, with nice level being preferred such
that dynamic priority spread within the group isn't flattened, which can
cause terminal starvation within the group, unless really required.)

	-Mike

