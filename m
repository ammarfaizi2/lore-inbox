Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUIPCP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUIPCP1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 22:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUIPCOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 22:14:31 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:18834 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266009AbUIPCNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 22:13:51 -0400
Subject: Re: get_current is __pure__, maybe __const__ even
From: Albert Cahalan <albert@users.sf.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Jakub Jelinek <jakub@redhat.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@muc.de
In-Reply-To: <20040915232956.GE9106@holomorphy.com>
References: <1095288600.1174.5968.camel@cube>
	 <20040915231518.GB31909@devserv.devel.redhat.com>
	 <20040915232956.GE9106@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1095300619.2191.6392.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 Sep 2004 22:10:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 19:29, William Lee Irwin III wrote:
> On Wed, Sep 15, 2004 at 06:50:00PM -0400, Albert Cahalan wrote:
> >> This looks fixable.
> >> At the very least, __attribute__((__pure__))
> >> will apply to your get_current function.
> >> I think __attribute__((__const__)) will too,
> >> even though it's technically against the
> >> documentation. While you do indeed read from
> >> memory, you don't read from memory that could
> >> be seen as changing. Nothing done during the
> >> lifetime of a task will change "current" as
> >> viewed from within that task.
> 
> On Wed, Sep 15, 2004 at 07:15:18PM -0400, Jakub Jelinek wrote:
> > current will certainly change in schedule (),

Not really!

>From the viewpoint of a single task looking
at current, it does not change. The task is
paused, and may well start up again on a
different CPU, but current doesn't change.

Any state gcc might keep would be stored on
the kernel stack or in a register, which will
be preserved because tasks don't share these.

AFAIK, gcc generates thread-safe code. It won't
convert code to something like this:

int foo(int bar){
static task_struct *__L131241 = get_current();
// blah, blah...
}

> > so either you'd need to avoid using current
> > in schedule() and use some other accessor
> > for the same without such attribute, or
> > #ifdef the attribute out when compiling sched.c.
> 
> Why would barrier() not suffice?

I don't think even barrier() is needed.
Suppose gcc were to cache the value of
current over a schedule. Who cares? It'll
be the same after schedule() as it was
before.


