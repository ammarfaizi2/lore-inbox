Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbVDFWxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbVDFWxM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 18:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVDFWxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 18:53:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:57278 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262337AbVDFWxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 18:53:07 -0400
Date: Wed, 6 Apr 2005 15:53:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg Edwards <edwardsg@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CON_CONSDEV bit not set correctly on last console
Message-Id: <20050406155317.54792458.akpm@osdl.org>
In-Reply-To: <20050405191003.GO21725@sgi.com>
References: <20050405191003.GO21725@sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Edwards <edwardsg@sgi.com> wrote:
>
> According to include/linux/console.h, CON_CONSDEV flag should be set on
> the last console specified on the boot command line:
> 
>      86 #define CON_PRINTBUFFER (1)
>      87 #define CON_CONSDEV     (2) /* Last on the command line */
>      88 #define CON_ENABLED     (4)
>      89 #define CON_BOOT        (8)
> 
> This does not currently happen if there is more than one console specified
> on the boot commandline.  Instead, it gets set on the first console on the
> command line.  This can cause problems for things like kdb that look for
> the CON_CONSDEV flag to see if the console is valid.
> 
> Additionaly, it doesn't look like CON_CONSDEV is reassigned to the next
> preferred console at unregister time if the console being unregistered
> currently has that bit set.
> 
> Example (from sn2 ia64):
> 
> elilo vmlinuz root=<dev> console=ttyS0 console=ttySG0
> 
> in this case, the flags on ttySG console struct will be 0x4 (should be
> 0x6).
> 
> Attached patch against bk fixes both issues for the cases I looked at.  It
> uses selected_console (which gets incremented for each console specified
> on the command line) as the indicator of which console to set CON_CONSDEV
> on.  When adding the console to the list, if the previous one had
> CON_CONSDEV set, it masks it out.  Tested on ia64 and x86.

The `console=a console=b' behaviour seem basically random to me :(.  And it
gets re-randomised on a regular basis.

I wonder if we should leave the existing behaviour alone (continue to set
CON_CONSDEV on the first console) and just change the documentation? 
That'll minimise the disruption which we cause.
