Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbTGBVw1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 17:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264632AbTGBVw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 17:52:27 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:30401 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S264539AbTGBVwZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 17:52:25 -0400
Message-Id: <200307022206.h62M6aFB025817@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: crypto API and IBM z990 hardware support
To: James Morris <jmorris@intercode.com.au>,
       Thomas Spatzier <TSPAT@de.ibm.com>, linux-kernel@vger.kernel.org
Date: Thu, 03 Jul 2003 00:06:21 +0200
References: <4P45.5YN.11@gated-at.bofh.it> <4T81.24d.41@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:

> On Wed, 2 Jul 2003, Thomas Spatzier wrote:
>
> I'd like to avoid these kind of macros, and make it a general case 
> solution (e.g. which can be used for various hardware implementations).
Right.

> One possibility would be to allow registration with an alias list in
> crypto API with attributes indicating whether the module is hardware,
> arch-specific etc.

Still too complicated imho. The built-in code should not need to know
about which modules exist. For example that would prevent autoloading
of third-party hardware crypto drivers. In most cases, a 
first-come-first-serve approach is sufficient and works without 
changes to the current code. Modules implementing the same algorithm
can just set .cra_name to the same value.

For built-in drivers, link order decides which implementation is 
preferred. Consequently, hardware crypto drivers need to come before
software implementations and must not register themselves if the 
hardware is not found at initcall time.

For the module case, the aes-z990.o module could declare
'MODULE_ALIAS(aes-hw);', the simple patch below makes sure
that any aes-hw module is preferred to the software aes
module. If there is more than one hardware implementation
available for an architecture, either the autoloader can be
extended further, or modprobe has to be configured
appropriately.

        Arnd <><

===== crypto/autoload.c 1.7 vs edited =====
--- 1.7/crypto/autoload.c       Sat May 17 21:39:13 2003
+++ edited/crypto/autoload.c    Wed Jul  2 23:48:10 2003
@@ -21,16 +21,15 @@
  * A far more intelligent version of this is planned.  For now, just
  * try an exact match on the name of the algorithm.
  */
-void crypto_alg_autoload(const char *name)
-{
-       request_module("%s", name);
-}
-
 struct crypto_alg *crypto_alg_mod_lookup(const char *name)
 {
        struct crypto_alg *alg = crypto_alg_lookup(name);
        if (alg == NULL) {
-               crypto_alg_autoload(name);
+               request_module("%s-hw", name);
+               alg = crypto_alg_lookup(name);
+       }
+       if (alg == NULL) {
+               request_module("%s", name);
                alg = crypto_alg_lookup(name);
        }
        return alg;

