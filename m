Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTESUdQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 16:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbTESUdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 16:33:16 -0400
Received: from tmi.comex.ru ([217.10.33.92]:54923 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S262827AbTESUdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 16:33:14 -0400
X-Comment-To: "Stephen C. Tweedie"
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Alex Tomas <bzzz@tmi.comex.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
From: Alex Tomas <bzzz@tmi.comex.ru>
Subject: Re: [Ext2-devel] [RFC] probably bug in current ext3/jbd
Date: Tue, 20 May 2003 00:46:34 +0000
In-Reply-To: <1053376482.11943.15.camel@sisko.scot.redhat.com> (Stephen C.
 Tweedie's message of "19 May 2003 21:34:42 +0100")
Message-ID: <87he7qe979.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <87d6igmarf.fsf@gw.home.net>
	<1053376482.11943.15.camel@sisko.scot.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi!

please, look:

  thread A                          commit thread

                        	    if (jh->b_committed_data) {
                                	kfree(jh->b_committed_data);
                                        jh->b_committed_data = NULL;
                                    }
access for
b_committed_data == NULL ?

                                         if (jh->b_frozen_data) {
                                            jh->b_committed_data = jh->b_frozen_data;
                                            jh->b_frozen_data = NULL;
                                          }


or I miss something subtle here?


>>>>> Stephen C Tweedie (SCT) writes:

 SCT> get_undo_access is a declaration of intention to modify the buffer. 
 SCT> When that happens, it calls do_get_write_access() with the force_copy
 SCT> flag set.  That means that it _always_ creates a new frozen_data copy of
 SCT> the buffer the first time we get undo access to a bitmap buffer within
 SCT> any given transaction.  That basically means that for bitmaps,
 SCT> frozen_data always holds the version of the buffer as of the end of the
 SCT> previously completed transaction.

 >> for_each_bh_in_forget_list() {
 >> if (jh->b_committed_data) {
 >> kfree(jh->b_committed_data);
 jh-> b_committed_data = NULL;
 >> }

 SCT> Ah, but the *immediately* following lines are:

 SCT> 			if (jh->b_frozen_data) {
 jh-> b_committed_data = jh->b_frozen_data;
 jh-> b_frozen_data = NULL;
 SCT> 			}

 SCT> so the frozen data that was preserved at get_undo_access() time has now
 SCT> committed to disk and gets rotated into the b_committed_data version. 
 SCT> This is exactly how we get the new version of the committed data when
 SCT> the old transaction commits.

 SCT> Cheers,
 SCT>  Stephen


