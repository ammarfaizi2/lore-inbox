Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbTJ2X7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 18:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTJ2X7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 18:59:14 -0500
Received: from ozlabs.org ([203.10.76.45]:37099 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261522AbTJ2X7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 18:59:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16288.21706.380647.350667@cargo.ozlabs.ibm.com>
Date: Thu, 30 Oct 2003 11:01:14 +1100
From: Paul Mackerras <paulus@samba.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix for module initialization failure
In-Reply-To: <20031029233556.939E52C472@lists.samba.org>
References: <20031029233556.939E52C472@lists.samba.org>
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell writes:

> Need a module_arch_cleanup() after a successful module_finalize()
> call: it was missing in the case where module->init() fails.  Since
> module_arch_cleanup() is a noop on x86, I didn't spot it earlier.
> 
> Thanks to Paul Mackerras for prodding me about this again...

Linus: this fixes a real bug which causes an oops on PPC in the case
where you try to load one module, but the init routine fails, and then
you try to load another module.  What happens is that the
module_finalize() call on the first module adds the module to a list
used in BUG() handling.  If the init routine fails, the code currently
doesn't call module_arch_cleanup(), which is where we remove the
module from the list used for BUG handling.  When you try to load the
next module, the BUG list head is pointing to a module which is no
longer there and you get an oops.

Please apply.

Thanks,
Paul.
