Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265656AbUBFT0c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 14:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265658AbUBFT0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 14:26:31 -0500
Received: from post.tau.ac.il ([132.66.16.11]:56753 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S265656AbUBFT02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 14:26:28 -0500
Date: Fri, 6 Feb 2004 21:26:18 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs - difference between a commit and a transaction
Message-ID: <20040206192618.GE2582@luna.mooo.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <20040206002346.GA2571@luna.mooo.com> <16419.22749.486759.348150@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16419.22749.486759.348150@laputa.namesys.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.23.0.3; VDF: 6.23.0.60; host: localhost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 12:05:33PM +0300, Nikita Danilov wrote:
> Micha Feigin writes:
>  > I am trying to do some work on reiserfs to make it laptop-mode
>  > compliant. After looking at the code because it was still noisy after I
>  > thought I told correctly to be quite, raised a question that I was
>  > hoping someone can clarify for me.
>  > 
>  > Reiserfs has both a transaction and a commit and I was wondering what
>  > is which.
> 
> Transaction is a sequence of file system modifications that (by the
> virtue of file system implementation) is bound to either be completed as
> a whole or be aborted as a whole (this is called "atomicity").
> 
> Commit is a certain operation performed during transaction life-time to
> implement its atomicity.
> 

So, at what time of a transaction's life would a commit be flushed to
disk, only in the process of flushing the transaction to disk or at
several points during its life time to make sure that atomicity is
preserved.

And on that note, can there be several transactions active at one time
or is a new transaction created only when the previous is closed and
ready to flush.

>  > 
>  > (I am mostly interested in this from the point of what max_trans_age
>  > and max_commit_age affect)
> 
> Take a look at the "commit" mount option of reiserfs.
> 

Thats what I was looking at and what I ported to 2.4 (it did require a
fix for laptop mode to enable reseting the value, but that will be
coming shortly).

The problem was that reiserfs was still being very noisy (kreiserfsd was
writing to disk around every 30 seconds despite beeing mounted with
commit=600). That led me to look further into the code and changing
max_trans_age instead of max_commit_age kept it quite for the full ten
minutes. I am still checking to make sure that its not something with me
or my system.

For laptop mode we want to keep disk activity quiet for around ten
minutes at a time so that the disk can be spun down, thus sacrificing
the chance of loosing data for battery life.

I am trying to see what is the right value to change and what is the
meaning of changing it but I could only find old documentation and the
comments in the code are good only for people who know the meaning of
the terms in the first place.

>  > 
>  > Thanks
> 
> Nikita.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
