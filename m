Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVCGO2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVCGO2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 09:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVCGO2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 09:28:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41353 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261186AbVCGO2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 09:28:40 -0500
Subject: Re: [Ext2-devel] [RFC] ext3/jbd race: releasing in-use
	journal_heads
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1109978252.7236.14.camel@dyn318077bld.beaverton.ibm.com>
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1109978252.7236.14.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110205697.15117.28.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 07 Mar 2005 14:28:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2005-03-04 at 23:17, Badari Pulavarty wrote:

> I looked at few journalling bugs recently on RHEL4 testing here.
> I am wondering if your patch fixes this following BUG also ?
> I never got to bottom of some of these journal panics -
> since they are not easily reproducible

Right...

>  + I don't understand
> journal code well enough :(

Fortunately this one seems to be a simple locking violation, nothing
subtle in the jbd layers.  

> Assertion failure in journal_commit_transaction() at fs/jbd/commit.c:790: "jh->b_next_transaction == ((void *)0)"
> kernel BUG in journal_commit_transaction at fs/jbd/commit.c:790!

I'm assuming that's the line
			J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
in the t_forget loop.  That's not one of the most common footprints I
saw due to this bug, but it's certainly a possible one.  We saw one case
where a bh from the wrong transaction was linked onto the j_locked_list,
due to it being freed then reused while in use; and if that can happen,
pretty much anything can go wrong afterwards!

--Stephen

