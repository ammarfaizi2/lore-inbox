Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267687AbTCBRzL>; Sun, 2 Mar 2003 12:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267870AbTCBRzK>; Sun, 2 Mar 2003 12:55:10 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:48579
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S267687AbTCBRzJ>; Sun, 2 Mar 2003 12:55:09 -0500
Message-ID: <3E6247F7.8060301@redhat.com>
Date: Sun, 02 Mar 2003 10:05:43 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030301
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Norbert Kiesel <nkiesel@tbdnetworks.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Multiple & vs. && and | vs. || bugs in 2.4.20
References: <20030302121425.GA27040@defiant>
In-Reply-To: <20030302121425.GA27040@defiant>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Norbert Kiesel wrote:

> --- linux-2.4.20/drivers/usb/acm.c~	2002-12-03 00:17:50.000000000 -0800
> +++ linux-2.4.20/drivers/usb/acm.c	2003-03-02 03:03:34.000000000 -0800
> @@ -240,7 +240,7 @@
>  	if (urb->status)
>  		dbg("nonzero read bulk status received: %d", urb->status);
>  
> -	if (!urb->status & !acm->throttle)  {
> +	if (!urb->status && !acm->throttle)  {
>  		for (i = 0; i < urb->actual_length && !acm->throttle; i++) {
>  			/* if we insert more than TTY_FLIPBUF_SIZE characters,
>  			 * we drop them. */

Have you really looked at detail at all these cases?  The problem is
that you have made the code less efficient on some platforms.  The use
of && requires shortcut evaluation.  I.e., the compiler is forced to not
evaluate !acm->throttle if !urb->status is true.  The causes, unless the
architecture has condition bits, a conditional jump.

The original code didn't need and normally has no jump and thi specific
case was certainly fine before since the result of the ! operator is
either 0 or 1 and therefore the & operator has no strange side effects.

As an example, here is how the code for x86 could have looked before

   movl   status(%edx), %edx
   testl  %edx, %edx
   movl   throttle(%eax), %eax
   sete   %dl
   testl  %eax, %eax
   sete   %al
   andb   %dl, %al
   jne    ...
   [if code]

After the change the code must look something like this:

   movl   status(%edx), %edx
   testl  %edx, %edx
   jne    ...
   movl   throttle(%eax), %eax
   testl  %eax, %eax
   jne    ...
   [if code]


Observe the extra 'jne' and the fact that the value of 'throttle'
element cannot be loaded until after the conditional jump.   Not even
out of order execution can arrange that.


To summarize, I'd probably not be amused if you would change any of my
code which takes advantage of such programming finess.  I would probably
have added appropriate comments to explain the code but nevertheless,
replacing the more efficient code with some which is easier to
understand should probably be considered on a case by case basis.
Incorrect branch prediction is costly.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Ykf82ijCOnn/RHQRApJaAKCxM4hwu12mJVbQuD3o+t13YVxrsACgsnVH
RZmgjNB5KP3Qu27iqpf5aiU=
=l7xl
-----END PGP SIGNATURE-----

