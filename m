Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264094AbTGBQnX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 12:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbTGBQnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 12:43:23 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:31251 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S264094AbTGBQnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 12:43:21 -0400
Date: Thu, 3 Jul 2003 02:57:30 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Thomas Spatzier <TSPAT@de.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: crypto API and IBM z990 hardware support
In-Reply-To: <OF014BDDD3.522D4623-ONC1256D57.003FFD79-C1256D57.0044F37D@de.ibm.com>
Message-ID: <Mutt.LNX.4.44.0307030234400.1298-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jul 2003, Thomas Spatzier wrote:

> I agree on having arch-specific implementations in crypto/arch directories.
> However, I've got some problems with having this kind of 'static' aliasing
> in modules.conf. In my case I do not know beforehand, whether a specific
> crypto instruction is enabled. I query some processor status flags during
> runime. If the check fails, I'd like to switch back to the original
> software implementation.

I did say it was the simple solution :-)

> I read in your autoconf.c file that a more sophisticated version of
> crypto_alg_autoload is planned. I would suggest first trying to load the
> arch-specific aes_z990.ko in crypto_alg_autoload. In my init_module
> function i could query the processor. If init_module for my implementation
> fails -> request_module fails -> load the standard module aes.ko.
> Something similar to this:
> 
> #ifndef CRYPTO_ARCH      //defined in arch makefile as "_z990"
> #define CRYPTO_ARCH ""
> #endif
> 
> void crypto_alg_autoload(const char *name)
> {
>       if (request_module("%s%s", name, CRYPTO_ARCH) != 0){
>             request_module("%s", name);
>       }
> }


I'd like to avoid these kind of macros, and make it a general case 
solution (e.g. which can be used for various hardware implementations).

One possibility would be to allow registration with an alias list in
crypto API with attributes indicating whether the module is hardware,
arch-specific etc.

So, during init, the s390 arch could register an alias like:

  name .= "aes_z990"
  algorithm .= "aes"
  attributes .= CRYPTO_ATTR_ARCH|CRYPTO_ATTR_HW

Then, when a caller specifies "aes", crypto_alg_autoload() would first
check the alias list, giving preference to CRYPTO_ALG_ARCH by default.  
In this case, it would find aes_z990 and try and load it.  If this fails,
it continues along the alias list then ultimately falls back to the
current behavior.

This would allow subsystems and hardware drivers to dynamically provide 
information to the API.  Callers of crypto_alloc_tfm() could then pass 
flags specifying preferences for algorithm implementations e.g. generic 
sw, arch sw, arch hw, misc hw.

This would also need to take into account modprobe.conf configuration and 
compiled in modules.



- James
-- 
James Morris
<jmorris@intercode.com.au>

