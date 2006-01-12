Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbWALKBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWALKBE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 05:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbWALKBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 05:01:04 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:48824 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1030346AbWALKBD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 05:01:03 -0500
To: Matt Helsley <matthltc@us.ibm.com>
Cc: John Hesterberg <jh@sgi.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Jay Lan <jlan@engr.sgi.com>,
       LKML <linux-kernel@vger.kernel.org>, elsa-devel@lists.sourceforge.net,
       lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit Connectors
References: <1136414431.22868.115.camel@stark>
	<20060104151730.77df5bf6.akpm@osdl.org>
	<1136486566.22868.127.camel@stark> <1136488842.22868.142.camel@stark>
	<20060105151016.732612fd.akpm@osdl.org>
	<1136505973.22868.192.camel@stark> <yq08xttybrx.fsf@jaguar.mkp.net>
	<43BE9E91.9060302@watson.ibm.com> <yq0wth72gr6.fsf@jaguar.mkp.net>
	<1137013330.6673.80.camel@stark> <20060111213910.GA17986@sgi.com>
	<1137019367.6673.97.camel@stark>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 12 Jan 2006 05:01:01 -0500
In-Reply-To: <1137019367.6673.97.camel@stark>
Message-ID: <yq0fynt3gv6.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Matt" == Matt Helsley <matthltc@us.ibm.com> writes:

Matt> On Wed, 2006-01-11 at 15:39 -0600, John Hesterberg wrote:
>> I have two concerns about an all-tasks notification interface.
>> First, we want this to scale, so don't want more global locks.  One
>> unique part of the task notify is that it doesn't use locks.

Matt> 	Are you against global locks in these paths based solely on
Matt> principle or have you measured their impact on scalability in
Matt> those locations?

Matt,

It all depends on the specific location of the locks and how often
they are taken. As long as something is taken by the same CPU all the
time is not going to be a major issue, but if we end up with anything
resembling a global lock, even if it is only held for a very short
time, it is going to bite badly. On a 4-way you probably won't notice,
but go to a 64-way and it bites, on a 512-way it eats you alive (we
had a problem in the timer code quite a while back that prevented the
machine from booting - it wasn't a lock that was held for a long time,
just the fact that every CPU would take it every HZ was enough).

Matt> 	Without measurement there are two conflicting principles here:
Matt> code complexity vs. scalability.

The two should never be mutually exlusive as long as we are careful.

Matt> 	If you've made measurements I'm curious to know what kind of
Matt> locks were measured, where they were used, what the load was
Matt> doing -- as a rough characterization of the pattern of
Matt> notifications -- and how much it impacted scalability. This
Matt> information might help suggest a better solution.

The one I mentioned above was in the timer interrupt path.

Cheers,
Jes
