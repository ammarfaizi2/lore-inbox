Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbTGBMVL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 08:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264970AbTGBMVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 08:21:10 -0400
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:33271 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id S264960AbTGBMVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 08:21:06 -0400
Subject: Re: crypto API and IBM z990 hardware support
To: James Morris <jmorris@intercode.com.au>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF014BDDD3.522D4623-ONC1256D57.003FFD79-C1256D57.0044F37D@de.ibm.com>
From: "Thomas Spatzier" <TSPAT@de.ibm.com>
Date: Wed, 2 Jul 2003 14:35:04 +0200
X-MIMETrack: Serialize by Router on D12ML041/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 02/07/2003 14:35:09
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Are there any details available on how all of this is implemented?  Are
> these instructions synchronous?

Yes, the instructions are sunchronous.

> The plan is to provide crypto/arch/ subdirectories where arch optimized
> versions of the crypto algorithms are implemented, and built
automatically
> (via configuration defaults) instead of the generic C versions.
>
> So, there might be:
>
> crypto/aes.c
> crypto/arch/i386/aes.s
>
> where on i386, aes.s would be built into aes.o and aes.c would not be
> built.
>
> The simple solution for you might be something like:
>
> crypto/aes.c -> aes.o
> crypto/arch/s390/aes_z990.c -> aes_z990.o
>
> and the administrator of the system could configure modprobe.conf to
alias
> aes to aes_z990 if the latter is supported in hardware.

I agree on having arch-specific implementations in crypto/arch directories.
However, I've got some problems with having this kind of 'static' aliasing
in modules.conf. In my case I do not know beforehand, whether a specific
crypto instruction is enabled. I query some processor status flags during
runime. If the check fails, I'd like to switch back to the original
software implementation.
I read in your autoconf.c file that a more sophisticated version of
crypto_alg_autoload is planned. I would suggest first trying to load the
arch-specific aes_z990.ko in crypto_alg_autoload. In my init_module
function i could query the processor. If init_module for my implementation
fails -> request_module fails -> load the standard module aes.ko.
Something similar to this:

#ifndef CRYPTO_ARCH      //defined in arch makefile as "_z990"
#define CRYPTO_ARCH ""
#endif

void crypto_alg_autoload(const char *name)
{
      if (request_module("%s%s", name, CRYPTO_ARCH) != 0){
            request_module("%s", name);
      }
}


Regards,

Thomas Spatzier
--------------------------------------------------
+49-7031-16-1219
TSPAT@de.ibm.com

