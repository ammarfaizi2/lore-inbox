Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbTEHSBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 14:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTEHSBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 14:01:48 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:31736 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S261962AbTEHSBr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 14:01:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Terje Malmedal <terje.malmedal@usit.uio.no>, hch@infradead.org
Subject: Re: The disappearing sys_call_table export.
Date: Thu, 8 May 2003 13:13:49 -0500
X-Mailer: KMail [version 1.2]
Cc: hch@infradead.org, alan@lxorguk.ukuu.org.uk, terje.eggestad@scali.com,
       arjanv@redhat.com, linux-kernel@vger.kernel.org, D.A.Fedorov@inp.nsk.su
References: <E19DnLH-0002As-00@aqualene.uio.no>
In-Reply-To: <E19DnLH-0002As-00@aqualene.uio.no>
MIME-Version: 1.0
Message-Id: <03050813134901.09468@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 May 2003 10:29, Terje Malmedal wrote:
> [Christoph Hellwig]
>
> >> The only problem I can see is that different modules overloading the
> >> same function needs to be unloaded in the correct order. Is this the
> >> only reason for removing it, or am I missing something?
> >
> > it's racy - and it doesn't work on half of the arches added over the
> > last years.
>
> Would you be so kind as to explain exactly what is racy? Just
> asserting that it is does not help me understand anything.

Look at this:

[1]int init_module(void)
[2]{
[3]  orig_fsync=sys_call_table[SYS_fsync];
[4]  sys_call_table[SYS_fsync]=hacked_fsync;
[5]  return 0;
[6]}

Unless there is a LOCK on sys_call_table[SYS_fsync] another CPU could
replace the pointer between lines 3 and 4. At that point line 4 would
destroy the existing entry.. or destroy it when the original is restored,
and would NOT be restoring the one insterted.
