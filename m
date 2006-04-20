Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWDTX1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWDTX1l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWDTX1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:27:41 -0400
Received: from ping.uio.no ([129.240.78.2]:17618 "EHLO ping.uio.no")
	by vger.kernel.org with ESMTP id S1751268AbWDTX1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:27:40 -0400
To: linuxram@us.ibm.com (Ram Pai)
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, arjan@infradead.org,
       bunk@stusta.de, greg@kroah.com, hch@infradead.org, mathur@us.ibm.com
Subject: Re: [RFC PATCH 2/3] export symbol report: export-symbol usage
 report generator.
References: <20060420223654.2E5CA470031@localhost>
From: ilmari@ilmari.org (=?utf-8?q?Dagfinn_Ilmari_Manns=C3=A5ker?=)
Organization: Program-, Informasjons- og Nettverksteknologisk Gruppe, UiO
Date: Fri, 21 Apr 2006 01:27:26 +0200
In-Reply-To: <20060420223654.2E5CA470031@localhost> (Ram Pai's message of
 "Thu, 20 Apr 2006 15:36:54 -0700 (PDT)")
Message-ID: <d8jirp37rq9.fsf@ritchie.ping.uio.no>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Exiscan-Spam-Score: -7.8 (-------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linuxram@us.ibm.com (Ram Pai) writes:

> The following patch provides the ability to generate a report of
>      (1) All the exported symbols and their in-kernel-module usage count 
>      (2) For each module, lists the modules and their exported symbols, on
> 		which it depends.

Neat. Just a few Perl nits (sorry, couldn't resist).

> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
[...]
> Index: 2617rc1/scripts/export_report.pl
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ 2617rc1/scripts/export_report.pl	2006-04-18 16:02:32.000000000 -0700
> @@ -0,0 +1,134 @@
[...]
> +sub alphabetically {
> +	($module1, $value1, undef) = split / /, "@{$a}";
> +	($module2, $value2, undef) = split / /, "@{$b}";

This:

> +	if ($value1 == $value2) {
> +		if ($module1 lt $module2) {
> +			return 1;
> +		} elsif ($module1 eq $module2) {
> +			return 0;
> +		} 
> +		return -1;
> +	}
> +	return $value1 <=> $value2;

can be written more idiomatically (and readably, IMHO):

        return $value1 <=> $value2 || $module1 cmp $module2;
> +}
[...]
> +#
> +# collect the usage count of each symbol.
> +#

And this:

> +for ($i = 0; $i <= $#ARGV; $i++) {
> +	$thismod = $ARGV[$i];

could be:

  foreach $thismod (@ARGV) {

> +	unless (open(MODULE_MODULE, $thismod)) {
> +		print "Sorry, cannot open $kernel: $!\n";
> +		next;
> +	}
> +	while ( <MODULE_MODULE> ) {
> +		chomp;
> +		if ( $_ !~ /0x[0-9a-f]{7,8},/ ) {
> +			next;
> +		}

Instead of this:

> +		(undef, undef, undef, undef, $symbol) = split /([,"])/, $_;

some may prefer:

                $symbol = (split /([,"])/)[4];

> +		($module, $value, $symbol, $gpl) = @{$SYMBOL{$symbol}};
> +		$SYMBOL{ $symbol } =  [ $module , $value+1 , $symbol, $gpl];
> +		push(@{$MODULE{$thismod}} , $symbol);
> +	}
> +	close(MODULE_MODULE);
> +}
[...]
> +while (($thismod, $list) = each %MODULE) {
> +	undef %depends;

If you instead use

        my %depends;

the variable will be lexically scoped to the body of the loop and thus
undef at the start of each iteration. I notice the lack of 'use strict'
and lexically scoped variables throughout this script, which makes it
less readable and maintainable than possible, IMHO.

> +	print "\t\t\t$thismod\n";
> +	foreach $symbol (@{$list}) {
> +		($module, $value, undef, $gpl) = @{$SYMBOL{$symbol}};
> +		push (@{$depends{"$module"}}, "$symbol $value");
> +	}
> +	print_depends_on(\%depends);
> +}

-- 
ilmari
"A disappointingly low fraction of the human race is,
 at any given time, on fire." - Stig Sandbeck Mathisen
