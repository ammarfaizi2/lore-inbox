Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292254AbSBYVdO>; Mon, 25 Feb 2002 16:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292275AbSBYVdJ>; Mon, 25 Feb 2002 16:33:09 -0500
Received: from ns.suse.de ([213.95.15.193]:47116 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292254AbSBYVcG>;
	Mon, 25 Feb 2002 16:32:06 -0500
Date: Mon, 25 Feb 2002 22:32:03 +0100
From: Dave Jones <davej@suse.de>
To: Ben Clifford <benc@hawaga.org.uk>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, acme@conectiva.com.br
Subject: Re: Linux 2.5.5-dj1 - IPv6 not loading correctly.
Message-ID: <20020225223203.C27081@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Ben Clifford <benc@hawaga.org.uk>, linux-kernel@vger.kernel.org,
	davem@redhat.com, acme@conectiva.com.br
In-Reply-To: <Pine.LNX.4.33.0202241300100.11220-100000@barbarella.hawaga.org.uk> <Pine.LNX.4.33.0202242203080.21716-100000@barbarella.hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0202242203080.21716-100000@barbarella.hawaga.org.uk>; from benc@hawaga.org.uk on Sun, Feb 24, 2002 at 10:16:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 10:16:16PM -0800, Ben Clifford wrote:

 > Looking at the code, the the ICMP6 control socket error is occurring
 > because sock_register isn't called for inet6 until after the ICMP6 control
 > socket is created (in af_inet6.c).
 > However, the ICMP6 control socket create calls sock_create, which requires
 > sock_register to have already been called.

 This probably happened during acme's recent protocol cleanups,
 and is probably a problem in mainline as well as -dj.
 
 > I have made the below change, which moves the protocol family registration
 > higher up in the code.  It seems to make ipv6 work now.
 > 
 > However, I'm concerned that this gives a small amount of time when the
 > family is registered but not fully initialised.
 > Is this bad?

 I'll let davem/acme comment on the correctness of the fix..
 Looks straightforward enough to me, but I'm not as kneedeep in
 networking internals as those two 8-)

 > 
 > - --- /mnt/dev/hda11/2.5.5-dj1-snark-not-changed-much/net/ipv6/af_inet6.c	Tue Feb 19 18:10:53 2002
 > +++ 2.5.5-dj1/net/ipv6/af_inet6.c	Sun Feb 24 22:13:38 2002
 > @@ -675,6 +675,13 @@
 >  	 */
 >  	inet6_register_protosw(&rawv6_protosw);
 > 
 > +	/* register the family here so that the init calls below will
 > +	 * work. ?? is this dangerous ??
 > +	 */
 > +
 > +	(void) sock_register(&inet6_family_ops);
 > +
 > +
 >  	/*
 >  	 *	ipngwg API draft makes clear that the correct semantics
 >  	 *	for TCP and UDP is to consider one TCP and UDP instance
 > @@ -719,9 +726,6 @@
 >  	udpv6_init();
 >  	tcpv6_init();
 > 
 > - -	/* Now the userspace is allowed to create INET6 sockets. */
 > - -	(void) sock_register(&inet6_family_ops);
 > - -
 >  	return 0;
 > 
 >  #ifdef CONFIG_PROC_FS
 > 

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
