Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131557AbRAKLnZ>; Thu, 11 Jan 2001 06:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131559AbRAKLnQ>; Thu, 11 Jan 2001 06:43:16 -0500
Received: from [172.16.18.67] ([172.16.18.67]:63360 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S131557AbRAKLnG>; Thu, 11 Jan 2001 06:43:06 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <11540.979193123@kao2.melbourne.sgi.com> 
In-Reply-To: <11540.979193123@kao2.melbourne.sgi.com> 
To: Keith Owens <kaos@ocs.com.au>
Cc: Antony Suter <antony@mira.net>,
        List Linux-Kernel <linux-kernel@vger.kernel.org>,
        Allen Unueco <allen@premierweb.com>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Jan 2001 11:42:24 +0000
Message-ID: <5358.979213344@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
>  And what a pile of crud those patches are!!  Instead of using the
> clean replacement interface for get_module_symbol, nvidia/
> patch-2.4.0-PR hard codes the old get_module_symbol algorithm as
> inline code.

Taking away get_module_symbol() and providing a replacement which has link 
order problems wasn't really very sensible.

You've changed a lookup in a static table built at compile time to a lookup 
in a dynamic table which has to be built in the right order at runtime.

It's too late to do the sensible thing and deprecate the old version rather 
than having a 'flag day'. But can we at least fix the link order crap?

struct static_inter_module_entry {
	const char *im_name;
	const void *userdata;
};

#define inter_module_register_static(x,y) \
 static struct static_inter_module_entry __ime_##x \
	__attribute__((unused,__section__(".intermodule")) \
	= { #x, y };

.. and the obvious for looking in that table in inter_module_get().


--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
