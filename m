Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268406AbUJDFAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268406AbUJDFAm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 01:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268407AbUJDFAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 01:00:41 -0400
Received: from pc1.pod.cz ([213.155.230.51]:36750 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id S268406AbUJDFA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 01:00:26 -0400
From: "Vitezslav Samel" <samel@mail.cz>
Date: Mon, 4 Oct 2004 07:00:24 +0200
To: Harald Welte <laforge@netfilter.org>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: [BUG] active ftp doesn't work since 2.6.9-rc1
Message-ID: <20041004050024.GA3683@pc11.op.pod.cz>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>
References: <20041001111201.GA23033@pc11.op.pod.cz> <20041001132248.GG27499@sunbeam.de.gnumonks.org> <20041001141050.GH27499@sunbeam.de.gnumonks.org> <20041001111201.GA23033@pc11.op.pod.cz> <20041001132248.GG27499@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041001141050.GH27499@sunbeam.de.gnumonks.org> <20041001132248.GG27499@sunbeam.de.gnumonks.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi!

> >   After upgrade to 2.6.9-rc3 on the firewall (with NAT), active ftp stopped
> > working. The first kernel, which doesn't work is 2.6.9-rc1.
> > Sympotms: passive ftp works O.K., active FTP doesn't open data stream (and in
> > logs there entries about invalid packets - using
> > iptables ... -m state --state INVALID -j LOG)
> 
> I just tried to reproduce the problem.  Can you confirm the problem
> disappears after executing
> 
> echo 1 > /proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_be_liberal
> 
> on your NAT box?

[...]

> Please use the following (attached) fix:
> 
> Fix NAT helper code to update TCP window tracking information
> if it resizes payload (and thus alrers sequence numbers).
> 
> This patchlet was somehow lost during 2.4.x->2.6.x port of TCP 
> window tracking :(
> 
> Signed-off-by: Harald Welte <laforge@netfilter.org>
> 
> --- linux-2.6.9-rc3-plain/net/ipv4/netfilter/ip_nat_helper.c	2004-10-01 12:08:40.000000000 +0000
> +++ linux-2.6.9-rc3-test/net/ipv4/netfilter/ip_nat_helper.c	2004-10-01 13:37:05.283639640 +0000
> @@ -347,7 +347,7 @@
>  	return 1;
>  }
>  
> -/* TCP sequence number adjustment.  Returns true or false.  */
> +/* TCP sequence number adjustment.  Returns 1 on success, 0 on failure */
>  int
>  ip_nat_seq_adjust(struct sk_buff **pskb, 
>  		  struct ip_conntrack *ct, 
> @@ -396,7 +396,12 @@
>  	tcph->seq = newseq;
>  	tcph->ack_seq = newack;
>  
> -	return ip_nat_sack_adjust(pskb, tcph, ct, ctinfo);
> +	if (!ip_nat_sack_adjust(pskb, tcph, ct, ctinfo))
> +		return 0;
> +
> +	ip_conntrack_tcp_update(*pskb, ct, dir);
> +
> +	return 1;
>  }
>  
>  static inline int

  Both solutions are working fine here.

	Thanks,
		Vita Samel
