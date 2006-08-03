Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWHCRVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWHCRVu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 13:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWHCRVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 13:21:50 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32394 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964800AbWHCRVu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 13:21:50 -0400
Subject: Re: frequent slab corruption (since a long time)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Miller <davem@davemloft.net>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org, jbaron@redhat.com
In-Reply-To: <20060802.154954.112624420.davem@davemloft.net>
References: <20060801.220538.89280517.davem@davemloft.net>
	 <20060801.223110.56811869.davem@davemloft.net>
	 <20060802222321.GH3639@redhat.com>
	 <20060802.154954.112624420.davem@davemloft.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Aug 2006 18:40:42 +0100
Message-Id: <1154626843.23655.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-02 am 15:49 -0700, ysgrifennodd David Miller:
> > None of the code manipulating tty->count seems to be under
> > the tty_mutex.  Should it be ?
> > Or is this protected through some other means?
> 
> It is in the primary code paths at least, all callers of init_dev()
> (which increments tty->count) grab the mutex and also release_dev()
> grabs the mutex around tty->count manipulations.

I've been auditing tty code and its joyously bad but only in harmless
places so far except for one.

init_dev (and caller) relies on tty_mutex to ensure that the
driver->ttys list is protected from things going away.

release_mem() removes stuff from the said list and frees memory. It is
not always called under tty_mutex and that appears very dubious to me at
the moment although tty->closing and the BKL *might* be sufficient.

Alan

