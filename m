Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVF0PCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVF0PCh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVF0O7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:59:24 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:60424 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261911AbVF0N2E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 09:28:04 -0400
To: Ed Sweetman <safemode@comcast.net>
Cc: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
Subject: Re: 8139too PCI IRQ issues   WAS Re: 2.6.12 breaks 8139cp
References: <200506261446.57802.nick@linicks.net>
	<42BEC2B6.6020905@comcast.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 27 Jun 2005 22:27:40 +0900
In-Reply-To: <42BEC2B6.6020905@comcast.net> (Ed Sweetman's message of "Sun, 26 Jun 2005 10:59:02 -0400")
Message-ID: <87fyv43p6b.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Ed Sweetman <safemode@comcast.net> writes:

> What are you supposed to do though if you dont have that bios option.
> And if the bios wasn't changed between kernel version upgrades, what
> is the PCI irq subsystem doing now that requires such a change? And
> what makes it possible to remove the problem with reverting just the
> 8139too driver ...   There is a quirk here, but the fix should be in
> the kernel, since not all bios' allow you to make the fix yourself. 

Can you post the detail? (/proc/interrupt, mptable, 8259A.pl, lspci -vvv)
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


--=-=-=
Content-Type: text/x-perl
Content-Disposition: inline; filename=8259A.pl

#!/usr/bin/perl
#
# 8259A
#

use strict;
use warnings;

use Getopt::Std;

sub outb
{
    my $data = shift;
    my $port = shift;

    open(IO, "> /dev/port") || die;
    sysseek(IO, $port, 0) || die;
    my $x = pack("C", $data);
    syswrite(IO, $x, 1);
    close(IO);
}

sub inb
{
    my $port = shift;
    my $data;

    open(IO, "/dev/port") || die;
    sysseek(IO, $port, 0) || die;
    sysread(IO, $data, 1);
    close(IO);

    return unpack("C", $data);
}

sub set_edge_level
{
    my $irq = shift;
    my $to = shift;
    my $mask = 1 << ($irq & 7);
    my $port = 0x4d0 + ($irq >> 3);
    my $val = inb($port);

    if ($to eq "edge") {
	outb($val & ~$mask, $port);
    } else {
	outb($val | $mask, $port);
    }
    print "irq $irq: -> $to\n";
}

our($opt_e, $opt_l);
getopts('e:l:');

if ($opt_e and ($opt_e < 15)) {
    set_edge_level($opt_e, "edge");
} elsif ($opt_l and ($opt_l < 15)) {
    set_edge_level($opt_l, "level");
}

foreach my $irq (0..15) {
    my $mask = 1 << ($irq & 7);
    my $port = 0x4d0 + ($irq >> 3);
    my $val = inb($port);

    printf "irq %d: %02x, %s\n", $irq, $val, ($val & $mask) ? "level" : "edge";
}

--=-=-=--
