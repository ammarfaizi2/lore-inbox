Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292247AbSBBIJJ>; Sat, 2 Feb 2002 03:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292250AbSBBIJB>; Sat, 2 Feb 2002 03:09:01 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:37386 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S292249AbSBBIIy>;
	Sat, 2 Feb 2002 03:08:54 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
In-Reply-To: Your message of "Fri, 01 Feb 2002 23:30:20 -0800."
             <20020202073020.GA7014@tapu.f00f.org> 
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_14557947050"
Date: Sat, 02 Feb 2002 19:08:38 +1100
Message-ID: <25095.1012637318@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_14557947050
Content-Type: text/plain; charset=us-ascii

cc: list trimmed.

On Fri, 1 Feb 2002 23:30:20 -0800, 
Chris Wedgwood <cw@f00f.org> wrote:
>compile and link it, have the linker know main or some part of crt0 is
>special, build a graph of the final ELF object, see that bar and blem
>are not connected to 'main' and discard them?
>
>I'm pretty sure (but not 100% certain) that oher compilers can do
>this, maybe someone can test on other platforms?
>
>A really smart linker (if given enough compiler help) could build a
>directional graph and still remove this code even if blem called foo.

AFAICT it has to be done in two stages.  Identify extern symbols that
are not referenced and convert them to static, then compile and let gcc
warn about unused statics and remove them.

The two stage approach is required because ld does not have enough
information to identify all function calls.  ld views an object as
opaque blobs of text and data with relocation entries that tie them
together.  When a function is called from the same source file, gcc/gas
tend to use PC relative branches for the inter-source call.  PC
relative local branches do not usually generate relocation entries.
Without a relocation entry, ld cannot detect the inter-source call.

There is also a problem with exported symbols.  To ld, EXPORT_SYMBOL
looks like a reference to the symbol, but the export entry is
irrelevant, what really matters is if any module refers to those
symbols.  ld cannot distinguish between used and unused exported
symbols.  To make matters worse, if you define foo as static and
EXPORT_SYMBOL(foo) in the same source then gcc thinks that the symbol
is used, because of the EXPORT_SYMBOL() reference.  Again what really
matters is if any module uses the exported symbol.

The script below runs the .o files for the kernel and identifies extern
symbols with no extern references, i.e. the first part of the problem.
It knows about exported symbols and modules and handles them correctly.
I have not run the script for years, the list of conglomerates and the
list starting with mod_use_count_ will need updating.

Beware that you get a lot of false positives because of the kernel
config mechanism.  A symbol may be listed as unused but changing the
config may cause it to be used.  This is especially true for exported
symbols.

<davem>What, no initc**l reference?</davem>

--==_Exmh_14557947050
Content-Type: text/plain ; name="namespace.pl"; charset=us-ascii
Content-Description: namespace.pl

#!/usr/bin/perl -w
#
#	namespace.pl.  Mon Jan 27 22:25:47 EST 1997
#
#	Perform a name space analysis on the linux kernel.
#
#	Copyright Keith Owens <kaos@ocs.com.au>.  GPL.
#
#	Invoke by changing directory to the top of the kernel source
#	tree then namespace.pl, no parameters.
#
#	Tuned for 2.1.x kernels with the new module handling, it will
#	work with 2.0 kernels as well.  Last change 2.1.81.
#
#	The source must be compiled/assembled first, the object files
#	are the primary input to this script.  Incomplete or missing
#	objects will result in a flawed analysis.
#
#	Even with complete objects, treat the result of the analysis
#	with caution.  Some external references are only used by
#	certain architectures, others with certain combinations of
#	configuration parameters.  Ideally the source should include
#	something like
#
#	#ifndef CONFIG_...
#	static
#	#endif
#	symbol_definition;
#
#	so the symbols are defined as static unless a particular
#	CONFIG_... requires it to be external.
#

require 5;	# at least perl 5
use strict;
use File::Find;

my $nm = "/usr/bin/nm -p";	# in case somebody moves nm

if ($#ARGV != -1) {
	print STDERR "usage: $0 takes no parameters\n";
	die("giving up\n");
}

