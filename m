Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbVHKR4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVHKR4f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVHKR4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:56:35 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:54443 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932322AbVHKR4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:56:34 -0400
Date: Thu, 11 Aug 2005 10:56:54 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, dipankar@in.ibm.com, rusty@au1.ibm.com, bmark@us.ibm.com
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
Message-ID: <20050811175654.GH1300@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050810171145.GA1945@us.ibm.com> <20050811171451.GA5108@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050811171451.GA5108@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 06:14:51PM +0100, Christoph Hellwig wrote:
> On Wed, Aug 10, 2005 at 10:11:45AM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > This patch is an experiment in use of RCU for individual code paths that
> > read-acquire the tasklist lock, in this case, unicast signal delivery.
> > It passes five kernbenches on 4-CPU x86, but obviously needs much more
> > testing before it is considered for serious use, let alone inclusion.
> 
> I think we should switch over tasklist_lock to RCU completely instead of
> adding suck hacks.  I've started lots of preparation work to get rid of
> tasklist_lock users outside of kernel/, especialy getting rid of any
> use in modules.

I agree fully with your end goal -- I would certainly look funny
disagreeing, right?  ;-)  And Oleg pointed out an area I missed in my
patch, am fixing, but in the meantime it most certainly does qualify as
a suck hack.  :-/  Working on it...

But one of the cool things about RCU is that we can make this change
incrementally, with a series of small patches.  We can have some of
the read paths protected by RCU and others continuing to be protected
by read_lock(), so that we can avoid the need for a "flag day" that
hits all 300+ uses of tasklist_lock.

FWIW, the approach that I am taking to fix the bug Oleg and Christoph
spotted is roughly as follows:

o	Add "struct rcu_head rcu", "struct sighand_struct *successor",
	and "int deleted" to struct sighand_struct.  This allows
	reliable signal delivery in face of sighand_struct replacements.
	If an RCU reader finds (deleted && !successor), that reader
	is trying to signal a dying process, so gives up.  If an
	RCU reader instead finds (deleted && successor), the reader
	traverses the successor pointer to find the current version.

o	Apply call_rcu() to deletion of struct sighand_struct, with
	the exception of a couple of failure paths in exec.c, where
	the sighand_struct was never exposed to RCU readers.

Thoughts?

						Thanx, Paul
