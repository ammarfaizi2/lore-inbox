Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317298AbSIIOmO>; Mon, 9 Sep 2002 10:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317326AbSIIOmO>; Mon, 9 Sep 2002 10:42:14 -0400
Received: from angband.namesys.com ([212.16.7.85]:38528 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S317298AbSIIOmN>; Mon, 9 Sep 2002 10:42:13 -0400
Date: Mon, 9 Sep 2002 18:46:57 +0400
From: Oleg Drokin <green@namesys.com>
To: Jeff Chua <jchua@fedex.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: remount reiserfs hangs under heavy load 2.4.20pre5
Message-ID: <20020909184657.A6250@namesys.com>
References: <20020906153029.A14514@namesys.com> <Pine.LNX.4.44.0209062327150.615-100000@boston.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209062327150.615-100000@boston.corp.fedex.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Sep 06, 2002 at 11:35:16PM +0800, Jeff Chua wrote:
> > > Whenever "mount -o remount -n -w /dev/hdax" is issued under disk
> > > activities, the system would freezed, and had to be hard booted.
> > What kind of disk activies?
> Activities such as compiling the kernel or rcp large files on /dev/hda3
> > What was mount status of filesystems before that command was it readonly
> > mounted ?
> Yes, read-only on /dev/hda2, trying to change to read-write.

Hm. Well, I have not found this same bug as you describe but a very similar
problem.
Can you please try patch below and see it it helps in your situation too?
It should apply to almost anything including 2.4.19 and 2.4.20-pre5.

Thank you.

Bye,
    Oleg


===== super.c 1.23 vs edited =====
--- 1.23/fs/reiserfs/super.c	Mon Sep  9 14:41:12 2002
+++ edited/super.c	Mon Sep  9 17:48:55 2002
@@ -664,7 +664,7 @@
   }
 
   if (*mount_flags & MS_RDONLY) {
-    /* remount rean-only */
+    /* remount read-only */
     if (s->s_flags & MS_RDONLY)
       /* it is read-only already */
       return 0;
@@ -680,6 +680,10 @@
     journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
     s->s_dirt = 0;
   } else {
+    /* remount read-write */
+    if (!(s->s_flags & MS_RDONLY))
+	return 0; /* We are read-write already */
+
     s->u.reiserfs_sb.s_mount_state = sb_state(rs) ;
     s->s_flags &= ~MS_RDONLY ; /* now it is safe to call journal_begin */
     journal_begin(&th, s, 10) ;
