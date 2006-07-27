Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWG0IyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWG0IyI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 04:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWG0IyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 04:54:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59275 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932442AbWG0IyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 04:54:06 -0400
Date: Thu, 27 Jul 2006 01:53:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: nickpiggin@yahoo.com.au, eike-kernel@sf-tec.de,
       linux-kernel@vger.kernel.org, aia21@cantab.net
Subject: Re: [BUG?] possible recursive locking detected
Message-Id: <20060727015356.f01b5644.akpm@osdl.org>
In-Reply-To: <1153988398.21849.16.camel@imp.csi.cam.ac.uk>
References: <200607261805.26711.eike-kernel@sf-tec.de>
	<20060726225311.f51cee6d.akpm@osdl.org>
	<44C86271.9030603@yahoo.com.au>
	<1153984527.21849.2.camel@imp.csi.cam.ac.uk>
	<20060727003806.def43f26.akpm@osdl.org>
	<1153988398.21849.16.camel@imp.csi.cam.ac.uk>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006 09:19:58 +0100
Anton Altaparmakov <aia21@cam.ac.uk> wrote:

> b) is impossible for ntfs.

ntfs write() is already doing GFP_HIGHUSER allocations inside i_mutex.

Presumably there's some reason why it isn't deadlocking at present.  Could
be that we'll end up deciding to make lockdep shut up about cross-fs
i_mutex-takings, but that's a bit lame because if some other fs starts
taking i_mutex in the reclaim path we're exposed to ab/ba deadlocks, and
they won't be reported.

But sorry, we just cannot go and require that write()'s pagecache
allocations not be able to write dirty data, not be able to strip buffers
from clean pages and not be able to reclaim slab.
