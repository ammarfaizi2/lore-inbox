Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWIVJTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWIVJTE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 05:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWIVJTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 05:19:04 -0400
Received: from osiris.atheme.org ([69.60.119.211]:53704 "EHLO
	osiris.atheme.org") by vger.kernel.org with ESMTP id S1751113AbWIVJTC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 05:19:02 -0400
In-Reply-To: <ef08l0$avn$1@taverner.cs.berkeley.edu>
References: <4E1176C1-8F18-4790-9BCB-95306ACED48A@atheme.org> <736CE60D-FB88-4246-8728-B7AC7880B28E@atheme.org> <ef08l0$avn$1@taverner.cs.berkeley.edu>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EEE7B568-41EC-4005-AFEF-FD9B47ED98EB@atheme.org>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: William Pitcock <nenolod@atheme.org>
Subject: Re: [PATCH 2.6.18 try 2] net/ipv4: sysctl to allow non-superuser to bypass CAP_NET_BIND_SERVICE requirement
Date: Fri, 22 Sep 2006 04:19:25 -0500
To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 22, 2006, at 3:59 AM, David Wagner wrote:

> William Pitcock  wrote:
>> This patch allows for a user to disable the requirement to meet the
>> CAP_NET_BIND_SERVICE capability for a non-superuser. It is toggled by
>> the net.ipv4.allow_lowport_bind_nonsuperuser sysctl value.
>
> Can't you provide this functionality (in a non-transparent way)  
> through
> user-space code alone?  I'm thinking of a setuid-root program that
> takes a port number as argv[1], binds to that port, dup()s the new
> file descriptor onto fd 0 (say), drops root, and then forks and execs
> a program specified on argv[2].  If you want to get fancy, instead of
> exec-ing, you could use the standard trick to pass the file descriptor
> over a Unix domain socket to some other process.  Seems like you  
> should
> be able to make something like this work, as long as you're willing to
> make small modifications to the program that uses the low port.  Does
> that work?

While this is possible, the purpose of this patch is to allow for  
such things to "just work" without any effort from the user to make  
it work.

Additionally, with your solution, the program would still need to be  
extensively modified. With the sysctl patch, this isn't necessary, as  
the lowport bind() will be successful as long as the sysctl value is  
set to a non-zero value.

On other TCP stacks, such as the one included with FreeBSD, you can  
do the exact same thing this patch does, by doing:

   # sysctl net.inet.ip.portrange.reservedhigh=0

The goal of this patch is to provide similar functionality, which  
right now, it does. However, it's not as fancy as FreeBSD's, but that  
is because PROT_SOCK in af_inet.c is a constant (#define), and thus  
not as nicely tuneable.

However, that is a weak argument for not doing it that way, as I  
could have done something like:

int sysctl_ip_portrange_high = PROT_SOCK;

The current way is simpler, though, than the way it is done in  
FreeBSD, and I feel covers the typical use-case very well.

However, that's really not a bad idea (what you proposed). But, I  
still believe that the sysctl patch is more flexible, especially in  
cases where you might not have the source-code to what you are trying  
to run (common with enterprise apps, gameserver admin panels, etc.).
