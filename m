Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273622AbRJIHgQ>; Tue, 9 Oct 2001 03:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273534AbRJIHgC>; Tue, 9 Oct 2001 03:36:02 -0400
Received: from mailserv.intranet.GR ([146.124.14.106]:40619 "EHLO
	mailserv.intranet.gr") by vger.kernel.org with ESMTP
	id <S273515AbRJIHfq>; Tue, 9 Oct 2001 03:35:46 -0400
Message-ID: <3BC2A98C.A57EA360@intracom.gr>
Date: Tue, 09 Oct 2001 10:38:52 +0300
From: Pantelis Antoniou <panto@intracom.gr>
Organization: INTRACOM S.A.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.18pre21 ppc)
X-Accept-Language: el, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Standard way of generating assembler offsets
In-Reply-To: <28136.1002196028@ocs3.intra.ocs.com.au>
			<3BC1735F.41CBF5C1@intracom.gr>  <3BC1E294.1A4FB12D@mvista.com> <1002563771.21079.3.camel@keller> <3BC1F7D6.E84D617B@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------B54AD3F1C510DC8D0A093BAD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B54AD3F1C510DC8D0A093BAD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

george anzinger wrote:
> 
> Georg Nikodym wrote:
> >
> > At the risk of sticking my foot in it, is there something wrong with the
> > ANSI C offsetof() macro, defined in <stddef.h>?
> >
> > --Georg
> No, and it could have been (and was) written prio to ANSI C defining
> it.  Something like:
> 
> #define offsetof(x, instruct) &((struct instruct *)0)->x
> 
> The issues that CPP resolves have to deal with the following sort of
> structure:
> 
> struct instruct {
>         struct foo * bar;
> #ifdef CONFIG_OPTION_DIDDLE
>         int diddle_flag;
>         int diddle_array[CONFIG_DIDDLE_SIZE];
> #endif
>         int x;
> }
> 
> Or for the simple need for a constant:
> 
> #define Const (CONFIG_DIDDLE_SIZE * sizeof(int))
> 
> Of course you could have any number of constant operators in the
> expression.  Note also, that the array in the structure above is defined
> by a CONFIG symbol.  This could also involve math, i.e.:
> 
> #define CONFIG_DIDDLE_SIZE CLOCK_RATE / HZ
> 
> and so on.  All in all, it best to let CPP do what it does best and
> scarf up the result:
> 
> #define GENERATE_CONSTANT(name,c) printf(#name " equ %d\n",c)
> 
> then:
> 
> GENERATE_CONSTANT(diddle_size,CONFIG_DIDDLE_SIZE);
> 
> In the code we did, we put all the GENERATE macros in a .h file.  The
> the code looked like:
> 
> #include.... all the headers needed....
> 
> #include <generate.h>
> 
> GENERATE....  all the generate macro calls...
> 
> } // all done (assumes that the "main(){" is in the generate.h file)
> 
> This whole mess was included as comments in the asm file.  The make rule
> then used a sed script to extract it, compile and run it to produce a
> new header file which the asm source included outside of the above
> stuff.
> 
> George

My script already handles that, everything is first passed through
CPP and the member offset are varied correctly according to any
compilation options.

I included the script and the results of two runs.

1. ./h2inc tst.h >tst.inc

2. ./h2inc --cflags="-DSHOW_HIDDEN -I./" >tst-hidden.inc

Regards
--------------B54AD3F1C510DC8D0A093BAD
Content-Type: text/plain; charset=us-ascii;
 name="h2inc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="h2inc"

#!/usr/bin/perl -w

use integer;
use Getopt::Long;
use File::Basename;
use File::stat;

my $CC       = "cc";
my $CFLAGS   = "-I./";
my $CPPFLAGS = "-E -dD";
my $OBJCOPY  = "objcopy";
my $OBJFLAGS = "-O binary";

