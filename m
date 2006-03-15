Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWCOJ5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWCOJ5k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 04:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWCOJ5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 04:57:40 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:11394 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750788AbWCOJ5j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 04:57:39 -0500
Date: Wed, 15 Mar 2006 02:02:10 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
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
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
Message-ID: <20060315100210.GU12807@sorel.sous-sol.org>
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603131802.k2DI2nv8005665@zach-dev.vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> +static void fixup_translation(struct vmi_annotation *a)
> +{
> +	unsigned char *c, *start, *end;
> +	int left;
> +
> +	memcpy(a->nativeEIP, a->translationEIP, a->translation_size);
> +	start = a->nativeEIP;
> +	end = a->nativeEIP + a->translation_size;
> +
> +	for (c = start; c < end;) {
> +		switch(*c) {
> +			case MNEM_CALL_NEAR:
> +				patch_call_site(a, c);
> +				c+=5;
> +				break;
> +
> +			case MNEM_PUSH_I:
> +				c+=5;
> +				break;
> +
> +			case MNEM_PUSH_IB:
> +				c+=2;
> +				break;
> +
> +			case MNEM_PUSH_EAX:
> +			case MNEM_PUSH_ECX:
> +			case MNEM_PUSH_EDX:
> +			case MNEM_PUSH_EBX:
> +			case MNEM_PUSH_EBP:
> +			case MNEM_PUSH_ESI:
> +			case MNEM_PUSH_EDI: 
> +				c+=1;
> +				break;
> +
> +			case MNEM_LEA:
> +				BUG_ON(*(c+1) != 0x64);  /* [--][--]+disp8, %esp */
> +				BUG_ON(*(c+2) != 0x24);  /* none + %esp */
> +				c+=4;
> +				break;
> +
> +			default:
> +				/*
> +				 * Don't printk - it may acquire spinlocks with
> +				 * partially completed VMI translations, causing
> +				 * nuclear meltdown of the core.
> + 				 */
> +				BUG();
> +				return;
> +		}

Why these restrictions?  How do you do int $0x82, for example?

thanks,
-chris
