Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263156AbUEQXfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbUEQXfx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUEQXfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:35:53 -0400
Received: from waste.org ([209.173.204.2]:31909 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263156AbUEQXft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:35:49 -0400
Date: Mon, 17 May 2004 18:35:15 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: J?rn Engel <joern@wohnheim.fh-wedel.de>, arjanv@redhat.com,
       benh@kernel.crashing.org, kronos@kronoz.cjb.net,
       linux-kernel@vger.kernel.org
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-ID: <20040517233515.GR5414@waste.org>
References: <20040513145640.GA3430@dreamland.darkstar.lan> <1084488901.3021.116.camel@gaston> <20040513182153.1feb488b.akpm@osdl.org> <20040514094923.GB29106@devserv.devel.redhat.com> <20040514114746.GB23863@wohnheim.fh-wedel.de> <20040514151520.65b31f62.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514151520.65b31f62.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 03:15:20PM -0700, Andrew Morton wrote:
> J?rn Engel <joern@wohnheim.fh-wedel.de> wrote:
> >
> > On Fri, 14 May 2004 11:49:23 +0200, Arjan van de Ven wrote:
> > > On Fri, May 14, 2004 at 11:47:39AM +0200, Andrew Morton wrote:
> > > > There's a `make buildcheck' target in -mm (from Arjan) into which we could
> > > > integrate such a tool.  Although probably it should be a different make
> > > > target.
> > > 
> > > I added it to buildcheck for now, based on Keith Owens' check-stack.sh
> > > script. I added a tiny bit of perl (shudder) to it to 
> > > 1) Make it print in decimal not hex
> > > 2) Filter the stack users to users of 400 bytes and higher
> > > 
> > > I arbitrarily used 400; that surely is debatable.
> > 
> > Keith' script has the major disadvantage of not working on anything
> > but i386.  Here is my old script that works on a few more.
> 
> That's nice and simple.  All due respect to Keith, this is something
> which humans have a chance of understanding too ;)

I have a cleaned up version of this script in -tiny which is a bit
nicer for adding new arches to and produces simpler output:

 1428 huft_build
 1292 inflate_dynamic
 1168 inflate_fixed
  528 ip_setsockopt
  496 tcp_check_req
  496 tcp_v4_conn_request
  484 tcp_timewait_state_process
  440 ip_getsockopt
  408 extract_entropy
  364 shrink_zone
  324 do_execve
...

#!/usr/bin/perl

#	Check the stack usage of functions
#
#	Copyright Joern Engel <joern@wh.fh-wedel.de>
#	Inspired by Linus Torvalds
#	Original idea maybe from Keith Owens
#	s390 port and big speedup by Arnd Bergmann <arnd@bergmann-dalldorf.de>
#	Mips port by Juan Quintela <quintela@mandrakesoft.com>
#       Rewritten for -tiny - Matt Mackall <mpm@selenic.com>
#
#	Usage:
#	objdump -d vmlinux | checkstack.pl i386
#
#	TODO :	Port to all architectures (one regex per arch)

$arch = shift;
$x	= "[0-9a-f]";	# hex character
$xs	= "[0-9a-f ]";	# hex character or space
$funcre = qr/^$x* \<(.*)\>:$/;

%stack_re =
(
 #c0105234:       81 ec ac 05 00 00       sub    $0x5ac,%esp
 "^i386\$" => qr/^.*sub    \$(0x$x{3,5}),\%esp$/o,
 #c0008ffc:       e24dd064        sub     sp, sp, #100    ; 0x64
 "^arm\$" => qr/.*sub.*sp, sp, #(([0-9]{2}|[3-9])[0-9]{2})/o,
 #8800402c:       67bdfff0        daddiu  sp,sp,-16
 "^mips64\$" => qr/.*daddiu.*sp,sp,-(([0-9]{2}|[3-9])[0-9]{2})/o,
 #88003254:       27bdffe0        addiu   sp,sp,-32
 "^mips\$" => qr/.*addiu.*sp,sp,-(([0-9]{2}|[3-9])[0-9]{2})/o,
 #c00029f4:       94 21 ff 30     stwu    r1,-208(r1)
 "^ppc\$" => qr/.*stwu.*r1,-($x{3,5})\(r1\)/o,
 #   11160:       a7 fb ff 60             aghi   %r15,-160
 "^s390x?\$" => qr/.*ag?hi.*\%r15,-(([0-9]{2}|[3-9])[0-9]{2})/o
);

for $arch_re (keys(%stack_re)) {
    $re = $stack_re{$arch_re} if ($arch =~ /$arch_re/);
}
die "Unknown architecture $arch!\n" if !$re;

while ($line = <STDIN>) {
    $func = $1 if ($line =~ m/$funcre/);
    $size{$func} = hex($1) if ($line =~ m/$re/);
}

for $func (sort {$size{$b} <=> $size{$a}} keys(%size)) {
	printf "% 5d $func\n", $size{$func};
}

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
