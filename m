Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTIKR1k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbTIKRYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:24:32 -0400
Received: from mail.kroah.org ([65.200.24.183]:11181 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261448AbTIKRXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:23:13 -0400
Date: Thu, 11 Sep 2003 10:15:05 -0700
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] add kobject to struct module
Message-ID: <20030911171505.GA13070@kroah.com>
References: <20030911062649.GA10454@kroah.com> <20030911081836.E8AFD2C04D@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911081836.E8AFD2C04D@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 06:18:12PM +1000, Rusty Russell wrote:
> In message <20030911062649.GA10454@kroah.com> you write:
> > On a site note, can't you just use a "struct completion" to use for your
> > waiting?  Or do you need to do something special here?
> 
> Hmm, *good* question.  Think...
> 
> Ah, it's because when someone's waiting for the reference count to hit
> zero, we wake them *every* time we decrement.  With the reference
> count spread across every cpu, it's the only way:
> 
>  static inline void module_put(struct module *module)
>  {
>  	if (module) {
>  		unsigned int cpu = get_cpu();
>  		local_dec(&module->ref[cpu].count);
>  		/* Maybe they're waiting for us to drop reference? */
>  		if (unlikely(!module_is_live(module)))
>  			wake_up_process(module->waiter);
>  		put_cpu();
>  	}
>  }
> 
> This doesn't really fit with a completion, unfortunately.

Ah, thanks for the explaination.  Makes sense.

greg k-h
