Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbTFGMct (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 08:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTFGMct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 08:32:49 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:33178 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S263183AbTFGMcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 08:32:47 -0400
Date: Sat, 7 Jun 2003 14:32:19 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __user annotations
Message-ID: <20030607143219.U626@nightmaster.csn.tu-chemnitz.de>
References: <7369DBDA-983E-11D7-8338-000A95A0560C@us.ibm.com> <Pine.LNX.4.44.0306061016250.20324-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.44.0306061016250.20324-100000@home.transmeta.com>; from torvalds@transmeta.com on Fri, Jun 06, 2003 at 10:28:22AM -0700
X-Spam-Score: -5.0 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19Od5S-0003BN-00*xrNTcLgyxac*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Jun 06, 2003 at 10:28:22AM -0700, Linus Torvalds wrote:
> HOWEVER, usually it's very obvious to fix the whole chain, unless some
> type is sometimes used for kernel addresses and sometimes for user 
> addresses (which networking does with iovec's, for example).
 
Then it's not very useful for me. I usally define the ABI between
user space and kernel space trough IOCTL like that:

/* These structures are usally bigger and nested deeper */
struct in_foo_ioctl_name {
   int bla;
}

struct out_foo_ioctl_name {
   char blubb;
}

union foo_ioctl_name {
   struct in_foo_ioctl_name in;
   struct out_foo_ioctl_name out;
}

#define SUBSYS_IOCTL 0xee

#define SUBSYS_FOO _IOWR(SUBSYS_IOCTL, 0x1, union foo_ioctl_name)

Now I do in principle

   union foo_ioctl_name k, *u = (union foo_ioctl_name *)arg;

   if (copy_from_user(&k.in, &u, sizeof(k.in)) return -EFAULT;
   if (handle_foo(&k)) return -EINVAL;
   if (copy_to_user(&u, &k.out, sizeof(k.out)) return -EFAULT;
   
which I consider very clean (our project provides both: The
only ABI provider and the only ABI user) and works from 2.0
trough 2.5 so far.

This will NOT work anymore with __user annotations, right?

That's a big pity. How do I workaround this? I would like to
help resolving this issues, if you are interested.

Regards

Ingo Oeser
