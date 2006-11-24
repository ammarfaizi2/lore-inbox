Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966058AbWKXTgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966058AbWKXTgW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 14:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966062AbWKXTgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 14:36:22 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:7082 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S966058AbWKXTgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 14:36:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=sbcglobal.net;
  h=Received:X-YMail-OSG:Message-ID:Date:From:Reply-To:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=PcTGHVGbQ8qSdh1yWBNNC9QEoZEsY7xKdl5voHeq02vTrcV1PIz4skg+Tyt+IggcJFX5j0GRIeKG/gTcyydllyRfiTN2/dWQRkuW0fNw08m5FRhAKNrzrDx/miLbG1D/C18lue4+zVWCTYRLGno0Y0KTNB6dgvr/KesdLSPsq+M=  ;
X-YMail-OSG: uJOtgkQVM1mhiY5N0A5zU3VFI8IwbV93XVphNr6fatru9pw9lecjIEgS_F2SVUE8gRPwa3im4bE4uDJBbsA96f9cduSa_pJVyAep5oIDKospzTNYVwEhbA--
Message-ID: <45674952.8020007@sbcglobal.net>
Date: Fri, 24 Nov 2006 13:34:42 -0600
From: Matthew Frost <artusemrys@sbcglobal.net>
Reply-To: artusemrys@sbcglobal.net
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
CC: Andrew Morton <akpm@osdl.org>, Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-mm1
References: <20061123021703.8550e37e.akpm@osdl.org>	<200611231223.48703.m.kozlowski@tuxland.pl> <20061123103607.af7ae8b0.akpm@osdl.org> <45660298.3090003@shadowen.org>
In-Reply-To: <45660298.3090003@shadowen.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> I get this accross the board on my test system too.  All clean downloads.
> 
> A quick look at the combo-patch and the broken-out patch seems to
> indicate they are not in sync with each other.  In the combo-patch we
> have this hunk (which is the one which fails):
> 
> --- linux-2.6.19-rc6/kernel/tsacct.c    2006-11-16 23:19:32.000000000 -0800
> +++ devel/kernel/tsacct.c       2006-11-23 01:12:17.000000000 -0800
> @@ -97,7 +97,14 @@ void xacct_add_tsk(struct taskstats *sta
>         stats->read_syscalls    = p->syscr;
>         stats->write_syscalls   = p->syscw;
>  #ifdef CONFIG_TASK_IO_ACCOUNTING
> -       stats->read_bytes       = p->ioac->read_bytes
> +       stats->read_bytes       = p->ioac.read_bytes;
> +       stats->write_bytes      = p->ioac.write_bytes;
> +       stats->cancelled_write_bytes = p->ioac.cancelled_write_bytes;
> +#else
> +       stats->read_bytes       = 0;
> +       stats->write_bytes      = 0;
> +       stats->cancelled_write_bytes = 0;
> +#endif
> 
> In the broken-out directory the only patch which references this file
> has the following different hunk:
> 
> --- a/kernel/tsacct.c~io-accounting-via-taskstats
> +++ a/kernel/tsacct.c
> @@ -96,6 +96,15 @@ void xacct_add_tsk(struct taskstats *sta
>         stats->write_char       = 0;
>         stats->read_syscalls    = p->syscr;
>         stats->write_syscalls   = p->syscw;
> +#ifdef CONFIG_TASK_IO_ACCOUNTING
> +       stats->read_bytes       = p->ioac.read_bytes;
> +       stats->write_bytes      = p->ioac.write_bytes;
> +       stats->cancelled_write_bytes = p->ioac.cancelled_write_bytes;
> +#else
> +       stats->read_bytes       = 0;
> +       stats->write_bytes      = 0;
> +       stats->cancelled_write_bytes = 0;
> +#endif
>  }
>  #undef KB
>  #undef MB
> 
> Looking at 2.6.19-rc6 this second version seems completely reasonable.
> The former does not.
> 
Swapping out those two hunks makes the patch apply cleanly here, too.  Thanks!

> -apw
> 
Matt
