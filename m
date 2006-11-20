Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966606AbWKTWTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966606AbWKTWTe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966275AbWKTWTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:19:34 -0500
Received: from ozlabs.org ([203.10.76.45]:51920 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S966606AbWKTWTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:19:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17762.9524.67555.778549@cargo.ozlabs.ibm.com>
Date: Tue, 21 Nov 2006 08:59:16 +1100
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH 01/22] powerpc: convert idle_loop to use hard_irq_disable()
In-Reply-To: <20061120180520.418063000@arndb.de>
References: <20061120174454.067872000@arndb.de>
	<20061120180520.418063000@arndb.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann writes:

> I got a bug report that I believe might be fixed by this
> patch. The problem seems to be that with soft-disabled
> interrupts in power_save, we can still get external exceptions
> on Cell, even if we are in pause(0) a.k.a. sleep state.

[snip]

> -				local_irq_disable();
> +				hard_irq_disable();

This would mean that any platform-specific power_save function that
wants to re-enable interrupts (as the pseries ones do) would have to
do hard_irq_enable instead of local_irq_enable.  Also, I don't think
this change will be good on iSeries.

What we want is an irq-disable function that is like local_irq_disable
but also clears MSR_EE and the hard irq enabled flag (provided we
aren't running on iSeries).

Paul.
