Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262811AbVCPVdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbVCPVdj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 16:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbVCPVbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 16:31:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:32954 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262815AbVCPVad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:30:33 -0500
Date: Wed, 16 Mar 2005 13:29:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org,
       benh@kernel.crashing.org, len.brown@intel.com,
       volker.braun@physik.hu-berlin.de
Subject: Re: [PATCH 1/2] Thinkpad Suspend Powersave: Fix ACPI's GFP_KERNEL
 allocations in contexts that can sleep
Message-Id: <20050316132952.3af7cff8.akpm@osdl.org>
In-Reply-To: <2.518178082@mit.edu>
References: <1.518178082@mit.edu>
	<2.518178082@mit.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Y. Ts'o" <tytso@mit.edu> wrote:
>
> This fixes a problem originally reported by Christian Borntraeger where
>  during the wakeup from a suspend-to-ram, several "sleeping function
>  called from invalid context" warning messages are issued.  Unlike a
>  previous patch which attempted to solve this problem, we avoid doing an
>  GFP_ATOMIC kmalloc() except when explicitly necessary.
> 
>  Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
> 
>  Index: src/drivers/acpi/osl.c
>  ===================================================================
>  --- src.orig/drivers/acpi/osl.c	2005-03-14 09:38:15.000000000 -0500
>  +++ src/drivers/acpi/osl.c	2005-03-14 09:38:18.000000000 -0500
>  @@ -145,7 +145,7 @@
>   void *
>   acpi_os_allocate(acpi_size size)
>   {
>  -	return kmalloc(size, GFP_KERNEL);
>  +	return kmalloc(size, in_atomic() ? GFP_ATOMIC : GFP_KERNEL);

We shouldn't do this.  Please see
http://www.uwsg.iu.edu/hypermail/linux/kernel/0503.1/1205.html
