Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266347AbUGUOfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266347AbUGUOfe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 10:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266351AbUGUOfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 10:35:34 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:1408 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266347AbUGUOfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 10:35:32 -0400
Date: Wed, 21 Jul 2004 20:04:16 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] kref shrinkage patches -- 1 of 2 -- kref shrinkage
Message-ID: <20040721143413.GB5974@obelix.in.ibm.com>
References: <20040720122307.GA1235@obelix.in.ibm.com> <20040721061418.GB18787@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721061418.GB18787@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 02:14:18AM -0400, Greg KH wrote:
> ... 
> > Just had a question about definition of kref_get though, 
> > why does it need to return struct kref * ? struct kref * is anywayz 
> > being passed to it, hence the caller has it anywayz -- so it doesn't 
> > value add anything afaics (but i might have limited vision so pls correct me)
> 
> Consistancy with other "get" and "put" functions.  It's quite common to
> do:
> 	have_this_foo(foo_get(foo));
> 
> or:
> 	foo_to_send_off = foo_get(foo);
> 

kref_get is invoked from inside foo_get in such cases no? so foo_get
can do kref_get and return struct *foo...like in usb_serial_get_by_index?

Even assuming foo_get is altogether replaced with kref_get, which might 
not be a very common case (looking at the current usage, and future usage in
fget_light etc)
we will still have to do
	foo_to_send_off = KREF_TO_FOO(kref_get(&foo->kref));
instead :
	kref_get(&foo->kref);
	foo_to_send_off = foo;
is better right?  Why use a macro for just one extra line of code.... 
Looking at the current usage and looking at refcount 'getters'
like fget, mntget etc., 'doesn't look like people will use the return
value from kref_get much anywayz.  Since the api is young is it better to
kill the return value now than let people misuse the return type like in the
scsi subsystem? 

Thanks,
Kiran
