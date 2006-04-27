Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbWD0LpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWD0LpR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 07:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWD0LpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 07:45:16 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:50876 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S965024AbWD0LpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 07:45:14 -0400
Date: Thu, 27 Apr 2006 13:45:12 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 1/4] kref: warn kref_put() with unreferenced kref
Message-ID: <20060427114512.GA6533@bitwizard.nl>
References: <20060424083333.217677000@localhost.localdomain> <20060424083341.613638000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424083341.613638000@localhost.localdomain>
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 04:33:34PM +0800, Akinobu Mita wrote:
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

This is WRONG. The refcount can be incremented (to two) AFTER the
atomic_read ==1 and the "atomic_set". The original code seems 
ok in this respect. 

	Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
