Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbUDZM7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUDZM7Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 08:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUDZM7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 08:59:25 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:41988 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261262AbUDZM6z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 08:58:55 -0400
To: "Mirko Caserta" <mirko@mcaserta.com>
Cc: "Linux Kernel ML" <linux-kernel@vger.kernel.org>
Subject: Re: 8139too not working in 2.6
References: <opr62ahdvlpsnffn@mail.mcaserta.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 26 Apr 2004 21:58:05 +0900
In-Reply-To: <opr62ahdvlpsnffn@mail.mcaserta.com>
Message-ID: <87oeperj4y.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

"Mirko Caserta" <mirko@mcaserta.com> writes:

> eth0: Transmit timeout, status 0c 0005 c07f media 10.

This problem looks like miss configuration of level/edge-triggerd, or
IRQ-routing problem.

The attached script may clarify the problem. Also "lspci -vvvxxx" and
output of dmesg would be useful.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


--=-=-=
Content-Type: text/x-perl
Content-Disposition: attachment; filename=dump_pirq.pl

#!/usr/bin/perl
#
# dump_pirq 1.21 2001/09/05 02:59:31
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
	$p = unpack "C", substr($buf, 0x54, 1);
	%tag = (0 => "A", 1 => "B", 2 => "C", 3 => "D");
	foreach $n (0, 1, 2, 3) {
	    printf "  PIRQ$tag{$n} : %s\n", ($p & (1 << $n)) ? "edge" : "level";
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
	$t = unpack "L", substr($buf, 0x4C, 4);
	# This mapping is insane!
	@map = (0, 9, 3, 10, 4, 5, 7, 6, 1, 11, 0, 12, 0, 14, 0, 15);
	for ($i = 0; $i < 8; $i++) {
	    $irq = ($p >> ($i*4)) & 15;
	    print "  INT", $i+1, " (link ", $i+1, "): ";
	    print ($map[$irq] ? "irq $map[$irq]" : "unrouted");
	    printf " (%s)\n", ($t & (1 << $i)) ? "edge" : "level";
	}
	$s = unpack "C", substr($buf, 0x70, 1);
	print "  Serial IRQ:";
	print (($s & 0x80) ? " [enabled]" : " [disabled]");
	print (($s & 0x40) ? " [continuous]" : " [quiet]");
	print " [frame=", (($s >> 2) & 15) + 17, "]";
	print " [pulse=", (($s & 3) * 4 + 4), "]\n";

	%table = (0x44 => IDE1, 0x74 => USB, 0x75 => IDE2, 0x76 => PMU,
		  0x77 => SMB);
	foreach $n (keys %table) {
	    $p = unpack "C", substr($buf, $n, 1);
	    printf "  %s level to edge: %s\n", $table{$n},
		($p & 4) ? "enable" : "disable";
	}

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
    print "  PIC Level mask: "; print_mask((inb(0x4d1)<<8) + inb(0x4d0));
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

--=-=-=--
