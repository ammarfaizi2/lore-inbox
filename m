Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVAYNJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVAYNJK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 08:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVAYNJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 08:09:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12459 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261930AbVAYNIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 08:08:54 -0500
Date: Tue, 25 Jan 2005 07:20:21 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nick Pollitt <npollitt@mvista.com>
Cc: kaos@sgi.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Configure mangles hex values
Message-ID: <20050125092021.GA19359@logos.cnet>
References: <200501241416.36422.npollitt@mvista.com> <200501241441.56586.npollitt@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501241441.56586.npollitt@mvista.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Nick,

Curiosity: What was the reason for stripping the leading 0x? 

On Mon, Jan 24, 2005 at 02:41:56PM -0800, Nick Pollitt wrote:
> Sorry about previous message.
> 
> The hex function in scripts/Configure strips the leading 0x from hex values.  
> The 0x needs to be there in autoconf.h, and stripping it out causes the 
> following problematic scenario:
> 
> If I start with a hex value in my config file like this:
> CONFIG_LOWMEM_SIZE=0x40000000
> and then run make oldconfig, it strips out the '0x' so I end up with this:
> CONFIG_LOWMEM_SIZE=40000000
> Then if I run make xconfig, it doesn't think this is a valid hex value, so it
> replaces my value with the default:
> CONFIG_LOWMEM_SIZE=0x20000000
> 
> The following patch removes the lines that strip out 0x, and inserts the 0x if 
> appropriate.
> 
> --- scripts/Configure.orig 2005-01-24 13:31:55.000000000 -0800
> +++ scripts/Configure 2005-01-24 13:34:20.000000000 -0800
> @@ -378,15 +378,18 @@
>  function hex () {
>   old=$(eval echo "\${$2}")
>   def=${old:-$3}
> - def=${def#*[x,X]}
>   while :; do
>     readln "$1 ($2) [$def] " "$def" "$old"
> -   ans=${ans#*[x,X]}
> -   if expr "$ans" : '[0-9a-fA-F][0-9a-fA-F]*$' > /dev/null; then
> -     define_hex "$2" "0x$ans"
> +   if expr "$ans" : '0x[0-9a-fA-F][0-9a-fA-F]*$' > /dev/null; then
> +     define_hex "$2" "$ans"
>       break
>     else
> -     help "$2"
> +     if expr "$ans" : '[0-9a-fA-F][0-9a-fA-F]*$' > /dev/null; then
> +       define_hex "$2" "0x$ans"
> +       break
> +     else
> +       help "$2"
> +     fi
>     fi
>   done
>  }
