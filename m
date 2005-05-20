Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVETJLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVETJLL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 05:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVETJLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 05:11:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35012 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261392AbVETJLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 05:11:06 -0400
Date: Fri, 20 May 2005 10:11:29 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linuxram@us.ibm.com, dhowells@redhat.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] namespace.c: fix race in mark_mounts_for_expiry()
Message-ID: <20050520091129.GL29811@parcelfarce.linux.theplanet.co.uk>
References: <E1DZ34O-0003RL-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DZ34O-0003RL-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 10:41:24AM +0200, Miklos Szeredi wrote:
> This patch fixes a race found by Ram in mark_mounts_for_expiry() in
> The solution is to make the atomic_read() and the get_namespace() into
> a single atomic operation.  The patch does this in a fairly ugly way
> (see comment above fix), which should be safe regardless.

That it certainly is.  What's more, there is a trivial way to deal with
that crap - have put_namespace() do atomic_dec_and_lock() instead of
atomic_dec_and_test().  And use the same spinlock (vfsmount_lock would be
an obvious choice) to protect the atomicity here.  End of story.
