Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262836AbSJLGye>; Sat, 12 Oct 2002 02:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbSJLGye>; Sat, 12 Oct 2002 02:54:34 -0400
Received: from packet.digeo.com ([12.110.80.53]:58864 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262836AbSJLGy3>;
	Sat, 12 Oct 2002 02:54:29 -0400
Message-ID: <3DA7C87A.670EDD45@digeo.com>
Date: Sat, 12 Oct 2002 00:00:10 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.41 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Mueller <robm@fastmail.fm>
CC: linux-kernel@vger.kernel.org, Jeremy Howard <jhoward@fastmail.fm>
Subject: Re: Strange load spikes on 2.4.19 kernel
References: <0f3201c2718c$750a13b0$1900a8c0@lifebook> <3DA77A20.2D28DBE7@digeo.com> <0f4301c27196$af8a8880$1900a8c0@lifebook> <3DA791E0.F0A1B11@digeo.com> <0fe701c271b9$e86ea910$1900a8c0@lifebook> <3DA7C4C2.58BCE2BC@digeo.com> <0ff701c271bb$f2e8a0b0$1900a8c0@lifebook>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Oct 2002 07:00:11.0371 (UTC) FILETIME=[01DB6BB0:01C271BD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Mueller wrote:
> 
> > It commits your changes to the journal every five seconds.  But your data
> > is then only in the journal.  It still needs to be written into your
> files.
> > That writeback is controlled by the normal kernel 30-second writeback
> > timing.  If that writeback isn't keeping up, kjournald needs to
> > force the writeback so it can recycle that data's space in the journal.
> >
> > While that writeback is happening, everything tends to wait on it.
> 
> Doesn't bdflush let you control this?

It doesn't work if the buffer flushtimes are wrong.

> So you're saying that ext3 is somehow breaking the standard kernel writeback
> code?

Possibly.  Please try ordered mode.

> Is this something they know about

yes

> , and/or are addressing?

Not yet.  Yours is only the second report.  Possible report.
Please try ordered mode.  The below will fix journalled
mode, if this is indeed the source of the problem


--- 2.4.19-pre10/fs/buffer.c~ext3-flushtime	Wed Jun  5 21:39:14 2002
+++ 2.4.19-pre10-akpm/fs/buffer.c	Wed Jun  5 21:39:22 2002
@@ -1067,6 +1067,8 @@ static void __refile_buffer(struct buffe
 		bh->b_list = dispose;
 		if (dispose == BUF_CLEAN)
 			remove_inode_queue(bh);
+		if (dispose == BUF_DIRTY)
+			set_buffer_flushtime(bh);
 		__insert_into_lru_list(bh, dispose);
 	}
 }
--- 2.4.19-pre10/fs/jbd/transaction.c~ext3-flushtime	Wed Jun  5 21:39:18 2002
+++ 2.4.19-pre10-akpm/fs/jbd/transaction.c	Wed Jun  5 21:39:22 2002
@@ -1101,7 +1101,6 @@ int journal_dirty_metadata (handle_t *ha
 	
 	spin_lock(&journal_datalist_lock);
 	set_bit(BH_JBDDirty, &bh->b_state);
-	set_buffer_flushtime(bh);
 
 	J_ASSERT_JH(jh, jh->b_transaction != NULL);
