Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbVAAD7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVAAD7x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 22:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVAAD7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 22:59:53 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:59333 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S262184AbVAAD7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 22:59:45 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org, pmarques@grupopie.com
Subject: Re: sh: inconsistent kallsyms data 
In-reply-to: Your message of "Fri, 31 Dec 2004 19:25:50 +0200."
             <20041231172549.GA18211@linux-sh.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 01 Jan 2005 14:59:19 +1100
Message-ID: <7184.1104551959@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2004 19:25:50 +0200, 
Paul Mundt <lethal@linux-sh.org> wrote:
>Building 2.6.10 for sh results in inconsistent kallsyms data. Turning on
>CONFIG_KALLSYMS_ALL fixes it, as does CONFIG_KALLSYMS_EXTRA_PASS.
>
>The symbols that seem to be problematic between the second and third
>pass are all kallsyms special symbols. With only CONFIG_KALLSYMS set we
>see:
>
>--- System.map  2004-12-31 10:53:10.278567522 -0600
>+++ .tmp_System.map     2004-12-31 10:53:10.347558024 -0600
>@@ -6868,9 +6868,9 @@
> 8817c4d0 D kallsyms_addresses
> 88182660 D kallsyms_num_syms
> 88182670 D kallsyms_names
>-88190630 D kallsyms_markers
>-881906a0 D kallsyms_token_table
>-88190b50 D kallsyms_token_index
>+881906a0 D kallsyms_markers
>+88190710 D kallsyms_token_table
>+88190bc0 D kallsyms_token_index
> 88191000 D irq_desc
> 88191000 A __per_cpu_end
> 88191000 A __per_cpu_start
>
>So for some reason we have a 0x70 variance between these, and only
>these. Running with --all-symbols this seems to work fine.

It is a nasty corner case in scripts/kallsyms.c processing.  There is a
difference in the list of names between pass 1 and pass 2.  This is not
supposed to happen, the name and compression tables must be the same
after pass 1 and 2.  The symbol addresses will be different, but the
amount of data must be the same.

--- out1        2005-01-01 14:30:30.192497864 +1100
+++ out2        2005-01-01 14:30:46.556974017 +1100
@@ -5854,390 +5854,389 @@
 r __param_yres         PTR     0x8816d300
 r __param_xres         PTR     0x8816d314
 A _etext       PTR     0x8816d328
-D init_task    PTR     0x8816d328
 R __stop___param       PTR     0x8816d328

In pass 1, init_task has the same value as _etext so it is included in
the name table.  Adding the kallsyms data to vmlinux at the end of pass
1 adds more data which shifts where init_task is linked so it is no
longer the same as _etext, so we lose a symbol on pass 2 which breaks
the kallsyms rules.

This corner case only occurs with CONFIG_KALLSYMS_ALL=n.  That is the
only time that we drop symbols outside the ranges _stext ... _etext and
_sinittext ... _einittext.  For CONFIG_KALLSYMS_ALL=n, we want the
_etext and _einittext labels, but not any other symbols that have the
same numeric value as _etext or _einittext.

Paul, please test this patch.  Build with CONFIG_KALLSYMS_ALL=n and
CONFIG_KALLSYMS_EXTRA_PASS=n.

Index: 2.6.10/scripts/kallsyms.c
===================================================================
--- 2.6.10.orig/scripts/kallsyms.c	2005-01-01 14:24:21.240400295 +1100
+++ 2.6.10/scripts/kallsyms.c	2005-01-01 14:54:57.695169107 +1100
@@ -184,6 +184,16 @@ symbol_valid(struct sym_entry *s)
 		if ((s->addr < _stext || s->addr > _etext)
 		    && (s->addr < _sinittext || s->addr > _einittext))
 			return 0;
+		/* Corner case.  Discard any symbols with the same value as
+		 * _etext or _einittext, they can move between pass 1 and 2
+		 * when the kallsyms data is added.  If these symbols move then
+		 * they may get dropped in pass 2, which breaks the kallsyms
+		 * rules.
+		 */
+		if ((s->addr == _etext || s->addr == _einittext) &&
+		    strcmp(s->sym + 1, "_etext") &&
+		    strcmp(s->sym + 1, "_einittext"))
+			return 0;
 	}
 
 	/* Exclude symbols which vary between passes. */


BTW, this script will take a .tmp_kallsyms<n>.S file and convert the
tables to something that a human can read.

#!/usr/bin/perl -w
#
# kallsyms_uncompress.pl (C) Keith Owens 2005 <kaos@ocs.com.au>
#
# Released under GPL V2.
#
# Uncompress the names in a .tmp_kallsymsn.S file.  Humans need text strings
# to work out why kallsyms is giving inconsistent results.  Use on 2.6.10
# onwards.
# kallsyms_uncompress.pl .tmp_kallsymsn.S > outfile

use strict;
die($0 . " takes exactly one argument\n") if($#ARGV != 0);

my @token;
my @name;
my @ptr;

my $line;
my $state = 0;	# 1 token, 2 name, 3 ptr

while (defined ($line = <>)) {
	chomp($line);
	if ($line eq "kallsyms_token_table:") {
		$state = 1;
		next;
	}
	if ($line eq "kallsyms_names:") {
		$state = 2;
		next;
	}
	if ($line eq "kallsyms_addresses:") {
		$state = 3;
		next;
	}
	next if ($state == 0);
	if ($line eq "") {
		$state = 0;
		next;
	}
	if ($state == 1) {
		$line =~ s/[^"]*"//;
		$line =~ s/"//;
		push(@token, $line);
	} elsif ($state == 2) {
		$line =~ s/\s//g;
		my @b = (split(/,/, $line));
		shift(@b);
		push(@name, \@b);
	} else {
		push(@ptr, $line);
	}
}

my ($b, $i, $text);
for ($i = 0; $i <= $#name; ++$i) {
	$text = "";
	foreach $b (@{$name[$i]}) {
		$text .= $token[hex($b)];
	}
	printf("%s %s %s\n", substr($text, 0, 1), substr($text, 1), $ptr[$i]);
}

