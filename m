Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbWAXK6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbWAXK6b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 05:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbWAXK6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 05:58:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62367 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030438AbWAXK6a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 05:58:30 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1138048952965@2gen.com> 
References: <1138048952965@2gen.com> 
To: David =?us-ascii?Q?=3D=3Fiso-8859-1=3FQ=3FH=3DE4rdeman=3F=3D?= 
	<david@2gen.com>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH 03/04] Add encryption ops to the keyctl syscall 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Tue, 24 Jan 2006 10:58:24 +0000
Message-ID: <17515.1138100304@hades.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Härdeman <david@2gen.com> wrote:

> Changes the keyctl syscall to accept six arguments (is it valid to do so?)
> and adds encryption as one of the supported ops for in-kernel keys.

I tried to avoid doing that for it required arch support as I recall, but I'm
not sure which arch I was thinking of. It looks like it ought to be okay...
it's no worse than mmap.

> +	 * - should return the amount of data that would be returned from the
> +         *   encryption even if the buffer is NULL
> +         * - expects the output buffer to be able to hold the result
> +	 */

Can you use TAB chars here please.

>  #define KEYCTL_ASSUME_AUTHORITY		16	/* assume request_key() authorisation */
> +#define KEYCTL_ENCRYPT                  17      /* encrypt a chunk of data using key */

And here.

> +	key = key_ref_to_ptr(key_ref);
> +
> +	/* see if we can read it directly */
> +	ret = key_permission(key_ref, KEY_READ);

You don't actually need to calculate key until after you've done all those
checks, so I'd move it further down the file. You can use the function to
release key references in the error handling or have a separate error handling
return path.

> +			down_read(&key->sem);
> +			ret = key->type->encrypt(key, data, dlen, result, rlen);
> +			up_read(&key->sem);

Do we really want to restrict the key type implementor to using the r/w
semaphore. Would it be better to let the type decide whether it wants to use
the semaphore or let it use RCU if it so desires?

David
