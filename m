Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbUASKiF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 05:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUASKiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 05:38:05 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:24730 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264498AbUASKiC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 05:38:02 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16395.45959.836058.398889@laputa.namesys.com>
Date: Mon, 19 Jan 2004 13:37:59 +0300
To: Micha Feigin <michf@post.tau.ac.il>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] reiserfs support for laptop_mode
In-Reply-To: <20040117061354.GB4768@luna.mooo.com>
References: <20040117061354.GB4768@luna.mooo.com>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Micha Feigin writes:
 > I've been using this since 2.4.22 and since laptop_mode is in the
 > kernel since 2.4.23-pre<something> and I haven't seen that anyone else
 > has implemented this so I decided to post it on the list in case anyone
 > is interested.
 > It a patch to modify the journal flush time of reiserfs to support
 > laptop_mode (same functionality as ext3 has already).
 > The times are taken from bdflush.

Support for reiserfs laptop mode is in 2.6 now. It is done by adding new
mount option "commit=N" that sets commit interval in seconds.

It doesn't look right to just plainly set reiserfs commit interval to be
the same as the ext3 commit interval.

 > 
 > --- kernel-source-2.4.25-pre6/fs/reiserfs/journal.c	2003-08-25 14:44:43.000000000 +0300
 > +++ kernel-source-2.4.25-pre6.new/fs/reiserfs/journal.c	2003-10-20 03:35:58.000000000 +0200
 > @@ -58,6 +58,7 @@
 >  #include <linux/stat.h>
 >  #include <linux/string.h>
 >  #include <linux/smp_lock.h>
 > +#include <linux/fs.h>
 >  
 >  /* the number of mounted filesystems.  This is used to decide when to
 >  ** start and kill the commit thread
 > @@ -2659,8 +2660,12 @@
 >    /* starting with oldest, loop until we get to the start */
 >    i = (SB_JOURNAL_LIST_INDEX(p_s_sb) + 1) % JOURNAL_LIST_COUNT ;
 >    while(i != start) {
 > -    if (SB_JOURNAL_LIST(p_s_sb)[i].j_len > 0 && ((now - SB_JOURNAL_LIST(p_s_sb)[i].j_timestamp) > SB_JOURNAL_MAX_COMMIT_AGE(p_s_sb) ||
 > -       immediate)) {
 > +    /* get_buffer_age() / HZ is used since the time returned by
 > +     * get_buffer_age is in sec * HZ and the journal time is taken in seconds.
 > +     */
 > +    if (SB_JOURNAL_LIST(p_s_sb)[i].j_len > 0 &&
 > +	((now - SB_JOURNAL_LIST(p_s_sb)[i].j_timestamp) > get_buffer_age() / HZ
 > +	 || immediate)) {

Nikita.
