Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288982AbSAFQQf>; Sun, 6 Jan 2002 11:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288983AbSAFQQQ>; Sun, 6 Jan 2002 11:16:16 -0500
Received: from prahad-2-15.dialup.vol.cz ([212.27.197.123]:260 "EHLO
	albireo.ucw.cz") by vger.kernel.org with ESMTP id <S288982AbSAFQQL>;
	Sun, 6 Jan 2002 11:16:11 -0500
Date: Sun, 6 Jan 2002 09:55:49 +0100
From: Martin Mares <mj@ucw.cz>
To: Keith Owens <kaos@ocs.com.au>
Cc: Mike Touloumtzis <miket@bluemug.com>, Larry McVoy <lm@bitmover.com>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: State of the new config & build system
Message-ID: <20020106095549.A664@ucw.cz>
In-Reply-To: <20011231200359.A22497@bluemug.com> <3680.1009873619@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3680.1009873619@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

> That is exactly what kbuild 2.5 does.  The slowdown occurs when
> massaging the -MD dependencies from absolute names to relative path
> names.  To support separate source and object trees, renaming of trees,
> different names in local and NFS mode etc., the massage code needs a
> list of where all the files are before it can convert the absolute
> dependencies produced by gcc.  Reading and indexing that file for every
> compile is _slow_.

I didn't follow the thread from the very beginning nor did I study
your makefiles carefully, because I don't have much time for kernel
hacking these days, but maybe I won't miss the pond :)

Is there any reason for processing all the files for each compile
instead of merging them to a single file once at the start of the make?

I use it in one of my projects, there is the relevant part of the
Makefile:

# Black magic with dependencies. It would be more correct to make "depend.new"
# a prerequisite for "depend", but "depend.new" often has the same timestamp
# as "depend" which would confuse make a lot and either force remaking anyway
# or (as in current versions of GNU make) erroneously skipping the remaking.

-include depend

depend: force
        if [ -s depend.new ] ; then build/mergedeps depend depend.new ; >depend.new ; fi

force:

# Implicit rules

obj/%.o: %.c
        DEPENDENCIES_OUTPUT="depend.new $@" $(CC) $(CFLAGS) -c -o $@ $<

The DEPENDENCIES_OUTPUT mode is much more convenient than gcc -Mx as it
avoids scattering the relevant information over many files. The mergedeps
script is a simple Perl script which takes care of merging the dependencies
gathered during the previous run of make to the depend file for the next
run. It can do a lot of fixups and translations, here is a trivial
example:

#!/usr/bin/perl

@ARGV == 2 or die "Usage: mergedeps <base> <update>";
foreach $a (@ARGV) {
        open F, "$a" or next;
        $t = "";
        while (<F>) {
                $t .= $_;
                if (! /\\$/) {
                        ($t =~ /^(.*):/) || die "Parse error at $t";
                        $rules{$1} = $t;
                        $t = "";
                }
        }
        close F;
}
open(F,">" . $ARGV[0]) || die "Unable to write output file";
foreach $a (sort keys %rules) {
        print F $rules{$a};
}
close F;

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Light-year? One-third less calories than a regular year.
