Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266276AbUAGTaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 14:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUAGT3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 14:29:40 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:32996 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265564AbUAGT1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 14:27:48 -0500
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
From: Ram Pai <linuxram@us.ibm.com>
To: Paolo Ornati <ornati@lycos.it>
Cc: Andrew Morton <akpm@osdl.org>, gandalf@wlug.westbo.se,
       linux-kernel@vger.kernel.org
In-Reply-To: <200401071559.16130.ornati@lycos.it>
References: <200401021658.41384.ornati@lycos.it>
	 <200401041530.24395.ornati@lycos.it>
	 <1073344795.3088.19.camel@dyn319250.beaverton.ibm.com>
	 <200401071559.16130.ornati@lycos.it>
Content-Type: text/plain
Organization: 
Message-Id: <1073503421.10018.17.camel@dyn319250.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Jan 2004 11:23:41 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-07 at 06:59, Paolo Ornati wrote:
> On Tuesday 06 January 2004 00:19, you wrote:
> > Sorry I was on vacation and could not get back earlier.
> >
> > I do not exactly know the reason why sequential reads on blockdevices
> > has regressed. One probable reason is that the same lazy-read
> > optimization which helps large random reads is regressing the sequential
> > read performance.
> >
> > Note: the patch, waits till the last page in the current window is being
> > read, before triggering a new readahead. By the time the readahead
> > request is satisfied, the next sequential read may already have been
> > requested. Hence there is some loss of parallelism here. However given
> > that largesize random reads is the most common case; this patch attacks
> > that case.
> >
> > If you revert back just the lazy-read optimization, you might see no
> > regression for sequential reads,
> 
> I have tried to revert it out:
> 
> --- mm/readahead.c.orig	2004-01-07 15:17:00.000000000 +0100
> +++ mm/readahead.c.my	2004-01-07 15:33:13.000000000 +0100
> @@ -480,7 +480,8 @@
>  		 * If we read in earlier we run the risk of wasting
>  		 * the ahead window.
>  		 */
> -		if (ra->ahead_start == 0 && offset == (ra->start + ra->size -1)) {
> +		if (ra->ahead_start == 0) {
>  			ra->ahead_start = ra->start + ra->size;
>  			ra->ahead_size = ra->next_size;
> 
> but the sequential read performance is still the same !
> 
> Reverting out the other part of the patch (that touches mm/filemap.c) the
> sequential read performance comes back like in 2.6.0.

I tried on my lab machine with scsi disks. (I dont have access currently
to a spare machine with ide disks.)

I find that reverting the changes in mm/filemap.c and then reverting the
lazy-read optimization gives much better sequential read performance on
blockdevices.  Is this your observation on IDE disks too?


> 
> I don't know why... but it does.

Lets see. I think my theory is partly the reason. But the changes in
filemap.c seems to be influencing more.


> 
> >
> > Let me see if I can verify this,
> > Ram Pai
> >
> 
> Bye

