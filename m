Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUBAJ7N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 04:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265246AbUBAJ7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 04:59:13 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36364 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265245AbUBAJ7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 04:59:11 -0500
Date: Sun, 1 Feb 2004 09:59:06 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jim McCloskey <mcclosk@ucsc.edu>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: net-pf-10, 2.6.1
Message-ID: <20040201095906.A15264@flint.arm.linux.org.uk>
Mail-Followup-To: Jim McCloskey <mcclosk@ucsc.edu>,
	linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
References: <E1AnDuR-0000Jj-00@toraigh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E1AnDuR-0000Jj-00@toraigh>; from mcclosk@ucsc.edu on Sun, Feb 01, 2004 at 01:28:55AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 01:28:55AM -0800, Jim McCloskey wrote:
> I've tried the variations I can think of---putting the line:
> 
>    install net-pf-10 /bin/true
> 
> in /lib/modules/modprobe.conf via update-modules, or directly by hand-editing.

The first thing to note is that the kernel tries to insert modules
for non-existent network protocols by calling modprobe with net-pf-N
where N is the protocol number.  N=10 for IPv6.

>    ohlone#  modprobe net-pf-10
>    FATAL: Module ipv6 not found.
> 
> indicating that modprobe knows about the alias, but is not running
> /bin/true when requested to load the module.

... because the module is now known as ipv6 not net-pf-10.

> However: if I manually edit /etc/modprobe.d/aliases (which you're not
> supposed to do), so as to comment out:
> 
>   # alias net-pf-10 ipv6
> 
> and then add:
> 
>   install ipv6 /bin/true

You've made two changes at the same time - no wonder you're getting
confused.  In the first change, you've told it to no longer alias
net-pf-10 to ipv6, so it won't go anywhere near "ipv6" anymore.  In
the second change, you've told it to use /bin/true to insert the ipv6
module - which it doesn't find because its still looking for "net-pf-10"

Golden rule: only make one change at a time.

Here's the practical examples showing what's going on:

[root@cps /root]# cat /etc/modprobe.conf
[root@cps /root]# modprobe net-pf-10
FATAL: Module net_pf_10 not found.
[root@cps /root]#

---

[root@cps /root]# cat /etc/modprobe.conf
alias net-pf-10 ipv6
[root@cps /root]# modprobe net-pf-10
FATAL: Module ipv6 not found.
[root@cps /root]#

---

[root@cps /root]# cat /etc/modprobe.conf
alias net-pf-10 ipv6
install net-pf-10 /bin/true
[root@cps /root]# modprobe net-pf-10
FATAL: Module ipv6 not found.
[root@cps /root]#

---

[root@cps /root]# cat /etc/modprobe.conf
alias net-pf-10 ipv6
install ipv6 /bin/true
[root@cps /root]# modprobe net-pf-10
[root@cps /root]#


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
