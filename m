Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317304AbSGDAiq>; Wed, 3 Jul 2002 20:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317303AbSGDAip>; Wed, 3 Jul 2002 20:38:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22284 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317301AbSGDAil>; Wed, 3 Jul 2002 20:38:41 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Cyrix IRQ routing is wrong?
Date: Thu, 4 Jul 2002 00:36:27 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <ag05ab$1gc$1@penguin.transmeta.com>
References: <Pine.LNX.4.44.0207011814070.18831-100000@marabou.research.att.com> <E17Ptae-0002Ir-00@www.linux.org.uk>
X-Trace: palladium.transmeta.com 1025743251 24407 127.0.0.1 (4 Jul 2002 00:40:51 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 4 Jul 2002 00:40:51 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E17Ptae-0002Ir-00@www.linux.org.uk>,
Alan Cox  <alan@www.linux.org.uk> wrote:
>> The existing code uses the upper nibble in the same byte for lower pirq,
>> but it seems that we should start with the lower nibble for EM-350A.
>
>On all my boards its upper first and the current code works while the 
>patch you have hangs the box

The original code (and thus the one that Pavel documents) definitely
matches the documentation closer, though.  And clearly the "^1" is wrong
for some machines, and apparently right for others. 

I'd like to know if there is some way to distinguish between the broken
PIRQ tables that Alan has, and the ones that match the docs (Pavel). 

There are now three different pirq mappings:

 - original
	0x5c + (pirq-1)

 - alan's original
	0x5c + (pirq^1)

	(This one is provably broken, since there is no way to access
	the high nibble of 0x5c at all, since a pirq=0 would never be
	set at all)

 - alan's current
	0x5c + ((pirq-1)^1)

I don't have any good "dump_pirq" dumps from Cyrix chips, so it's hard
to get better guesses. People with Cyrix routers should probably send me
(and cc Jeff Garzik) the output from dump_pirq _and_ the output from
"lspci -vxxx ; cat /proc/interrupts" (the latter so that the actual
mappings and the router entries are visible).

			Linus

--- dump_pirq ---
#!/usr/bin/perl
#
# dump_pirq 1.20 2000/12/19 19:19:52
#
# A utility to parse the BIOS PCI IRQ Routing Table
#
# Copyright (C) 2000 David A. Hinds -- dahinds@users.sourceforge.net
#

#-----------------------------------------------------------------------

sub dev {
    my($devfn) = @_;
    sprintf "%02x.%d", ($devfn>>3), ($devfn&7);
}

sub print_mask
{
    my($mask) = @_;
    printf "0x%04x [", $mask;
    for (my $i = 0; $i < 16; $i++) {
	next if (!($mask & (1<<$i)));
	$mask &= ~(1<<$i);
	print (($mask) ? "$i," : "$i");
    }
    print "]\n";
}

sub row {
    my($tag, $link, $mask) = @_;
    if ($link != 0) {
	printf "  INT$tag: link 0x%02x, irq mask ", $link;
	print_mask($mask);
    }
}

sub class_of
{
    my($slot) = @_;
    open(IN, "/sbin/lspci -s $slot |");
    $_ = <IN>;
    close(IN);
    return (/^....... ([^:]+):/) ? $1 : "";
}

sub parse_pirq
{
    my($buf) = @_;

    my($p) = index($buf, "\$PIR");
    my($minor,$major,$size,$rbus,$rdev,$mask,$cvd,$mini) =
	unpack "CCSCCSLL", substr($buf, $p+4, 16);

    printf "Interrupt routing table found at address 0xf%04x:\n", $p;
    printf "  Version $major.$minor, size 0x%04x\n", $size;
    printf "  Interrupt router is device %02x:%s\n", $rbus, dev($rdev);
    print "  PCI exclusive interrupt mask: ";
    print_mask($mask);
    if ($cvd) {
	printf("  Compatible router: vendor 0x%04x device 0x%04x\n",
	       ($cvd & 0xffff), ($cvd >> 16));
    }

    $ofs = 32;
    while ($ofs < $size) {
	# Parse a table entry describing a single PCI device
	($bus, $devfn, $la, $ma, $lb, $mb, $lc, $mc, $ld, $md, $slot) =
	    unpack "CCCSCSCSCSC", substr($buf, $p+$ofs, 15);
	$s = sprintf "%02x:%s", $bus, dev($devfn);
	printf "\nDevice $s (slot $slot): %s\n", class_of($s);
	row("A", $la, $ma); row("B", $lb, $mb);
	row("C", $lc, $mc); row("D", $ld, $md);
	push(@{$dev{$la}}, $s . "1");
	push(@{$dev{$lb}}, $s . "2");
	push(@{$dev{$lc}}, $s . "3");
	push(@{$dev{$ld}}, $s . "4");
	$ofs += 16;
    }
    return ($rbus, $rdev, $cvd);
}

#-----------------------------------------------------------------------

# The link values in the interrupt routing table are implementation
# dependent.  Here, we'll try to interpret the link values for some
# known PCI bridge types.

%pIIx = (0x122e8086, "82371FB PIIX",
	 0x70008086, "82371SB PIIX3",
	 0x71108086, "82371AB PIIX4/PIIX4E",
	 0x71988086, "82443MX",
	 0x24108086, "82801AA ICH",
	 0x24208086, "82801AB ICH0",
	 0x24408086, "82801BA ICH2",
	 0x244c8086, "82801BAM ICH2-M");

%via = (0x05861106, "82C586",
	0x05961106, "82C596",
	0x06861106, "82C686");

%opti = (0xc7001045, "82C700");

%pico = (0x00021066, "PT86C523");

%ali = (0x153310b9, "Aladdin M1533");

%sis = (0x04961039, "85C496/497",
	0x00081039, "85C503");

%cyrix = (0x01001078, "5530");

%all_routers = (%pIIx, %via, %opti, %pico, %ali, %sis, %cyrix);

sub outb
{
    my($data,$port) = @_;
    open(IO, ">/dev/port") || die;
    sysseek(IO, $port, 0) || die;
    my $x = pack "C", $data;
    syswrite(IO, $x, 1);
    close(IO);
}

sub inb
{
    my($port) = @_;
    my($data);
    open(IO, "/dev/port") || die;
    sysseek(IO, $port, 0) || die;
    sysread(IO, $data, 1);
    close(IO);
    return unpack "C", $data;
}

sub dump_router
{
    my($rbus, $rdev, $cvd) = @_;
    my($buf, @p, $i, $irq);

    printf "\nInterrupt router at %02x:%s: ", $rbus, dev($rdev);
    $rf = sprintf "/proc/bus/pci/%02x/%s", $rbus, dev($rdev);
    open(IN, $rf);
    if (sysread(IN, $buf, 0x100) != 0x100) {
	print "\nCould not read router info from $rf.\n";
	exit;
    }
    close(IN);
    my $vd = unpack "L", substr($buf, 0, 4);

    if ((defined $pIIx{$vd}) || (defined $pIIx{$cvd})) {

	$name = (defined $pIIx{$vd}) ? $pIIx{$vd} : $pIIx{$cvd};
	printf "Intel $name PCI-to-ISA bridge\n";
	@p = unpack "CCCCC", substr($buf, 0x60, 5);
	for ($i = 0; $i < 4; $i++) {
	    printf "  PIRQ%d (link 0x%02x): ", $i+1, 0x60+$i;
	    print (($p[$i] < 16) ? "irq $p[$i]\n" : "unrouted\n");
	}
	print "  Serial IRQ:";
	print (($p[4] & 0x80) ? " [enabled]" : " [disabled]");
	print (($p[4] & 0x40) ? " [continuous]" : " [quiet]");
	print " [frame=", (($p[4] >> 2) & 15) + 17, "]";
	print " [pulse=", (($p[4] & 3) * 4 + 4), "]\n";
	print "  Level mask: "; print_mask((inb(0x4d1)<<8) + inb(0x4d0));

    } elsif ((defined $via{$vd}) || (defined $via{$cvd})) {

	$name = (defined $via{$vd}) ? $via{$vd} : $via{$cvd};
	printf "VIA $name PCI-to-ISA bridge\n";
	$p = unpack "L", substr($buf, 0x55, 4);
	%tag = (1, "A", 2, "B", 3, "C", 5, "D");
	foreach $link (1,2,3,5) {
	    $irq = ($p >> ($link * 4)) & 15;
	    print "  PIRQ$tag{$link} (link 0x0$link): ";
	    print ($irq ? "irq $irq\n" : "unrouted\n");
	}

    } elsif ((defined $opti{$vd}) || (defined $opti{$cvd})) {

	$name = (defined $opti{$vd}) ? $opti{$vd} : $opti{$cvd};
	printf "OPTi $name PCI-to-ISA bridge\n";
	$p = unpack "S", substr($buf, 0xb8, 2);
	for ($i = 0; $i < 4; $i++) {
	    $irq = ($p >> ($i * 4)) & 15;
	    printf "  PCIRQ$i (link 0x%02x): ", ($i<<4)+0x02;
	    print ($irq ? "irq $irq\n" : "unrouted\n");
	}

    } elsif ((defined $pico{$vd} || defined $pico{$cvd})) {

	$name = (defined $pico{$vd}) ? $pico{$vd} : $pico{$cvd};
	printf "PicoPower $name PCI-to-ISA bridge\n";
	outb(0x10, 0x24); $p = inb(0x26);
	outb(0x11, 0x24); $p += inb(0x26)<<8;
	@tag = ("A", "B", "C", "D");
	for ($i = 0; $i < 4; $i++) {
	    $irq = ($p >> ($i * 4)) & 15;
	    print "  INT$tag[$i] (link 0x0", $i+1, "): ";
	    print ($irq ? "irq $irq\n" : "unrouted\n");
	}

    } elsif ((defined $ali{$vd} || defined $ali{$cvd})) {

	$name = (defined $ali{$vd}) ? $ali{$vd} : $ali{$cvd};
	printf "AcerLabs $name PCI-to-ISA bridge\n";
	$p = unpack "L", substr($buf, 0x48, 4);
	# This mapping is insane!
	@map = (0, 9, 3, 10, 4, 5, 7, 6, 1, 11, 0, 12, 0, 14, 0, 15);
	for ($i = 0; $i < 8; $i++) {
	    $irq = ($p >> ($i*4)) & 15;
	    print "  INT", $i+1, " (link ", $i+1, "): ";
	    print ($map[$irq] ? "irq $map[$irq]\n" : "unrouted\n");
	}
	$s = unpack "C", substr($buf, 0x70, 1);
	print "  Serial IRQ:";
	print (($s & 0x80) ? " [enabled]" : " [disabled]");
	print (($s & 0x40) ? " [continuous]" : " [quiet]");
	print " [frame=", (($s >> 2) & 15) + 17, "]";
	print " [pulse=", (($s & 3) * 4 + 4), "]\n";

    } elsif ((defined $sis{$vd}) || (defined $sis{$cvd})) {

	$name = (defined $sis{$vd}) ? $sis{$vd} : $sis{$cvd};
	printf "SiS $name PCI-to-ISA bridge\n";
	$base = ($name eq "85C496/497") ? 0xc0 : 0x41;
	@p = unpack "CCCC", substr($buf, $base, 4);
	@tag = ("A", "B", "C", "D");
	for ($i = 0; $i < 4; $i++) {
	    $irq = ($p[$i] & 0x80) ? 0 : ($p[$i] & 0x0f);
	    printf "  INT$tag[$i] (link 0x%02x): ", $i+$base;
	    print ($irq ? "irq $irq\n" : "unrouted\n");
	}

    } elsif ((defined $cyrix{$vd}) || (defined $cyrix{$cvd})) {

	$name = (defined $cyrix{$vd}) ? $cyrix{$vd} : $cyrix{$cvd};
	printf "CYRIX $name PCI-to-ISA bridge\n";
	$p = unpack "S", substr($buf, 0x5c, 2);
	%tag = ("A", "B", "C", "D");
	for ($i = 0; $i < 4; $i++) {
	    $irq = ($p >> ($i * 4)) & 15;
	    printf "  PIRQ$tag{$i} (link 0x%02x): ", $i+1;
	    print ($irq ? "irq $irq\n" : "unrouted\n");
	}

    } else {

	printf("unknown vendor 0x%04x device 0x%04x\n",
	       ($vd & 0xffff), ($vd >> 16));
	foreach $k (sort keys %dev) {
	    next if ($k == 0);
	    printf "  PIRQ? (link 0x%02x): ", $k;
	    $irq = 0;
	    foreach $d (@{$dev{$k}}) {
		$d =~ /(..):(..)\..(.)/;
		($bus,$dev,$pin) = ($1,$2,$3);
		for ($fn = 0; $fn < 8; $fn++) {
		    open(IN, "/proc/bus/pci/$bus/$dev.$fn") || last;
		    sysread(IN, $buf, 0x100);
		    close(IN);
		    ($i,$p) = unpack "CC", substr($buf, 0x3c, 2);
		    $irq = $i if (($p == $pin) && $i && ($i != 255));
		}
	    }
	    print ($irq ? "irq $irq\n" : "unrouted?\n");
	}
    }

}

#-----------------------------------------------------------------------

# Grab the BIOS from 0xf0000-0xfffff
open(IN, "/dev/mem") || die "cannot open /dev/mem\n";
sysseek(IN, 0xf0000, 0) || die;
die if (sysread(IN, $buf, 0x10000) != 0x10000);
close(IN);

if (index($buf, "\$PIR") >= 0) {

    # Dump the PIRQ table, and the router information
    ($rbus, $rdev, $cvd) = parse_pirq($buf);
    dump_router($rbus, $rdev, $cvd);

} else {

    # Scan for any interrupt router device we recognize
    print "No PCI interrupt routing table was found.\n";
    open(DEV, "/proc/bus/pci/devices");
    while (<DEV>) {
	($rbus,$rdev,$vd) = /^(..)(..)\s+(........)/;
	$rbus = hex($rbus); $rdev = hex($rdev); $vd = hex($vd);
	$vd = (($vd & 0xffff0000) >> 16) | (($vd & 0xffff) << 16);
	if (defined $all_routers{$vd}) {
	    dump_router($rbus, $rdev, $vd);
	    $nr++;
	}
    }
    print "\nNo known PCI interrupt routers were found.\n" if (!$nr);

}

