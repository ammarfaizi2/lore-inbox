Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWDYDwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWDYDwo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 23:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWDYDwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 23:52:44 -0400
Received: from cantor2.suse.de ([195.135.220.15]:48012 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751360AbWDYDwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 23:52:43 -0400
Date: Mon, 24 Apr 2006 20:51:28 -0700
From: Greg KH <greg@kroah.com>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 1/4] kref: warn kref_put() with unreferenced kref
Message-ID: <20060425035128.GB18085@kroah.com>
References: <20060424083333.217677000@localhost.localdomain> <20060424083341.613638000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424083341.613638000@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 04:33:34PM +0800, Akinobu Mita wrote:
> This patch adds warning to detect kref_put() with unreferenced kref.
> 
> Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
> 
>  lib/kref.c |   14 ++++++++------
>  1 files changed, 8 insertions(+), 6 deletions(-)
> 
> Index: 2.6-git/lib/kref.c
> ===================================================================
> --- 2.6-git.orig/lib/kref.c
> +++ 2.6-git/lib/kref.c
> @@ -49,6 +49,7 @@ void kref_get(struct kref *kref)
>   */
>  int kref_put(struct kref *kref, void (*release)(struct kref *kref))
>  {
> +	WARN_ON(atomic_read(&kref->refcount) < 1);

How can this ever be true?  If the refcount _ever_ goes below 1, the
object is freed.

> @@ -56,12 +57,13 @@ int kref_put(struct kref *kref, void (*r
>  	 * if current count is one, we are the last user and can release object
>  	 * right now, avoiding an atomic operation on 'refcount'
>  	 */
> -	if ((atomic_read(&kref->refcount) == 1) ||
> -	    (atomic_dec_and_test(&kref->refcount))) {
> -		release(kref);
> -		return 1;
> -	}
> -	return 0;
> +	if (atomic_read(&kref->refcount) == 1)
> +		atomic_set(&kref->refcount, 0);
> +	else if (!atomic_dec_and_test(&kref->refcount))
> +		return 0;
> +
> +	release(kref);
> +	return 1;

What does this change do?  What are you trying to help out with?
CONFIG_DEBUG_SLAB will check to see if you reference krefs that have
already been freed.

thanks,

greg k -h
