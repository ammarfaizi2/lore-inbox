Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTERNHu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 09:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbTERNHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 09:07:50 -0400
Received: from tmi.comex.ru ([217.10.33.92]:24785 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S262056AbTERNHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 09:07:49 -0400
Subject: [RFC] probably bug in current ext3/jbd
From: Alex Tomas <bzzz@tmi.comex.ru>
To: linux-kernel@vger.kernel.org
Cc: ext2-devel@lists.sourceforge.net, Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: Sun, 18 May 2003 17:21:08 +0000
Message-ID: <87d6igmarf.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi!

ext3/jbd use b_committed_data buffer in order to prevent
allocation of blocks which were freed in non-committed
transaction. I think there is bug in this code. look,

some thread                               commit thread
----------------------------------------------------------
get_undo_access(#1)
dirty_buffer(#1)
stop_journal()

                                           start commit


start_journal()
get_undo_access(#1):
   1) wait for #1 to be
      in t_forget_list

                                           write #1 to log
                                           put #1 onto t_forget_list


   2) b_commit_data exists,
      finish get_undo_access()


                                           for_each_bh_in_forget_list() {
                                              if (jh->b_committed_data) {
                                                  kfree(jh->b_committed_data);
                                                  jh->b_committed_data = NULL;
                                              }
                                           }

                                           
/* using of b_committed_data */

b_committed_data is NULL ?



with best regards, Alex

