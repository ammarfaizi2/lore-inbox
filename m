Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWC3J4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWC3J4u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 04:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWC3J4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 04:56:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65478 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751336AbWC3J4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 04:56:50 -0500
Date: Thu, 30 Mar 2006 01:56:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH][RFC] splice support
Message-Id: <20060330015630.00d8cba2.akpm@osdl.org>
In-Reply-To: <20060330094522.GR13476@suse.de>
References: <20060329122841.GC8186@suse.de>
	<20060329143758.607c1ccc.akpm@osdl.org>
	<20060330074534.GL13476@suse.de>
	<20060330000240.156f4933.akpm@osdl.org>
	<20060330081008.GO13476@suse.de>
	<20060330002726.48cf0ffb.akpm@osdl.org>
	<20060330085134.GP13476@suse.de>
	<20060330091523.GQ13476@suse.de>
	<20060330014024.6ada0532.akpm@osdl.org>
	<20060330094522.GR13476@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> > The one-at-a-time logic looks OK from a quick scan.  Do we have logic in
>  > there to check that we're not overrunning i_size?  (See the pain
>  > do_generic_mapping_read() goes through).
> 
>  do_splice_to() checks that, should I move that checking further down in
>  case the file is truncated?

Again, see do_generic_mapping_read()'s ghastly tricks - it checks i_size
after each readpage().

i_size can increase or decrease under our feet if we're not holding i_mutex
(and we don't want to).  So userspace is being silly and the main things we
need to care about here are to not leak uninitialised data and to not oops.
A readpage() outside i_size will return either all-zeroes or some valid
data which isn't actually within i_size any more, so I guess we're OK.



