Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265376AbUGGTsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265376AbUGGTsG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 15:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUGGTsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 15:48:05 -0400
Received: from mailer2.psc.edu ([128.182.66.106]:47579 "EHLO mailer2.psc.edu")
	by vger.kernel.org with ESMTP id S265376AbUGGTsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 15:48:00 -0400
Date: Wed, 7 Jul 2004 15:47:30 -0400 (EDT)
From: John Heffner <jheffner@psc.edu>
To: Stephen Hemminger <shemminger@osdl.org>
cc: "David S. Miller" <davem@redhat.com>, bert hubert <ahu@ds9a.nl>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>, <netdev@oss.sgi.com>,
       <alessandro.suardi@oracle.com>, <phyprabab@yahoo.com>,
       <netdev@oss.sgi.com>, <linux-net@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix tcp_default_win_scale.
In-Reply-To: <20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net>
Message-ID: <Pine.NEB.4.33.0407071541380.19720-100000@dexter.psc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2004, Stephen Hemminger wrote:

> +/* Default window scaling based on the size of the maximum window  */
> +static inline __u8 tcp_default_win_scale(void)
> +{
> +	int b = ffs(sysctl_tcp_rmem[2]);
> +	return (b < 17) ? 0 : b-16;
> +}


I would actually change this to be:

static inline __u8 tcp_select_win_scale(void)
{
	int b = ffs(tcp_win_from_space(max(sysctl_tcp_rmem[2], sysctl_rmem_max)));
	b = (b < 17) ? 0 : b-16;
	return max(b, 14);
}

Then you can also get rid of all the window scale calculation code in
tcp_select_initial_window().

  -John

