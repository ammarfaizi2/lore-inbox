Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbTESUpa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 16:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbTESUpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 16:45:30 -0400
Received: from tmi.comex.ru ([217.10.33.92]:63115 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S262783AbTESUp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 16:45:28 -0400
X-Comment-To: "Stephen C. Tweedie"
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Alex Tomas <bzzz@tmi.comex.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
From: Alex Tomas <bzzz@tmi.comex.ru>
Subject: Re: [Ext2-devel] [RFC] probably bug in current ext3/jbd
Date: Tue, 20 May 2003 00:58:48 +0000
In-Reply-To: <1053377493.11943.32.camel@sisko.scot.redhat.com> (Stephen C.
 Tweedie's message of "19 May 2003 21:51:33 +0100")
Message-ID: <87el2ue8mv.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <87d6igmarf.fsf@gw.home.net>
	<1053376482.11943.15.camel@sisko.scot.redhat.com>
	<87he7qe979.fsf@gw.home.net>
	<1053377493.11943.32.camel@sisko.scot.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


aha. now it's clear. thank you. I catched J_ASSERT(b_committed_data != NULL)
in ext3_free_blocks() with de-BKL'ed JBD. hence, my solution is to have a
tid journal_head indicating which transaction uses b_committed_data.

I don't want to look intrusive, but .. what do you think about new locking
schema I'm trying to implement?


>>>>> Stephen C Tweedie (SCT) writes:

 >> access for
 >> b_committed_data == NULL ?

 SCT> Not with BKL.  Without it, yes, that's definitely a risk, and you need
 SCT> some locking for the access to b_committed_data.  Without that, even if
 SCT> you keep the jh->b_committed_data field valid, you risk freeing the old
 SCT> copy that another thread is using.

 SCT> Cheers,
 SCT>  Stephen

