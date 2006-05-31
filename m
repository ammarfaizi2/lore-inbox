Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbWEaFz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWEaFz2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 01:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWEaFz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 01:55:28 -0400
Received: from gw.openss7.com ([142.179.199.224]:26344 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S932499AbWEaFz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 01:55:27 -0400
Date: Tue, 30 May 2006 23:55:26 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Raghuram <draghuram@rocketmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about tcp hash function tcp_hashfn()
Message-ID: <20060530235525.A30563@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Raghuram <draghuram@rocketmail.com>,
	linux-kernel@vger.kernel.org
References: <20060531042908.10463.qmail@web51410.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060531042908.10463.qmail@web51410.mail.yahoo.com>; from draghuram@rocketmail.com on Tue, May 30, 2006 at 09:29:08PM -0700
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raghuram,

On Tue, 30 May 2006, Raghuram wrote:

> 
> Hi,
> 
> I needed a hash function (in my TCP related work) for
> a project and happened to look at the function used by
> TCP implementation in Linux. I searched for some
> information about this function but couldn't find much
> info. I would appreciate it if someone can provide
> details or some pointers in this regard. Specifically,
> 
> 
> 1) Are there some design considerations/assumptions
> behind the algorithm? In general, how was the
> algorithm arrived at?

If you mean tcp_hashfn() from 2.4 kernel, I don't believe so.
In fact, if you analyze it, it is not even a very good nor
efficient hash function.  For example, it goes to great pains
to permute upper order bits in the local address, which for
most connections will be a constant value.

> 2) What happens if there are collisions? I am assuming
> that each entry in the array will point to a linked
> list of structures. Is there any limit on the length
> of this list? 

The hash value is used to index a hash bucket that has
established TCP sockets attached in a linked (collision)
list.  Because the number of input values is limited, the
number of collisions is bounded.  What the actual bound is
can be determined by analysis or using numerical methods.

Because local address has an extremely limited range, local
port number has a limited range (for dynamic assigment) and
the maximum number of connections will be limited by other
factors (e.g. system maximum number of open file descriptors)
the practical bound is much smaller than the theoretical bound
on the length of the collision list.  Because it is not a very
good hash function, the bound on collisions for a given range
of input values might be greater than if a better function were
used.  Also, TCP allocates rather large connection hash tables
at startup further reducing the size of collision lists.

There are two typcial uses of TCP: well known port numbers
upon which listening servers exist and outgoing client connections.
Outgoing client connections will almost always use a unique port
number.  The hash function does not really exploit this fact.

--brian

-- 
Brian F. G. Bidulock    ¦ The reasonable man adapts himself to the ¦
bidulock@openss7.org    ¦ world; the unreasonable one persists in  ¦
http://www.openss7.org/ ¦ trying  to adapt the  world  to himself. ¦
                        ¦ Therefore  all  progress  depends on the ¦
                        ¦ unreasonable man. -- George Bernard Shaw ¦
