Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946429AbWJSUYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946429AbWJSUYJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 16:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946442AbWJSUYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 16:24:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54686 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1946429AbWJSUYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 16:24:07 -0400
Date: Thu, 19 Oct 2006 16:23:54 -0400
From: Dave Jones <davej@redhat.com>
To: Marcus Meissner <meissner@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] binfmt_elf: randomize PIE binaries
Message-ID: <20061019202354.GI26530@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marcus Meissner <meissner@suse.de>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20061019143547.GA8586@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061019143547.GA8586@suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 04:35:47PM +0200, Marcus Meissner wrote:

 > --- linux-2.6.18/fs/binfmt_elf.c.xx	2006-10-19 11:21:49.000000000 +0200
 > +++ linux-2.6.18/fs/binfmt_elf.c	2006-10-19 11:24:58.000000000 +0200
 > @@ -856,7 +856,12 @@ static int load_elf_binary(struct linux_
 >  			 * default mmap base, as well as whatever program they
 >  			 * might try to exec.  This is because the brk will
 >  			 * follow the loader, and is not movable.  */
 > -			load_bias = ELF_PAGESTART(ELF_ET_DYN_BASE - vaddr);
 > +			if (current->flags & PF_RANDOMIZE)
 > +				load_bias = randomize_range(0, ELF_ET_DYN_BASE,
 > +							    vaddr);
 > +			else
 > +				load_bias = ELF_ET_DYN_BASE - vaddr;
 > +			load_bias = ELF_PAGESTART(load_bias);
 >  		}
 >  
 >  		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,


vaddr seems odd to be using as the len for randomize_range doesn't it ?
Should that be randomize_range(0, ELF_ET_DYN_BASE, ELF_ET_DYN_BASE - vaddr); 

maybe ?

Also, when we get to the elf_map(), we add vaddr back again, but in the
randomize_range case, we never subtracted it.  hmm?

	Dave

-- 
http://www.codemonkey.org.uk
