Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266159AbUAGO7e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 09:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266166AbUAGO7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 09:59:34 -0500
Received: from lmdeliver02.st1.spray.net ([212.78.202.115]:62412 "EHLO
	lmdeliver02.st1.spray.net") by vger.kernel.org with ESMTP
	id S266159AbUAGO7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 09:59:32 -0500
From: Paolo Ornati <ornati@lycos.it>
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
Date: Wed, 7 Jan 2004 15:59:16 +0100
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>, gandalf@wlug.westbo.se,
       linux-kernel@vger.kernel.org
References: <200401021658.41384.ornati@lycos.it> <200401041530.24395.ornati@lycos.it> <1073344795.3088.19.camel@dyn319250.beaverton.ibm.com>
In-Reply-To: <1073344795.3088.19.camel@dyn319250.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401071559.16130.ornati@lycos.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 January 2004 00:19, you wrote:
> Sorry I was on vacation and could not get back earlier.
>
> I do not exactly know the reason why sequential reads on blockdevices
> has regressed. One probable reason is that the same lazy-read
> optimization which helps large random reads is regressing the sequential
> read performance.
>
> Note: the patch, waits till the last page in the current window is being
> read, before triggering a new readahead. By the time the readahead
> request is satisfied, the next sequential read may already have been
> requested. Hence there is some loss of parallelism here. However given
> that largesize random reads is the most common case; this patch attacks
> that case.
>
> If you revert back just the lazy-read optimization, you might see no
> regression for sequential reads,

I have tried to revert it out:

--- mm/readahead.c.orig	2004-01-07 15:17:00.000000000 +0100
+++ mm/readahead.c.my	2004-01-07 15:33:13.000000000 +0100
@@ -480,7 +480,8 @@
 		 * If we read in earlier we run the risk of wasting
 		 * the ahead window.
 		 */
-		if (ra->ahead_start == 0 && offset == (ra->start + ra->size -1)) {
+		if (ra->ahead_start == 0) {
 			ra->ahead_start = ra->start + ra->size;
 			ra->ahead_size = ra->next_size;

but the sequential read performance is still the same !

Reverting out the other part of the patch (that touches mm/filemap.c) the
sequential read performance comes back like in 2.6.0.

I don't know why... but it does.

>
> Let me see if I can verify this,
> Ram Pai
>

Bye

-- 
	Paolo Ornati
	Linux v2.4.23


