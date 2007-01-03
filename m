Return-Path: <linux-kernel-owner+w=401wt.eu-S1754671AbXACGzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671AbXACGzu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 01:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754670AbXACGzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 01:55:50 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:53759 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754671AbXACGzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 01:55:50 -0500
Date: Wed, 3 Jan 2007 12:25:38 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
       Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Adrian Bunk <bunk@stusta.de>, Jean Delvare <khali@linux-fr.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] i386 kernel instant reboot with older binutils fix
Message-ID: <20070103065538.GD17546@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20070103041645.GA17546@in.ibm.com> <m1tzz8k3sd.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1tzz8k3sd.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 11:44:34PM -0700, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@in.ibm.com> writes:
> 
> > o i386 kernel reboots instantly if compiled with binutils older than
> >   2.6.15.
> >
> > o Older binutils required explicit flags to mark a section allocatable
> >   and executable(AX). Newer binutils automatically mark a section AX if
> >   the name starts with .text.
> >
> > o While defining a new section using assembler "section" directive,
> >   explicitly mention section flags.
> 
> As such this patch looks fine, and is certainly harmless.  But don't we
> also need to address the issue that .text.head is not listed in the
> linker script?
> 
> i.e.  Don't we also need?
> 
>   .text : AT(ADDR(.text) - LOAD_OFFSET) {
>   	_text = .;			/* Text and read-only data */
> +	*(.text.head)
> 	*(.text)
> 	SCHED_TEXT
> 	LOCK_TEXT
> 	KPROBES_TEXT
> 	*(.fixup)
> 	*(.gnu.warning)
>   	_etext = .;			/* End of text section */
>   } :text = 0x9090
> 
> 
> I'm not even certain how the i386 kernel links properly without the above.

Hi Eric,

This .text.head section is not part of vmlinux. This is part of uncompressed
portion in bzImage. arch/i386/boot/compressed/head.S.

Hence, arch/i386/boot/compressed/vmlinux.lds should take care of it which
already has entry for linking .text.head section.

        . =  0  ;
        .text.head : {
                _head = . ;
                *(.text.head)
                _ehead = . ;
        }

Thanks
Vivek
