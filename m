Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbTESUVw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 16:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTESUVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 16:21:52 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:48342 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262742AbTESUVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 16:21:48 -0400
Subject: Re: [Ext2-devel] [RFC] probably bug in current ext3/jbd
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <87d6igmarf.fsf@gw.home.net>
References: <87d6igmarf.fsf@gw.home.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053376482.11943.15.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 May 2003 21:34:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2003-05-18 at 18:21, Alex Tomas wrote:

> ext3/jbd use b_committed_data buffer in order to prevent
> allocation of blocks which were freed in non-committed
> transaction. I think there is bug in this code. look,

You just found a rather subtle bug which was fixed around 2 or 3 years
ago. :-)

> some thread                               commit thread
> ----------------------------------------------------------

> start_journal()
> get_undo_access(#1):
>    1) wait for #1 to be
>       in t_forget_list

get_undo_access is a declaration of intention to modify the buffer. 
When that happens, it calls do_get_write_access() with the force_copy
flag set.  That means that it _always_ creates a new frozen_data copy of
the buffer the first time we get undo access to a bitmap buffer within
any given transaction.  That basically means that for bitmaps,
frozen_data always holds the version of the buffer as of the end of the
previously completed transaction.

>                                            for_each_bh_in_forget_list() {
>                                               if (jh->b_committed_data) {
>                                                   kfree(jh->b_committed_data);
>                                                   jh->b_committed_data = NULL;
>                                               }

Ah, but the *immediately* following lines are:

			if (jh->b_frozen_data) {
				jh->b_committed_data = jh->b_frozen_data;
				jh->b_frozen_data = NULL;
			}

so the frozen data that was preserved at get_undo_access() time has now
committed to disk and gets rotated into the b_committed_data version. 
This is exactly how we get the new version of the committed data when
the old transaction commits.

Cheers,
 Stephen