my %nmdata = ();	# nm data for each object
my %def = ();		# all definitions for each name
my %ksymtab = ();	# names that appear in __ksymtab_
my %ref = ();		# $ref{$name} exists if there is a true external reference to $name
my %export = ();	# $export{$name} exists if there is an EXPORT_... of $name

&find(\&linux_objects, '.');	# find the objects and do_nm on them
list_multiply_defined();
resolve_external_references();
list_extra_externals();

exit(0);

sub linux_objects
{
	# Select objects, ignoring objects which are only created by
	# merging other objects.  Also ignore all of modules, scripts
	# and compressed.
	my $basename = $_;
	$_ = $File::Find::name;
	s:^\./::;
	if (/.*\.o$/ && ! (
	    m:/fs.o$: || m:/isofs.o$: || m:/nfs.o$:
	    || m:/xiafs.o$: || m:/umsdos.o$: || m:/hpfs.o$:
	    || m:/smbfs.o$: || m:/ncpfs.o$: || m:/ufs.o$:
	    || m:/affs.o$: || m:/romfs.o$: || m:/kernel.o$:
	    || m:/mm.o$: || m:/ipc.o$: || m:/ext.o$:
	    || m:/msdos.o$: || m:/proc/proc.o$: || m:/minix.o$:
	    || m:/ext2.o$: || m:/sysv.o$: || m:/fat.o$:
	    || m:/vfat.o$: || m:/unix.o$: || m:/802.o$:
	    || m:/appletalk.o$: || m:/ax25.o$: || m:/core.o$:
	    || m:/ethernet.o$: || m:/ipv4.o$: || m:/ipx.o$:
	    || m:/netrom.o$: || m:/ipv6.o$: || m:/x25.o$:
	    || m:/rose.o$: || m:/bridge.o$: || m:/lapb.o$:
	    || m:/sock_n_syms.o$: || m:/teles.o$: || m:/pcbit.o$:
	    || m:/isdn.o$: || m:/ftape.o$: || m:/scsi_mod.o$:
	    || m:/sd_mod.o$: || m:/sr_mod.o$: || m:/lowlevel.o$:
	    || m:/sound.o$: || m:/piggy.o$: || m:/bootsect.o$:
	    || m:/boot/setup.o$: || m:^modules/: || m:^scripts/:
	    || m:/compressed/:
	    || m:/autofs.o$: || m:/lockd/lockd.o$: || m:/nfsd.o$:
	    || m:/sunrpc.o$: || m:/scsi_n_syms.o$:
	    || m:/boot/bbootsect.o$: || m:/boot/bsetup.o$:
	    || m:/misc/parport.o$: || m:/nls/nls.o$:
	    || m:/debug/debug.o$: || m:/netlink/netlink.o$:
	    || m:/sched/sched.o$: || m:/sound/sb.o$: 
	    || m:/sound/soundcore.o$: || m:/pci/pci_syms.o$: 
	    || m:/devpts/devpts.o$: || m:/video/fbdev.o$: 
	  )
	) {
		do_nm($basename, $_);
	}
	$_ = $basename;		# File::Find expects $_ untouched (undocumented)
}

