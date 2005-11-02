Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965197AbVKBTqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbVKBTqd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 14:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbVKBTqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 14:46:33 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:21905 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965197AbVKBTqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 14:46:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=SRux+Z2pSfDBg87DNrKd+/fB+eMujetP1PV5fSr8wWeiTYFA81wHyPaxvpdkDCebjJmPPllv/bJOKHkzyWuJNegbDGwSmvrYqcXDyx8Dvzt9VS+MA3Sf//OlEsXwqwqD3x9/bL8sjUfdlvDSFtj01CDgRZErrKDeDUtQ7S7OEEc=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 8/10] UML - Maintain own LDT entries
Date: Wed, 2 Nov 2005 20:51:22 +0100
User-Agent: KMail/1.8.3
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       bstroesser@fujitsu-siemens.com, Allan Graves <allan.graves@oracle.com>
References: <200510310439.j9V4dfbw000872@ccure.user-mode-linux.org>
In-Reply-To: <200510310439.j9V4dfbw000872@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511022051.24335.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 05:39, Jeff Dike wrote:
> From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
>
> Patch imlements full LDT handling in SKAS:
>  * UML holds it's own LDT table, used to deliver data on
>    modify_ldt(READ)
>  * UML disables the default_ldt, inherited from the host (SKAS3)
>    or resets LDT entries, set by host's clib and inherited in
>    SKAS0
>  * A new global variable skas_needs_stub is inserted, that
>    can be used to decide, whether stub-pages must be supported
>    or not.
>  * Uses the syscall-stub to replace missing PTRACE_LDT (therefore,
>    write_ldt_entry needs to be modified)
Two complaints against this patch (to be fixed afterwards, so I'm not CC'ing 
akpm):

*) It reverts my cleanup and consolidation of ldt.c wrt. SKAS vs TT.

Or at least so I think (I must still give a proper look afterwards, and I'll 
post patches). Actually it seems that this is done on purpose, but I don't 
agree too much on this. I will see.

*) Doesn't compile on old GCC's - it uses anonymous unions:
(it's asm-um/ldt-i386.h).
> +
> +struct ldt_entry {
> +	__u32 a;
> +	__u32 b;
> +};

> +typedef struct uml_ldt {
> +	int entry_count;
> +	struct semaphore semaphore;
> +	union {
> +		struct ldt_entry * pages[LDT_PAGES_MAX];
> +		struct ldt_entry entries[LDT_DIRECT_ENTRIES];
> +	};
> +} uml_ldt_t;

Suggestions for almost free replacement of anonymous union: 
> Index: 2.6.14-akpm/include/asm-um/ldt.h
> ===================================================================
> --- 2.6.14-akpm.orig/include/asm-um/ldt.h	2005-08-28 19:41:01.000000000
> -0400 +++ 2.6.14-akpm/include/asm-um/ldt.h	2005-10-28 17:31:07.000000000
AAAAAAAAAAAARGH!!!!!!!!!!!!!! This is supposed to be a  _SYMLINK_!

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
