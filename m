Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbTCEHOh>; Wed, 5 Mar 2003 02:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbTCEHOh>; Wed, 5 Mar 2003 02:14:37 -0500
Received: from holomorphy.com ([66.224.33.161]:31900 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263342AbTCEHOg>;
	Wed, 5 Mar 2003 02:14:36 -0500
Date: Tue, 4 Mar 2003 23:24:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Miles Bader <miles@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WARN_ON noise in 2.5.63's kernel/sched.c:context_switch
Message-ID: <20030305072439.GQ1195@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Miles Bader <miles@gnu.org>, linux-kernel@vger.kernel.org
References: <buoadgkuatx.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030225063739.GY10411@holomorphy.com> <buok7fetheb.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buok7fetheb.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 04:13:48PM +0900, Miles Bader wrote:
> Ok, I think I found the reason; sched.c cleans up some stuff in
> schedule_tail, and in this code (arch/v850/kernel/entry.S):
> C_ENTRY(ret_from_fork):
> #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
> 	mov	r10, r6			// switch_thread returns the prev task.
> 	jarl	CSYM(schedule_tail), lp	// ...which is schedule_tail's arg
> #endif
> 	mov	r0, r10			// Child's fork call should return 0.
> 	br	ret_from_trap		// Do normal trap return.
> ... it only calls that if CONFIG_PREEMPT is turned on.  If I remove the
> #ifdef, then I get no warnings.
> I take it that the call to schedule_tail should now be unconditional?
> [some other archs have the same #ifdef]

Yeah, this is the root problem. You have to go through schedule_tail()
to clean up the mm's etc.


-- wli
