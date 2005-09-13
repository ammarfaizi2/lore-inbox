Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965072AbVIMTID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbVIMTID (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 15:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbVIMTID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 15:08:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38611 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965072AbVIMTIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 15:08:00 -0400
Date: Tue, 13 Sep 2005 12:07:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Morris <jmorris@namei.org>
Cc: linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil
Subject: Re: [PATCH] SELinux - convert to kzalloc
Message-Id: <20050913120707.74a19800.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0509131116280.3479@excalibur.intercode>
References: <Pine.LNX.4.63.0509131116280.3479@excalibur.intercode>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> wrote:
>
>  This patch converts SELinux code from kmalloc/memset to the new kazalloc 
>  function.  On i386, this results in a text saving of over 1K.
> 
>  Before:
>  text    data     bss     dec     hex filename
>  86319    4642   15236  106197   19ed5 security/selinux/built-in.o
>      
>  After:
>  text    data     bss     dec     hex filename
>  85278    4642   15236  105156   19ac4 security/selinux/built-in.o
> 

That's a nice size reduction.  If we had kzalloc_gfp_kernel(size_t) we
could drop an argument and save even more, but I suspect Linus would come
after me with a cattle prod.

Note that the use of kzalloc() will nullify kmalloc's compile-time
optimisation where it determines which slab to use at compile time -
kzalloc() won't know the size and will have to do the table search.  But
the performance benefit from text size reductions will balance that.

SELinux seems to do a lot of kzalloc(a * b, flags):

 +	mysids = kzalloc(maxnel*sizeof(*mysids), GFP_ATOMIC);
 +	*names = (char**)kzalloc(sizeof(char*) * *len, GFP_ATOMIC);
 +	mysids2 = kzalloc(maxnel*sizeof(*mysids2), GFP_ATOMIC);

Consider using kcalloc() here.