sub do_nm
{
	my ($basename, $fullname) = @_;
	my ($source, $type, $name);
	if (! -e $basename) {
		printf STDERR "$basename does not exist\n";
		return;
	}
	if ($fullname !~ /\.o$/) {
		printf STDERR "$fullname is not an object file\n";
		return;
	}
	$source = $basename;
	$source =~ s/\.o$//;
	if (! -e "$source.c" && ! -e "$source.S") {
		printf STDERR "No source file found for $fullname\n";
		return;
	}
	if (! open(NMDATA, "$nm $basename|")) {
		printf STDERR "$nm $fullname failed $!\n";
		return;
	}
	my @nmdata;
	while (<NMDATA>) {
		chop;
		($type, $name) = (split(/ +/, $_, 3))[1..2];
		# Expected types
		# B weak external reference to data that has been resolved
		# C global variable, uninitialised
		# D global variable, initialised
		# R global array, initialised
		# T global label/procedure
		# U external reference
		# W weak external reference to text that has been resolved
		# a assembler equate
		# b static variable, uninitialised
		# d static variable, initialised
		# r static array, initialised
		# t static label/procedures
		# ? undefined type, used a lot by modules
		if ($type !~ /^[BCDRTUWabdrt?]$/) {
			printf STDERR "nm output for $fullname contains unknown type '$_'\n";
		}
		elsif ($name =~ /\./) {
			# name with '.' is local static
		}
		else {
			$name =~ s/_R[a-f0-9]{8}$//;	# module versions adds this
			if ($type =~ /[BCDRTW]/ &&
				$name ne 'init_module' &&
				$name ne 'cleanup_module' &&
				$name ne 'Using_Versions' &&
				$name !~ /^Version_[0-9]+$/ &&
				$name ne 'kernel_version') {
				if (!exists($def{$name})) {
					$def{$name} = [];
				}
				push(@{$def{$name}}, $fullname);
			}
			push(@nmdata, "$type $name");
			if ($name =~ /^__ksymtab_/) {
				$name = substr($name, 10);
				if (!exists($ksymtab{$name})) {
					$ksymtab{$name} = [];
				}
				push(@{$ksymtab{$name}}, $fullname);
			}
		}
	}
	close(NMDATA);
	if ($#nmdata < 0) {
		printf "No nm data for $fullname\n";
		return;
	}
	$nmdata{$fullname} = \@nmdata;
}

sub list_multiply_defined
{
	my ($name, $module);
	foreach $name (keys(%def)) {
		if ($#{$def{$name}} > 0) {
			printf "$name is multiply defined in :-\n";
			foreach $module (@{$def{$name}}) {
				printf "\t$module\n";
			}
		}
	}
}

sub resolve_external_references
{
	my ($object, $type, $name, $i, $j, $kstrtab, $ksymtab, $export);
	printf "\n";
	foreach $object (keys(%nmdata)) {
		my $nmdata = $nmdata{$object};
		for ($i = 0; $i <= $#{$nmdata}; ++$i) {
			($type, $name) = split(' ', $nmdata->[$i], 2);
			if ($type eq "U") {
				if (exists($def{$name}) || exists($ksymtab{$name})) {
					# add the owning object to the nmdata
					$nmdata->[$i] = "$type $name $object";
					# only count as a reference if it is not EXPORT_...
					$kstrtab = "? __kstrtab_$name";
					$ksymtab = "? __ksymtab_$name";
					$export = 0;
					for ($j = 0; $j <= $#{$nmdata}; ++$j) {
						if ($nmdata->[$j] eq $kstrtab ||
						    $nmdata->[$j] eq $ksymtab) {
							$export = 1;
							last;
						}
					}
					if ($export) {
						$export{$name} = "";
					}
					else {
						$ref{$name} = ""
					}
				}
				elsif ($name ne "mod_use_count_" &&
				       $name ne "__this_module" &&
				       $name ne "_etext" &&
				       $name ne "_edata" &&
				       $name ne "_end" &&
				       $name ne "__start___ksymtab" &&
				       $name ne "__start___ex_table" &&
				       $name ne "__stop___ksymtab" &&
				       $name ne "__stop___ex_table" &&
				       $name ne "__stop___ex_table" &&
				       $name ne "__bss_start" &&
				       $name ne "_text" &&
				       $name ne "__init_begin" &&
				       $name ne "__init_end") {
					printf "Cannot resolve reference to $name from $object\n";
				}
			}
		}
	}
}

sub list_extra_externals
{
	my %noref = ();
	my ($name, @module, $module, $export);
	foreach $name (keys(%def)) {
		if (! exists($ref{$name})) {
			@module = @{$def{$name}};
			foreach $module (@module) {
				if (! exists($noref{$module})) {
					$noref{$module} = [];
				}
				push(@{$noref{$module}}, $name);
			}
		}
	}
	if (%noref) {
		printf "\nExternally defined symbols with no external references\n";
		foreach $module (sort(keys(%noref))) {
			printf "  $module\n";
			foreach (sort(@{$noref{$module}})) {
				if (exists($export{$_})) {
					$export = " (export only)";
				}
				else {
					$export = "";
				}
				printf "    $_$export\n";
			}
		}
	}
}

--==_Exmh_14557947050--


