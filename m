Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSH0SEI>; Tue, 27 Aug 2002 14:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316684AbSH0SEH>; Tue, 27 Aug 2002 14:04:07 -0400
Received: from ip66-2-81-26.z81-2-66.customer.algx.net ([66.2.81.26]:22511
	"EHLO wiley") by vger.kernel.org with ESMTP id <S316683AbSH0SEF>;
	Tue, 27 Aug 2002 14:04:05 -0400
Subject: Functions with Large Stack Usage
From: Danny Cox <danscox@mindspring.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-A0tMjPCQFGpmTkU9Prxi"
X-Mailer: Ximian Evolution 1.0.8 
Date: 27 Aug 2002 14:08:24 -0400
Message-Id: <1030471704.1610.47.camel@wiley>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-A0tMjPCQFGpmTkU9Prxi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

	After having read of the stack overflow "issues" awhile back, a couple
of ideas gelled, with this script as a result.  The script finds
functions that use a large (changeable) amount of stack space.  Note:
it's heuristic, it's static, it only looks at compiled-in functions, and
says nothing about the dynamic system.  It DOES point out functions that
may (MAY) need to be examined closer.

	The functions and their sizes are:

check huft_build (stack 1436)
check inflate_fixed (stack 1168)
check inflate_dynamic (stack 1308)
check pci_sanity_check (stack 804)
check pcibios_fixup_peer_bridges (stack 804)
check elf_core_dump (stack 592)
check xfs_ioctl (stack 752)
check semctl_main (stack 588)
check extract_entropy (stack 708)
check vt_ioctl (stack 756)
check ide_unregister (stack 880)
check cdrom_buffer_sectors (stack 516)
check cdrom_read_intr (stack 532)
check cdrom_slot_status (stack 1040)
check cdrom_number_of_slots (stack 1040)
check cdrom_select_disc (stack 1040)
check cdrom_ioctl (stack 1084)
check pci_do_scan_bus (stack 680)

	This is from kernel 2.4.19-xfs (yes, I'm an XFS weenie ;-).

	How it works:  With Keith Owens' KDB patch, one may compile the kernel
with frame pointers.  With the Disassemble::X86 Perl module from CPAN
(http://search.cpan.org/author/BOBMATH/Disassemble-X86-0.12/X86.pm),
it's easy.  It requires the vmlinux and System.map files, and for each
function looks at the first 10 instructions for the 'sub esp,N'.  The N
is the number of bytes of stack used.

	I'm not subscribed to this list.  I tried once, but it's much too busy
for me to keep up with, and actually get any work done ;-).  So, please
CC: me if you wish me to be included.

	I apologize in advance for 1) the C-like Perl code, and 2) for
attaching it.  I've tried an in-line paste before, but it wraps, and
makes it even uglier than before.

	Comments, bugs, and enhancements are encouraged.  Thanks!

	Please return to your regularly scheduled discussions.

-- 
kernel, n.: A part of an operating system that preserves the
medieval traditions of sorcery and black art.

Danny

--=-A0tMjPCQFGpmTkU9Prxi
Content-Disposition: attachment; filename=check_stack
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-perl; name=check_stack; charset=ISO-8859-1

#!/usr/bin/perl
# check_stack --- check for too deep stack depths; it most likely only
#		only works for the linux kernel....

use 5.006;
use strict;
use warnings;
use Getopt::Std;
use lib "blib/lib";
use Disassemble::X86;

use vars qw ( $opt_d );
getopts ("d") and $#ARGV =3D=3D 1 or die <<END_USAGE;
usage: $0 [-d] vmlinux System.map
-d  debug ON
END_USAGE

# slurp up the whole object file
open OBJ, "<$ARGV[0]" or die "$0: can't read $ARGV[0]: $!\n";
my $slash_save =3D $/;
undef $/;
my $file =3D <OBJ>;
close OBJ;
$/ =3D $slash_save;

# init the disassembler
my $dis =3D Disassemble::X86->new (
	start =3D> 0xc0100000 - 0x1000,	# text addr - file offset
	pos   =3D> 0,
	size  =3D> 32,
	text  =3D> $file,
);

# you may change these as you see fit

# max_check is the maximum number of instructions to scan for the 'sub esp,=
...'
#	before giving up
my $max_check =3D 10;

# stack_limit is the size that we'll consider worthy of reporting
my $stack_limit =3D 512;

# end of changables

# max_stack is the maximum stack size we saw
my $max_stack =3D 0;

# open System.map.  It contains the address, type, and names of each functi=
on
#		(among other things)
open MAP, "<$ARGV[1]" or die "$0: can't read $ARGV[1]: $!\n";

while (<MAP>) {
	my ($addr, $type, $name) =3D split (' ', $_);
	next if $name =3D~ /^\./;		# we don't want names like '.yadda'
	if ($type =3D~ /^[Tt]$/) {	# we only want text symbols
		print "looking at $name ($addr)\n" if $opt_d;

		$dis->pos (hex ($addr));
		for (my $i =3D 0; $i < $max_check && !$dis->at_end; $i++) {
			my $op =3D $dis->disasm ();
			printf "%04x %s\n", $dis->op_start (), $op if $opt_d;
			next if (!defined $op);
			if ($op =3D~ /sub esp,(0x[[:xdigit:]]+)/) {
				my $stack =3D hex ($1);
				$max_stack =3D $stack if $stack > $max_stack;
				printf "check $name (stack %d)\n", $stack
				    if $stack >=3D $stack_limit;
				last;
			}
		}

	}
}
close MAP;

print "max single stack used is $max_stack\n";

exit 0;

# end check_stack

--=-A0tMjPCQFGpmTkU9Prxi--

