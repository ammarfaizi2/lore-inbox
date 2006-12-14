Return-Path: <linux-kernel-owner+w=401wt.eu-S1751884AbWLNAmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbWLNAmJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 19:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbWLNAmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 19:42:09 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34118 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885AbWLNAmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 19:42:07 -0500
Date: Wed, 13 Dec 2006 16:41:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <gregkh@suse.de>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Arjan <arjan@linux.intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kref refcnt and false positives
Message-Id: <20061213164159.f93cde95.akpm@osdl.org>
In-Reply-To: <20061214001246.GA10056@suse.de>
References: <20061213153408.A13049@unix-os.sc.intel.com>
	<20061214001246.GA10056@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 16:12:46 -0800
Greg KH <gregkh@suse.de> wrote:

> > Original comment seemed to indicate that this conditional thing was
> > performance related. Is it really? If not, we should consider the below patch.
> 
> Yes, it's a performance gain and I don't see how this patch would change
> the above warning.

I suspect it's a false optimisation.

int kref_put(struct kref *kref, void (*release)(struct kref *kref))
{
	WARN_ON(release == NULL);
	WARN_ON(release == (void (*)(struct kref *))kfree);

	/*
	 * if current count is one, we are the last user and can release object
	 * right now, avoiding an atomic operation on 'refcount'
	 */
 	if ((atomic_read(&kref->refcount) == 1) ||
	    (atomic_dec_and_test(&kref->refcount))) {
		release(kref);
		return 1;
	}
	return 0;
}

The only time we avoid the atomic_dec_and_test() is when the object is
about to be freed.  ie: once in its entire lifetime.  And freeing the
object is part of an expensive (and rare) operation anyway.

otoh, we've gone and added a test-n-branch to the common case: those cases
where the object will not be freed.

