Return-Path: <linux-kernel-owner+w=401wt.eu-S1751890AbWLNH6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbWLNH6G (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 02:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbWLNH5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 02:57:41 -0500
Received: from sp604002mt.neufgp.fr ([84.96.92.61]:53269 "EHLO sMtp.neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751886AbWLNH5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 02:57:37 -0500
Date: Thu, 14 Dec 2006 08:56:44 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: kref refcnt and false positives
In-reply-to: <20061213164159.f93cde95.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <gregkh@suse.de>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Arjan <arjan@linux.intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Message-id: <458103BC.4080802@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <20061213153408.A13049@unix-os.sc.intel.com>
 <20061214001246.GA10056@suse.de> <20061213164159.f93cde95.akpm@osdl.org>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> On Wed, 13 Dec 2006 16:12:46 -0800
> Greg KH <gregkh@suse.de> wrote:
> 
>>> Original comment seemed to indicate that this conditional thing was
>>> performance related. Is it really? If not, we should consider the below patch.
>> Yes, it's a performance gain and I don't see how this patch would change
>> the above warning.
> 
> I suspect it's a false optimisation.
> 
> int kref_put(struct kref *kref, void (*release)(struct kref *kref))
> {
> 	WARN_ON(release == NULL);
> 	WARN_ON(release == (void (*)(struct kref *))kfree);
> 
> 	/*
> 	 * if current count is one, we are the last user and can release object
> 	 * right now, avoiding an atomic operation on 'refcount'
> 	 */
>  	if ((atomic_read(&kref->refcount) == 1) ||
> 	    (atomic_dec_and_test(&kref->refcount))) {
> 		release(kref);
> 		return 1;
> 	}
> 	return 0;
> }
> 
> The only time we avoid the atomic_dec_and_test() is when the object is
> about to be freed.  ie: once in its entire lifetime.  And freeing the
> object is part of an expensive (and rare) operation anyway.
> 
> otoh, we've gone and added a test-n-branch to the common case: those cases
> where the object will not be freed.
> 

I agree this 'optimization' is not "good" (I was the guy who suggested it 
http://lkml.org/lkml/2006/1/30/4 )

After Eric Biederman message (http://lkml.org/lkml/2006/1/30/292) I remember 
adding some stat counters and telling Greg to not put the patch in because 
kref_put() was mostly called with refcount=1. But the patch did its way. I 
*did* ask Greg to revert it, but cannot find this mail archived somewhere...

But I believe Venkatesh problem comes from its release() function : It is 
supposed to free the object.
If not, it should properly setup it so that further uses are OK.

ie doing in release(kref)
atomic_set(&kref->count, 0);

Eric
