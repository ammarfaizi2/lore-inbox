Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263758AbTH1Gdq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 02:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTH1Gdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 02:33:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9695 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263758AbTH1Gdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 02:33:44 -0400
Date: Wed, 27 Aug 2003 23:25:14 -0700
From: "David S. Miller" <davem@redhat.com>
To: Vinay K Nallamothu <vinay-rc@naturesoft.net>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.0-test4][IPv6] ip6_flowlabel.c: timer cleanups
Message-Id: <20030827232514.0854fc06.davem@redhat.com>
In-Reply-To: <1061907882.1108.28.camel@lima.royalchallenge.com>
References: <1061907882.1108.28.camel@lima.royalchallenge.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Aug 2003 19:54:41 +0530
Vinay K Nallamothu <vinay-rc@naturesoft.net> wrote:

> @@ -104,10 +105,9 @@
>  			fl->opt = NULL;
>  			kfree(opt);
>  		}
> -		if (!del_timer(&ip6_fl_gc_timer) ||
> -		    (long)(ip6_fl_gc_timer.expires - ttd) > 0)
> -			ip6_fl_gc_timer.expires = ttd;
> -		add_timer(&ip6_fl_gc_timer);
> +		if (!timer_pending(&ip6_fl_gc_timer) ||
> +		    time_after(ip6_fl_gc_timer.expires, ttd))
> +			mod_timer(&ip6_fl_gc_timer, ttd);
>  	}
>  }
>  

This code is still racey.  This code needs to hold the
toplevel ip6_fl_lock during the GC timer manipulations
and tests.
