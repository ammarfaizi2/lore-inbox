Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272484AbRIVXaV>; Sat, 22 Sep 2001 19:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272511AbRIVXaJ>; Sat, 22 Sep 2001 19:30:09 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:38311 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S272484AbRIVX3z>; Sat, 22 Sep 2001 19:29:55 -0400
Message-ID: <3BAD1F04.8EFA46F4@kegel.com>
Date: Sat, 22 Sep 2001 16:30:12 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vitaly Luban <vitaly@luban.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Signal-per-fd for RT signals; write_lock_bh(file_lock)?
In-Reply-To: <3BA2AFFF.C7B8C4DF@kegel.com> <3BA2E144.FB0E5D55@luban.org> <3BA2E99A.1134E382@kegel.com> <3BA350A7.7D39FC23@kegel.com> <3BA3C61A.DED5A27A@luban.org> <3BA3D10B.FE3C6C79@kegel.com> <3BA40FEC.A6E0557E@luban.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Luban wrote:
> Could you please try attached one? It's mostly untested, but my home site
> will be down next week.

I just had time to read your new patch; have not yet run it.
I think there may be some problems in send_signal:

1) might still have null pointer dereference.  If files is NULL, following section
+        if( newsignal && q )
+            filep->f_infoptr = q;
+        write_unlock( &files->file_lock);
may crash due to NULL filep and unlocking an already unlocked lock.
BTW, you might be able to use a read lock there.

2) You're using a kind of spinlock that compiles to a no-op on single
processor, but the crash (see the old oops traceback in
http://marc.theaimsgroup.com/?l=linux-kernel&m=100055931808169&w=2 )
happens on a single processor, so your locking shouldn't help.
The conflict is between a bottom half and normal.  Thus write_lock, besides
not helping on uniprocessor, might cause a deadlock on smp.  
Might have to convert the write_lock in get_unused_fd() and friends to be a
write_lock_bh() instead to prevent the bottom half from running until the normal
part is done with the file lock!

This bottom-half-vs-normal issue worries me greatly.  It may take
a lot of thought to fix this.  Then again, maybe I'm just confused;
I've never dealt with kernel spinlocks before, and anyone who reads
my posts regularly knows that I'm wrong most of the time.  Anyone
who actually *understands* this stuff, please speak up with corrections...

3) you still save info in the file even if you don't end up queuing
a signal; your changes in send_signal should be in the default case
of the switch, just to keep things in a good state.

4) collect_signal references the file table, so it needs to lock it;
probably read_lock (but maybe write_lock, I dunno), and probably
_bh, too, to avoid deadlock.

> I'm looking forward to see a test case, all I could come up with happily
> runs on the old version.

I'll try to put it together today.  
- Dan
