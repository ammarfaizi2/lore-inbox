Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVDISWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVDISWN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 14:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVDISWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 14:22:13 -0400
Received: from coderock.org ([193.77.147.115]:45540 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261365AbVDISVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 14:21:40 -0400
Date: Sat, 9 Apr 2005 20:21:28 +0200
From: Domen Puncer <domen@coderock.org>
To: Magnus Damm <damm@opensource.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] autoparam
Message-ID: <20050409182128.GA5542@nd47.coderock.org>
References: <20050320223814.25305.52695.65404@clementine.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20050320223814.25305.52695.65404@clementine.local>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 21/03/05 00:06 +0100, Magnus Damm wrote:
> Here are a set of patches that makes it possible to autogenerate kernel command
> line documentation from the source code. The approach is rather straightforward
> - the parameter name, the type and the description are stored in a section 
> called __param_strings. After vmlinux is built this section is extracted using
> objcopy and a script is used to generate a primitive - but up to date - 
> document.

I think it's a great idea. A needed feature with simple implementation.
I like it.

> 
> Right now the section is left in the kernel binary. The document is currently
> not generated from the Makefile, so the curious user should perform:

Any plans to make this a complete patch?

> 
> $ objcopy -j __param_strings vmlinux -O binary foo
> $ chmod a+x scripts/section2text.rb
> $ cat foo | ./scripts/section2text.rb
> 
> And yeah, you need to install ruby to run the script.

Attached a perl script, that has almost the same output. (I think
perl is more usual on linux machines)

> 
> The ruby script section2text.rb does some checks to see if MODULE_PARM_DESC()
> is used without module_param(). You will find interesting typos.
> 
> Future work that extends this idea could include replacing __setup(name) with 
> __setup(name, descr). And storing the documentation somewhere to make it easy
> for the end user to look up the generated parameter list from the boot loader.

And kernel-parameters.txt will never again have obsoleted options :-)


	Domen

--tThc/1wpZn/ma/RB
Content-Type: application/x-perl
Content-Disposition: attachment; filename="section2text.pl"
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/perl=0Ause strict;=0Amy ($p, @params, %param_t, %param_d);=0A=0A=
while (<>) {=0A	my @params =3D split '\0', $_;=0A	foreach $p (@params) {=0A=
		next if (!$p);=0A		# description, it has " () "=0A		if ($p =3D~ /(\S+) \(=
\) (.+)/) {=0A			$param_d{$1} =3D $2;=0A			next;=0A		}=0A		# type in parens=
=0A		if ($p =3D~ /(\S+)\s+(.*)/) {=0A			$param_t{$1} =3D $2;=0A			next;=0A	=
	}=0A		# what's after '=3D'=0A		if ($p =3D~ /(\S+=3D).*/) {=0A			$param_t{$=
1} =3D '(string)';=0A			next;=0A		}=0A		# parameter has no value=0A		if ($p=
 =3D~ /(\S+)/) {=0A			$param_t{$1} =3D '';=0A			next;=0A		}=0A	}=0A}=0A=0A#=
 print it=0Aforeach $p (sort(keys(%param_t))) {=0A	print "$p $param_t{$p}\n=
";=0A	if (!$param_d{$p}) {=0A		print "  No description\n";=0A	} else {=0A		=
print "  $param_d{$p}\n";=0A	}=0A	print "\n";=0A}=0A=0A# descriptions alone=
; typos=0Aforeach $p (sort(keys(%param_d))) {=0A	if (!$param_t{$p}) {=0A		p=
rint STDERR "$p only has description\n";=0A	}=0A}=0A
--tThc/1wpZn/ma/RB--