sub find_32bit_type;
sub target_endianess;
sub alligned_type_size;
sub base_type_size;
sub members_offset;
sub tmpfile;
sub inputfile;
sub decode_type;
sub decode_member;
sub find_complex_member_name;
sub find_matching_brace;

$Getopt::Long::ignorecase = 0;	# Don't ignore case

my @filelist = ();

GetOptions	(
	"cc=s" 			=> \$CC,
	"cflags=s" 		=> \$CFLAGS,
	"cppflags=s" 	=> \$CPPFLAGS,
	"objcopy=s" 	=> \$OBJCOPY,
	"objflags=s" 	=> \$OBJFLAGS
			);

`$CC 2>/dev/null -v`;
die "Compiler is not present", if $? != 0;

my $u32 		= &find_32bit_type();
my $endianess 	= &target_endianess($u32);

for ($i = 0; $i <= $#ARGV; $i++) {
	$_ = $ARGV[$i];
	# print STDERR "file: $_\n";
	push @filelist, $_;
}

$#filelist >= 0 || die "Filename missing\n";

my %members  = ();
my %typedefs = ();
my %structs  = ();
my %unions   = ();

my %ilist = ();	# hash of included files
my $ilist;

my $defines;

foreach $f (@filelist) {

	$f = basename($f);

	%ilist = ();
	undef $ilist;

	$defines = "";

	&inputfile($f);

	my @defines = split(/\n/, $defines);

	my $incfile = $f;
	$incfile =~ s/\.h$/.inc/g;
	$incfile =~ s/\S*\/(\S+\.inc)/$1/g;
	my $incfiledef = "_" . uc($incfile);
	$incfiledef =~ s/\./_/g;

	print "#ifndef $incfiledef\n";
	print "#define $incfiledef\n\n";

	if (defined ($ilist)) {
		my $if;
		foreach $if (split /\s/, $ilist) {
			$if =~ s/\.h$/.inc/g;
			$if =~ s/\S*\/(\S+\.inc)/$1/g;
			$if = basename($if);
			print "#include \"$if\"\n";
		}
		print "\n";
	}

	my @offsets;
	my $b;
	my $i;
	my $j;
	my $k;
	foreach $b (sort keys %members) {
		my @m = split /\s/, $members{$b};
		my $m;
		print "/****************************************************************\n\n";
		print "\tOffsets for $b\n\n";
		print "****************************************************************/\n\n";

		my $size_define;
		my $complete_type;

		if ($typedefs{$b}) {
			$complete_type = $b;
			$size_define = $b . "_SIZE";
		} elsif ($structs{$b}) {
			$complete_type = "struct $b";
			$size_define = "struct_" . $b . "_SIZE";
		} elsif ($unions{$b}) {
			$complete_type = "union $b";
			$size_define = "union_" . $b . "_SIZE";
		} else { die; }

		@offsets = &members_offset($endianess, $u32, "#include \"$f\"\n", $complete_type, \@m);

		$j = 0;
		foreach (@offsets) {
			my $cm = $m[$j++];
			my @cm = split(/\./, $cm);
			for ($k = 0; $k <= $#defines; $k++) {
				my @tt = split(/\s+/, $defines[$k]);
				if (defined($tt[2]) && $tt[2] eq $cm) {
					# print STDERR "define alias found for $cm\n";
					$defines[$k] = "/* $tt[1] removed as an alias for $cm */";
					@cm = ($tt[1]);
					last;
				}
			}
			$cm = join('_', @cm);
			printf("#define %-30s %3d\n", $cm, $_);
		}

		printf("#define %-30s %3d\n", $size_define, &base_type_size($endianess, $u32, "#include \"$f\"\n", $complete_type));

		print "\n";
	}

	$defines = join("\n", @defines);

	if ($defines ne "") {
		print "/****************************************************************\n\n";
		print "\tSimple defines list \n\n";
		print "****************************************************************/\n\n";
		print "$defines\n\n";
	}

	print "#endif\n";

}

