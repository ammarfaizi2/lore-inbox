Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264142AbTEOXfQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 19:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTEOXfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 19:35:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:5544 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264142AbTEOXfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 19:35:15 -0400
Date: Thu, 15 May 2003 16:47:32 -0700 (PDT)
Message-Id: <20030515.164732.15245120.davem@redhat.com>
To: chas@cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] allow atm to be loaded as a module
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305152140.h4FLeX101951@relax.cmf.nrl.navy.mil>
References: <200305152140.h4FLeX101951@relax.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@cmf.nrl.navy.mil>
   Date: Thu, 15 May 2003 17:40:33 -0400

Please make this smaller.

   +static int __init atm_init(void)
   +{
   +	int error;
   +
   +	if ((error = atmpvc_init()) < 0) {
   +		printk(KERN_ERR "atmpvc_init() failed with %d\n", error);
   +		goto done;
   +	}
   +	if ((error = atmsvc_init()) < 0) {
   +		printk(KERN_ERR "atmsvc_init() failed with %d\n", error);
   +		atmpvc_exit();
   +		goto done;
   +	}
   +#ifdef CONFIG_PROC_FS
   +        if ((error = atm_proc_init()) < 0) {
   +		printk(KERN_ERR "atm_proc_init() failed with %d\n",error);
   +		atmpvc_exit();
   +		atmsvc_exit();
   +		goto done;
   +	}
   +#endif
   +done:
   +	return error;
   +}

Duplicating the exit functions (up to 3 times) is a huge waste of
space and no compiler is going to do this rearrangement for you.
Yes, this means use gotos....
