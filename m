Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbUAUS2y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 13:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266010AbUAUS2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 13:28:54 -0500
Received: from post.tau.ac.il ([132.66.16.11]:42397 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S266004AbUAUS2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 13:28:51 -0500
Date: Wed, 21 Jan 2004 20:28:47 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] reiserfs support for laptop_mode
Message-ID: <20040121182846.GB29494@luna.mooo.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <20040117061354.GB4768@luna.mooo.com> <16395.45959.836058.398889@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16395.45959.836058.398889@laputa.namesys.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.23.0.2; VDF: 6.23.0.38; host: localhost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 01:37:59PM +0300, Nikita Danilov wrote:
> Micha Feigin writes:
>  > I've been using this since 2.4.22 and since laptop_mode is in the
>  > kernel since 2.4.23-pre<something> and I haven't seen that anyone else
>  > has implemented this so I decided to post it on the list in case anyone
>  > is interested.
>  > It a patch to modify the journal flush time of reiserfs to support
>  > laptop_mode (same functionality as ext3 has already).
>  > The times are taken from bdflush.
> 
> Support for reiserfs laptop mode is in 2.6 now. It is done by adding new
> mount option "commit=N" that sets commit interval in seconds.
> 

First of all its nice to know that laptop mode has finally made it
into 2.6. On the other hand setting commit=N on mount is not a good
solution since you want different flush times for when laptop mode is
activated and when it is disabled.
When laptop mode is disabled the default of 5 seconds is good since the
disk is always spinning. When laptop mode is enabled you want to change
the journal flush time to the linux buffer flush time so that the
journal won't keep waking up the disk. Its a bigger risk of loosing the
data so you don't want the longer journal flush time when laptop mode
isn't activated.

> It doesn't look right to just plainly set reiserfs commit interval to be
> the same as the ext3 commit interval.

I am not setting it to the same value as ext3. When laptop mode isn't
activated it is set to the default value used by reiserfs if bdflush
isn't modified (it does give you the ability to play with the flush
interval if you want even when reiserfs isn't activated).
If laptop mode is activated the flush time is set to the linux buffer
flush time so that the journal won't wake up the disk.

> 
>  > 
>  > --- kernel-source-2.4.25-pre6/fs/reiserfs/journal.c	2003-08-25 14:44:43.000000000 +0300
>  > +++ kernel-source-2.4.25-pre6.new/fs/reiserfs/journal.c	2003-10-20 03:35:58.000000000 +0200
>  > @@ -58,6 +58,7 @@
>  >  #include <linux/stat.h>
>  >  #include <linux/string.h>
>  >  #include <linux/smp_lock.h>
>  > +#include <linux/fs.h>
>  >  
>  >  /* the number of mounted filesystems.  This is used to decide when to
>  >  ** start and kill the commit thread
>  > @@ -2659,8 +2660,12 @@
>  >    /* starting with oldest, loop until we get to the start */
>  >    i = (SB_JOURNAL_LIST_INDEX(p_s_sb) + 1) % JOURNAL_LIST_COUNT ;
>  >    while(i != start) {
>  > -    if (SB_JOURNAL_LIST(p_s_sb)[i].j_len > 0 && ((now - SB_JOURNAL_LIST(p_s_sb)[i].j_timestamp) > SB_JOURNAL_MAX_COMMIT_AGE(p_s_sb) ||
>  > -       immediate)) {
>  > +    /* get_buffer_age() / HZ is used since the time returned by
>  > +     * get_buffer_age is in sec * HZ and the journal time is taken in seconds.
>  > +     */
>  > +    if (SB_JOURNAL_LIST(p_s_sb)[i].j_len > 0 &&
>  > +	((now - SB_JOURNAL_LIST(p_s_sb)[i].j_timestamp) > get_buffer_age() / HZ
>  > +	 || immediate)) {
> 
> Nikita.
> 
