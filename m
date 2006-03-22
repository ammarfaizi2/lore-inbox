Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932721AbWCVU73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbWCVU73 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 15:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932723AbWCVU7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 15:59:12 -0500
Received: from mail.suse.de ([195.135.220.2]:54229 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932721AbWCVU7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 15:59:02 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC, PATCH 4/24] i386 Vmi inline implementation
Date: Wed, 22 Mar 2006 21:12:50 +0100
User-Agent: KMail/1.9.1
Cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
References: <200603131802.k2DI22OK005657@zach-dev.vmware.com>
In-Reply-To: <200603131802.k2DI22OK005657@zach-dev.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603222112.52385.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 March 2006 19:02, Zachary Amsden wrote:

> +#define MAKESTR(x)              #x
> +#define XSTR(x)                 MAKESTR(x)
> +#define XCONC(args...)		args
> +#define CONCSTR(x...)		#x
> +#define XCSTR(x...)		CONCSTR(x)

We have legions of these all over the tree. How about you put
them into some central file and gc a few?


> +/*
> + * Propagate these definitions as strings up to C code for convenient use
> + * in stringized assembler as pseudo-mnemonics; we must emit assembler
> + * directives to generate equates for the VMI_CALL_XXX symbols, since they
> + * will not be available otherwise to the assembler, and we can't emit
> + * the C versions of these functions from within an inline assembler
> + * string.
> + */
> +asm(".equ VMI_CALL_CUR, 0;\n\t");

The standard way to do this is to use asm-offsets.c



> +#define VDEF(call)						\
> +	asm (".equ VMI_CALL_" #call ", VMI_CALL_CUR;\n\t");	\
> +	asm (".equ VMI_CALL_CUR, VMI_CALL_CUR+1;\n\t");
> +VMI_CALLS

Hmmm? This doesn't look like something a header file should be doing.

How about you put that big list and the definition into a .c ?


> +#if defined(CONFIG_VMI_C_CONVENTION)

I don't think that file can be reviewed in any meaningful way before
you don't get rid of the macro mess and the unneeded calling conventions.


-Andi