sub inputfile {
	my $file = shift(@_);
	$file = basename($file);
	my @wf = ();	# whole file
	my $wf = '';
	my $size;
	my $align;

	# print STDERR "Processing : $file\n";

	my $tmp = &tmpfile();
	my $tmp_c = $tmp . ".c";
	my $tmp_o = $tmp . ".o";

	local $SIG{'INT'} =
		sub {
			unlink $tmp_c;
			unlink $tmp_o;
			die $_[0];
		};
	
	open(TMPFILE, ">$tmp_c") || die;
	print TMPFILE "#include \"$file\"\n";
	close(TMPFILE);
	# first verify that the header file is correct
	`$CC $CFLAGS -c $tmp_c -o $tmp_o`; 
	if ($? != 0) {
		# try system wide include
		open(TMPFILE, ">$tmp_c") || die;
		print TMPFILE "#include \<$file\>\n";
		close(TMPFILE);
		# first verify that the header file is correct
		`$CC $CFLAGS -c $tmp_c -o $tmp_o`; die, if ($? != 0);
	}
	unlink $tmp_o;	# remove object file

	# open(LOGFILE, ">log.i") || die;

	# print LOGFILE "$CC $CFLAGS $CPPFLAGS $tmp_c |\n";

	open(CPPPIPE, "$CC $CFLAGS $CPPFLAGS $tmp_c |") || die;

	$wf = "";
	my $cf = "";	# current file - only output for current file 

	my $last;
	my $lll;

	while (<CPPPIPE>) {
		# print LOGFILE $_;
		$lll = $_;
		chop;
		if (s/\\$//) {
			$_ .= <CPPPIPE>; redo;
		}	# check for escape at the end of line
		$last = $_;
		my $ll = $_;
		if (! /\s*\#\s*/) {
			if (basename($cf) eq basename($file)) {
				$wf .= "$_\n";
			}
			next;
		}
		# print STDERR "\$\_='$_'\n";
		# print STDERR "o: \$\_='$_', \$\`='$`', \$\&='$&', \$\'='$'\n";
		if (/\s+[0-9]+\s*\"([^\"].*)\"/) {
			# print STDERR "$cf - $1\n";
			my $c = basename($1);
			if (!defined($ilist{$c})) {
				next, if ($c eq basename($tmp_c));				# do not add the dummy 
				if ($c ne basename($file) &&
					basename($cf) eq basename($file)) { # do not add self, and only directly included
					# print STDERR "$ll: $1\n";	
					$ilist{$c} = 1;
					if (defined($ilist)) {
						$ilist .= " $c";
					} else {
						$ilist = $c;
					}
				}
			}
			$cf = basename($1);
		} elsif (/\s*define\s*([a-zA-Z_][a-zA-Z0-9_]*)/) {
			# $_ = $';
			next, if ($cf ne $file);
			# print STDERR "\$lll='$lll'\n\$last='$last'\n\$\_='$_'\n\$\`='$`'\n\$\&='$&'\n\$\'='$'\n";
			my $defname = $1;
			next, if (/\(.*\)/);	# ignore arguments
			$_ = $';
			if (/\S+.*$/) {
				my $what = $&;
				# next, if ($what =~ /[()]/);	# only simple defines pass
				# $defines .= "#define $defname $1\n";
				# print STDERR "1-> '$defname' '$what'\n";
				$defines .= sprintf("#define %-30s %s\n", $defname, $what);
			} else {
				# print STDERR "2-> $defname\n";
				$defines .= sprintf("#define %-30s\n", $defname);
			}
		} else {
			# print STDERR "$_";
		}
	}

	# close(LOGFILE);

	# print STDERR "FILE:\n" . $wf ."FEND:\n";
	$wf =~ s/([*;,.!~{}()+\-\\\/\[\]])/ $1 /gsx;	# add spaces
	$wf =~ s/\s+/ /gsx;
	# print STDERR $wf;
	@wf = split /\s/,  $wf;

	$i  = 0;
	OUTTER: while ($i < ($#wf + 1)) {
		# print STDERR "$i: '$wf[$i]'\n";
		if ($wf[$i] eq "typedef" && $wf[$i+1] eq "struct") {
			&decode_type(\@wf, \$i);
		} elsif ($wf[$i] eq "typedef" && $wf[$i+1] eq "union") {
			&decode_type(\@wf, \$i);
		} elsif ($wf[$i] eq "struct") {
			&decode_type(\@wf, \$i);
		} elsif ($wf[$i] eq "union") {
			&decode_type(\@wf, \$i);
		} else {
			$i++;
		}
	}
	close CPPPIPE;

	unlink $tmp_c;

	local $SIG{'INT'} = 'DEFAULT';

	return 1;
}

sub decode_member {
	my $wf = shift(@_);	# reference to the whole body of the file
	my $ms = shift(@_);	# start of member definition
	my $me = shift(@_);	# end of member definition
	my $ii;
	my $i;
	my $n;

	# decode right to left
	$i = $me;
	$i--, if ($$wf[$i] eq ";");
	while ($$wf[$i] eq "]") {	# array definition, find match 
		# print STDERR "'$$wf[$i]'\n";
		$n = 1;
		do {
			$i--;
			# print STDERR "'$$wf[$i]'\n";
			$n++, if ($$wf[$i] eq "]");
			$n--, if ($$wf[$i] eq "[");
		} while ($n > 0 || $$wf[$i] ne "[");
		$i--;
	}
	while ($$wf[$i] eq ")") {	# function pointer definition, find match 
		$n = 1;
		$ii = $i;
		# print STDERR "'$$wf[$ii]'\n";
		do {
			$ii--;
			# print STDERR "'$$wf[$ii]'\n";
			$n++, if ($$wf[$ii] eq ")");
			$n--, if ($$wf[$ii] eq "(");
		} while ($n > 0 || $$wf[$ii] ne "(");
		# now check if next token is a pointer then we've found it
		# print STDERR "i=$i, ii=$ii, '" . $$wf[$ii] . "' '" . $$wf[$ii+1] . "' '" . $$wf[$ii+2] . "'\n";
		if ($i - $ii == 3 && $$wf[$ii+1] eq "*") {	# found it!
			$i = $ii + 2;
		} else {
			$i = $ii - 1;
		}
	}
	# print STDERR "found; $$wf[$i]\n";
	return $$wf[$i];
}

sub find_complex_member_name {
	my $wf   = shift(@_);	# reference to the whole body of the file
	my $k    = shift(@_);	# start of member definition
	my $last = shift(@_);	# end of member definition

	my $ct = $$wf[$k];
	my $ccs = $k + 2;
	my $n = 0;
	do {
		$k++;
		$n++, if ($$wf[$k] eq "{");
		$n--, if ($$wf[$k] eq "}");
	} while ($n > 0);
	my $cce = $k;
	$k++;
	my $cs = $k;
	$k++, while ($$wf[$k] ne ";");
	my $ce = $k;
	$k++;
	my $cn = &decode_member($wf, $cs, $ce);
	return $cn;
}

sub find_matching_brace {
	my $wf   = shift(@_);	# reference to the whole body of the file
	my $k    = shift(@_);	# start of member definition
	my $last = shift(@_);	# end of member definition

	my $n = 0;
	do {
		$k++;
		$n++, if ($$wf[$k] eq "{");
		$n--, if ($$wf[$k] eq "}");
	} while ($n > 0);
	$k++;
	$k++, while ($$wf[$k] ne ";");
	$k++;
	return $k;
}

sub get_next_type_name {
}

sub decode_type {
	my $wf = shift(@_);	# reference to the whole body of the file
	my $i  = shift(@_);	# reference to the token index at the file
	my $n = 0;			# nesting level
	my $k;
	my $j;
	my $anchor;
	my $first_brace;
	my $last_brace;
	my $trailer;
	my @result = ();

	$anchor = $$i;		# keep this for later
	# now find the brace
	$j = $anchor;
	# first find opening brace or terminating semicolon
	$j++, while ($$wf[$j] ne "{" && $$wf[$j] ne ";");

	if ($$wf[$j] eq ";") {	# not a structure definition
		$$i = $j + 1;
		return "";
	}
	$first_brace = $j;

	$n = 1;
	do {
		$j++;
		$n++, if ($$wf[$j] eq "{");
		$n--, if ($$wf[$j] eq "}");
	} while ($n > 0 || $$wf[$j] ne "}");

	$last_brace = $j;

	# find terminating semicolon
	$j++, while ($$wf[$j] ne ";");

	my $is_typedef = $$wf[$anchor] eq "typedef";
	my $is_struct  = $$wf[$anchor] eq "struct";
	my $is_union   = $$wf[$anchor] eq "union";
	my $is_declaration = 0;
	my $base_type;

	if ($is_typedef) {
		my $ii = $j - 1;	# remove semicolon
		# print STDERR "is_typedef\n";
		# print STDERR "'$$wf[$ii]' ";
		while ($$wf[$ii] eq "]") {	# array definition, find match 
			$n = 1;
			do {
				$ii--;
				# print STDERR "'$$wf[$ii]' ";
				$n++, if ($$wf[$ii] eq "]");
				$n--, if ($$wf[$ii] eq "[");
			} while ($n > 0 || $$wf[$ii] ne "[");
			$ii--;
		}
		$base_type = $$wf[$ii];
		if ($$wf[$j-1] eq "]") {
			$$i = $j;
			print STDERR "typedef arrays not supported; skipping $base_type\n";
			return "";
		}
		$typedefs{$base_type} = $is_typedef;
		$structs{$base_type}  = $is_struct;
		$unions{$base_type}   = $is_union;
	} else {
		# print STDERR "!is_typedef\n";
		$base_type = $$wf[$anchor] . " " . $$wf[$anchor + 1];
		$base_type = $$wf[$anchor + 1];
		if ($base_type ne "{") {
			$typedefs{$base_type} = $is_typedef;
			$structs{$base_type}  = $is_struct;
			$unions{$base_type}   = $is_union;
		} else {
			$is_declaration = 1;
		}
	}

	# print STDERR "sizeof($base_type)\n";
	my $ms; my $me; my $member; my @nt = ();
	my $cs; my $ce; my $ct; my $cn; my $ccs; my $cce;

	$ct = "";
	$n = 0;
	for ($ms = $first_brace + 1, $me = $first_brace+1; $me < $last_brace; ) {

		# print STDERR "$$wf[$me-1] \>$$wf[$me]\< $$wf[$me+1]\n";

		if (($$wf[$me] eq "union" || $$wf[$me] eq "struct") && $$wf[$me+1] eq "{") {
			$cn = &find_complex_member_name($wf, $me, $last_brace);
			# print STDERR "found $ct $cn\n"; 
			if (! $is_declaration) {
				if ($ct eq "struct" || length($cn) > 2) {
					if (defined($members{$base_type})) {
						$members{$base_type} .= " $cn";
					} else {
						$members{$base_type} = $cn;
					}
				}
			}
			$ms = $me + 2; $me = $ms;
			push @nt, $cn;
			# print STDERR "pushed $cn, \@nt = @nt\n"; 
			next;
		}
		if ($$wf[$me] eq "}") {
			$me++;
			$cn = pop @nt;
			# print STDERR "poped $cn, \@nt = @nt\n"; 
			$me++, while ($me < $last_brace && $$wf[$me] ne ";");
			$ms = $me + 1; $me = $ms;
			next;
		}

		$me++, while ($me < $last_brace && $$wf[$me] ne ";");
		last, if ($me >= $last_brace);

		$me--;	# remove semicolon
		last, if ($ms >= $me);	# protection for empty types

		if (! $is_declaration) {
			$member = &decode_member($wf, $ms, $me);
			# print STDERR "offsetof($base_type, $member)\n";
			$member = join('.', @nt, $member);
			if (defined($members{$base_type})) {
				$members{$base_type} .= " $member";
			} else {
				$members{$base_type} = $member;
			}
		}
		$ms = $me + 2; $me = $ms;
	}

	$$i = $j;

	return "";
}

sub tmpfile {
	my $tmp_dir  = -d '/tmp' ? '/tmp' : $ENV{TMP} || $ENV{TEMP};
	my $tmp_name = sprintf("%s/%s-%d-%d", $tmp_dir, basename($0), $$, time());
	return $tmp_name;
}

sub target_endianess {
	my $thirty_two_bits_type = shift(@_);
	my $extra_code = shift(@_);
	if (!defined($extra_code)) { $extra_code = ""; }
	my $tmp_dir  = -d '/tmp' ? '/tmp' : $ENV{TMP} || $ENV{TEMP};
	my $tmp_name = sprintf("%s/%s-%d-%d", $tmp_dir, basename($0), $$, time());
	my $tmp_c    = "$tmp_name.c";
	my $tmp_o    = "$tmp_name.o";
	my $tmp_bin  = "$tmp_name.bin";
	my $t_size;
	my $sb;
	my $fsize;
	my $i;

	unlink $tmp_c;

	local $SIG{'INT'} =
		sub {
			unlink $tmp_c;
			unlink $tmp_o;
			unlink $tmp_bin;
			die $_[0];
		};
	
	open(TMPFILE, ">$tmp_c") || die "Could not create temp file";
	print TMPFILE "$extra_code\n";
	print TMPFILE "const $thirty_two_bits_type tmp_val = 0x01234567LU;\n"; 
	close(TMPFILE);

	`$CC $CFLAGS -c $tmp_c -o $tmp_o`;		die, if $? != 0;
	`$OBJCOPY $OBJFLAGS $tmp_o $tmp_bin`;	die, if $? != 0;

	$sb = stat($tmp_bin);
	$fsize = $sb->size;

	my $read_bytes;
	my $buf;
	open(TMPFILE, "<$tmp_bin") || die "Could not open binary file";
	($read_bytes = read TMPFILE, $buf, 4) == 4 || die "File has illegal size";
	my @v;
	($v[0], $v[1], $v[2], $v[3]) = unpack("C4", $buf);
	close(TMPFILE);

	unlink $tmp_c;
	unlink $tmp_o;
	unlink $tmp_bin;

	local $SIG{'INT'} = 'DEFAULT';

	if ($v[0] == 0x01 && $v[1] == 0x23 && $v[2] == 0x45 && $v[3] == 0x67) {
		return("big");
	}
	if ($v[3] == 0x01 && $v[2] == 0x23 && $v[1] == 0x45 && $v[0] == 0x67) {
		return("little");
	}
	return("unknown");
}

sub alligned_type_size {
	my $type = shift(@_);
	my $type_val = shift(@_);
	if (!defined($type_val)) { $type_val = "0"; }
	my $array_size = shift(@_);
	if (!defined($array_size)) { $array_size = 16; }
	my $extra_code = shift(@_);
	if (!defined($extra_code)) { $extra_code = ""; }

	my $tmp_dir  = -d '/tmp' ? '/tmp' : $ENV{TMP} || $ENV{TEMP};
	my $tmp_name = sprintf("%s/%s-%d-%d", $tmp_dir, basename($0), $$, time());
	my $tmp_c    = "$tmp_name.c";
	my $tmp_o    = "$tmp_name.o";
	my $tmp_bin  = "$tmp_name.bin";
	my $t_size;
	my $sb;
	my $fsize;
	my $i;

	# first find out the size of the size_t type

	unlink $tmp_c;

	local $SIG{'INT'} =
		sub {
			unlink $tmp_c;
			unlink $tmp_o;
			unlink $tmp_bin;
			die $_[0];
		};

	open(TMPFILE, ">$tmp_c") || die "Could not create temp file";
	print TMPFILE "$extra_code\n";
	print TMPFILE "const $type tmp_array[$array_size] = {\n";
	for ($i = 0; $i < $array_size; $i++) {
		print TMPFILE "$type_val,\n";
	}
	print TMPFILE "};\n";
	close(TMPFILE);

	`$CC $CFLAGS -c $tmp_c -o $tmp_o`;		die, if $? != 0;
	`$OBJCOPY $OBJFLAGS $tmp_o $tmp_bin`;	die, if $? != 0;

	$sb = stat($tmp_bin);
	$fsize = $sb->size;

	$t_size = $fsize / $array_size;

	unlink $tmp_c;
	unlink $tmp_o;
	unlink $tmp_bin;

	local $SIG{'INT'} = 'DEFAULT';

	return $t_size;
}

sub members_offset {
	my $endianess	= shift(@_);	# big or little
	my $thirty_two_bits_type = shift(@_);
	my $extra_code  = shift(@_);	# 
	my $base   		= shift(@_);	# base type
	my $members		= shift(@_);	# member to find the offset
	my $offset = 0;
	my @offsets = ();
	my $i;
	my $j;

	my $tmp_dir  = -d '/tmp' ? '/tmp' : $ENV{TMP} || $ENV{TEMP};
	my $tmp_name = sprintf("%s/%s-%d-%d", $tmp_dir, basename($0), $$, time());
	my $tmp_c    = "$tmp_name.c";
	my $tmp_o    = "$tmp_name.o";
	my $tmp_bin  = "$tmp_name.bin";

	unlink $tmp_c;

	local $SIG{'INT'} =
		sub {
			unlink $tmp_c;
			unlink $tmp_o;
			unlink $tmp_bin;
			die $_[0];
		};

	open(TMPFILE, ">$tmp_c") || die "Could not create temp file";
	print TMPFILE "$extra_code\n";
	print TMPFILE "#include <stddef.h>\n";

	$j = $#$members + 1;
	print TMPFILE "const $thirty_two_bits_type offset_table[$j] = {\n";
	foreach (@$members) {
		print TMPFILE "\toffsetof($base, $_),\n";
	}
	print TMPFILE "};\n";

	close(TMPFILE);

	`$CC $CFLAGS -c $tmp_c -o $tmp_o`;		die, if $? != 0;
	`$OBJCOPY $OBJFLAGS $tmp_o $tmp_bin`;	die, if $? != 0;

	my $read_bytes;
	my $buf;
	open(TMPFILE, "<$tmp_bin") || die "Could not open binary file";
	
	for ($i = 0; $i < $j; $i++) {
		($read_bytes = read TMPFILE, $buf, 4) == 4 || die "File has illegal size";
		if ($endianess eq "big") {
			($offset) = unpack("N", $buf);	# big endian 32 bits
		} else {
			($offset) = unpack("V", $buf);	# little endian 32 bits
		}
		push @offsets, $offset;
	}

	close(TMPFILE);

	unlink $tmp_c;
	unlink $tmp_o;
	unlink $tmp_bin;

	local $SIG{'INT'} = 'DEFAULT';

	return(@offsets);
}


sub base_type_size {
	my $endianess	= shift(@_);	# big or little
	my $thirty_two_bits_type = shift(@_);
	my $extra_code  = shift(@_);	# 
	my $base   		= shift(@_);	# base type
	my $size = 0;

	my $tmp_dir  = -d '/tmp' ? '/tmp' : $ENV{TMP} || $ENV{TEMP};
	my $tmp_name = sprintf("%s/%s-%d-%d", $tmp_dir, basename($0), $$, time());
	my $tmp_c    = "$tmp_name.c";
	my $tmp_o    = "$tmp_name.o";
	my $tmp_bin  = "$tmp_name.bin";

	unlink $tmp_c;

	local $SIG{'INT'} =
		sub {
			unlink $tmp_c;
			unlink $tmp_o;
			unlink $tmp_bin;
			die $_[0];
		};

	open(TMPFILE, ">$tmp_c") || die "Could not create temp file";
	print TMPFILE "$extra_code\n";
	print TMPFILE "#include <stddef.h>\n";
	print TMPFILE "const $thirty_two_bits_type size = sizeof($base);\n";
	close(TMPFILE);

	`$CC $CFLAGS -c $tmp_c -o $tmp_o`;		die, if $? != 0;
	`$OBJCOPY $OBJFLAGS $tmp_o $tmp_bin`;	die, if $? != 0;

	my $read_bytes;
	my $buf;
	open(TMPFILE, "<$tmp_bin") || die "Could not open binary file";
	($read_bytes = read TMPFILE, $buf, 4) == 4 || die "File has illegal size";
	if ($endianess eq "big") {
		($size) = unpack("N", $buf);	# big endian 32 bits
	} else {
		($size) = unpack("V", $buf);	# little endian 32 bits
	}

	close(TMPFILE);

	unlink $tmp_c;
	unlink $tmp_o;
	unlink $tmp_bin;

	local $SIG{'INT'} = 'DEFAULT';

	return($size);
}

sub find_32bit_type {
	my $sizeof_int   = &alligned_type_size("int",    "0", 16, "");
	my $sizeof_short = &alligned_type_size("short",  "0", 16, "");
 	my $sizeof_long  = &alligned_type_size("long",   "0", 16, "");
	my $u32;

	if ($sizeof_int  == 4) {
		$u32 = "unsigned int"; $s32 = "signed int"; 
	} elsif ($sizeof_long == 4) {
		$u32 = "unsigned long"; $s32 = "signed long"; 
	} elsif ($sizeof_short == 4) {
		$u32 = "unsigned short"; $s32 = "signed short"; 
	} else {
		die "Not one 32 bit type found!\n";
	}
	return $u32;
}

--------------B54AD3F1C510DC8D0A093BAD
Content-Type: text/plain; charset=us-ascii;
 name="tst.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tst.h"

#ifndef TST_H
#define TST_H

#include "tst2.h"

#define TST_DEF	0x10

struct tst {
	int tst_member_a;
	union {
		char *tst_u_str;
	} tst_member_b;
#ifdef SHOW_HIDDEN
	int tst_hidden;
#endif
};

#endif

--------------B54AD3F1C510DC8D0A093BAD
Content-Type: text/plain; charset=us-ascii;
 name="tst2.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tst2.h"

#ifndef TST2_H
#define TST2_H

#endif

--------------B54AD3F1C510DC8D0A093BAD
Content-Type: text/plain; charset=us-ascii;
 name="tst.inc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tst.inc"

#ifndef _TST_INC
#define _TST_INC

#include "tst2.inc"

/****************************************************************

	Offsets for tst

****************************************************************/

#define tst_member_a                     0
#define tst_member_b                     4
#define tst_member_b_tst_u_str           4
#define struct_tst_SIZE                  8

/****************************************************************

	Simple defines list 

****************************************************************/

#define TST_H                         
#define TST_DEF                        0x10

#endif

--------------B54AD3F1C510DC8D0A093BAD
Content-Type: text/plain; charset=us-ascii;
 name="tst-hidden.inc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tst-hidden.inc"

#ifndef _TST_INC
#define _TST_INC

#include "tst2.inc"

/****************************************************************

	Offsets for tst

****************************************************************/

#define tst_member_a                     0
#define tst_member_b                     4
#define tst_member_b_tst_u_str           4
#define tst_hidden                       8
#define struct_tst_SIZE                 12

/****************************************************************

	Simple defines list 

****************************************************************/

#define TST_H                         
#define TST_DEF                        0x10

#endif

--------------B54AD3F1C510DC8D0A093BAD
Content-Type: text/plain; charset=us-ascii;
 name="tst2.inc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tst2.inc"

#ifndef _TST2_INC
#define _TST2_INC

/****************************************************************

	Simple defines list 

****************************************************************/

#define TST2_H                        

#endif

--------------B54AD3F1C510DC8D0A093BAD--

