Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265287AbUIIX5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUIIX5d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbUIIX5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:57:32 -0400
Received: from open.hands.com ([195.224.53.39]:21983 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S265287AbUIIX5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:57:04 -0400
Date: Fri, 10 Sep 2004 01:08:19 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] update: _working_ code to add device+inode check to ipt_owner.c
Message-ID: <20040910000819.GA7587@lkcl.net>
References: <20040909162200.GB9456@lkcl.net> <20040909091931.K1973@build.pdx.osdl.net> <20040909181034.GF10046@lkcl.net> <20040909114846.V1924@build.pdx.osdl.net> <20040909212514.GA10892@lkcl.net> <20040909160449.E1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909160449.E1924@build.pdx.osdl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 04:04:49PM -0700, Chris Wright wrote:

> >  what's the disconnect between the task_list and the sockets (sk_buff)
> >  that makes that [not knowing which one will be woken up] relevant?
> 
> There's nothing stopping the following:  
> 
> exec good_proc
> 	socket()
> 	fork
> 	exec bad_proc
 
> Now good_proc and bad_proc are sharing a socket.  Packet comes in
> destined for that socket.  Rule says it's ok to deliver to socket
> (because of good_proc).  

> Packet delivered to socket, wakes up waiters
> (good and bad).  Now, what's stopping the bad_proc from reading from the
> socket?

 okay.

 i am not so worried about this scenario _because_:

 under an selinux system, you would set up a policy which only
 allowed the good_proc to exec other_good_procs (with the
 macro can_exec(good_proc, { other_good_proc1, other_good_proc2 })


 consequently, you'd design your firewall rules (in conjunction with
 your selinux policy) to add _two_ dev+inode-program-enabled firewall rules
 to cover the same socket, e.g. apache2 (good_proc) and some cgi script
 helper (other_good_proc) - one for each program:

	 iptables -A INPUT -m tcp --dport=80 -m program --exe=/usr/bin/apache2 -j ACCEPT

 and:

	 iptables -A INPUT -m tcp --dport=80 -m program --exe=/usr/cgi-bin/blahblah -j ACCEPT

 
> >  so it's a socket: let's take an example - and i'm assuming for now
> >  that things like passing file descriptors over unix-domain-sockets
> >  between processes just ... doesn't happen, okay? :)
> 
> These do happen, which is part of the problem ;-)
 
 i would not consider this to be a problem [in an environment where
 you specify DENY as the default and ALLOW specific instances]

 under such circumstances [file descs passed between programs]...
 you would end up having to create _two_ program-specific rules, like
 above.

 one for each of the two programs.

 [this has got to be better than the present situation, where you have
  to "iptables -A OUTPUT -m tcp --sport=25" and that allows ANY process
  under the sun to have data escaping on port 25.]

 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

